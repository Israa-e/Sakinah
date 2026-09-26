import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/states.dart';
import '../../../profile/presentation/profile_routes.dart';
import '../../domain/journey_models.dart';
import '../providers/journey_providers.dart';
import '../widgets/journey_garden_card.dart';
import '../widgets/journey_goals_milestones.dart';
import '../widgets/journey_progress_widgets.dart';

/// Journey tab root: the spiritual garden, streak, level, weekly rhythm,
/// intentions and milestones — all derived live from the user's activity.
class JourneyScreen extends ConsumerWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(journeyStatsProvider);
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          children: [
            const _JourneyHeader(),
            const SizedBox(height: AppSpacing.xl),
            ...switch (stats) {
              AsyncData(:final value) => _content(context, ref, value),
              AsyncError() => [
                  ErrorState(
                    message: l10n.journeyError,
                    retryLabel: l10n.retry,
                    onRetry: () => ref.invalidate(journeyStatsProvider),
                  ),
                ],
              _ => const [
                  Padding(
                    padding: EdgeInsets.only(top: AppSpacing.huge),
                    child: LoadingState(),
                  ),
                ],
            },
          ],
        ),
      ),
    );
  }

  List<Widget> _content(BuildContext context, WidgetRef ref, JourneyStats stats) {
    final l10n = context.l10n;
    final selected = ref.watch(journeySelectedGoalsProvider);
    final goals = selected.isEmpty ? journeyDefaultGoals : selected;

    return [
      JourneyGardenCard(stats: stats),
      if (stats.isEmpty) ...[
        const SizedBox(height: AppSpacing.md),
        const JourneyStartCard(),
      ],
      const SizedBox(height: AppSpacing.md),
      JourneyLevelStreakRow(stats: stats),
      const SizedBox(height: AppSpacing.md),
      JourneyWeekCard(stats: stats),
      const SizedBox(height: AppSpacing.xl),
      JourneySectionTitle(l10n.journeyHabitsTitle),
      JourneyHabitsGrid(stats: stats),
      const SizedBox(height: AppSpacing.xl),
      JourneySectionTitle(l10n.journeyGoalsTitle),
      if (selected.isEmpty)
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: AppSpacing.xxs,
            end: AppSpacing.xxs,
            bottom: AppSpacing.sm,
          ),
          child: Text(
            l10n.journeyGoalsDefaultHint,
            style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
          ),
        ),
      JourneyGoalsList(goals: goals, stats: stats),
      const SizedBox(height: AppSpacing.xl),
      JourneySectionTitle(
        l10n.journeyMilestonesTitle,
        trailing: l10n.journeyMilestonesCount(
          stats.milestones.length,
          JourneyMilestone.values.length,
        ),
      ),
      JourneyMilestones(reached: stats.milestones),
      const SizedBox(height: AppSpacing.xl),
      JourneyActionButton(
        label: l10n.journeyActionReflect,
        icon: Icons.edit_calendar_outlined,
        onPressed: () => context.go(ProfilePaths.reflections),
      ),
      const SizedBox(height: AppSpacing.md),
      Text(
        l10n.journeyXpNote,
        textAlign: TextAlign.center,
        style: context.textStyles.labelSmall?.copyWith(color: context.colors.onSurfaceVariant),
      ),
    ];
  }
}

class _JourneyHeader extends StatelessWidget {
  const _JourneyHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.journeyEyebrow.toUpperCase(),
                style: context.textStyles.labelSmall?.copyWith(
                  color: context.palette.gold,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Semantics(
                header: true,
                child: Text(
                  l10n.journeyTitle,
                  style: context.textStyles.headlineMedium?.copyWith(color: colors.primary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: Text(
            l10n.journeyGardenName,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.end,
            style: context.sakinahTypography.arabicHeading.copyWith(color: colors.primary),
          ),
        ),
      ],
    );
  }
}
