import 'package:flutter/material.dart';

import 'steps/goals_step.dart';
import 'steps/language_step.dart';
import 'steps/location_step.dart';
import 'steps/notifications_step.dart';
import 'steps/prayer_preferences_step.dart';
import 'steps/welcome_step.dart';

/// Hosts the six onboarding steps in one `PageView` so swiping back/forward
/// and the step-position indicator stay centrally controlled, while each
/// step is still its own small, focused widget.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _step = 0;

  static const _stepCount = 6;

  void _goToStep(int step) {
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _next() => _goToStep((_step + 1).clamp(0, _stepCount - 1));

  void _back() => _goToStep((_step - 1).clamp(0, _stepCount - 1));

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _step > 0) _back();
      },
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _step = index),
        children: [
          WelcomeStep(stepIndex: 0, stepCount: _stepCount, onNext: _next),
          LanguageStep(stepIndex: 1, stepCount: _stepCount, onNext: _next, onBack: _back),
          LocationStep(stepIndex: 2, stepCount: _stepCount, onNext: _next, onBack: _back),
          PrayerPreferencesStep(
            stepIndex: 3,
            stepCount: _stepCount,
            onNext: _next,
            onBack: _back,
          ),
          NotificationsStep(stepIndex: 4, stepCount: _stepCount, onNext: _next, onBack: _back),
          GoalsStep(stepIndex: 5, stepCount: _stepCount, onBack: _back),
        ],
      ),
    );
  }
}
