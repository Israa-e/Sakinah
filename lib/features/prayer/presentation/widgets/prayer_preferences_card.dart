import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_bottom_sheet.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/sakinah_dropdown.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/profile_routes.dart';
import '../../domain/common_calculation_methods.dart';
import '../../domain/prayer_notifications_provider.dart';
import '../../domain/prayer_settings_provider.dart';

String madhabLabel(Madhab madhab, AppLocalizations l10n) =>
    madhab == Madhab.hanafi ? l10n.prayerMadhabHanafi : l10n.prayerMadhabShafi;

/// Calculation method / madhab summary (tap "Change" for a sheet with the
/// pickers, which also links on to Profile settings) and the prayer
/// notifications switch.
class PrayerPreferencesCard extends ConsumerWidget {
  const PrayerPreferencesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = context.colors;
    final settings = ref.watch(prayerSettingsControllerProvider);
    final notificationsEnabled = ref.watch(prayerNotificationsEnabledProvider);

    return SakinahCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardEyebrow(l10n.prayerSettingsTitle, icon: Icons.tune),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.calculationMethodLabel, style: context.textStyles.labelLarge),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      '${settings.calculationMethod.displayName} · '
                      '${madhabLabel(settings.madhab, l10n)}',
                      style: context.textStyles.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => showSakinahBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => const _PrayerSettingsSheet(),
                ),
                child: Text(l10n.prayerChangeSettings),
              ),
            ],
          ),
          Divider(height: AppSpacing.xl, color: context.palette.cardBorder),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.prayerNotificationsLabel, style: context.textStyles.labelLarge),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      l10n.prayerNotificationsSubtitle,
                      style: context.textStyles.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Switch(
                value: notificationsEnabled,
                onChanged: (value) {
                  ref.read(prayerNotificationsEnabledProvider.notifier).setEnabled(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrayerSettingsSheet extends ConsumerWidget {
  const _PrayerSettingsSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(prayerSettingsControllerProvider);
    final controller = ref.read(prayerSettingsControllerProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.prayerSettingsTitle, style: context.textStyles.titleLarge),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.calculationMethodLabel, style: context.textStyles.labelLarge),
        const SizedBox(height: AppSpacing.xs),
        SakinahDropdown<CalculationMethod>(
          value: settings.calculationMethod,
          items: commonCalculationMethods.contains(settings.calculationMethod)
              ? commonCalculationMethods
              : [settings.calculationMethod, ...commonCalculationMethods],
          labelOf: (m) => m.displayName,
          onChanged: controller.setCalculationMethod,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.madhabLabel, style: context.textStyles.labelLarge),
        const SizedBox(height: AppSpacing.xs),
        SakinahDropdown<Madhab>(
          value: settings.madhab,
          items: Madhab.values,
          labelOf: (m) => madhabLabel(m, l10n),
          onChanged: controller.setMadhab,
        ),
        const SizedBox(height: AppSpacing.md),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            onPressed: () {
              final router = GoRouter.of(context);
              Navigator.of(context).pop();
              router.go(ProfilePaths.root);
            },
            icon: const Icon(Icons.person_outline, size: 18),
            label: Text(l10n.prayerMoreSettings),
          ),
        ),
      ],
    );
  }
}
