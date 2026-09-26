import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/progress_indicators.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../dhikr/presentation/dhikr_routes.dart';
import '../../../profile/presentation/profile_routes.dart';
import '../../../quran/presentation/quran_routes.dart';
import '../../domain/journey_models.dart';

/// Section title used across the Journey screen (mockup: title-lg, primary).
class JourneySectionTitle extends StatelessWidget {
  const JourneySectionTitle(this.title, {super.key, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.xxs,
        end: AppSpacing.xxs,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: context.textStyles.titleLarge?.copyWith(color: context.colors.primary),
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: context.textStyles.labelSmall?.copyWith(color: context.palette.gold),
            ),
        ],
      ),
    );
  }
}

/// Level ring + streak card, side by side.
class JourneyLevelStreakRow extends StatelessWidget {
  const JourneyLevelStreakRow({required this.stats, super.key});

  final JourneyStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final text = context.textStyles;

    final streakHint = stats.isEmpty
        ? l10n.journeyStreakStart
        : stats.isActiveToday
            ? l10n.journeyStreakTendedToday
            : l10n.journeyStreakOpenToday;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SakinahCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardEyebrow(l10n.journeyLevelCardTitle, icon: Icons.auto_graph),
                  const SizedBox(height: AppSpacing.sm),
                  Center(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(end: stats.levelProgress),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      builder: (context, value, _) => CircularProgress(
                        value: value,
                        size: 80,
                        strokeWidth: 7,
                        color: colors.primary,
                        trackColor: colors.surfaceContainerHigh,
                        child: Text(
                          '${stats.level}',
                          style: text.headlineMedium?.copyWith(color: colors.primary),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.journeyXpToNext(stats.xpPerLevel - stats.xpIntoLevel),
                    style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: SakinahCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardEyebrow(l10n.journeyStreakTitle, icon: Icons.energy_savings_leaf_outlined),
                  const SizedBox(height: AppSpacing.sm),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${stats.currentStreak}',
                          style: text.displaySmall?.copyWith(color: colors.primary),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: l10n.journeyDaysUnit(stats.currentStreak),
                          style: text.titleMedium?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    l10n.journeyBestStreak(stats.bestStreak),
                    style: text.labelMedium?.copyWith(color: context.palette.gold),
                  ),
                  const Spacer(),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    streakHint,
                    style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Seven-day activity strip (bars scale with each day's XP) + deeds line.
class JourneyWeekCard extends StatelessWidget {
  const JourneyWeekCard({required this.stats, super.key});

  final JourneyStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final text = context.textStyles;
    final days = stats.last7Days;
    final maxXp = days.fold<int>(1, (m, d) => d.xp > m ? d.xp : m);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final weekday = DateFormat('EEEEE', locale);
    final fullDate = DateFormat.MMMEd(locale);

    return SakinahCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.journeyWeekTitle,
                  style: text.titleMedium?.copyWith(color: colors.onSurface),
                ),
              ),
              Text(
                l10n.journeyActiveDays(stats.weekTotals.activeDays),
                style: text.labelSmall?.copyWith(color: context.palette.gold),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              for (final day in days)
                Expanded(
                  child: _DayBar(
                    label: weekday.format(day.day),
                    semantic: fullDate.format(day.day),
                    fraction: day.isActive ? day.xp / maxXp : 0,
                    active: day.isActive,
                    isToday: day.day == stats.today,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(height: 1, color: colors.outlineVariant.withValues(alpha: 0.3)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(Icons.volunteer_activism_outlined, size: 18, color: context.palette.gold),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  l10n.journeyDeedsThisWeek(stats.weekTotals.deeds),
                  style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayBar extends StatelessWidget {
  const _DayBar({
    required this.label,
    required this.semantic,
    required this.fraction,
    required this.active,
    required this.isToday,
  });

  final String label;
  final String semantic;
  final double fraction;
  final bool active;
  final bool isToday;

  static const _maxHeight = 56.0;
  static const _minHeight = 10.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final height = active ? _minHeight + (_maxHeight - _minHeight) * fraction : _minHeight;
    return Semantics(
      label: semantic,
      excludeSemantics: true,
      child: Column(
        children: [
          SizedBox(
            height: _maxHeight,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: 14,
                height: height,
                decoration: BoxDecoration(
                  color: active ? colors.primary : colors.surfaceContainerHigh,
                  borderRadius: AppRadius.pillAll,
                  border: isToday && !active
                      ? Border.all(color: colors.primary.withValues(alpha: 0.6))
                      : null,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: context.textStyles.labelSmall?.copyWith(
              color: isToday ? colors.primary : colors.onSurfaceVariant,
              fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isToday ? context.palette.gold : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

/// 2×2 grid of weekly habit tiles (Quran, Prayer, Dhikr, Reflection). Each
/// tile opens the place where that habit is practised.
class JourneyHabitsGrid extends StatelessWidget {
  const JourneyHabitsGrid({required this.stats, super.key});

  final JourneyStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final w = stats.weekTotals;
    final tiles = [
      _HabitTile(
        icon: Icons.menu_book_outlined,
        title: l10n.goalQuran,
        subtitle: l10n.journeyAyahsTotal(w.ayahs),
        days: w.quranDays,
        onTap: () => context.go(QuranPaths.root),
      ),
      _HabitTile(
        icon: Icons.mosque_outlined,
        title: l10n.goalPrayer,
        subtitle: l10n.journeyPrayersTotal(w.prayers),
        days: w.prayerDays,
        onTap: () => context.push(AppRoutes.prayer),
      ),
      _HabitTile(
        icon: Icons.touch_app_outlined,
        title: l10n.goalDhikr,
        subtitle: l10n.journeyDhikrTotal(w.dhikr),
        days: w.dhikrDays,
        onTap: () => context.go(DhikrPaths.root),
      ),
      _HabitTile(
        icon: Icons.edit_note,
        title: l10n.journeyHabitReflection,
        subtitle: l10n.journeyReflectionsTotal(w.reflections),
        days: w.reflectionDays,
        onTap: () => context.go(ProfilePaths.reflections),
      ),
    ];

    Widget row(Widget a, Widget b) => IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: a),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: b),
            ],
          ),
        );

    return Column(
      children: [
        row(tiles[0], tiles[1]),
        const SizedBox(height: AppSpacing.sm),
        row(tiles[2], tiles[3]),
      ],
    );
  }
}

class _HabitTile extends StatelessWidget {
  const _HabitTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.days,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final int days;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final palette = context.palette;
    final text = context.textStyles;
    final complete = days >= 7;

    return SakinahCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: complete
                      ? palette.hero
                      : colors.secondaryContainer.withValues(alpha: 0.6),
                ),
                child: Icon(icon, size: 18, color: complete ? palette.onHero : colors.primary),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (complete)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: AppSpacing.xxs),
                        child: Icon(Icons.check_circle, size: 14, color: colors.primary),
                      ),
                    Flexible(
                      child: Text(
                        context.l10n.journeyHabitDays(days),
                        textAlign: TextAlign.end,
                        style: text.labelSmall?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(title, style: text.titleMedium?.copyWith(color: colors.onSurface)),
          Text(subtitle, style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
          const Spacer(),
          const SizedBox(height: AppSpacing.sm),
          ProgressBar(
            value: days / 7,
            height: 6,
            color: colors.primary,
            trackColor: colors.surfaceContainerHigh,
          ),
        ],
      ),
    );
  }
}
