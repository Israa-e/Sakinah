import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../../../prayer/domain/prayer_models.dart';
import '../../../prayer/presentation/prayer_name_x.dart';
import '../../../prayer/presentation/providers/prayer_providers.dart';

String _formatRemaining(Duration d) {
  final positive = d.isNegative ? Duration.zero : d;
  final hours = positive.inHours;
  final minutes = positive.inMinutes.remainder(60);
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}

class HomePrayerCard extends ConsumerWidget {
  const HomePrayerCard({super.key});

  static const _approachingThreshold = Duration(minutes: 15);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final info = ref.watch(nextPrayerProvider);

    if (info == null) {
      return const SakinahCard(
        child: SizedBox(height: 140, child: SkeletonLoader()),
      );
    }

    final colorScheme = context.colors;
    final locale = Localizations.localeOf(context).languageCode;
    final isApproaching = info.remaining <= _approachingThreshold;

    return SakinahCard(
      color: colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.prayer.name.label(l10n).toUpperCase(),
                      style: context.textStyles.labelLarge
                          ?.copyWith(color: colorScheme.onPrimary.withValues(alpha: 0.8)),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      DateFormat.Hm(locale).format(info.prayer.time),
                      style: context.textStyles.displayMedium
                          ?.copyWith(color: colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: isApproaching
                      ? colorScheme.tertiary
                      : colorScheme.onPrimary.withValues(alpha: 0.15),
                  borderRadius: AppRadius.pillAll,
                ),
                child: Text(
                  l10n.prayerCountdown(_formatRemaining(info.remaining)),
                  style: context.textStyles.labelSmall?.copyWith(
                    color: isApproaching ? colorScheme.onTertiary : colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _PrayerTimeline(schedule: info.schedule, next: info.prayer, now: DateTime.now()),
          if (info.schedule.isEstimated) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.prayerEstimatedNotice,
              style: context.textStyles.labelSmall
                  ?.copyWith(color: colorScheme.onPrimary.withValues(alpha: 0.6)),
            ),
          ],
        ],
      ),
    );
  }
}

class _PrayerTimeline extends StatelessWidget {
  const _PrayerTimeline({required this.schedule, required this.next, required this.now});

  final PrayerSchedule schedule;
  final PrayerTime next;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = context.colors;
    final locale = Localizations.localeOf(context).languageCode;

    return Row(
      children: [
        for (final t in schedule.times)
          Expanded(
            child: _PrayerTimelineEntry(
              label: t.name.label(l10n),
              time: DateFormat.Hm(locale).format(t.time),
              isNext: t.name == next.name,
              isPast: t.time.isBefore(now) && t.name != next.name,
              onPrimary: colorScheme.onPrimary,
              accent: colorScheme.tertiary,
            ),
          ),
      ],
    );
  }
}

class _PrayerTimelineEntry extends StatelessWidget {
  const _PrayerTimelineEntry({
    required this.label,
    required this.time,
    required this.isNext,
    required this.isPast,
    required this.onPrimary,
    required this.accent,
  });

  final String label;
  final String time;
  final bool isNext;
  final bool isPast;
  final Color onPrimary;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final opacity = isPast ? 0.4 : (isNext ? 1.0 : 0.75);
    return Column(
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(bottom: AppSpacing.xxs),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isNext ? accent : onPrimary.withValues(alpha: opacity),
          ),
        ),
        Text(
          label,
          style: context.textStyles.labelSmall?.copyWith(color: onPrimary.withValues(alpha: opacity)),
        ),
        Text(
          time,
          style: context.textStyles.bodySmall?.copyWith(
            color: onPrimary.withValues(alpha: opacity),
            fontWeight: isNext ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
