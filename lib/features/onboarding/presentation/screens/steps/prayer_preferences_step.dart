import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/widgets/sakinah_button.dart';
import '../../../domain/onboarding_models.dart';
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
          _Dropdown<CalculationMethod>(
            value: data.calculationMethod,
            items: CalculationMethod.values,
            labelOf: (m) => m.label,
            onChanged: controller.setCalculationMethod,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.madhabLabel, style: context.textStyles.labelLarge),
          const SizedBox(height: AppSpacing.xs),
          _Dropdown<Madhab>(
            value: data.madhab,
            items: Madhab.values,
            labelOf: (m) => m.label,
            onChanged: controller.setMadhab,
          ),
        ],
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  const _Dropdown({
    required this.value,
    required this.items,
    required this.labelOf,
    required this.onChanged,
    super.key,
  });

  final T value;
  final List<T> items;
  final String Function(T) labelOf;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: AppRadius.mediumAll,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          borderRadius: AppRadius.mediumAll,
          items: [
            for (final item in items)
              DropdownMenuItem(value: item, child: Text(labelOf(item))),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}
