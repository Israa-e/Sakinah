import 'package:flutter/material.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';

enum HomePillStyle {
  /// Deep-green pill with light text (primary action, e.g. "Start").
  hero,

  /// Sage `secondary-container` pill (e.g. "Begin").
  tonal,

  /// Quiet `surface-container-low` pill (e.g. "Continue reading").
  soft,

  /// Hairline-outlined pill (e.g. "Mark as done").
  outline,
}

/// The compact rounded-full buttons used inside Home's sanctuary cards.
class HomePillButton extends StatelessWidget {
  const HomePillButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.style = HomePillStyle.soft,
    this.icon,
    this.leadingIcon,
  });

  final String label;
  final VoidCallback? onPressed;
  final HomePillStyle style;

  /// Trailing icon (e.g. an arrow).
  final IconData? icon;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final palette = context.palette;
    final (Color bg, Color fg, BorderSide side) = switch (style) {
      HomePillStyle.hero => (palette.hero, palette.onHero, BorderSide.none),
      HomePillStyle.tonal => (colors.secondaryContainer, colors.primary, BorderSide.none),
      HomePillStyle.soft => (colors.surfaceContainerLow, colors.primary, BorderSide.none),
      HomePillStyle.outline => (
        Colors.transparent,
        colors.primary,
        BorderSide(color: colors.outlineVariant.withValues(alpha: 0.6)),
      ),
    };
    final textStyle = context.textStyles.labelMedium?.copyWith(color: fg);

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        minimumSize: const Size(0, 40),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.pillAll, side: side),
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: 16, color: fg),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(label, style: textStyle, overflow: TextOverflow.ellipsis),
          ),
          if (icon != null) ...[const SizedBox(width: 6), Icon(icon, size: 16, color: fg)],
        ],
      ),
    );
  }
}
