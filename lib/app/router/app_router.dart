import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/widgets/coming_soon_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/domain/onboarding_status_provider.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import 'app_shell.dart';

part 'app_router.g.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const quran = '/quran';
  static const dhikr = '/dhikr';
  static const journey = '/journey';
  static const profile = '/profile';
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.quran,
                builder: (context, state) =>
                    const ComingSoonScreen(icon: Icons.menu_book_outlined),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.dhikr,
                builder: (context, state) =>
                    const ComingSoonScreen(icon: Icons.self_improvement_outlined),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.journey,
                builder: (context, state) => const ComingSoonScreen(icon: Icons.eco_outlined),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) =>
                    const ComingSoonScreen(icon: Icons.person_outline),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
