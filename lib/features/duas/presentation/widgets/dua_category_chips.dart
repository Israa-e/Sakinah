import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../domain/dua.dart';
import 'dua_category_x.dart';

/// Horizontal "All + categories" chip row. [selected] `null` = All.
class DuaCategoryChips extends StatelessWidget {
  const DuaCategoryChips({
    required this.selected,
    required this.onSelected,
    super.key,
    this.padding = const EdgeInsetsDirectional.symmetric(horizontal: AppSpacing.lg),
  });

  final DuaCategory? selected;
  final ValueChanged<DuaCategory?> onSelected;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: padding,
        children: [
          DuaChip(
            label: context.l10n.duasCategoryAll,
            icon: Icons.stars,
            selected: selected == null,
            onTap: () => onSelected(null),
          ),
          for (final c in DuaCategory.values) ...[
            const SizedBox(width: AppSpacing.xs),
            DuaChip(
              label: c.label(context),
              selected: selected == c,
              onTap: () => onSelected(c),
            ),
          ],
        ],
      ),
    );
  }
}

class DuaChip extends StatelessWidget {
  const DuaChip({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fg = selected ? colors.onPrimary : colors.onSurfaceVariant;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? colors.primaryContainer : colors.surfaceContainerLow,
        shape: StadiumBorder(
          side: selected
              ? BorderSide.none
              : BorderSide(color: colors.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: fg),
                  const SizedBox(width: 6),
                ],
                Text(label, style: context.textStyles.labelMedium?.copyWith(color: fg)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
