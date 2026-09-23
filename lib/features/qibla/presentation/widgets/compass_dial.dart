import 'dart:math';

import 'package:flutter/material.dart';

/// Draws a static compass ring (N/E/S/W + degree ticks) — the Kaaba arrow is
/// layered on top and rotated separately by the caller.
class CompassDial extends StatelessWidget {
  const CompassDial({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomPaint(
      size: Size.square(size),
      painter: _CompassDialPainter(
        ringColor: colorScheme.outlineVariant,
        tickColor: colorScheme.onSurfaceVariant,
        labelColor: colorScheme.onSurface,
      ),
    );
  }
}

class _CompassDialPainter extends CustomPainter {
  _CompassDialPainter({
    required this.ringColor,
    required this.tickColor,
    required this.labelColor,
  });

  final Color ringColor;
  final Color tickColor;
  final Color labelColor;

  static const _cardinalLabels = ['N', 'E', 'S', 'W'];

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final ringPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius - 1, ringPaint);

    for (var degree = 0; degree < 360; degree += 10) {
      final isCardinal = degree % 90 == 0;
      final angle = degree * pi / 180;
      final tickLength = isCardinal ? 14.0 : 7.0;
      final outer = Offset(
        center.dx + radius * sin(angle),
        center.dy - radius * cos(angle),
      );
      final inner = Offset(
        center.dx + (radius - tickLength) * sin(angle),
        center.dy - (radius - tickLength) * cos(angle),
      );
      canvas.drawLine(
        outer,
        inner,
        Paint()
          ..color = isCardinal ? labelColor : tickColor
          ..strokeWidth = isCardinal ? 2 : 1,
      );

      if (isCardinal) {
        final label = _cardinalLabels[degree ~/ 90];
        final textPainter = TextPainter(
          text: TextSpan(
            text: label,
            style: TextStyle(
              color: labelColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        final labelOffset = Offset(
          center.dx + (radius - 30) * sin(angle) - textPainter.width / 2,
          center.dy - (radius - 30) * cos(angle) - textPainter.height / 2,
        );
        textPainter.paint(canvas, labelOffset);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CompassDialPainter oldDelegate) =>
      ringColor != oldDelegate.ringColor ||
      tickColor != oldDelegate.tickColor ||
      labelColor != oldDelegate.labelColor;
}
