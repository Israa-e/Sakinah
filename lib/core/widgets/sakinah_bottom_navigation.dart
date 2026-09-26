import 'package:flutter/material.dart';

import '../../app/theme/sakinah_palette.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';

class SakinahNavItem {
  const SakinahNavItem({required this.icon, required this.selectedIcon, required this.label});

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// The five-tab shell navigation (Home/Quran/Dhikr/Journey/Profile), styled
/// per the design: white bar with rounded top, elevation-2 shadow, and the
/// active tab wrapped in a soft sage pill with a filled icon.
class SakinahBottomNavigation extends StatelessWidget {
  const SakinahBottomNavigation({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<SakinahNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.medium)),
        border: Border(top: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.3))),
        boxShadow: palette.sheetShadow,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.xs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavButton(
                    item: items[i],
                    selected: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.item, required this.selected, required this.onTap});

  final SakinahNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final activeFg = isDark ? colors.primaryFixed : colors.primaryContainer;
    final fg = selected ? activeFg : colors.onSurfaceVariant;
    return Semantics(
      selected: selected,
      button: true,
      label: item.label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: 36,
        // heightFactor 1: size to the item — Scaffold offers the bar slot the whole screen height.
        child: Align(
          heightFactor: 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
            decoration: BoxDecoration(
              color: selected
                  ? (isDark
                      ? colors.primaryContainer.withValues(alpha: 0.4)
                      : colors.secondaryContainer.withValues(alpha: 0.6))
                  : Colors.transparent,
              borderRadius: AppRadius.pillAll,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(selected ? item.selectedIcon : item.icon, size: 22, color: fg),
                const SizedBox(height: 2),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: fg,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
