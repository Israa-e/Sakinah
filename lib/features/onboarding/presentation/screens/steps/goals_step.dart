import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_router.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/onboarding_models.dart';
import '../../controllers/onboarding_controller.dart';
import '../../widgets/onboarding_scaffold.dart';
import '../../widgets/onboarding_widgets.dart';

/// Mockup 06: multi-select focus areas plus an optional display name that
/// Home greets the user with.
class GoalsStep extends ConsumerStatefulWidget {
  const GoalsStep({
    required this.stepIndex,
    required this.stepCount,
    required this.onBack,
    super.key,
  });

  final int stepIndex;
  final int stepCount;
  final VoidCallback onBack;

  @override
  ConsumerState<GoalsStep> createState() => _GoalsStepState();
}

class _GoalsStepState extends ConsumerState<GoalsStep> {
  late final TextEditingController _name = TextEditingController(
    text: ref.read(onboardingControllerProvider).displayName,
  );
  bool _finishing = false;

  static String _labelFor(AppLocalizations l10n, OnboardingGoal goal) => switch (goal) {
    OnboardingGoal.quran => l10n.onboardingGoalQuranTitle,
    OnboardingGoal.prayer => l10n.onboardingGoalPrayerTitle,
    OnboardingGoal.dhikr => l10n.onboardingGoalDhikrTitle,
    OnboardingGoal.dua => l10n.onboardingGoalDuaTitle,
    OnboardingGoal.consistency => l10n.onboardingGoalConsistencyTitle,
    OnboardingGoal.memorization => l10n.onboardingGoalMemorizationTitle,
  };

  static IconData _iconFor(OnboardingGoal goal) => switch (goal) {
    OnboardingGoal.quran => Icons.menu_book,
    OnboardingGoal.prayer => Icons.mosque,
    OnboardingGoal.dhikr => Icons.touch_app,
    OnboardingGoal.dua => Icons.self_improvement,
    OnboardingGoal.consistency => Icons.forest,
    OnboardingGoal.memorization => Icons.favorite,
  };

  static const _order = [
    OnboardingGoal.quran,
    OnboardingGoal.prayer,
    OnboardingGoal.dhikr,
    OnboardingGoal.dua,
    OnboardingGoal.consistency,
    OnboardingGoal.memorization,
  ];

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    setState(() => _finishing = true);
    final controller = ref.read(onboardingControllerProvider.notifier)..setDisplayName(_name.text);
    await controller.finish();
    if (mounted) context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final data = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final colors = context.colors;

    return OnboardingScaffold(
      stepIndex: widget.stepIndex,
      stepCount: widget.stepCount,
      onBack: widget.onBack,
      footer: OnboardingPillButton(
        label: l10n.onboardingComplete,
        isLoading: _finishing,
        onPressed: _finish,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OnboardingHeading(
            icon: Icons.yard,
            title: l10n.onboardingGoalsTitle,
            subtitle: l10n.onboardingGoalsSubtitle,
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.onboardingNameLabel, style: context.textStyles.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          TextField(
            key: const ValueKey('onboarding-name'),
            controller: _name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            maxLength: 40,
            onChanged: controller.setDisplayName,
            decoration: InputDecoration(
              hintText: l10n.onboardingNameHint,
              prefixIcon: const Icon(Icons.person_outline),
              counterText: '',
              border: const OutlineInputBorder(borderRadius: AppRadius.largeAll),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final goal in _order) ...[
            SelectableOptionCard(
              key: ValueKey('goal-${goal.name}'),
              isRadio: false,
              selected: data.goals.contains(goal),
              onTap: () => controller.toggleGoal(goal),
              leading: OptionLeadingBadge(
                selected: data.goals.contains(goal),
                child: Icon(_iconFor(goal)),
              ),
              title: _labelFor(l10n, goal),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          const SizedBox(height: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.secondaryContainer.withValues(alpha: context.isDark ? 0.15 : 0.4),
              borderRadius: AppRadius.largeAll,
              border: Border.all(color: colors.secondaryContainer),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, size: 20, color: onboardingAccent(context)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.onboardingGoalsTip,
                    style: context.textStyles.bodySmall?.copyWith(
                      color: colors.onSecondaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
