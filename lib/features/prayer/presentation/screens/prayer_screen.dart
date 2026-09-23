import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_app_bar.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/sakinah_dropdown.dart';
import '../../../../core/widgets/states.dart';
import '../../domain/common_calculation_methods.dart';
import '../../domain/prayer_models.dart';
import '../../domain/prayer_notifications_provider.dart';
import '../../domain/prayer_settings_provider.dart';
import '../prayer_name_x.dart';
import '../providers/prayer_providers.dart';

class PrayerScreen extends ConsumerWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final scheduleAsync = ref.watch(todayPrayerScheduleProvider);
    final nextInfo = ref.watch(nextPrayerProvider);

    return Scaffold(
      appBar: SakinahAppBar(title: l10n.prayerScreenTitle, showBackButton: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          children: [
            scheduleAsync.when(
              loading: () => const SkeletonLoader(height: 220),
              error: (e, st) => ErrorState(message: l10n.errorGeneric),
              data: (schedule) => _ScheduleList(
                schedule: schedule,
                nextName: nextInfo?.prayer.name,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SakinahOutlinedButton(
              label: l10n.qiblaButton,
              icon: Icons.explore_outlined,
              onPressed: () => context.push(AppRoutes.qibla),
            ),
            const SizedBox(height: AppSpacing.xl),
            const _PrayerSettingsSection(),
          ],
        ),
      ),
    );
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({required this.schedule, required this.nextName});

  final PrayerSchedule schedule;
  final PrayerName? nextName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    return SakinahCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Column(
        children: [
          for (final t in schedule.times)
            ListTile(
              title: Text(t.name.label(l10n)),
              trailing: Text(
                DateFormat.Hm(locale).format(t.time),
                style: context.textStyles.bodyLarge?.copyWith(
                  fontWeight: t.name == nextName ? FontWeight.w700 : FontWeight.w400,
                  color: t.name == nextName ? context.colors.primary : null,
                ),
              ),
            ),
          if (schedule.isEstimated)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Text(
                l10n.prayerEstimatedNotice,
                style: context.textStyles.labelSmall
                    ?.copyWith(color: context.colors.onSurfaceVariant),
              ),
            ),
        ],
      ),
    );
  }
}

class _PrayerSettingsSection extends ConsumerWidget {
  const _PrayerSettingsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(prayerSettingsControllerProvider);
    final settingsController = ref.read(prayerSettingsControllerProvider.notifier);
    final notificationsEnabled = ref.watch(prayerNotificationsEnabledProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.prayerSettingsTitle, style: context.textStyles.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        Text(l10n.calculationMethodLabel, style: context.textStyles.labelLarge),
        const SizedBox(height: AppSpacing.xs),
        SakinahDropdown<CalculationMethod>(
          value: settings.calculationMethod,
          items: commonCalculationMethods,
          labelOf: (m) => m.displayName,
          onChanged: settingsController.setCalculationMethod,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.madhabLabel, style: context.textStyles.labelLarge),
        const SizedBox(height: AppSpacing.xs),
        SakinahDropdown<Madhab>(
          value: settings.madhab,
          items: Madhab.values,
          labelOf: (m) => m == Madhab.hanafi ? 'Hanafi' : "Shafi'i, Maliki & Hanbali",
          onChanged: settingsController.setMadhab,
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerHighest,
            borderRadius: AppRadius.mediumAll,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.prayerNotificationsLabel, style: context.textStyles.labelLarge),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      l10n.prayerNotificationsSubtitle,
                      style: context.textStyles.bodySmall
                          ?.copyWith(color: context.colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Switch(
                value: notificationsEnabled,
                onChanged: (value) {
                  ref.read(prayerNotificationsEnabledProvider.notifier).setEnabled(value);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
