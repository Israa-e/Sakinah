import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/core/storage/preferences_service.dart';
import 'package:sakinah/features/prayer/data/adhan_prayer_repository.dart';
import 'package:sakinah/features/prayer/presentation/screens/prayer_screen.dart';
import 'package:sakinah/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fakes/fake_prayer_repository.dart';

void main() {
  Future<void> pumpPrayerScreen(WidgetTester tester, {bool estimated = false}) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          prayerRepositoryProvider.overrideWithValue(FakePrayerRepository(isEstimated: estimated)),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          supportedLocales: [Locale('en'), Locale('ar')],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: PrayerScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders all five prayer names and times from the schedule', (tester) async {
    await pumpPrayerScreen(tester);

    expect(find.text('Fajr'), findsOneWidget);
    expect(find.text('Dhuhr'), findsOneWidget);
    expect(find.text('Asr'), findsOneWidget);
    expect(find.text('Maghrib'), findsOneWidget);
    expect(find.text('Isha'), findsOneWidget);
    expect(find.text('05:12'), findsOneWidget);
  });

  testWidgets('shows the estimated-schedule notice only when the schedule is estimated', (
    tester,
  ) async {
    await pumpPrayerScreen(tester, estimated: true);
    expect(find.textContaining('Estimated'), findsOneWidget);
  });

  testWidgets('lets the user flip the notifications toggle', (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1.0;

    await pumpPrayerScreen(tester);

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);
    expect(tester.widget<Switch>(switchFinder).value, isFalse);

    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    expect(tester.widget<Switch>(switchFinder).value, isTrue);
  });
}
