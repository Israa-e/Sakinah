import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/widgets/sakinah_button.dart';
import '../../../../../core/widgets/sakinah_dropdown.dart';
import '../../../../prayer/domain/common_calculation_methods.dart';
import '../../controllers/onboarding_controller.dart';
import '../../widgets/onboarding_scaffold.dart';

class PrayerPreferencesStep extends ConsumerWidget {
  const PrayerPreferencesStep({
    required this.stepIndex,
    required this.stepCount,
    required this.onNext,
    required this.onBack,
    super.key,
  });

  final int stepIndex;
  final int stepCount;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final data = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return OnboardingScaffold(
      stepIndex: stepIndex,
      stepCount: stepCount,
      onBack: onBack,
      footer: SakinahButton(label: l10n.continueLabel, onPressed: onNext),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingPrayerPrefsTitle, style: context.textStyles.headlineLarge),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.calculationMethodLabel, style: context.textStyles.labelLarge),
          const SizedBox(height: AppSpacing.xs),
          SakinahDropdown<CalculationMethod>(
            value: data.calculationMethod,
            items: commonCalculationMethods,
            labelOf: (m) => m.displayName,
            onChanged: controller.setCalculationMethod,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.madhabLabel, style: context.textStyles.labelLarge),
          const SizedBox(height: AppSpacing.xs),
          SakinahDropdown<Madhab>(
            value: data.madhab,
            items: Madhab.values,
            labelOf: (m) => m == Madhab.hanafi ? 'Hanafi' : "Shafi'i, Maliki & Hanbali",
            onChanged: controller.setMadhab,
          ),
        ],
      ),
    );
  }
}
