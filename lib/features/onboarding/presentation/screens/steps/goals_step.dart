import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_router.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/widgets/sakinah_button.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/onboarding_models.dart';
import '../../controllers/onboarding_controller.dart';
import '../../widgets/onboarding_scaffold.dart';

class GoalsStep extends ConsumerWidget {
  const GoalsStep({
    required this.stepIndex,
    required this.stepCount,
    required this.onBack,
    super.key,
  });

  final int stepIndex;
  final int stepCount;
  final VoidCallback onBack;

  String _labelFor(AppLocalizations l10n, OnboardingGoal goal) => switch (goal) {
        OnboardingGoal.quran => l10n.goalQuran,
        OnboardingGoal.prayer => l10n.goalPrayer,
        OnboardingGoal.dhikr => l10n.goalDhikr,
        OnboardingGoal.dua => l10n.goalDua,
        OnboardingGoal.memorization => l10n.goalMemorization,
        OnboardingGoal.consistency => l10n.goalConsistency,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final data = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final colorScheme = context.colors;

    return OnboardingScaffold(
      stepIndex: stepIndex,
      stepCount: stepCount,
      onBack: onBack,
      footer: SakinahButton(
        label: l10n.beginJourney,
        onPressed: () async {
          await controller.finish();
          if (context.mounted) context.go(AppRoutes.home);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingGoalsTitle, style: context.textStyles.headlineLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.onboardingGoalsSubtitle,
            style: context.textStyles.bodyMedium
                ?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final goal in OnboardingGoal.values)
                _GoalChip(
                  label: _labelFor(l10n, goal),
                  selected: data.goals.contains(goal),
                  onTap: () => controller.toggleGoal(goal),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GoalChip extends StatelessWidget {
  const _GoalChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Material(
      color: selected ? colorScheme.primary : colorScheme.surfaceContainerHighest,
      borderRadius: AppRadius.pillAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.pillAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Text(
            label,
            style: context.textStyles.bodyMedium?.copyWith(
              color: selected ? colorScheme.onPrimary : colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
