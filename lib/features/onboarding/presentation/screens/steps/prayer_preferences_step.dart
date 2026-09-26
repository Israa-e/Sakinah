import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/widgets/sakinah_card.dart';
import '../../controllers/onboarding_controller.dart';
import '../../widgets/onboarding_scaffold.dart';
import '../../widgets/onboarding_widgets.dart';
import '../../widgets/prayer_preference_widgets.dart';

/// Mockup 14: calculation authority list + Asr (madhab) segmented toggle.
class PrayerPreferencesStep extends ConsumerWidget {
  const PrayerPreferencesStep({
    required this.stepIndex,
    required this.stepCount,
    required this.onNext,
    required this.onBack,
    super.key,
    this.onSkip,
  });

  final int stepIndex;
  final int stepCount;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final data = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final colors = context.colors;

    return OnboardingScaffold(
      stepIndex: stepIndex,
      stepCount: stepCount,
      onBack: onBack,
      onSkip: onSkip,
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingPillButton(label: l10n.onboardingConfirmContinue, onPressed: onNext),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.onboardingSettingsHint,
            textAlign: TextAlign.center,
            style: context.textStyles.bodySmall?.copyWith(color: colors.secondary),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.onboardingPrayerPrefsTitle,
            style: context.textStyles.headlineMedium?.copyWith(color: colors.primary),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.onboardingPrayerPrefsSubtitle,
            style: context.textStyles.bodyMedium?.copyWith(color: colors.secondary),
          ),
          const SizedBox(height: AppSpacing.xl),
          CardEyebrow(l10n.onboardingCalcAuthority),
          const SizedBox(height: AppSpacing.sm),
          CalculationMethodList(
            value: data.calculationMethod,
            onChanged: controller.setCalculationMethod,
          ),
          const SizedBox(height: AppSpacing.md),
          CardEyebrow(l10n.onboardingMadhabSection),
          const SizedBox(height: AppSpacing.sm),
          MadhabSelector(value: data.madhab, onChanged: controller.setMadhab),
        ],
      ),
    );
  }
}
