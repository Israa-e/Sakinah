import 'package:flutter/material.dart';

/// The Sakīnah palette, taken 1:1 from the design system tokens
/// (`instraction/design.md`). Names mirror the Material 3 roles used in the
/// mockups, so a mockup class like `bg-primary-container` maps directly to
/// `colorScheme.primaryContainer`. Do not reach for a raw hex value anywhere
/// else in the app; add it here first if it's missing.
abstract final class AppColors {
  // --- Brand anchors (design.md → Colors) ---
  static const Color forest = Color(0xFF183C35);
  static const Color forestPressed = Color(0xFF122D28);
  static const Color sage = Color(0xFF6F8178);
  static const Color gold = Color(0xFFC9A86A);
  static const Color linen = Color(0xFFF8F7F3);
  static const Color paper = Color(0xFFFAF9F5);
  static const Color charcoal = Color(0xFF202522);
  static const Color white = Color(0xFFFFFFFF);

  // --- Light scheme (design tokens) ---
  static const Color surface = Color(0xFFF6FBF5);
  static const Color surfaceDim = Color(0xFFD7DBD6);
  static const Color surfaceBright = Color(0xFFF6FBF5);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF0F5F0);
  static const Color surfaceContainer = Color(0xFFEBEFEA);
  static const Color surfaceContainerHigh = Color(0xFFE5E9E4);
  static const Color surfaceContainerHighest = Color(0xFFDFE4DF);
  static const Color onSurface = Color(0xFF181D1A);
  static const Color onSurfaceVariant = Color(0xFF414846);
  static const Color inverseSurface = Color(0xFF2C322E);
  static const Color inverseOnSurface = Color(0xFFEDF2ED);
  static const Color outline = Color(0xFF717976);
  static const Color outlineVariant = Color(0xFFC1C8C5);
  static const Color surfaceTint = Color(0xFF42655D);
  static const Color primary = Color(0xFF002620);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF183C35);
  static const Color onPrimaryContainer = Color(0xFF81A69D);
  static const Color inversePrimary = Color(0xFFA8CEC4);
  static const Color secondary = Color(0xFF51625A);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFD1E4D9);
  static const Color onSecondaryContainer = Color(0xFF55665E);
  static const Color tertiary = Color(0xFF2D1E00);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF483200);
  static const Color onTertiaryContainer = Color(0xFFBA9A5E);
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);
  static const Color primaryFixed = Color(0xFFC4EBE0);
  static const Color primaryFixedDim = Color(0xFFA8CEC4);
  static const Color onPrimaryFixed = Color(0xFF00201B);
  static const Color onPrimaryFixedVariant = Color(0xFF2A4D46);
  static const Color secondaryFixed = Color(0xFFD4E7DC);
  static const Color secondaryFixedDim = Color(0xFFB8CBC1);
  static const Color onSecondaryFixed = Color(0xFF0E1F18);
  static const Color onSecondaryFixedVariant = Color(0xFF394A43);
  static const Color tertiaryFixed = Color(0xFFFFDEA4);
  static const Color tertiaryFixedDim = Color(0xFFE5C281);
  static const Color onTertiaryFixed = Color(0xFF261900);
  static const Color onTertiaryFixedVariant = Color(0xFF5B430E);

  // --- Dark scheme (design.md → Dark Mode Adaptation, extended to M3 roles) ---
  static const Color darkSurface = Color(0xFF111513);
  static const Color darkSurfaceBright = Color(0xFF353B37);
  static const Color darkSurfaceContainerLowest = Color(0xFF0C0F0E);
  static const Color darkSurfaceContainerLow = Color(0xFF18201D);
  static const Color darkSurfaceContainer = Color(0xFF1C2421);
  static const Color darkSurfaceContainerHigh = Color(0xFF232B28);
  static const Color darkSurfaceContainerHighest = Color(0xFF2D3531);
  static const Color darkOnSurface = Color(0xFFE8EEE9);
  static const Color darkOnSurfaceVariant = Color(0xFFC1C8C5);
  static const Color darkOutline = Color(0xFF8B9390);
  static const Color darkOutlineVariant = Color(0xFF414846);
  static const Color darkPrimary = Color(0xFFA8CEC4);
  static const Color darkOnPrimary = Color(0xFF10362F);
  static const Color darkPrimaryContainer = Color(0xFF2A4D46);
  static const Color darkOnPrimaryContainer = Color(0xFFC4EBE0);
  static const Color darkSecondary = Color(0xFFB8CBC1);
  static const Color darkOnSecondary = Color(0xFF23342D);
  static const Color darkSecondaryContainer = Color(0xFF394A43);
  static const Color darkOnSecondaryContainer = Color(0xFFD4E7DC);
  static const Color darkTertiary = Color(0xFFE5C281);
  static const Color darkOnTertiary = Color(0xFF402D00);
  static const Color darkTertiaryContainer = Color(0xFF5B430E);
  static const Color darkOnTertiaryContainer = Color(0xFFC8A96B);
  static const Color darkError = Color(0xFFFFB4AB);
  static const Color darkOnError = Color(0xFF690005);
  static const Color darkErrorContainer = Color(0xFF93000A);
  static const Color darkOnErrorContainer = Color(0xFFFFDAD6);
}
