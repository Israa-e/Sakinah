import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/progress_indicators.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../dhikr/presentation/dhikr_routes.dart';
import '../../../duas/presentation/duas_routes.dart';
import '../../../onboarding/domain/onboarding_models.dart';
import '../../../quran/presentation/quran_routes.dart';
import '../../domain/journey_models.dart';
import '../journey_l10n_x.dart';

/// Gentle first-run card: shown while nothing has been logged yet.
class JourneyStartCard extends StatelessWidget {
  const JourneyStartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = context.textStyles;
    return SakinahCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardEyebrow(l10n.journeyStartTitle, icon: Icons.grass_outlined),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.journeyStartBody,
            style: text.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          JourneyActionButton.outlined(
            label: l10n.journeyActionLogPrayer,
            icon: Icons.mosque_outlined,
            onPressed: () => context.push(AppRoutes.prayer),
          ),
          const SizedBox(height: AppSpacing.xs),
          JourneyActionButton.outlined(
            label: l10n.journeyActionRead,
            icon: Icons.menu_book_outlined,
            onPressed: () => context.go(QuranPaths.root),
          ),
          const SizedBox(height: AppSpacing.xs),
          JourneyActionButton.outlined(
            label: l10n.journeyActionDhikr,
            icon: Icons.touch_app_outlined,
            onPressed: () => context.go(DhikrPaths.root),
          ),
        ],
      ),
    );
  }
}

/// The user's onboarding focus areas with today's progress where measurable.
class JourneyGoalsList extends StatelessWidget {
  const JourneyGoalsList({required this.goals, required this.stats, super.key});

  final List<OnboardingGoal> goals;
  final JourneyStats stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (i, goal) in goals.indexed) ...[
          if (i > 0) const SizedBox(height: AppSpacing.sm),
          _GoalCard(goal: goal, stats: stats),
        ],
      ],
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({required this.goal, required this.stats});

  final OnboardingGoal goal;
  final JourneyStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final palette = context.palette;
    final text = context.textStyles;
    final today = stats.todayActivity;

    final (IconData icon, String title, String status, double? progress, bool done,
        VoidCallback? onTap) = switch (goal) {
      OnboardingGoal.prayer => (
          Icons.mosque_outlined,
          l10n.goalPrayer,
          l10n.journeyGoalPrayerProgress(today.prayers.clamp(0, 5)),
          today.prayers / 5,
          today.prayers >= 5,
          () => context.push(AppRoutes.prayer),
        ),
      OnboardingGoal.quran => (
          Icons.menu_book_outlined,
          l10n.goalQuran,
          l10n.journeyGoalQuranProgress(today.ayahs),
          null,
          today.ayahs > 0,
          () => context.go(QuranPaths.root),
        ),
      OnboardingGoal.dhikr => (
          Icons.touch_app_outlined,
          l10n.goalDhikr,
          l10n.journeyGoalDhikrProgress(today.dhikr),
          null,
          today.dhikr > 0,
          () => context.go(DhikrPaths.root),
        ),
      OnboardingGoal.dua => (
          Icons.volunteer_activism_outlined,
          l10n.goalDua,
          l10n.journeyGoalDuaHint,
          null,
          false,
          () => context.push(DuasPaths.library),
        ),
      OnboardingGoal.memorization => (
          Icons.favorite_outline,
          l10n.goalMemorization,
          l10n.journeyGoalMemorizationHint,
          null,
          false,
          () => context.go(QuranPaths.root),
        ),
      OnboardingGoal.consistency => (
          Icons.forest_outlined,
          l10n.goalConsistency,
          l10n.journeyGoalConsistencyProgress(stats.currentStreak),
          null,
          stats.isActiveToday,
          null,
        ),
    };

    return SakinahCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.secondaryContainer.withValues(alpha: 0.6),
            ),
            child: Icon(icon, size: 22, color: colors.primary),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: text.titleMedium?.copyWith(color: colors.onSurface)),
                const SizedBox(height: 2),
                Text(
                  done ? '${l10n.journeyGoalDoneToday} · $status' : status,
                  style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                ),
                if (progress != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  ProgressBar(
                    value: progress,
                    height: 6,
                    color: colors.primary,
                    trackColor: colors.surfaceContainerHigh,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          if (done)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(shape: BoxShape.circle, color: palette.hero),
              child: Icon(Icons.check, size: 16, color: palette.onHero),
            )
          else if (onTap != null)
            Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
        ],
      ),
    );
  }
}

/// Wrap of milestone chips — reached ones are filled, the rest quietly locked.
class JourneyMilestones extends StatelessWidget {
  const JourneyMilestones({required this.reached, super.key});

  final Set<JourneyMilestone> reached;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final text = context.textStyles;
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (final m in JourneyMilestone.values)
          Builder(
            builder: (context) {
              final isReached = reached.contains(m);
              final fg = isReached ? colors.onSecondaryContainer : colors.onSurfaceVariant;
              return Semantics(
                label: isReached ? m.label(l10n) : '${m.label(l10n)}, ${l10n.journeyMilestoneLocked}',
                excludeSemantics: true,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: isReached
                        ? colors.secondaryContainer
                        : colors.surfaceContainer.withValues(alpha: 0.7),
                    borderRadius: AppRadius.pillAll,
                    border: Border.all(
                      color: isReached
                          ? context.palette.gold.withValues(alpha: 0.5)
                          : context.palette.cardBorder,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isReached ? m.icon : Icons.lock_outline,
                        size: 16,
                        color: isReached ? context.palette.gold : fg.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: AppSpacing.xxs),
                      Flexible(
                        child: Text(
                          m.label(l10n),
                          style: text.labelMedium?.copyWith(
                            color: isReached ? fg : fg.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

/// Full-width button whose label wraps instead of overflowing (the shared
/// Sakinah buttons keep their label on one line, which overflows at large
/// text scales in Arabic).
class JourneyActionButton extends StatelessWidget {
  const JourneyActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  }) : _outlined = false;

  const JourneyActionButton.outlined({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  }) : _outlined = true;

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool _outlined;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: AppSpacing.xs),
        Flexible(child: Text(label, textAlign: TextAlign.center)),
      ],
    );
    return SizedBox(
      width: double.infinity,
      child: _outlined
          ? OutlinedButton(onPressed: onPressed, child: child)
          : ElevatedButton(onPressed: onPressed, child: child),
    );
  }
}
