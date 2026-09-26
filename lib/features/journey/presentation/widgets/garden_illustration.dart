import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../domain/journey_models.dart';

/// The spiritual garden, painted in Flutter. The plant grows with [stage] and
/// sways very gently (a slow 5s breath) unless the platform asks for reduced
/// motion.
class GardenIllustration extends StatefulWidget {
  const GardenIllustration({required this.stage, super.key, this.size = 160});

  final GardenStage stage;
  final double size;

  @override
  State<GardenIllustration> createState() => _GardenIllustrationState();
}

class _GardenIllustrationState extends State<GardenIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sway = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduceMotion) {
      _sway.stop();
      _sway.value = 0.5;
    } else if (!_sway.isAnimating) {
      _sway.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _sway.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final palette = context.palette;
    final paints = _GardenColors(
      aura: colors.secondaryContainer.withValues(alpha: 0.35),
      soil: colors.surfaceContainerHighest,
      soilShade: colors.outlineVariant.withValues(alpha: 0.5),
      stem: colors.primary,
      leaf: colors.primary,
      leafAlt: colors.secondary,
      canopy: colors.primaryContainer,
      trunk: colors.onSurfaceVariant,
      flower: palette.gold,
      flowerCenter: palette.heroAccent,
      seed: palette.gold,
    );

    return Semantics(
      image: true,
      child: TweenAnimationBuilder<double>(
        key: ValueKey(widget.stage),
        tween: Tween(begin: 0.92, end: 1),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        builder: (context, grow, _) => AnimatedBuilder(
          animation: _sway,
          builder: (context, _) => CustomPaint(
            size: Size.square(widget.size),
            painter: _GardenPainter(
              stage: widget.stage,
              sway: Curves.easeInOut.transform(_sway.value) * 2 - 1,
              grow: grow,
              colors: paints,
            ),
          ),
        ),
      ),
    );
  }
}

class _GardenColors {
  const _GardenColors({
    required this.aura,
    required this.soil,
    required this.soilShade,
    required this.stem,
    required this.leaf,
    required this.leafAlt,
    required this.canopy,
    required this.trunk,
    required this.flower,
    required this.flowerCenter,
    required this.seed,
  });

  final Color aura;
  final Color soil;
  final Color soilShade;
  final Color stem;
  final Color leaf;
  final Color leafAlt;
  final Color canopy;
  final Color trunk;
  final Color flower;
  final Color flowerCenter;
  final Color seed;
}

class _GardenPainter extends CustomPainter {
  _GardenPainter({
    required this.stage,
    required this.sway,
    required this.grow,
    required _GardenColors colors,
  }) : _c = colors;

  final GardenStage stage;

  /// -1..1 — the gentle side-to-side breath.
  final double sway;

  /// 0..1 — scale applied while a new stage settles in.
  final double grow;
  final _GardenColors _c;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final base = Offset(w / 2, h * 0.84);

    // Calm aura.
    canvas.drawCircle(
      Offset(w / 2, h * 0.52),
      w * 0.42,
      Paint()..color = _c.aura,
    );

    // Soil mound.
    canvas.drawOval(
      Rect.fromCenter(center: base, width: w * 0.64, height: h * 0.14),
      Paint()..color = _c.soil,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: base.translate(0, h * 0.015),
        width: w * 0.4,
        height: h * 0.06,
      ),
      Paint()..color = _c.soilShade,
    );

    canvas.save();
    canvas.translate(base.dx, base.dy);
    canvas.rotate(sway * 0.025);
    canvas.scale(grow);

    switch (stage) {
      case GardenStage.seed:
        _seed(canvas, w, h);
      case GardenStage.sprout:
        _plant(canvas, h * 0.24, 2, w, h);
      case GardenStage.sapling:
        _plant(canvas, h * 0.42, 4, w, h);
      case GardenStage.blooming:
        _plant(canvas, h * 0.5, 6, w, h);
        _flowers(canvas, h * 0.5, w, h);
      case GardenStage.flourishing:
        _tree(canvas, w, h);
    }
    canvas.restore();
  }

  void _seed(Canvas canvas, double w, double h) {
    canvas.save();
    canvas.rotate(-0.4);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(0, -h * 0.03), width: w * 0.07, height: w * 0.1),
      Paint()..color = _c.seed,
    );
    canvas.restore();
    // A promise of a shoot.
    final shoot = Path()
      ..moveTo(0, -h * 0.07)
      ..quadraticBezierTo(w * 0.01, -h * 0.11, w * 0.035, -h * 0.12);
    canvas.drawPath(
      shoot,
      Paint()
        ..color = _c.stem
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
  }

  void _plant(Canvas canvas, double height, int leaves, double w, double h) {
    final stem = Path()
      ..moveTo(0, 0)
      ..cubicTo(w * 0.03, -height * 0.35, -w * 0.03, -height * 0.7, 0, -height);
    canvas.drawPath(
      stem,
      Paint()
        ..color = _c.stem
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
    final leafLength = w * (leaves <= 2 ? 0.14 : 0.16);
    for (var i = 0; i < leaves; i++) {
      final t = leaves == 2 ? 1.0 : 0.35 + 0.65 * (i / (leaves - 1));
      final left = i.isEven;
      final angle = left ? -math.pi * 0.82 : -math.pi * 0.18;
      _leaf(
        canvas,
        Offset(0, -height * t),
        angle,
        leafLength * (0.8 + 0.2 * t),
        left ? _c.leaf : _c.leafAlt,
      );
    }
  }

  void _leaf(Canvas canvas, Offset from, double angle, double length, Color color) {
    final dir = Offset(math.cos(angle), math.sin(angle));
    final normal = Offset(-dir.dy, dir.dx);
    final tip = from + dir * length;
    final mid = from + dir * (length * 0.5);
    final path = Path()
      ..moveTo(from.dx, from.dy)
      ..quadraticBezierTo(
        (mid + normal * length * 0.38).dx,
        (mid + normal * length * 0.38).dy,
        tip.dx,
        tip.dy,
      )
      ..quadraticBezierTo(
        (mid - normal * length * 0.38).dx,
        (mid - normal * length * 0.38).dy,
        from.dx,
        from.dy,
      );
    canvas.drawPath(path, Paint()..color = color);
  }

  void _flowers(Canvas canvas, double height, double w, double h) {
    final spots = [
      Offset(0, -height - w * 0.02),
      Offset(-w * 0.14, -height * 0.72),
      Offset(w * 0.14, -height * 0.58),
    ];
    for (final (i, c) in spots.indexed) {
      _flower(canvas, c, w * (i == 0 ? 0.045 : 0.035));
    }
  }

  void _flower(Canvas canvas, Offset center, double r) {
    final petal = Paint()..color = _c.flower;
    for (var k = 0; k < 5; k++) {
      final a = k * 2 * math.pi / 5;
      canvas.drawCircle(center + Offset(math.cos(a), math.sin(a)) * r, r * 0.75, petal);
    }
    canvas.drawCircle(center, r * 0.6, Paint()..color = _c.flowerCenter);
  }

  void _tree(Canvas canvas, double w, double h) {
    final trunkHeight = h * 0.36;
    final trunk = Path()
      ..moveTo(-w * 0.04, 0)
      ..quadraticBezierTo(-w * 0.02, -trunkHeight * 0.5, -w * 0.025, -trunkHeight)
      ..lineTo(w * 0.025, -trunkHeight)
      ..quadraticBezierTo(w * 0.02, -trunkHeight * 0.5, w * 0.04, 0)
      ..close();
    canvas.drawPath(trunk, Paint()..color = _c.trunk);

    final canopyCenter = Offset(0, -trunkHeight - h * 0.12);
    final blobs = [
      (Offset(-w * 0.13, h * 0.04), w * 0.14, _c.leafAlt),
      (Offset(w * 0.13, h * 0.04), w * 0.14, _c.leafAlt),
      (Offset(0, -h * 0.06), w * 0.16, _c.canopy),
      (Offset(-w * 0.08, h * 0.02), w * 0.13, _c.leaf),
      (Offset(w * 0.09, -h * 0.01), w * 0.12, _c.leaf),
    ];
    for (final (offset, radius, color) in blobs) {
      canvas.drawCircle(canopyCenter + offset, radius, Paint()..color = color);
    }
    final fruits = [
      Offset(-w * 0.12, h * 0.02),
      Offset(w * 0.06, -h * 0.07),
      Offset(w * 0.15, h * 0.06),
      Offset(-w * 0.02, h * 0.07),
    ];
    for (final f in fruits) {
      canvas.drawCircle(canopyCenter + f, w * 0.022, Paint()..color = _c.flower);
    }
  }

  @override
  bool shouldRepaint(_GardenPainter old) =>
      old.stage != stage || old.sway != sway || old.grow != grow || old._c != _c;
}
