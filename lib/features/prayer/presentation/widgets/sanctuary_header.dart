import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';

/// Which half of the "Qibla & Prayer" sanctuary is showing.
enum SanctuaryTab { prayerTimes, qibla }

/// Top bar shared by the Prayer and Qibla screens so the two routes read as
/// one sanctuary: back arrow, compass mark + "Qibla & Prayer" title, and an
/// optional trailing label (e.g. the location).
class SanctuaryTopBar extends StatelessWidget {
  const SanctuaryTopBar({super.key, this.trailing});

  final Widget? trailing;

  void _back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.surface,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xs,
          AppSpacing.xs,
          AppSpacing.lg,
          AppSpacing.xs,
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => _back(context),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              icon: Icon(Icons.adaptive.arrow_back, color: colors.secondary, size: 22),
            ),
            Icon(Icons.explore_outlined, color: colors.primary, size: 22),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                context.l10n.prayerQiblaTitle,
                style: context.textStyles.titleLarge?.copyWith(color: colors.primary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) Flexible(child: trailing!),
          ],
        ),
      ),
    );
  }
}

/// Pill segmented control swapping between `/prayer` and `/qibla` with
/// `context.replace`, so switching halves never grows the back stack.
class SanctuarySegmentedControl extends StatelessWidget {
  const SanctuarySegmentedControl({required this.selected, super.key});

  final SanctuaryTab selected;

  void _select(BuildContext context, SanctuaryTab tab) {
    if (tab == selected) return;
    context.replace(tab == SanctuaryTab.qibla ? AppRoutes.qibla : AppRoutes.prayer);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: context.isDark ? colors.surfaceContainerLow : colors.surfaceContainerHigh,
        borderRadius: AppRadius.pillAll,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          _Segment(
            icon: Icons.schedule,
            label: l10n.prayerTabTimes,
            selected: selected == SanctuaryTab.prayerTimes,
            onTap: () => _select(context, SanctuaryTab.prayerTimes),
          ),
          _Segment(
            icon: Icons.explore_outlined,
            label: l10n.prayerTabQibla,
            selected: selected == SanctuaryTab.qibla,
            onTap: () => _select(context, SanctuaryTab.qibla),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fg = selected ? colors.primary : colors.onSurfaceVariant;
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            constraints: const BoxConstraints(minHeight: 40),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: selected
                  ? (context.isDark
                        ? colors.surfaceContainerHighest
                        : colors.surfaceContainerLowest)
                  : Colors.transparent,
              borderRadius: AppRadius.pillAll,
              boxShadow: selected ? context.palette.whisperShadow : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: fg),
                const SizedBox(width: AppSpacing.xxs + 2),
                Flexible(
                  child: Text(
                    label,
                    style: context.textStyles.labelMedium?.copyWith(
                      color: fg,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
