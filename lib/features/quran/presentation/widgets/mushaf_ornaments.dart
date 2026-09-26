import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../data/quran_text.dart';
import 'mushaf_theme.dart';

/// Width of the ornamental band of [MushafFramePainter].
const double mushafFrameBand = 13;

/// Ornate double page frame: thin outer rule, a band of repeating
/// diamond/flower motifs, a double inner rule and corner rosettes.
class MushafFramePainter extends CustomPainter {
  const MushafFramePainter(this.theme, {this.inset = 3});

  final MushafTheme theme;
  final double inset;

  @override
  void paint(Canvas canvas, Size size) {
    const b = mushafFrameBand;
    final outer = (Offset.zero & size).deflate(inset);
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..color = theme.frame
      ..strokeWidth = 1.3;
    final thin = Paint()
      ..style = PaintingStyle.stroke
      ..color = theme.frame
      ..strokeWidth = 0.8;
    final fillSoft = Paint()..color = theme.frameSoft;
    final fill = Paint()..color = theme.frame;

    // Paper-tinted band behind the motifs.
    canvas.drawPath(
      Path()
        ..fillType = PathFillType.evenOdd
        ..addRect(outer)
        ..addRect(outer.deflate(b)),
      Paint()..color = Color.alphaBlend(theme.frameSoft.withValues(alpha: 0.18), theme.paper),
    );
    canvas
      ..drawRect(outer, line)
      ..drawRect(outer.deflate(b), line)
      ..drawRect(outer.deflate(b + 3.5), thin);

    // Motifs along the band's centre line.
    final mid = outer.deflate(b / 2);
    void edge(Offset from, Offset to) {
      final length = (to - from).distance;
      final dir = (to - from) / length;
      final normal = Offset(-dir.dy, dir.dx);
      const step = 10.0;
      final count = (length / step).floor();
      final pad = (length - count * step) / 2;
      for (var i = 0; i <= count; i++) {
        final c = from + dir * (pad + i * step);
        if (i.isEven) {
          final path = Path()
            ..moveTo(c.dx + dir.dx * 4, c.dy + dir.dy * 4)
            ..lineTo(c.dx + normal.dx * 3.6, c.dy + normal.dy * 3.6)
            ..lineTo(c.dx - dir.dx * 4, c.dy - dir.dy * 4)
            ..lineTo(c.dx - normal.dx * 3.6, c.dy - normal.dy * 3.6)
            ..close();
          canvas
            ..drawPath(path, fillSoft)
            ..drawPath(path, thin)
            ..drawCircle(c, 0.9, fill);
        } else {
          for (final o in [dir, -dir, normal, -normal]) {
            canvas.drawCircle(c + o * 2.2, 1.05, fill);
          }
        }
      }
    }

    const corner = b * 1.6;
    edge(mid.topLeft + const Offset(corner, 0), mid.topRight - const Offset(corner, 0));
    edge(mid.bottomLeft + const Offset(corner, 0), mid.bottomRight - const Offset(corner, 0));
    edge(mid.topLeft + const Offset(0, corner), mid.bottomLeft - const Offset(0, corner));
    edge(mid.topRight + const Offset(0, corner), mid.bottomRight - const Offset(0, corner));

    for (final c in [mid.topLeft, mid.topRight, mid.bottomLeft, mid.bottomRight]) {
      paintRosette(canvas, c, b * 0.95, theme);
    }
  }

  @override
  bool shouldRepaint(MushafFramePainter old) => old.theme != theme || old.inset != inset;
}

/// Eight-petal rosette used on frame corners and title-box ears.
void paintRosette(Canvas canvas, Offset c, double r, MushafTheme theme) {
  final stroke = Paint()
    ..style = PaintingStyle.stroke
    ..color = theme.frame
    ..strokeWidth = 0.9;
  canvas.drawCircle(c, r, Paint()..color = theme.paper);
  for (var i = 0; i < 8; i++) {
    final a = i * math.pi / 4;
    canvas
      ..save()
      ..translate(c.dx, c.dy)
      ..rotate(a);
    final petal = Rect.fromCenter(center: Offset(r * 0.5, 0), width: r * 0.95, height: r * 0.42);
    canvas
      ..drawOval(petal, Paint()..color = theme.frameSoft)
      ..drawOval(petal, stroke)
      ..restore();
  }
  canvas
    ..drawCircle(c, r, stroke)
    ..drawCircle(c, r * 0.22, Paint()..color = theme.frame);
}

/// Elongated hexagonal plaque (top-bar labels, page number).
class PlaquePainter extends CustomPainter {
  const PlaquePainter(this.theme);

  final MushafTheme theme;

  static Path shape(Size s, double inset) {
    final h = s.height;
    final tip = math.min(h / 2, s.width / 4);
    return Path()
      ..moveTo(inset, h / 2)
      ..lineTo(tip + inset * 0.5, inset)
      ..lineTo(s.width - tip - inset * 0.5, inset)
      ..lineTo(s.width - inset, h / 2)
      ..lineTo(s.width - tip - inset * 0.5, h - inset)
      ..lineTo(tip + inset * 0.5, h - inset)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final outer = shape(size, 0.8);
    canvas
      ..drawPath(outer, Paint()..color = theme.plaque)
      ..drawPath(
        outer,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4
          ..color = theme.frame,
      )
      ..drawPath(
        shape(size, 3.6),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.7
          ..color = theme.frameSoft,
      );
  }

  @override
  bool shouldRepaint(PlaquePainter old) => old.theme != theme;
}

/// A label on a [PlaquePainter] background.
class MushafPlaque extends StatelessWidget {
  const MushafPlaque({required this.theme, required this.child, super.key, this.height = 34});

  final MushafTheme theme;
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PlaquePainter(theme),
      child: SizedBox(
        height: height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: height * 0.62),
          child: Center(widthFactor: 1, child: child),
        ),
      ),
    );
  }
}

/// Framed surah title box with rosette "ears" on both sides.
class SurahTitleBox extends StatelessWidget {
  const SurahTitleBox({
    required this.nameAr,
    required this.theme,
    required this.fontSize,
    super.key,
  });

  final String nameAr;
  final MushafTheme theme;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final height = math.max(46.0, fontSize * 2.1);
    return CustomPaint(
      painter: _TitleBoxPainter(theme),
      child: SizedBox(
        height: height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: height * 0.9),
          child: Center(
            child: Text(
              nameAr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
              textScaler: TextScaler.noScaling,
              style: context.sakinahTypography.quranText.copyWith(
                fontSize: fontSize,
                height: 1.3,
                color: theme.ink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleBoxPainter extends CustomPainter {
  const _TitleBoxPainter(this.theme);

  final MushafTheme theme;

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final ear = h * 0.62;
    final box = Rect.fromLTRB(ear, 2, size.width - ear, h - 2);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = theme.frame;

    // Ears: pointed leaves reaching outward, each holding a rosette.
    for (final left in [true, false]) {
      final x0 = left ? box.left : box.right;
      final tip = left ? 1.0 : size.width - 1;
      final path = Path()
        ..moveTo(x0, box.top + h * 0.08)
        ..quadraticBezierTo((x0 + tip) / 2, box.top - 1, tip, h / 2)
        ..quadraticBezierTo((x0 + tip) / 2, box.bottom + 1, x0, box.bottom - h * 0.08)
        ..close();
      canvas
        ..drawPath(
          path,
          Paint()..color = Color.alphaBlend(theme.frameSoft.withValues(alpha: 0.35), theme.paper),
        )
        ..drawPath(path, stroke..strokeWidth = 1.1);
      paintRosette(canvas, Offset(x0 + (tip - x0) * 0.42, h / 2), h * 0.2, theme);
    }

    canvas
      ..drawRect(box, Paint()..color = theme.paper)
      ..drawRect(box, stroke..strokeWidth = 2.6)
      ..drawRect(box.deflate(4.5), stroke..strokeWidth = 0.9);
  }

  @override
  bool shouldRepaint(_TitleBoxPainter old) => old.theme != theme;
}

/// Inline ayah-end medallion with the ayah number in Arabic-Indic digits.
class AyahMarker extends StatelessWidget {
  const AyahMarker({
    required this.number,
    required this.theme,
    required this.size,
    super.key,
    this.filled = false,
  });

  final int number;
  final MushafTheme theme;
  final double size;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final digits = QuranText.arabicIndicDigits(number);
    final fontSize = size * (digits.length >= 3 ? 0.34 : 0.42);
    return Semantics(
      label: '$number',
      child: CustomPaint(
        painter: _MarkerPainter(theme, filled: filled),
        child: SizedBox.square(
          dimension: size,
          child: Center(
            child: Text(
              digits,
              textDirection: TextDirection.rtl,
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                fontFamily: AppFonts.quran,
                fontFamilyFallback: const [AppFonts.quranFallback],
                fontSize: fontSize,
                height: 1,
                fontWeight: FontWeight.w700,
                color: filled ? theme.paper : theme.marker,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MarkerPainter extends CustomPainter {
  const _MarkerPainter(this.theme, {required this.filled});

  final MushafTheme theme;
  final bool filled;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2 - 0.8;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = theme.marker;
    // Scalloped outer ring (12 lobes) around a circle.
    final scallop = Path();
    const lobes = 12;
    for (var i = 0; i <= lobes * 2; i++) {
      final a = i * math.pi / lobes - math.pi / 2;
      final rr = i.isEven ? r : r * 0.86;
      final p = c + Offset(math.cos(a), math.sin(a)) * rr;
      if (i == 0) {
        scallop.moveTo(p.dx, p.dy);
      } else {
        scallop.lineTo(p.dx, p.dy);
      }
    }
    scallop.close();
    canvas
      ..drawPath(
        scallop,
        Paint()..color = filled ? theme.marker : theme.paper.withValues(alpha: 0.9),
      )
      ..drawPath(scallop, stroke)
      ..drawCircle(c, r * 0.7, stroke..strokeWidth = 0.8);
  }

  @override
  bool shouldRepaint(_MarkerPainter old) => old.theme != theme || old.filled != filled;
}

/// Page number on a small plaque, set into the bottom of the frame.
class PageNumberMedallion extends StatelessWidget {
  const PageNumberMedallion({required this.page, required this.theme, super.key});

  final int page;
  final MushafTheme theme;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$page',
      child: MushafPlaque(
        theme: theme,
        height: 28,
        child: Text(
          QuranText.arabicIndicDigits(page),
          textScaler: TextScaler.noScaling,
          style: TextStyle(
            fontFamily: AppFonts.quran,
            fontFamilyFallback: const [AppFonts.quranFallback],
            fontSize: 15,
            height: 1.1,
            fontWeight: FontWeight.w700,
            color: theme.ink,
          ),
        ),
      ),
    );
  }
}
