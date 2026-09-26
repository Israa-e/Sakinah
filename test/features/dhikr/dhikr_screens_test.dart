import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sakinah/app/theme/app_theme.dart';
import 'package:sakinah/core/storage/preferences_service.dart';
import 'package:sakinah/features/dhikr/data/drift_dhikr_repository.dart';
import 'package:sakinah/features/dhikr/presentation/dhikr_routes.dart';
import 'package:sakinah/features/dhikr/presentation/providers/dhikr_providers.dart';
import 'package:sakinah/features/dhikr/presentation/screens/dhikr_counter_screen.dart';
import 'package:sakinah/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_dhikr_repository.dart';

void main() {
  final now = DateTime(2026, 9, 24, 13); // midday -> "After Prayer" cycle

  Future<(FakeDhikrRepository, SharedPreferences)> pumpApp(
    WidgetTester tester, {
    String initialLocation = DhikrPaths.root,
    Map<String, int>? counts,
    Locale locale = const Locale('en'),
    Size size = const Size(390, 1600),
    bool dark = false,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = FakeDhikrRepository(todayCounts: counts, today: now);
    final router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        ...dhikrRoutes,
        GoRoute(path: '/profile', builder: (_, _) => const Text('PROFILE')),
        GoRoute(path: '/journey', builder: (_, _) => const Text('JOURNEY')),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          dhikrRepositoryProvider.overrideWithValue(repo),
          dhikrClockProvider.overrideWithValue(() => now),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          locale: locale,
          theme: AppTheme.light(languageCode: locale.languageCode),
          darkTheme: AppTheme.dark(languageCode: locale.languageCode),
          themeMode: dark ? ThemeMode.dark : ThemeMode.light,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      ),
    );
    await tester.pumpAndSettle();
    return (repo, prefs);
  }

  testWidgets('tab root renders the sourced adhkar list and today\'s progress', (tester) async {
    await pumpApp(tester, counts: {'after_prayer_subhanallah': 33});

    expect(find.text('Dhikr & Sanctuary'), findsOneWidget);
    expect(find.text('Tasbeeh Counter'), findsOneWidget);
    expect(find.text('Garden Journey'), findsOneWidget);
    // Current cycle card (midday -> after prayer) shows 1 of 3.
    expect(find.text('1 of 3 completed'), findsOneWidget);
    expect(find.byKey(const ValueKey('dhikr-card-after_prayer_subhanallah')), findsOneWidget);
    expect(find.text('Source: Sahih Muslim 596'), findsWidgets);
    expect(find.text('Done'), findsOneWidget);
  });

  testWidgets('category chip filters the list', (tester) async {
    await pumpApp(tester);
    await tester.ensureVisible(find.widgetWithText(ChoiceChip, 'Anytime'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'Anytime'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('dhikr-card-astaghfirullah')), findsOneWidget);
    expect(find.byKey(const ValueKey('dhikr-card-after_prayer_subhanallah')), findsNothing);
  });

  testWidgets('tapping a card opens its counter', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byKey(const ValueKey('dhikr-card-after_prayer_alhamdulillah')));
    await tester.pumpAndSettle();
    expect(find.byType(DhikrCounterScreen), findsOneWidget);
    expect(find.text('الْحَمْدُ لِلَّهِ'), findsOneWidget);
    expect(find.text('Goal / 33'), findsOneWidget);
  });

  testWidgets('garden view summarises today and links to Journey', (tester) async {
    await pumpApp(tester, counts: {'astaghfirullah': 12});
    await tester.tap(find.text('Garden Journey'));
    await tester.pumpAndSettle();
    expect(find.text('12'), findsOneWidget);
    expect(find.text('1 of 7 days'), findsOneWidget);
    await tester.tap(find.text('Open your garden'));
    await tester.pumpAndSettle();
    expect(find.text('JOURNEY'), findsOneWidget);
  });

  testWidgets('profile icon goes to the Profile tab', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byTooltip('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('PROFILE'), findsOneWidget);
  });

  Finder ringText(String text) =>
      find.descendant(of: find.byKey(const ValueKey('tasbeeh-ring')), matching: find.text(text));

  testWidgets('counter: tap counts, persists, completes, undo, reset', (tester) async {
    final (repo, _) = await pumpApp(
      tester,
      initialLocation: DhikrPaths.counter('after_prayer_allahu_akbar'),
      counts: {'after_prayer_allahu_akbar': 32},
    );
    expect(ringText('32'), findsOneWidget);
    expect(find.text('Goal / 34'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('tasbeeh-ring')));
    await tester.pump();
    expect(ringText('33'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('tasbeeh-ring')));
    await tester.pumpAndSettle();
    expect(ringText('34'), findsOneWidget);
    expect(find.textContaining('Target reached'), findsOneWidget);

    // Debounced write reaches the repository.
    await tester.pump(const Duration(milliseconds: 500));
    expect(repo.countsFor(now)['after_prayer_allahu_akbar'], 34);

    await tester.tap(find.byKey(const ValueKey('dhikr-undo')));
    await tester.pumpAndSettle();
    expect(ringText('33'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('dhikr-reset')));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Reset'));
    await tester.pumpAndSettle();
    expect(ringText('0'), findsOneWidget);
    expect(repo.countsFor(now)['after_prayer_allahu_akbar'], 0);
  });

  testWidgets('counter: haptics toggle and target cycle persist', (tester) async {
    final (_, prefs) = await pumpApp(
      tester,
      initialLocation: DhikrPaths.counter('after_prayer_subhanallah'),
    );
    expect(find.text('Gentle'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('dhikr-haptics')));
    await tester.pumpAndSettle();
    expect(find.text('Mute'), findsOneWidget);
    expect(prefs.getBool(DhikrHaptics.prefsKey), isFalse);

    await tester.tap(find.byKey(const ValueKey('dhikr-target')));
    await tester.pumpAndSettle();
    expect(find.text('Goal / 99'), findsOneWidget);
    expect(prefs.getInt('dhikr.target.after_prayer_subhanallah'), 99);
  });

  testWidgets('counter: next flows through the post-prayer set', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byKey(const ValueKey('dhikr-card-after_prayer_subhanallah')));
    await tester.pumpAndSettle();
    expect(find.text('Next: Al-ḥamdu lillāh'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('dhikr-next')));
    await tester.pumpAndSettle();
    expect(find.text('الْحَمْدُ لِلَّهِ'), findsOneWidget);
    expect(find.text('Next: Allāhu akbar'), findsOneWidget);
  });

  testWidgets('unknown key shows a not-found state', (tester) async {
    await pumpApp(tester, initialLocation: DhikrPaths.counter('nope'));
    expect(find.text('This dhikr could not be found.'), findsOneWidget);
  });

  testWidgets('no overflow at 360px, Arabic RTL, dark, text scale 1.3', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await pumpApp(tester, locale: const Locale('ar'), size: const Size(360, 2400), dark: true);
    expect(tester.takeException(), isNull);
    final card = find.byKey(const ValueKey('dhikr-card-la_ilaha_illallah_wahdahu'));
    await tester.scrollUntilVisible(
      card,
      300,
      scrollable: find
          .descendant(
            of: find.byKey(const ValueKey('dhikr-scroll')),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(card);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(DhikrCounterScreen), findsOneWidget);
  });
}
