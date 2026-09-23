import 'package:flutter/material.dart';

/// The Sakīnah palette. Feels like cream + white + deep green, with gold used
/// sparingly as an accent — never as the dominant color. Do not reach for a
/// raw hex value anywhere else in the app; add it here first if it's missing.
abstract final class AppColors {
  // --- Brand base (as specified) ---
  static const Color background = Color(0xFFF8F7F3);
  static const Color primary = Color(0xFF183C35);
  static const Color secondary = Color(0xFF6F8178);
  static const Color accent = Color(0xFFC9A86A);
  static const Color text = Color(0xFF202522);
  static const Color white = Color(0xFFFFFFFF);

  static const Color darkBackground = Color(0xFF111513);
  static const Color darkSurface = Color(0xFF18201D);
  static const Color darkText = Color(0xFFE8EEE9);

  // --- Light scheme derived tones ---
  static const Color lightSurfaceAlt = Color(0xFFF1EFE8);
  static const Color lightPrimaryContainer = Color(0xFFDCE7E1);
  static const Color lightOnPrimaryContainer = Color(0xFF0D211D);
  static const Color lightSecondaryContainer = Color(0xFFE3E7E2);
  static const Color lightOnSecondaryContainer = Color(0xFF2C332E);
  static const Color lightOnAccent = Color(0xFF3A2E15);
  static const Color lightAccentContainer = Color(0xFFF3E7D0);
  static const Color lightError = Color(0xFFA6483A);
  static const Color lightErrorContainer = Color(0xFFF4DEDA);
  static const Color lightOnErrorContainer = Color(0xFF3D140D);
  static const Color lightOutline = Color(0xFFC6CCC5);
  static const Color lightOutlineVariant = Color(0xFFE1E4DF);

  // --- Dark scheme derived tones (lightened for contrast against dark bg) ---
  static const Color darkSurfaceAlt = Color(0xFF1E2723);
  static const Color darkPrimary = Color(0xFF6FA893);
  static const Color darkOnPrimary = Color(0xFF0D211D);
  static const Color darkPrimaryContainer = Color(0xFF23433B);
  static const Color darkOnPrimaryContainer = Color(0xFFCFE6DE);
  static const Color darkSecondary = Color(0xFFA7B5AC);
  static const Color darkOnSecondary = Color(0xFF1B211D);
  static const Color darkSecondaryContainer = Color(0xFF3A433D);
  static const Color darkOnSecondaryContainer = Color(0xFFDDE4DE);
  static const Color darkAccent = Color(0xFFD8BC8A);
  static const Color darkOnAccent = Color(0xFF3A2E15);
  static const Color darkAccentContainer = Color(0xFF4A3B22);
  static const Color darkOnAccentContainer = Color(0xFFF3E7D0);
  static const Color darkError = Color(0xFFE2A79B);
  static const Color darkOnError = Color(0xFF3D140D);
  static const Color darkErrorContainer = Color(0xFF5C2D24);
  static const Color darkOnErrorContainer = Color(0xFFF4DEDA);
  static const Color darkOutline = Color(0xFF3B443E);
  static const Color darkOutlineVariant = Color(0xFF2A322D);
}
