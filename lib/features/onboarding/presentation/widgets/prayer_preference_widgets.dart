import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../prayer/data/calculation_method_x.dart';
import '../../../prayer/domain/common_calculation_methods.dart';
import 'onboarding_widgets.dart';

/// Localized name for a calculation method; falls back to adhan_dart's own
/// English display name for methods outside the curated list.
String calculationMethodName(AppLocalizations l10n, CalculationMethod method) => switch (method) {
  CalculationMethod.muslimWorldLeague => l10n.onboardingMethodMwl,
  CalculationMethod.egyptian => l10n.onboardingMethodEgyptian,
  CalculationMethod.karachi => l10n.onboardingMethodKarachi,
  CalculationMethod.ummAlQura => l10n.onboardingMethodUmmAlQura,
  CalculationMethod.northAmerica => l10n.onboardingMethodIsna,
  CalculationMethod.gulfRegion => l10n.onboardingMethodGulf,
  CalculationMethod.singapore => l10n.onboardingMethodSingapore,
  CalculationMethod.turkiye => l10n.onboardingMethodTurkiye,
  CalculationMethod.moonsightingCommittee => l10n.onboardingMethodMoonsighting,
  _ => method.displayName,
};

String _formatAngle(double value) =>
    value == value.roundToDouble() ? value.toInt().toString() : value.toString();

/// "Fajr 18°, Isha 17°" — read straight from adhan_dart's parameters for the
/// method, never hand-written.
String calculationMethodDetails(AppLocalizations l10n, CalculationMethod method) {
  final params = method.toParameters();
  final fajr = _formatAngle(params.fajrAngle);
  final interval = params.ishaInterval ?? 0;
  if (interval > 0) {
    return l10n.onboardingMethodAnglesInterval(fajr, interval);
  }
  return l10n.onboardingMethodAngles(fajr, _formatAngle(params.ishaAngle));
}

String madhabName(AppLocalizations l10n, Madhab madhab) => switch (madhab) {
  Madhab.shafi => l10n.onboardingMadhabStandard,
  Madhab.hanafi => l10n.onboardingMadhabHanafi,
};

/// Radio list of the curated calculation methods as sanctuary cards.
class CalculationMethodList extends StatelessWidget {
  const CalculationMethodList({required this.value, required this.onChanged, super.key});

  final CalculationMethod value;
  final ValueChanged<CalculationMethod> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final methods = commonCalculationMethods.contains(value)
        ? commonCalculationMethods
        : [value, ...commonCalculationMethods];
    return Column(
      children: [
        for (final method in methods) ...[
          SelectableOptionCard(
            key: ValueKey('calc-method-${method.name}'),
            selected: method == value,
            onTap: () => onChanged(method),
            title: calculationMethodName(l10n, method),
            subtitle: calculationMethodDetails(l10n, method),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

/// Two-cell segmented selector for the Asr juristic method with a short,
/// neutral explanation of each (shadow-length factor).
class MadhabSelector extends StatelessWidget {
  const MadhabSelector({required this.value, required this.onChanged, super.key});

  final Madhab value;
  final ValueChanged<Madhab> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh.withValues(alpha: 0.5),
        borderRadius: AppRadius.largeAll,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _MadhabCell(
                key: const ValueKey('madhab-shafi'),
                selected: value == Madhab.shafi,
                title: l10n.onboardingMadhabStandard,
                schools: l10n.onboardingMadhabStandardSchools,
                description: l10n.onboardingMadhabStandardDesc,
                onTap: () => onChanged(Madhab.shafi),
              ),
            ),
            const SizedBox(width: AppSpacing.xxs),
            Expanded(
              child: _MadhabCell(
                key: const ValueKey('madhab-hanafi'),
                selected: value == Madhab.hanafi,
                title: l10n.onboardingMadhabHanafi,
                schools: l10n.onboardingMadhabHanafiSchools,
                description: l10n.onboardingMadhabHanafiDesc,
                onTap: () => onChanged(Madhab.hanafi),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MadhabCell extends StatelessWidget {
  const _MadhabCell({
    required this.selected,
    required this.title,
    required this.schools,
    required this.description,
    required this.onTap,
    super.key,
  });

  final bool selected;
  final String title;
  final String schools;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = onboardingAccent(context);
    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      button: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selected ? colors.surfaceContainerLowest : Colors.transparent,
          borderRadius: AppRadius.mediumAll,
          border: Border.all(color: selected ? accent.withValues(alpha: 0.3) : Colors.transparent),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: AppRadius.mediumAll,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: context.textStyles.bodyMedium?.copyWith(
                            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                            color: selected ? colors.primary : colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                      if (selected) Icon(Icons.check_circle, size: 18, color: accent),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    schools,
                    style: context.textStyles.bodySmall?.copyWith(color: colors.secondary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: context.textStyles.labelSmall?.copyWith(
                      color: colors.outline,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
