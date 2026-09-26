import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sakinah/app/theme/app_theme.dart';
import 'package:sakinah/features/journey/domain/journey_models.dart';
import 'package:sakinah/features/journey/presentation/providers/journey_providers.dart';
import 'package:sakinah/features/journey/presentation/screens/journey_screen.dart';
import 'package:sakinah/features/onboarding/domain/onboarding_models.dart';
import 'package:sakinah/l10n/app_localizations.dart';

final _now = DateTime(2026, 9, 24, 12);

JourneyStats _emptyStats() => computeJourneyStats(const {}, now: _now);

JourneyStats _populatedStats() {
  final byDay = <DateTime, DayActivity>{};
  for (var i = 0; i < 8; i++) {
    final d = DateTime(2026, 9, 24 - i);
    byDay[d] = DayActivity(
      day: d,
      prayers: 5,
      ayahs: 20,
      dhikr: 100,
      reflections: i == 1 ? 1 : 0,
      deeds: i.isEven ? 1 : 0,
    );
  }
  return computeJourneyStats(byDay, now: _now);
}

Future<GoRouter> _pump(
  WidgetTester tester, {
  required JourneyStats stats,
  List<OnboardingGoal> goals = const [],
  Locale locale = const Locale('en'),
  ThemeMode themeMode = ThemeMode.light,
  double textScale = 1,
  Size size = const Size(390, 844),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  Widget stub(String name) => Scaffold(body: Text('stub:$name'));
  final router = GoRouter(
    initialLocation: '/journey',
    routes: [
      GoRoute(path: '/journey', builder: (_, _) => const JourneyScreen()),
      GoRoute(path: '/quran', builder: (_, _) => stub('quran')),
      GoRoute(path: '/dhikr', builder: (_, _) => stub('dhikr')),
      GoRoute(path: '/prayer', builder: (_, _) => stub('prayer')),
      GoRoute(path: '/duas', builder: (_, _) => stub('duas')),
      GoRoute(path: '/profile/reflections', builder: (_, _) => stub('reflections')),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        journeyStatsProvider.overrideWith((ref) => Stream.value(stats)),
        journeySelectedGoalsProvider.overrideWith((ref) => goals),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        locale: locale,
        theme: AppTheme.light(languageCode: locale.languageCode),
        darkTheme: AppTheme.dark(languageCode: locale.languageCode),
        themeMode: themeMode,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            disableAnimations: true,
            textScaler: TextScaler.linear(textScale),
          ),
          child: child!,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

void main() {
  testWidgets('brand-new user sees an inviting zero state', (tester) async {
    await _pump(tester, stats: _emptyStats());

    expect(find.text('Your Journey'), findsOneWidget);
    expect(find.text('Level 1'), findsOneWidget);
    expect(find.textContaining('Your garden awaits', findRichText: true), findsOneWidget);
    expect(
      find.text('Every garden begins with a single seed. One small act today plants yours.'),
      findsOneWidget,
    );
    expect(find.text('PLANT YOUR FIRST SEED'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Log a prayer'), 200);
    expect(find.text('Log a prayer'), findsOneWidget);
    // No goals chosen → gentle defaults with a hint.
    final hint =
        find.text("You haven't chosen focus areas yet — here are gentle places to begin.");
    await tester.scrollUntilVisible(hint, 200);
    expect(
      find.text("You haven't chosen focus areas yet — here are gentle places to begin."),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(find.text('0 of 7 reached'), 200);
    expect(find.text('0 of 7 reached'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('populated journey shows streak, stage, habits and goals', (tester) async {
    final stats = _populatedStats();
    expect(stats.currentStreak, 8);
    expect(stats.gardenStage, GardenStage.blooming);

    await _pump(
      tester,
      stats: stats,
      goals: const [OnboardingGoal.prayer, OnboardingGoal.consistency],
    );

    expect(find.textContaining('8 days of consistency', findRichText: true), findsOneWidget);
    expect(find.text('Blooming → Flourishing tree'), findsOneWidget);
    expect(find.text('Next in 13 days'), findsOneWidget);
    expect(find.text('PLANT YOUR FIRST SEED'), findsNothing);
    expect(find.text('Today is tended. Well done.'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Weekly habits'), 200);
    await tester.scrollUntilVisible(find.text('Reflection'), 200);
    expect(find.text('7 / 7 days'), findsNWidgets(3));
    expect(find.text('1 / 7 days'), findsOneWidget);

    await tester.scrollUntilVisible(find.textContaining('8-day streak'), 200);
    expect(find.textContaining('5 / 5 prayers today'), findsOneWidget);
    expect(find.textContaining('8-day streak'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('habit tiles link to the real destinations', (tester) async {
    final router = await _pump(tester, stats: _populatedStats());
    await tester.scrollUntilVisible(find.text('Reflection'), 200);
    await tester.ensureVisible(find.text('Reflection'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reflection'));
    await tester.pumpAndSettle();
    expect(find.text('stub:reflections'), findsOneWidget);
    expect(router.routerDelegate.currentConfiguration.uri.path, '/profile/reflections');
  });

  testWidgets('renders without overflow at 360px, text scale 1.3, dark, Arabic', (tester) async {
    await _pump(
      tester,
      stats: _populatedStats(),
      locale: const Locale('ar'),
      themeMode: ThemeMode.dark,
      textScale: 1.3,
      size: const Size(360, 780),
      goals: OnboardingGoal.values,
    );
    expect(find.text('رحلتك'), findsOneWidget);
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('zero state has no overflow at 360px, text scale 1.3, Arabic', (tester) async {
    await _pump(
      tester,
      stats: _emptyStats(),
      locale: const Locale('ar'),
      textScale: 1.3,
      size: const Size(360, 780),
    );
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
