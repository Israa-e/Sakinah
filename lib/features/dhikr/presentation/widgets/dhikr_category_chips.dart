import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../providers/dhikr_providers.dart';
import 'dhikr_category_x.dart';

/// Horizontal category filter chips plus the "x of y completed" pill for the
/// current selection.
class DhikrCategoryChips extends ConsumerWidget {
  const DhikrCategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final selected = ref.watch(dhikrCategoryFilterProvider);
    final progress = ref.watch(dhikrCategoryProgressProvider(selected));
    final options = <DhikrCategory?>[null, ...DhikrCategory.values];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final option in options) ...[
                if (option != options.first) const SizedBox(width: AppSpacing.xs),
                _chip(context, ref, option, selected: option == selected),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerLow,
            borderRadius: AppRadius.pillAll,
            border: Border.all(color: palette.cardBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: palette.gold, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  '${selected == null ? l10n.dhikrCategoryAll : selected.label(l10n)} • '
                  '${l10n.dhikrCompletedOf(progress.completed, progress.total)}',
                  style: context.textStyles.labelMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chip(
    BuildContext context,
    WidgetRef ref,
    DhikrCategory? option, {
    required bool selected,
  }) {
    final l10n = context.l10n;
    final palette = context.palette;
    return ChoiceChip(
      label: Text(option == null ? l10n.dhikrCategoryAll : option.label(l10n)),
      avatar: option == null
          ? null
          : Icon(
              option.icon,
              size: 16,
              color: selected ? palette.onHero : context.colors.secondary,
            ),
      showCheckmark: false,
      selected: selected,
      selectedColor: palette.hero,
      labelStyle: context.textStyles.labelMedium?.copyWith(
        color: selected ? palette.onHero : context.colors.onSurfaceVariant,
      ),
      shape: const StadiumBorder(),
      side: BorderSide(color: palette.cardBorder),
      onSelected: (_) => ref.read(dhikrCategoryFilterProvider.notifier).select(option),
    );
  }
}
