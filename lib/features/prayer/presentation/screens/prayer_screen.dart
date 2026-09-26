import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/states.dart';
import '../prayer_formatting.dart';
import '../providers/prayer_providers.dart';
import '../widgets/next_prayer_hero.dart';
import '../widgets/prayer_preferences_card.dart';
import '../widgets/prayer_schedule_card.dart';
import '../widgets/sanctuary_header.dart';

/// "Prayer Times" half of the Qibla & Prayer sanctuary (`/prayer`): next
/// prayer hero, today's schedule with mark-as-prayed, and preferences.
class PrayerScreen extends ConsumerWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final scheduleAsync = ref.watch(todayPrayerScheduleProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SanctuaryTopBar(trailing: _LocationLabel()),
            const OfflineBanner(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                ),
                children: [
                  const SanctuarySegmentedControl(selected: SanctuaryTab.prayerTimes),
                  const SizedBox(height: AppSpacing.lg),
                  scheduleAsync.when(
                    loading: () => const Column(
                      children: [
                        SkeletonLoader(height: 180),
                        SizedBox(height: AppSpacing.lg),
                        SkeletonLoader(height: 320),
                      ],
                    ),
                    error: (e, st) => ErrorState(
                      message: l10n.errorGeneric,
                      retryLabel: l10n.retry,
                      onRetry: () => ref.invalidate(todayPrayerScheduleProvider),
                    ),
                    data: (_) => const Column(
                      children: [
                        NextPrayerHero(),
                        SizedBox(height: AppSpacing.lg),
                        PrayerScheduleCard(),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const PrayerPreferencesCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationLabel extends ConsumerWidget {
  const _LocationLabel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(todayPrayerScheduleProvider.select((s) => s.valueOrNull?.location));
    if (location == null) return const SizedBox.shrink();
    final colors = context.colors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.near_me_outlined, size: 16, color: context.palette.gold),
        const SizedBox(width: AppSpacing.xxs),
        Flexible(
          child: Text(
            PrayerFormat.coordinates(location, digits: 1),
            style: context.textStyles.labelMedium?.copyWith(color: colors.secondary),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textDirection: TextDirection.ltr,
          ),
        ),
      ],
    );
  }
}
