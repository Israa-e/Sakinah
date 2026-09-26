import 'package:flutter/material.dart';

import '../../app/theme/sakinah_palette.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';

/// Base surface for every card-shaped component in the app ("Sanctuary
/// tile"): white card, 20px radius, hairline border and whisper shadow. When
/// tappable it gives the design's tactile press response (scale 0.985 +
/// 1px drop). Feature cards compose this rather than each rebuilding their
/// own `Container` + `BoxDecoration`.
class SakinahCard extends StatefulWidget {
  const SakinahCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
    this.color,
    this.border,
    this.borderRadius = AppRadius.cardAll,
    this.shadow = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final BoxBorder? border;
  final BorderRadius borderRadius;
  final bool shadow;

  @override
  State<SakinahCard> createState() => _SakinahCardState();
}

class _SakinahCardState extends State<SakinahCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = context.palette;
    final content = DecoratedBox(
      decoration: BoxDecoration(
        color: widget.color ?? theme.cardColor,
        borderRadius: widget.borderRadius,
        border: widget.border ?? Border.all(color: palette.cardBorder),
        boxShadow: widget.shadow ? palette.whisperShadow : null,
      ),
      child: Padding(padding: widget.padding, child: widget.child),
    );

    if (widget.onTap == null) return content;

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? 0.985 : 1,
        duration: const Duration(milliseconds: 150),
        child: AnimatedSlide(
          offset: _pressed ? const Offset(0, 0.004) : Offset.zero,
          duration: const Duration(milliseconds: 150),
          child: Material(
            color: Colors.transparent,
            borderRadius: widget.borderRadius,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: widget.borderRadius,
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}

/// Small-caps gold category label used at the top of sanctuary tiles
/// ("TODAY'S DHIKR", "YOUR QURAN", ...).
class CardEyebrow extends StatelessWidget {
  const CardEyebrow(this.text, {super.key, this.icon, this.color});

  final String text;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.palette.gold;
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(color: c);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: c),
          const SizedBox(width: 6),
        ],
        Flexible(child: Text(text.toUpperCase(), style: style)),
      ],
    );
  }
}
