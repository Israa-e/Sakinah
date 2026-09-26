import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/features/duas/data/bundled_dua_repository.dart';
import 'package:sakinah/features/duas/domain/dua.dart';
import 'package:sakinah/features/duas/presentation/providers/duas_providers.dart';
import 'package:sakinah/features/duas/presentation/screens/dua_detail_screen.dart';
import 'package:sakinah/features/duas/presentation/screens/duas_library_screen.dart';
import 'package:sakinah/features/duas/presentation/widgets/dua_category_chips.dart';
import 'package:sakinah/l10n/app_localizations.dart';

import '../../fakes/test_database.dart';

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

  Future<void> pump(
    WidgetTester tester,
    Widget home, {
    double textScale = 1,
    Locale locale = const Locale('en'),
  }) async {
    tester.view.physicalSize = const Size(1080, 30000);
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          duaRepositoryProvider.overrideWith((ref) => BundledDuaRepository(db)),
          duaCatalogProvider.overrideWith((ref) async => catalog),
        ],
        child: MaterialApp(
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: home,
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

  testWidgets('library lists du\'as and filters by search', (tester) async {
    await pump(tester, const DuasLibraryScreen());

    expect(find.text("Du'as Sanctuary"), findsOneWidget);
    expect(find.text('Daily featured'), findsOneWidget);
    expect(find.text('Increase in knowledge'), findsWidgets);

    await tester.enterText(find.byType(TextField), 'knowledge');
    await tester.pumpAndSettle();

    expect(find.text('Increase in knowledge'), findsOneWidget);
    expect(find.text("Du'a of Yunus (Dhun-Nun)"), findsNothing);
    // Featured card hides while filtering.
    expect(find.text('Daily featured'), findsNothing);

    await tester.enterText(find.byType(TextField), 'zzzz-nothing');
    await tester.pumpAndSettle();
    expect(find.text("No du'as found"), findsOneWidget);

    await tearDownTree(tester);
  });

  testWidgets('library filters by category chip', (tester) async {
    await pump(tester, const DuasLibraryScreen());

    final chipRow = find.descendant(of: find.byType(DuaCategoryChips), matching: find.byType(Scrollable));
    await tester.scrollUntilVisible(find.widgetWithText(DuaChip, 'Family'), 80, scrollable: chipRow);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(DuaChip, 'Family'));
    await tester.pumpAndSettle();

    expect(find.text('Mercy for parents'), findsOneWidget);
    expect(find.text('Increase in knowledge'), findsNothing);

    await tester.scrollUntilVisible(find.widgetWithText(DuaChip, 'All'), -80, scrollable: chipRow);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(DuaChip, 'All'));
    await tester.pumpAndSettle();
    expect(find.text('Increase in knowledge'), findsWidgets);

    await tearDownTree(tester);
  });

  testWidgets('detail shows citation and toggles saved state in Drift', (tester) async {
    await pump(tester, const DuaDetailScreen(duaKey: 'yunus-dhun-nun'));

    expect(find.text("Du'a of Yunus (Dhun-Nun)"), findsOneWidget);
    expect(find.text('Translation: Sahih International'), findsOneWidget);
    expect(find.text('Al-Anbiyaa 21:87'), findsOneWidget);

    await tester.tap(find.text('Save'));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pumpAndSettle();

    var rows = await tester.runAsync(() => db.select(db.savedDuas).get());
    expect(rows!.map((r) => r.duaKey), ['yunus-dhun-nun']);
    expect(find.text('Saved'), findsOneWidget);

    await tester.tap(find.text('Saved'));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pumpAndSettle();

    rows = await tester.runAsync(() => db.select(db.savedDuas).get());
    expect(rows, isEmpty);
    expect(find.text('Save'), findsOneWidget);

    await tearDownTree(tester);
  });

  testWidgets('detail recite counter counts locally and copy shows a snackbar', (tester) async {
    await pump(tester, const DuaDetailScreen(duaKey: 'increase-knowledge'));

    await tester.tap(find.byKey(const Key('dua-recite-counter')));
    await tester.tap(find.byKey(const Key('dua-recite-counter')));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.text('Copy'));
    // Clipboard.setData round-trips a platform channel before the snackbar.
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text("Du'a copied"), findsOneWidget);

    await tearDownTree(tester);
  });

  testWidgets('detail shows not-found for an unknown key', (tester) async {
    await pump(tester, const DuaDetailScreen(duaKey: 'does-not-exist'));
    expect(find.text("This du'a couldn't be found."), findsOneWidget);
    await tearDownTree(tester);
  });

  testWidgets('library and detail fit 360px at text scale 1.3 in Arabic', (tester) async {
    await pump(
      tester,
      const DuasLibraryScreen(),
      textScale: 1.3,
      locale: const Locale('ar'),
    );
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());

    await pump(
      tester,
      const DuaDetailScreen(duaKey: 'closing-al-baqarah'),
      textScale: 1.3,
      locale: const Locale('ar'),
    );
    expect(tester.takeException(), isNull);
    await tearDownTree(tester);
  });
}
