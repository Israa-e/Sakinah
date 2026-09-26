import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Semantic colors from the design system that don't have a Material
/// [ColorScheme] slot, or whose mockup usage wouldn't survive dark mode if
/// mapped literally (e.g. the deep-green hero card reads `on-primary` text on
/// a `primary-container` background — fine in light, unreadable in dark).
@immutable
class SakinahPalette extends ThemeExtension<SakinahPalette> {
  const SakinahPalette({
    required this.canvas,
    required this.paper,
    required this.gold,
    required this.goldSoft,
    required this.hero,
    required this.onHero,
    required this.onHeroMuted,
    required this.heroAccent,
    required this.cardBorder,
    required this.shadow,
  });

  /// Linen app canvas (scaffold background).
  final Color canvas;

  /// Warm paper tone for the Quran/Du'a reading canvases.
  final Color paper;

  /// Matte sand gold — category labels, ayah markers, milestones.
  final Color gold;

  /// Softer gold for thin dividers/strokes (use with alpha).
  final Color goldSoft;

  /// Deep forest hero surfaces (next-prayer card, mini audio player, CTAs).
  final Color hero;
  final Color onHero;
  final Color onHeroMuted;

  /// Gold highlight used *on* hero surfaces (pulse dot, progress fill).
  final Color heroAccent;

  /// Hairline card boundary.
  final Color cardBorder;

  /// Tint for the whisper shadow.
  final Color shadow;

  static const light = SakinahPalette(
    canvas: AppColors.surface,
    paper: AppColors.paper,
    gold: AppColors.onTertiaryContainer,
    goldSoft: AppColors.gold,
    hero: AppColors.primaryContainer,
    onHero: AppColors.onPrimary,
    onHeroMuted: AppColors.onPrimaryContainer,
    heroAccent: AppColors.tertiaryFixedDim,
    cardBorder: Color(0x0D202522), // rgba(32,37,34,0.05)
    shadow: AppColors.forest,
  );

  static const dark = SakinahPalette(
    canvas: AppColors.darkSurface,
    paper: AppColors.darkSurface,
    gold: AppColors.darkOnTertiaryContainer,
    goldSoft: AppColors.darkOnTertiaryContainer,
    hero: AppColors.primaryContainer,
    onHero: AppColors.darkOnSurface,
    onHeroMuted: AppColors.onPrimaryContainer,
    heroAccent: AppColors.tertiaryFixedDim,
    cardBorder: Color(0x14E8EEE9), // rgba(232,238,233,0.08)
    shadow: Colors.black,
  );

  /// Elevation 1 — `0 4px 20px -2px rgba(24,60,53,0.04)`.
  List<BoxShadow> get whisperShadow => [
        BoxShadow(
          color: shadow.withValues(alpha: 0.05),
          offset: const Offset(0, 4),
          blurRadius: 20,
          spreadRadius: -2,
        ),
      ];

  /// Hero glow — `0 12px 36px -8px rgba(0,38,32,0.18)`.
  List<BoxShadow> get heroShadow => [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.18),
          offset: const Offset(0, 12),
          blurRadius: 36,
          spreadRadius: -8,
        ),
      ];

  /// Elevation 2 for bottom bars/sheets — `0 -8px 32px rgba(17,21,19,0.08)`.
  List<BoxShadow> get sheetShadow => [
        BoxShadow(
          color: const Color(0xFF111513).withValues(alpha: 0.08),
          offset: const Offset(0, -8),
          blurRadius: 32,
        ),
      ];

  @override
  SakinahPalette copyWith({
    Color? canvas,
    Color? paper,
    Color? gold,
    Color? goldSoft,
    Color? hero,
    Color? onHero,
    Color? onHeroMuted,
    Color? heroAccent,
    Color? cardBorder,
    Color? shadow,
  }) {
    return SakinahPalette(
      canvas: canvas ?? this.canvas,
      paper: paper ?? this.paper,
      gold: gold ?? this.gold,
      goldSoft: goldSoft ?? this.goldSoft,
      hero: hero ?? this.hero,
      onHero: onHero ?? this.onHero,
      onHeroMuted: onHeroMuted ?? this.onHeroMuted,
      heroAccent: heroAccent ?? this.heroAccent,
      cardBorder: cardBorder ?? this.cardBorder,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  SakinahPalette lerp(ThemeExtension<SakinahPalette>? other, double t) {
    if (other is! SakinahPalette) return this;
    return SakinahPalette(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      paper: Color.lerp(paper, other.paper, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      goldSoft: Color.lerp(goldSoft, other.goldSoft, t)!,
      hero: Color.lerp(hero, other.hero, t)!,
      onHero: Color.lerp(onHero, other.onHero, t)!,
      onHeroMuted: Color.lerp(onHeroMuted, other.onHeroMuted, t)!,
      heroAccent: Color.lerp(heroAccent, other.heroAccent, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}

extension SakinahPaletteContextX on BuildContext {
  SakinahPalette get palette {
    final theme = Theme.of(this);
    return theme.extension<SakinahPalette>() ??
        (theme.brightness == Brightness.dark ? SakinahPalette.dark : SakinahPalette.light);
  }
}
