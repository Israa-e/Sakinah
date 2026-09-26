import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../prayer_formatting.dart';
import '../prayer_name_x.dart';
import '../providers/prayer_providers.dart';

/// Deep-green "next prayer" focus card on the Prayer screen.
class NextPrayerHero extends ConsumerWidget {
  const NextPrayerHero({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(prayerDayStateProvider);
    if (state == null) return const SizedBox(height: 180);

    final l10n = context.l10n;
    final palette = context.palette;
    final locale = Localizations.localeOf(context).languageCode;
    final next = state.next;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [palette.hero, Color.lerp(palette.hero, Colors.black, 0.32)!],
        ),
        borderRadius: AppRadius.xLargeAll,
        boxShadow: palette.heroShadow,
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: -32,
            bottom: -40,
            child: ExcludeSemantics(
              child: Icon(Icons.mosque, size: 180, color: palette.onHero.withValues(alpha: 0.07)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm - 2,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: palette.onHero.withValues(alpha: 0.1),
                        borderRadius: AppRadius.pillAll,
                        border: Border.all(color: palette.onHero.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        l10n.prayerNextPrayer.toUpperCase(),
                        style: context.textStyles.labelSmall?.copyWith(color: palette.heroAccent),
                      ),
                    ),
                    const NextPrayerCountdownBadge(),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: Text(
                        next.name.label(l10n),
                        style: context.textStyles.displayMedium?.copyWith(color: palette.onHero),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      PrayerFormat.time(next.time, locale),
                      style: context.textStyles.displayMedium?.copyWith(
                        color: palette.onHero,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                if (state.schedule.isEstimated) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.prayerEstimatedNotice,
                    style: context.textStyles.bodySmall?.copyWith(color: palette.onHeroMuted),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "in 01:24" pill. Watches only the whole-minute countdown so it rebuilds
/// once a minute, and nothing around it rebuilds at all.
class NextPrayerCountdownBadge extends ConsumerWidget {
  const NextPrayerCountdownBadge({super.key, this.onHero = true});

  /// Styled for the deep-green hero (default) or for a light card row.
  final bool onHero;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minutes = ref.watch(
      nextPrayerProvider.select((i) => i == null ? null : PrayerFormat.minutesLeft(i.remaining)),
    );
    if (minutes == null) return const SizedBox.shrink();
    final palette = context.palette;
    final text = context.l10n.prayerCountdown(PrayerFormat.countdown(minutes));

    if (!onHero) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(color: palette.gold, borderRadius: AppRadius.smallAll),
        child: Text(
          text.toUpperCase(),
          style: context.textStyles.labelSmall?.copyWith(
            color: context.isDark ? context.colors.surface : context.colors.primary,
            fontSize: 10,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
      decoration: BoxDecoration(
        color: palette.onHero.withValues(alpha: 0.12),
        borderRadius: AppRadius.pillAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timelapse, size: 15, color: palette.onHero),
          const SizedBox(width: AppSpacing.xxs + 2),
          Text(text, style: context.textStyles.labelMedium?.copyWith(color: palette.onHero)),
        ],
      ),
    );
  }
}
