import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/dhikr/presentation/dhikr_routes.dart';
import '../../features/duas/presentation/duas_routes.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/journey/presentation/journey_routes.dart';
import '../../features/onboarding/domain/onboarding_status_provider.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/prayer/presentation/screens/prayer_screen.dart';
import '../../features/profile/presentation/profile_routes.dart';
import '../../features/qibla/presentation/screens/qibla_screen.dart';
import '../../features/quran/presentation/quran_routes.dart';
import 'app_shell.dart';
import 'navigator_keys.dart';

part 'app_router.g.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const quran = '/quran';
  static const dhikr = '/dhikr';
  static const journey = '/journey';
  static const profile = '/profile';
  static const prayer = '/prayer';
  static const qibla = '/qibla';
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final onboardingComplete = ref.read(onboardingStatusProvider);
      final goingToOnboarding = state.matchedLocation == AppRoutes.onboarding;

      if (!onboardingComplete && !goingToOnboarding) {
        return AppRoutes.onboarding;
      }
      if (onboardingComplete && goingToOnboarding) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.prayer,
        builder: (context, state) => const PrayerScreen(),
      ),
      GoRoute(
        path: AppRoutes.qibla,
        builder: (context, state) => const QiblaScreen(),
      ),
      ...duasRoutes,
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(routes: quranRoutes),
          StatefulShellBranch(routes: dhikrRoutes),
          StatefulShellBranch(routes: journeyRoutes),
          StatefulShellBranch(routes: profileRoutes),
        ],
      ),
    ],
  );
}
