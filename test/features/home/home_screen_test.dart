import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sakinah/app/theme/app_theme.dart';
import 'package:sakinah/core/location/geo_coordinates.dart';
import 'package:sakinah/core/network/network_info.dart';
import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/core/storage/preferences_service.dart';
import 'package:sakinah/features/home/data/juz_boundaries.dart';
import 'package:sakinah/features/home/presentation/screens/home_screen.dart';
import 'package:sakinah/features/prayer/data/adhan_prayer_repository.dart';
import 'package:sakinah/features/prayer/presentation/providers/prayer_providers.dart';
import 'package:sakinah/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fakes/fake_prayer_repository.dart';
import '../../fakes/test_database.dart';

/// Lets real async work (Drift queries) complete, then settles frames.
Future<void> settle(WidgetTester tester) async {
  await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
  await tester.pumpAndSettle();
}

void main() {
  late AppDatabase db;

  setUp(() => db = openTestDatabase());
  tearDown(() => db.close());

  /// 13:00 on the fake day: Fajr & Dhuhr have begun, Asr (15:45) is next.
  final afternoon = fakePrayerDay.add(const Duration(hours: 13));

  Future<GoRouter> pumpHome(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    ThemeMode themeMode = ThemeMode.light,
    double textScale = 1,
    Size size = const Size(420, 2600),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    Widget stub(GoRouterState state) => Scaffold(body: Text('stub:${state.uri}'));
    final router = GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
        for (final path in [
          '/prayer',
          '/qibla',
          '/dhikr',
          '/dhikr/counter/:key',
          '/duas',
          '/ask',
          '/profile',
          '/quran/surah/:n',
        ])
          GoRoute(path: path, builder: (_, state) => stub(state)),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          appDatabaseProvider.overrideWithValue(db),
          isOnlineProvider.overrideWith((ref) => Stream.value(true)),
          clockTickProvider.overrideWith((ref) => Stream.value(afternoon)),
          prayerRepositoryProvider.overrideWithValue(
            FakePrayerRepository(
              location: const GeoCoordinates(latitude: 30.0444, longitude: 31.2357),
            ),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          locale: locale,
          theme: AppTheme.light(languageCode: locale.languageCode),
          darkTheme: AppTheme.dark(languageCode: locale.languageCode),
          themeMode: themeMode,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
        ),
      ),
    );
    await settle(tester);
    return router;
  }

  /// Widget tests over Drift: unmount the tree (cancelling query streams)
  /// and let Drift's zero-delay cleanup timer fire before the test ends.
  void testWidgetsDb(String description, WidgetTesterCallback body) {
    testWidgets(description, (tester) async {
      await body(tester);
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(milliseconds: 1));
    });
  }

  Future<void> seedQuranProgress(WidgetTester tester) async {
    await tester.runAsync(
      () => db.upsertQuranProgress(
        QuranProgressEntriesCompanion.insert(
          surahNumber: 2,
          surahNameAr: 'سُورَةُ البَقَرَةِ',
          surahNameEn: 'Al-Baqara',
          ayahNumber: 143,
          totalAyahs: 286,
          updatedAt: Value(DateTime(2026, 1, 15, 9)),
        ),
      ),
    );
  }

  testWidgetsDb('renders the next-prayer hero from the prayer schedule', (tester) async {
    await pumpHome(tester);

    expect(find.text('Assalamu Alaikum 🌿'), findsOneWidget);
    expect(find.text('NEXT PRAYER'), findsOneWidget);
    expect(find.text('Asr'), findsNWidgets(2)); // hero title + timeline node
    expect(find.text('15:45'), findsNWidgets(2)); // hero time + timeline node
    expect(find.text('in 02:45'), findsOneWidget);
    expect(find.text('30.0°, 31.2°'), findsOneWidget);
    for (final name in ['Fajr', 'Dhuhr', 'Maghrib', 'Isha']) {
      expect(find.byKey(ValueKey('home-timeline-${name.toLowerCase()}')), findsOneWidget);
    }
    expect(find.text('Midnight'), findsOneWidget);
    expect(find.text('Last third'), findsOneWidget);
  });

  testWidgetsDb('long-pressing a passed prayer on the timeline logs it', (tester) async {
    await pumpHome(tester);

    final fajr = find.byKey(const ValueKey('home-timeline-fajr'));
    expect(find.descendant(of: fajr, matching: find.byIcon(Icons.check)), findsNothing);

    await tester.longPress(fajr);
    await settle(tester);

    final rows = await tester.runAsync(() => db.select(db.prayerLogs).get());
    expect(rows!.map((r) => r.prayer), ['fajr']);
    expect(find.descendant(of: fajr, matching: find.byIcon(Icons.check)), findsOneWidget);

    // Upcoming prayers can't be logged ahead of time.
    await tester.longPress(find.byKey(const ValueKey('home-timeline-isha')));
    await settle(tester);
    final after = await tester.runAsync(() => db.select(db.prayerLogs).get());
    expect(after!.length, 1);
  });

  testWidgetsDb('tapping the hero opens the Prayer screen', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.text('NEXT PRAYER'));
    await tester.pumpAndSettle();
    expect(find.text('stub:/prayer'), findsOneWidget);
  });

  testWidgetsDb('Quran card empty state starts with Al-Fatiha', (tester) async {
    await pumpHome(tester);

    expect(find.text('Begin with Al-Fatiha'), findsOneWidget);
    await tester.ensureVisible(find.text('Start reading'));
    await tester.tap(find.text('Start reading'));
    await tester.pumpAndSettle();
    expect(find.text('stub:/quran/surah/1'), findsOneWidget);
  });

  testWidgetsDb('Quran card shows surah, ayah, juz and completion, then continues', (tester) async {
    await seedQuranProgress(tester);
    await pumpHome(tester);

    expect(find.text('Surah Al-Baqara'), findsOneWidget);
    expect(find.text('Ayah 143 • Juz 2'), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);

    await tester.ensureVisible(find.text('Continue reading'));
    await tester.tap(find.text('Continue reading'));
    await tester.pumpAndSettle();
    expect(find.text('stub:/quran/surah/2?ayah=143'), findsOneWidget);
  });

  testWidgetsDb('dhikr Start opens the suggested counter and the deed can be marked done', (tester) async {
    await pumpHome(tester);

    await tester.ensureVisible(find.text('Mark as done'));
    await tester.tap(find.text('Mark as done'));
    await settle(tester);
    expect(find.text('Done for today'), findsOneWidget);

    await tester.ensureVisible(find.text('Start'));
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(find.textContaining('stub:/dhikr/counter/'), findsOneWidget);
  });

  testWidgetsDb('shows the verified footer verse with its source', (tester) async {
    await pumpHome(tester);
    expect(find.textContaining('Quran 13:28'), findsOneWidget);
    expect(find.textContaining('Sahih International'), findsOneWidget);
  });

  testWidgetsDb('lays out in Arabic, dark mode, 360px wide at 1.3x text', (tester) async {
    await seedQuranProgress(tester);
    await pumpHome(
      tester,
      locale: const Locale('ar'),
      themeMode: ThemeMode.dark,
      textScale: 1.3,
      size: const Size(360, 3200),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('العصر'), findsWidgets);
    expect(find.text('سُورَةُ البَقَرَةِ'), findsOneWidget);
  });

  test('juzFor maps boundaries correctly', () {
    expect(juzFor(1, 1), 1);
    expect(juzFor(2, 141), 1);
    expect(juzFor(2, 142), 2);
    expect(juzFor(18, 74), 15);
    expect(juzFor(18, 75), 16);
    expect(juzFor(114, 6), 30);
  });
}
