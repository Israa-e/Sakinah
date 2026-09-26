import 'package:flutter/material.dart';

import '../../domain/mushaf_page.dart';

/// Reader-local palette for the mushaf page ("Colour your mushaf" + night).
@immutable
class MushafTheme {
  const MushafTheme({
    required this.color,
    required this.isNight,
    required this.paper,
    required this.frame,
    required this.frameSoft,
    required this.ink,
    required this.marker,
    required this.highlight,
    required this.plaque,
    required this.swatch,
  });

  final MushafColor color;
  final bool isNight;

  /// Page background.
  final Color paper;

  /// Frame lines, plaque borders, icons.
  final Color frame;

  /// Frame motif fill / soft dividers.
  final Color frameSoft;

  /// Quran text.
  final Color ink;

  /// Ayah-number medallions.
  final Color marker;

  /// Selected / recited ayah background.
  final Color highlight;

  /// Plaque and popup surfaces.
  final Color plaque;

  /// Representative colour for the theme picker.
  final Color swatch;

  static const _sand = MushafTheme(
    color: MushafColor.sand,
    isNight: false,
    paper: Color(0xFFFFF9F1),
    frame: Color(0xFF9A7B56),
    frameSoft: Color(0xFFCDB696),
    ink: Color(0xFF1E1A16),
    marker: Color(0xFF8C6A3C),
    highlight: Color(0xFFEBDECB),
    plaque: Color(0xFFF3E8D8),
    swatch: Color(0xFFB08D66),
  );

  static const _blue = MushafTheme(
    color: MushafColor.blue,
    isNight: false,
    paper: Color(0xFFF5F9FD),
    frame: Color(0xFF3E6D9A),
    frameSoft: Color(0xFFA3BDD6),
    ink: Color(0xFF15202B),
    marker: Color(0xFF2D6196),
    highlight: Color(0xFFD9E6F3),
    plaque: Color(0xFFE4EEF8),
    swatch: Color(0xFF2E78C2),
  );

  static const _green = MushafTheme(
    color: MushafColor.green,
    isNight: false,
    paper: Color(0xFFF6FAF1),
    frame: Color(0xFF5A7D39),
    frameSoft: Color(0xFFAFC795),
    ink: Color(0xFF1A2214),
    marker: Color(0xFF4C782A),
    highlight: Color(0xFFE0ECD2),
    plaque: Color(0xFFE8F1DD),
    swatch: Color(0xFF6E9E3A),
  );

  static MushafTheme base(MushafColor color) => switch (color) {
    MushafColor.sand => _sand,
    MushafColor.blue => _blue,
    MushafColor.green => _green,
  };

  /// [color] theme, or its night variant (dark paper, light ink).
  static MushafTheme of(MushafColor color, {required bool night}) {
    final b = base(color);
    if (!night) return b;
    return MushafTheme(
      color: color,
      isNight: true,
      paper: const Color(0xFF15130F),
      frame: Color.lerp(b.frame, Colors.white, 0.18)!,
      frameSoft: Color.lerp(b.frame, const Color(0xFF15130F), 0.35)!,
      ink: const Color(0xFFE9E2D5),
      marker: Color.lerp(b.marker, Colors.white, 0.4)!,
      highlight: Color.lerp(b.frame, const Color(0xFF15130F), 0.62)!,
      plaque: const Color(0xFF24201A),
      swatch: b.swatch,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MushafTheme && other.color == color && other.isNight == isNight;

  @override
  int get hashCode => Object.hash(color, isNight);
}
