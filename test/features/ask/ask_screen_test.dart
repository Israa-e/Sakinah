import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/core/errors/app_failure.dart';
import 'package:sakinah/core/errors/result.dart';
import 'package:sakinah/core/network/network_info.dart';
import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/features/ask/data/remote_ask_repository.dart';
import 'package:sakinah/features/ask/domain/ask_models.dart';
import 'package:sakinah/features/ask/domain/ask_repository.dart';
import 'package:sakinah/features/ask/presentation/screens/ask_screen.dart';
import 'package:sakinah/features/duas/data/bundled_dua_repository.dart';
import 'package:sakinah/features/duas/domain/dua.dart';
import 'package:sakinah/features/duas/presentation/providers/duas_providers.dart';
import 'package:sakinah/l10n/app_localizations.dart';

import '../../fakes/test_database.dart';

class _FakeAskRepository implements AskRepository {
  _FakeAskRepository(this.results);

  final List<Result<AskAnswer>> results;
  final questions = <String>[];

  @override
  bool get isConfigured => true;

  @override
  Future<Result<AskAnswer>> ask(String question, AskLanguage language) async {
    questions.add(question);
    return results.removeAt(0);
  }
}

class _FakeNetworkInfo implements NetworkInfo {
  _FakeNetworkInfo({required this.connected});

  final bool connected;

  @override
  Future<bool> get isConnected async => connected;

  @override
  Stream<bool> get onConnectivityChanged => const Stream.empty();
}

void main() {
  late AppDatabase db;
  late List<Dua> catalog;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    catalog = parseDuaCatalog(await rootBundle.loadString(duasAssetPath));
  });

  setUp(() => db = openTestDatabase());
  tearDown(() => db.close());

  Future<void> pump(WidgetTester tester, List<Override> overrides) async {
    tester.view.physicalSize = const Size(1080, 30000);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          duaRepositoryProvider.overrideWith((ref) => BundledDuaRepository(db)),
          duaCatalogProvider.overrideWith((ref) async => catalog),
          ...overrides,
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: AskScreen(),
        ),
      ),
    );
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pumpAndSettle();
  }

  Future<void> tearDownTree(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  }

  testWidgets('shows the unavailable state when no service URL is configured', (tester) async {
    await pump(tester, [askBaseUrlProvider.overrideWithValue('')]);

    expect(find.byKey(const Key('ask-unavailable')), findsOneWidget);
    expect(find.text("Ask Sakīnah isn't available yet"), findsOneWidget);
    expect(find.text("Browse du'as"), findsOneWidget);
    expect(
      find.text('For learning purposes. For personal religious rulings, consult a qualified scholar.'),
      findsOneWidget,
    );
    final field = tester.widget<TextField>(find.byKey(const Key('ask-input')));
    expect(field.enabled, isFalse);

    await tearDownTree(tester);
  });

  testWidgets('renders an answer with its sources from the repository', (tester) async {
    final fake = _FakeAskRepository([
      const Success(
        AskAnswer(
          answer: 'Test answer from the backend.',
          sources: [
            AskSource(type: AskSourceType.quran, reference: '13:28'),
            AskSource(type: AskSourceType.hadith, reference: 'Sahih al-Bukhari 6407'),
          ],
          disclaimer: 'Server disclaimer text.',
        ),
      ),
    ]);
    await pump(tester, [askRepositoryProvider.overrideWithValue(fake)]);

    expect(find.byKey(const Key('ask-unavailable')), findsNothing);

    await tester.enterText(find.byKey(const Key('ask-input')), 'What brings peace?');
    await tester.tap(find.byKey(const Key('ask-send')));
    await tester.pumpAndSettle();

    expect(fake.questions, ['What brings peace?']);
    expect(find.text('What brings peace?'), findsOneWidget);
    expect(find.text('Test answer from the backend.'), findsOneWidget);
    expect(find.text('Quran 13:28'), findsOneWidget);
    expect(find.text('Hadith · Sahih al-Bukhari 6407'), findsOneWidget);
    expect(find.text('Server disclaimer text.'), findsOneWidget);

    await tearDownTree(tester);
  });

  testWidgets('suggested question chip asks it; network failure offers retry', (tester) async {
    final fake = _FakeAskRepository([
      const Failure(NetworkFailure()),
      const Success(AskAnswer(answer: 'Recovered answer.', sources: [])),
    ]);
    await pump(tester, [askRepositoryProvider.overrideWithValue(fake)]);

    await tester.tap(find.text("Du'a for anxiety and peace"));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('ask-failure')), findsOneWidget);
    expect(find.text("You're offline. Connect to the internet and try again."), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(fake.questions, ["Du'a for anxiety and peace", "Du'a for anxiety and peace"]);
    expect(find.text('Recovered answer.'), findsOneWidget);
    expect(find.textContaining('No sources were returned'), findsOneWidget);

    await tearDownTree(tester);
  });

  group('RemoteAskRepository', () {
    test('returns the not-configured failure when the URL is empty', () async {
      final repo = RemoteAskRepository(
        // Never used: the empty URL short-circuits before any request.
        Dio(),
        _FakeNetworkInfo(connected: true),
        baseUrl: '',
      );
      expect(repo.isConfigured, isFalse);
      final result = await repo.ask('Hello', AskLanguage.en);
      expect(result, isA<Failure<AskAnswer>>());
      expect(isAskServiceNotConfigured((result as Failure<AskAnswer>).failure), isTrue);
    });

    test('returns a network failure when offline', () async {
      final repo = RemoteAskRepository(
        Dio(),
        _FakeNetworkInfo(connected: false),
        baseUrl: 'https://example.invalid',
      );
      final result = await repo.ask('Hello', AskLanguage.en);
      expect((result as Failure<AskAnswer>).failure, isA<NetworkFailure>());
    });

    test('parseAskResponse validates the contract', () {
      expect(parseAskResponse(null), isNull);
      expect(parseAskResponse({'answer': ''}), isNull);
      final parsed = parseAskResponse({
        'answer': 'A',
        'sources': [
          {'type': 'quran', 'reference': '2:255'},
          {'type': 'hadith'},
        ],
        'disclaimer': 'D',
      })!;
      expect(parsed.sources.single.reference, '2:255');
      expect(parsed.sources.single.type, AskSourceType.quran);
      expect(parsed.disclaimer, 'D');
    });
  });
}
