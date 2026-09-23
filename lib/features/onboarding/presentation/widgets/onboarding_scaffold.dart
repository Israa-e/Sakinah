import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';

/// Shared frame for every onboarding step: consistent padding, an optional
/// back affordance, a step-position indicator, and a bottom-pinned action
/// area so every screen's primary button lands in the same place.
class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    required this.body,
    required this.stepIndex,
    required this.stepCount,
    super.key,
    this.onBack,
    this.footer,
  });

  final Widget body;
  final int stepIndex;
  final int stepCount;
  final VoidCallback? onBack;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (onBack != null)
                    IconButton(
                      onPressed: onBack,
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    )
                  else
                    const SizedBox(height: 48),
                  const Spacer(),
                  _StepDots(current: stepIndex, count: stepCount),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(child: body),
              ?footer,
            ],
          ),
        ),
      ),
    );
  }
}

class _StepDots extends StatelessWidget {
  const _StepDots({required this.current, required this.count});

  final int current;
  final int count;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == current ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: i == current ? colorScheme.primary : colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}
