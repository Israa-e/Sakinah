import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/extensions/build_context_extensions.dart';

/// Localized 8-point compass abbreviation for [degrees] (0 = north).
String compassPoint(BuildContext context, double degrees) {
  final l10n = context.l10n;
  final points = [
    l10n.qiblaDirN,
    l10n.qiblaDirNE,
    l10n.qiblaDirE,
    l10n.qiblaDirSE,
    l10n.qiblaDirS,
    l10n.qiblaDirSW,
    l10n.qiblaDirW,
    l10n.qiblaDirNW,
  ];
  final index = (((degrees % 360) + 22.5) ~/ 45) % 8;
  return points[index];
}

/// The Qibla compass in the sanctuary style: a fixed gold outer ring with a
/// "you are facing" pointer at the top, and an inner disk (degree ticks,
/// cardinal letters, north tip and the Kaaba marker at [qiblaBearing]) that
/// counter-rotates with the device [heading] so north stays north. The hub
/// shows the bearing. Without a heading the disk simply stays north-up.
class CompassDial extends StatelessWidget {
  const CompassDial({
    required this.size,
    required this.qiblaBearing,
    super.key,
    this.heading,
    this.aligned = false,
  });

  final double size;
  final double qiblaBearing;
  final double? heading;
  final bool aligned;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final palette = context.palette;
    final l10n = context.l10n;
    final diskInset = size * 0.1;
    final hubSize = size * 0.34;

    return Directionality(
      // Pure geometry — never mirrored in RTL.
      textDirection: TextDirection.ltr,
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Fixed rings.
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: palette.gold.withValues(alpha: 0.3)),
              ),
              child: const SizedBox.expand(),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.surfaceContainerLow.withValues(alpha: 0.6),
                  border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.25)),
                ),
                child: const SizedBox.expand(),
              ),
            ),
            // Rotating disk.
            Padding(
              padding: EdgeInsets.all(diskInset),
              child: _ContinuousRotation(
                degrees: -(heading ?? 0),
                child: _Disk(
                  qiblaBearing: qiblaBearing,
                  aligned: aligned,
                  cardinals: [l10n.qiblaDirN, l10n.qiblaDirE, l10n.qiblaDirS, l10n.qiblaDirW],
                ),
              ),
            ),
            // Fixed "you are facing" pointer.
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(
                  Icons.navigation,
                  size: 18,
                  color: aligned ? palette.gold : colors.primary,
                ),
              ),
            ),
            // Hub.
            Container(
              width: hubSize,
              height: hubSize,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.surfaceContainerLow,
                border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4)),
              ),
              child: FittedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${qiblaBearing.round()}°',
                      style: context.textStyles.headlineMedium?.copyWith(
                        color: colors.primary,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      compassPoint(context, qiblaBearing),
                      style: context.textStyles.labelSmall?.copyWith(color: palette.gold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Disk extends StatelessWidget {
  const _Disk({required this.qiblaBearing, required this.aligned, required this.cardinals});

  final double qiblaBearing;
  final bool aligned;
  final List<String> cardinals;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.surfaceContainerLowest,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: palette.whisperShadow,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: _DiskPainter(
              tickColor: colors.secondary.withValues(alpha: 0.35),
              ringColor: colors.outlineVariant.withValues(alpha: 0.5),
              labelColor: colors.onSurfaceVariant,
              northColor: colors.error.withValues(alpha: 0.8),
              cardinals: cardinals,
              labelStyle: context.textStyles.labelSmall ?? const TextStyle(fontSize: 11),
            ),
          ),
          // Kaaba beam + marker, rotated to the Qibla bearing on the disk.
          Transform.rotate(
            angle: qiblaBearing * pi / 180,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final r = constraints.maxWidth / 2;
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: r * 0.22,
                      child: Container(
                        width: 2,
                        height: r * 0.62,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [palette.hero, palette.gold, palette.gold.withValues(alpha: 0)],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: r * 0.06,
                      child: _KaabaMarker(glow: aligned),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// A small stylised Kaaba: dark cube with a gold band.
class _KaabaMarker extends StatelessWidget {
  const _KaabaMarker({required this.glow});

  final bool glow;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: palette.hero,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: palette.gold.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: palette.gold.withValues(alpha: glow ? 0.55 : 0.15),
            blurRadius: glow ? 14 : 4,
            spreadRadius: glow ? 2 : 0,
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 7),
          Container(height: 3, color: palette.heroAccent),
        ],
      ),
    );
  }
}

/// Animates rotation along the shortest arc, so crossing north (359° → 1°)
/// doesn't spin the dial all the way round.
class _ContinuousRotation extends StatefulWidget {
  const _ContinuousRotation({required this.degrees, required this.child});

  final double degrees;
  final Widget child;

  @override
  State<_ContinuousRotation> createState() => _ContinuousRotationState();
}

class _ContinuousRotationState extends State<_ContinuousRotation> {
  late double _turns = widget.degrees / 360;

  @override
  void didUpdateWidget(covariant _ContinuousRotation oldWidget) {
    super.didUpdateWidget(oldWidget);
    final current = _turns * 360;
    var delta = (widget.degrees - current) % 360;
    if (delta > 180) delta -= 360;
    if (delta < -180) delta += 360;
    _turns = (current + delta) / 360;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: _turns,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: widget.child,
    );
  }
}

class _DiskPainter extends CustomPainter {
  _DiskPainter({
    required this.tickColor,
    required this.ringColor,
    required this.labelColor,
    required this.northColor,
    required this.cardinals,
    required this.labelStyle,
  });

  final Color tickColor;
  final Color ringColor;
  final Color labelColor;
  final Color northColor;
  final List<String> cardinals;
  final TextStyle labelStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    // Dashed inner ring.
    final dashPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const dashes = 60;
    final innerRadius = radius * 0.84;
    for (var i = 0; i < dashes; i += 2) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: innerRadius),
        i * 2 * pi / dashes,
        2 * pi / dashes,
        false,
        dashPaint,
      );
    }

    Offset polar(double r, double angle) =>
        Offset(center.dx + r * sin(angle), center.dy - r * cos(angle));

    for (var degree = 0; degree < 360; degree += 10) {
      final angle = degree * pi / 180;
      final isCardinal = degree % 90 == 0;
      final isMajor = degree % 30 == 0;
      if (isCardinal) continue; // Letters stand in for the cardinal ticks.
      final length = isMajor ? 8.0 : 4.0;
      canvas.drawLine(
        polar(radius - 3, angle),
        polar(radius - 3 - length, angle),
        Paint()
          ..color = tickColor
          ..strokeWidth = isMajor ? 1.5 : 1,
      );
    }

    // North tip.
    final tip = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(center.dx, 7), width: 5, height: 10),
      const Radius.circular(3),
    );
    canvas.drawRRect(tip, Paint()..color = northColor);

    for (var i = 0; i < 4; i++) {
      final angle = i * pi / 2;
      final painter = TextPainter(
        text: TextSpan(
          text: cardinals[i],
          style: labelStyle.copyWith(
            color: i == 0 ? northColor : labelColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final pos = polar(radius - 24, angle);
      painter.paint(canvas, pos - Offset(painter.width / 2, painter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _DiskPainter oldDelegate) =>
      tickColor != oldDelegate.tickColor ||
      ringColor != oldDelegate.ringColor ||
      labelColor != oldDelegate.labelColor ||
      northColor != oldDelegate.northColor ||
      labelStyle != oldDelegate.labelStyle ||
      !_listEquals(cardinals, oldDelegate.cardinals);

  static bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
