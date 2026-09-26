import 'package:flutter/material.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/progress_indicators.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../domain/journey_models.dart';
import '../journey_l10n_x.dart';
import 'garden_illustration.dart';

/// Hero card: level + XP bar, the growing garden, streak chip and the
/// stage-progress ribbon.
class JourneyGardenCard extends StatelessWidget {
  const JourneyGardenCard({required this.stats, super.key});

  final JourneyStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final text = context.textStyles;
    final palette = context.palette;

    return SakinahCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: AppRadius.cardAll,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [
                colors.surfaceContainerLow.withValues(alpha: 0.7),
                colors.surfaceContainerLow.withValues(alpha: 0),
                colors.secondaryContainer.withValues(alpha: 0.25),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xxs,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _Pill(
                            label: l10n.journeyLevel(stats.level),
                            background: colors.secondaryContainer,
                            foreground: colors.primary,
                          ),
                          Text(
                            l10n.journeyLevelCaption,
                            style: text.labelMedium?.copyWith(color: colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      l10n.journeyXpProgress(stats.xpIntoLevel, stats.xpPerLevel),
                      style: text.labelSmall?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                TweenAnimationBuilder<double>(
                  tween: Tween(end: stats.levelProgress),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  builder: (context, value, _) => ProgressBar(
                    value: value,
                    color: colors.primary,
                    trackColor: colors.surfaceContainerHigh,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLow.withValues(alpha: 0.6),
                    borderRadius: AppRadius.mediumAll,
                    border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      GardenIllustration(stage: stats.gardenStage),
                      const SizedBox(height: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xxs,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLowest,
                          borderRadius: AppRadius.pillAll,
                          border: Border.all(color: palette.cardBorder),
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(end: AppSpacing.xxs),
                                  child: Icon(
                                    Icons.energy_savings_leaf_outlined,
                                    size: 15,
                                    color: colors.primary,
                                  ),
                                ),
                              ),
                              TextSpan(text: l10n.journeyStreakDays(stats.currentStreak)),
                              TextSpan(
                                text: '  •  ',
                                style: TextStyle(color: palette.gold, fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                text: stats.gardenStage.label(l10n),
                                style: TextStyle(color: palette.gold),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: text.labelSmall?.copyWith(color: colors.primary),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        stats.gardenStage.message(l10n),
                        textAlign: TextAlign.center,
                        style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Divider(height: 1, color: colors.outlineVariant.withValues(alpha: 0.3)),
                const SizedBox(height: AppSpacing.sm),
                _StageRibbon(stats: stats),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StageRibbon extends StatelessWidget {
  const _StageRibbon({required this.stats});

  final JourneyStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final text = context.textStyles;
    final next = stats.nextStage;
    final days = stats.daysToNextStage;

    return Row(
      children: [
        Icon(Icons.yard_outlined, size: 18, color: context.palette.gold),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            next == null
                ? stats.gardenStage.label(l10n)
                : l10n.journeyStageProgress(stats.gardenStage.label(l10n), next.label(l10n)),
            style: text.labelMedium?.copyWith(color: colors.primary),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: _Pill(
            label: days == null ? l10n.journeyStageMax : l10n.journeyNextInDays(days),
            background: colors.surfaceContainer,
            foreground: colors.secondary,
          ),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.background, required this.foreground});

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
      decoration: BoxDecoration(color: background, borderRadius: AppRadius.pillAll),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: context.textStyles.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
