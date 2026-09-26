import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../controllers/onboarding_controller.dart';
import 'steps/goals_step.dart';
import 'steps/language_step.dart';
import 'steps/location_step.dart';
import 'steps/notifications_step.dart';
import 'steps/prayer_preferences_step.dart';
import 'steps/welcome_step.dart';

/// Hosts the welcome screen plus the five numbered setup steps in one
/// `PageView` so back/forward and the progress indicator stay centrally
/// controlled, while each step is still its own small, focused widget.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  /// Welcome + 5 numbered steps.
  static const _pageCount = 6;
  static const _numberedSteps = _pageCount - 1;

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _next() => _goToPage((_page + 1).clamp(0, _pageCount - 1));

  void _back() => _goToPage((_page - 1).clamp(0, _pageCount - 1));

  /// Header "Skip": finish with whatever has been chosen so far (defaults
  /// otherwise) and go straight Home. Every choice is editable from Profile.
  Future<void> _skipSetup() async {
    await ref.read(onboardingControllerProvider.notifier).finish();
    if (mounted) context.go(AppRoutes.home);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Keep the (auto-disposed) controller alive for the whole flow: the
    // PageView disposes off-screen steps, which would otherwise drop the
    // choices collected so far whenever no visible step watches it.
    ref.watch(onboardingControllerProvider.select((_) => 0));
    return PopScope(
      canPop: _page == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _page > 0) _back();
      },
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _page = index),
        children: [
          WelcomeStep(onNext: _next),
          LanguageStep(
            stepIndex: 0,
            stepCount: _numberedSteps,
            onNext: _next,
            onBack: _back,
            onSkip: _skipSetup,
          ),
          LocationStep(
            stepIndex: 1,
            stepCount: _numberedSteps,
            onNext: _next,
            onBack: _back,
            onSkip: _skipSetup,
          ),
          PrayerPreferencesStep(
            stepIndex: 2,
            stepCount: _numberedSteps,
            onNext: _next,
            onBack: _back,
            onSkip: _skipSetup,
          ),
          NotificationsStep(
            stepIndex: 3,
            stepCount: _numberedSteps,
            onNext: _next,
            onBack: _back,
            onSkip: _skipSetup,
          ),
          GoalsStep(stepIndex: 4, stepCount: _numberedSteps, onBack: _back),
        ],
      ),
    );
  }
}
