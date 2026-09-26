import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/progress_indicators.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../dhikr_routes.dart';
import '../providers/dhikr_providers.dart';
import 'dhikr_category_x.dart';

/// "Current cycle" card: the adhkar set that fits the time of day, today's
/// progress through it, and a Continue button to the first unfinished item.
class DhikrCycleCard extends ConsumerWidget {
  const DhikrCycleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final category = ref.watch(suggestedDhikrCategoryProvider);
    final progress = ref.watch(dhikrCategoryProgressProvider(category));
    final counts = ref.watch(todayDhikrCountsProvider).valueOrNull ?? const <String, int>{};
    final items = ref.watch(dhikrCatalogProvider).where((i) => i.category == category).toList();
    if (items.isEmpty) return const SizedBox.shrink();
    final nextItem = items.firstWhere(
      (i) => (counts[i.key] ?? 0) < i.targetCount,
      orElse: () => items.first,
    );
    final percent = (progress.ratio * 100).round();

    return SakinahCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: palette.gold, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(child: CardEyebrow(l10n.dhikrCurrentCycle)),
              Icon(category.icon, size: 20, color: palette.gold),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            category.label(l10n),
            style: context.textStyles.headlineMedium?.copyWith(color: context.colors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Text(
                  progress.isComplete
                      ? l10n.dhikrAllDoneToday
                      : l10n.dhikrCompletedOf(progress.completed, progress.total),
                  style: context.textStyles.labelMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                '$percent%',
                style: context.textStyles.labelMedium?.copyWith(color: palette.gold),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ProgressBar(
            value: progress.ratio,
            height: 6,
            color: context.colors.tertiaryFixedDim,
            trackColor: context.colors.secondary.withValues(alpha: 0.2),
          ),
          const SizedBox(height: AppSpacing.md),
          SakinahButton(
            label: l10n.continueLabel,
            icon: Icons.arrow_forward,
            onPressed: () => context.push(DhikrPaths.counter(nextItem.key)),
          ),
        ],
      ),
    );
  }
}
