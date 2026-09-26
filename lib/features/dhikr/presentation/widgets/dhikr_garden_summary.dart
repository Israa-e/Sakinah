import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/progress_indicators.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../journey/presentation/journey_routes.dart';
import '../providers/dhikr_providers.dart';
import 'dhikr_category_x.dart';

/// Compact "Garden Journey" view: today's dhikr progress and the week's
/// rhythm, with a hand-off to the Journey tab (which owns the full garden).
class DhikrGardenSummary extends ConsumerWidget {
  const DhikrGardenSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final summary = ref.watch(todayDhikrSummaryProvider).valueOrNull;
    final week = ref.watch(dhikrWeekSummariesProvider).valueOrNull ?? const <DhikrDaySummary>[];
    final activeDays = week.where((d) => d.hasAnyDhikr).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SakinahCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardEyebrow(l10n.dhikrGardenEyebrow, icon: Icons.local_florist_outlined),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.dhikrGardenTitle,
                style: context.textStyles.headlineMedium?.copyWith(color: context.colors.primary),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _Stat(
                      label: l10n.dhikrTodayCountLabel,
                      value: '${summary?.totalCount ?? 0}',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _Stat(
                      label: l10n.dhikrCompletedLabel,
                      value: '${summary?.completedCount ?? 0}/${summary?.itemCount ?? 0}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              for (final category in DhikrCategory.values) ...[
                _CategoryRow(category: category),
                const SizedBox(height: AppSpacing.sm),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SakinahCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: CardEyebrow(l10n.dhikrWeekTitle)),
                  Text(
                    l10n.dhikrDaysActive(activeDays),
                    style: context.textStyles.labelMedium?.copyWith(color: palette.gold),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [for (final day in week) _DayDot(day: day)],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        SakinahButton(
          label: l10n.dhikrOpenGarden,
          icon: Icons.park_outlined,
          onPressed: () => context.go(JourneyPaths.root),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLow,
        borderRadius: AppRadius.largeAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: context.textStyles.headlineMedium?.copyWith(color: context.colors.primary),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            label,
            style: context.textStyles.labelMedium?.copyWith(color: context.colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends ConsumerWidget {
  const _CategoryRow({required this.category});

  final DhikrCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final progress = ref.watch(dhikrCategoryProgressProvider(category));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(category.icon, size: 16, color: context.colors.secondary),
            const SizedBox(width: AppSpacing.xs),
            Expanded(child: Text(category.label(l10n), style: context.textStyles.labelMedium)),
            Text(
              '${progress.completed}/${progress.total}',
              style: context.textStyles.labelMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        ProgressBar(
          value: progress.ratio,
          height: 5,
          color: context.colors.tertiaryFixedDim,
          trackColor: context.colors.secondary.withValues(alpha: 0.2),
        ),
      ],
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.day});

  final DhikrDaySummary day;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final active = day.hasAnyDhikr;
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? context.colors.tertiaryFixedDim : Colors.transparent,
            border: Border.all(
              color: active
                  ? context.colors.tertiaryFixedDim
                  : context.colors.secondary.withValues(alpha: 0.3),
            ),
          ),
          child: active ? Icon(Icons.check, size: 14, color: palette.hero) : null,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          DateFormat.E(locale).format(day.day),
          style: context.textStyles.labelSmall?.copyWith(color: context.colors.onSurfaceVariant),
        ),
      ],
    );
  }
}
