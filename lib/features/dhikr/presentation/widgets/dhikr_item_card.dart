import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/progress_indicators.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../dhikr_routes.dart';
import '../providers/dhikr_providers.dart';
import 'dhikr_category_x.dart';

/// One adhkar entry in the sanctuary list: Arabic, transliteration,
/// translation, source and today's progress. Opens the counter on tap.
class DhikrItemCard extends ConsumerWidget {
  const DhikrItemCard({required this.item, super.key});

  final DhikrItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final count = ref.watch(
      todayDhikrCountsProvider.select((counts) => counts.valueOrNull?[item.key] ?? 0),
    );
    final done = count >= item.targetCount;
    final palette = context.palette;

    return SakinahCard(
      key: ValueKey('dhikr-card-${item.key}'),
      onTap: () => context.push(DhikrPaths.counter(item.key)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: CardEyebrow(item.category.label(l10n), icon: item.category.icon)),
              const SizedBox(width: AppSpacing.xs),
              _ProgressBadge(count: count, target: item.targetCount, done: done),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            item.arabic,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.start,
            style: context.sakinahTypography.quranTextMedium.copyWith(
              color: context.colors.primary,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.transliteration,
            style: context.textStyles.bodyMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: context.colors.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            item.translation,
            style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(Icons.verified_outlined, size: 14, color: palette.gold),
              const SizedBox(width: AppSpacing.xxs),
              Expanded(
                child: Text(
                  l10n.dhikrSource(item.sourceReference),
                  style: context.textStyles.labelSmall?.copyWith(color: palette.gold),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              CircularProgress(
                value: count / item.targetCount,
                size: 28,
                strokeWidth: 3,
                color: context.colors.tertiaryFixedDim,
                trackColor: context.colors.secondary.withValues(alpha: 0.2),
                child: done ? Icon(Icons.check, size: 14, color: palette.gold) : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressBadge extends StatelessWidget {
  const _ProgressBadge({required this.count, required this.target, required this.done});

  final int count;
  final int target;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
      decoration: BoxDecoration(
        color: done ? palette.hero : context.colors.surfaceContainer,
        borderRadius: AppRadius.pillAll,
      ),
      child: Text(
        done ? l10n.dhikrDone : l10n.dhikrTodayProgress(count, target),
        style: context.textStyles.labelSmall?.copyWith(
          color: done ? palette.onHero : context.colors.onSurfaceVariant,
        ),
      ),
    );
  }
}
