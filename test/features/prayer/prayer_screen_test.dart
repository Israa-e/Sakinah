import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/app/theme/app_theme.dart';
import 'package:sakinah/core/location/geo_coordinates.dart';
import 'package:sakinah/core/network/network_info.dart';
import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/core/storage/preferences_service.dart';
import 'package:sakinah/features/prayer/data/adhan_prayer_repository.dart';
import 'package:sakinah/features/prayer/data/drift_prayer_log_repository.dart';
import 'package:sakinah/features/prayer/domain/prayer_models.dart';
import 'package:sakinah/features/prayer/presentation/providers/prayer_providers.dart';
import 'package:sakinah/features/prayer/presentation/screens/prayer_screen.dart';
import 'package:sakinah/features/prayer/presentation/widgets/prayer_schedule_card.dart';
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

  /// 13:00 on the fake day: Fajr & Dhuhr have begun, Asr is next.
  final afternoon = fakePrayerDay.add(const Duration(hours: 13));

  Future<void> pumpPrayerScreen(
    WidgetTester tester, {
    bool estimated = false,
    Locale locale = const Locale('en'),
    ThemeMode themeMode = ThemeMode.light,
    double textScale = 1,
    Size size = const Size(800, 2400),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          appDatabaseProvider.overrideWithValue(db),
          isOnlineProvider.overrideWith((ref) => Stream.value(true)),
          clockTickProvider.overrideWith((ref) => Stream.value(afternoon)),
          prayerRepositoryProvider.overrideWithValue(
            FakePrayerRepository(
              isEstimated: estimated,
              withSunrise: true,
              location: estimated
                  ? null
                  : const GeoCoordinates(latitude: 30.0444, longitude: 31.2357),
            ),
          ),
        ],
        child: MaterialApp(
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
          home: const PrayerScreen(),
        ),
      ),
    );
    await settle(tester);
  }

  Future<Set<String>> loggedNames(WidgetTester tester) async {
    final rows = await tester.runAsync(() => db.select(db.prayerLogs).get());
    return {for (final r in rows!) r.prayer};
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

  final scheduleCard = find.byType(PrayerScheduleCard);

  testWidgetsDb('renders all five prayer names and times from the schedule', (tester) async {
    await pumpPrayerScreen(tester);

    for (final name in ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha', 'Sunrise']) {
      expect(find.descendant(of: scheduleCard, matching: find.text(name)), findsOneWidget);
    }
    expect(find.text('05:12'), findsOneWidget);
  });

  testWidgetsDb('highlights the next prayer with a countdown in the hero', (tester) async {
    await pumpPrayerScreen(tester);

    // Asr at 15:45, two hours forty-five from 13:00.
    expect(find.text('Asr'), findsNWidgets(2)); // hero + schedule row
    expect(find.text('in 02:45'), findsOneWidget);
    expect(find.text('IN 02:45'), findsOneWidget); // schedule row badge
  });

  testWidgetsDb('shows the estimated-schedule notice only when the schedule is estimated', (
    tester,
  ) async {
    await pumpPrayerScreen(tester);
    expect(find.textContaining('Estimated'), findsNothing);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 1));
    await pumpPrayerScreen(tester, estimated: true);
    expect(find.textContaining('Estimated'), findsOneWidget);
  });

  testWidgetsDb('marks a begun prayer as prayed and un-marks it again', (tester) async {
    await pumpPrayerScreen(tester);
    expect(find.text('0 of 5 prayers logged today'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('prayer-row-fajr')));
    await settle(tester);

    expect(await loggedNames(tester), {PrayerName.fajr.name});
    expect(find.text('1 of 5 prayers logged today'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('prayer-row-fajr')),
        matching: find.byIcon(Icons.check),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('prayer-row-fajr')));
    await settle(tester);

    expect(await loggedNames(tester), isEmpty);
    expect(find.text('0 of 5 prayers logged today'), findsOneWidget);
  });

  testWidgetsDb('upcoming prayers cannot be logged yet', (tester) async {
    await pumpPrayerScreen(tester);

    await tester.tap(find.byKey(const ValueKey('prayer-row-isha')));
    await settle(tester);

    expect(await loggedNames(tester), isEmpty);
  });

  testWidgetsDb('lets the user flip the notifications toggle', (tester) async {
    await pumpPrayerScreen(tester);

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);
    expect(tester.widget<Switch>(switchFinder).value, isFalse);

    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    expect(tester.widget<Switch>(switchFinder).value, isTrue);
  });

  testWidgetsDb('lays out in Arabic, dark mode, 360px wide at 1.3x text', (tester) async {
    await pumpPrayerScreen(
      tester,
      locale: const Locale('ar'),
      themeMode: ThemeMode.dark,
      textScale: 1.3,
      size: const Size(360, 2400),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('العصر'), findsWidgets);
  });

  test('repository toggles and normalizes the day', () async {
    final repo = DriftPrayerLogRepository(db);
    final noon = fakePrayerDay.add(const Duration(hours: 12));

    expect(await repo.togglePrayed(noon, PrayerName.dhuhr), isTrue);
    expect(await repo.watchLoggedPrayers(fakePrayerDay).first, {PrayerName.dhuhr});

    await repo.setPrayed(fakePrayerDay, PrayerName.asr, prayed: true);
    final range = await repo.watchLoggedPrayersBetween(fakePrayerDay, fakePrayerDay).first;
    expect(range[fakePrayerDay], {PrayerName.dhuhr, PrayerName.asr});

    expect(await repo.togglePrayed(noon, PrayerName.dhuhr), isFalse);
    expect(await repo.watchLoggedPrayers(noon).first, {PrayerName.asr});
  });
}
