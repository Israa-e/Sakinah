import 'package:flutter/material.dart';

/// Font family names — must match the `family:` entries registered in
/// pubspec.yaml under `flutter/fonts`.
abstract final class AppFonts {
  static const String latin = 'Inter';
  static const String arabic = 'IBM Plex Sans Arabic';
  static const String quran = 'Noto Naskh Arabic';
}

/// Sakīnah's type scale: Display / H1 / H2 / H3 / Body large / Body /
/// Body small / Caption / Button map onto Material's TextTheme slots so the
/// rest of the app can keep using `Theme.of(context).textTheme.*` normally.
/// Quran text and Arabic headings are script-specific (always Arabic script,
/// regardless of the active app locale) so they live in [AppTypographyExtension]
/// instead of the locale-dependent TextTheme.
abstract final class AppTypography {
  static TextTheme textTheme({required String languageCode, required Color color}) {
    final base = languageCode == 'ar' ? AppFonts.arabic : AppFonts.latin;
    TextStyle style(double size, FontWeight weight, {double? height, double? letterSpacing}) {
      return TextStyle(
        fontFamily: base,
        fontSize: size,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        color: color,
      );
    }

    return TextTheme(
      displayMedium: style(34, FontWeight.w700, height: 1.2), // Display
      headlineLarge: style(28, FontWeight.w700, height: 1.25), // H1
      headlineMedium: style(24, FontWeight.w600, height: 1.3), // H2
      headlineSmall: style(20, FontWeight.w600, height: 1.3), // H3
      bodyLarge: style(17, FontWeight.w400, height: 1.5), // Body large
      bodyMedium: style(15, FontWeight.w400, height: 1.5), // Body
      bodySmall: style(13, FontWeight.w400, height: 1.45), // Body small
      labelSmall: style(12, FontWeight.w500, height: 1.3, letterSpacing: 0.2), // Caption
      labelLarge: style(15, FontWeight.w600, height: 1.2, letterSpacing: 0.2), // Button
    );
  }
}

/// Extra, script-specific styles that don't map onto Material's [TextTheme].
@immutable
class AppTypographyExtension extends ThemeExtension<AppTypographyExtension> {
  const AppTypographyExtension({
    required this.quranText,
    required this.arabicHeading,
  });

  final TextStyle quranText;
  final TextStyle arabicHeading;

  factory AppTypographyExtension.build({required Color color}) {
    return AppTypographyExtension(
      quranText: TextStyle(
        fontFamily: AppFonts.quran,
        fontSize: 26,
        fontWeight: FontWeight.w400,
        height: 2.0,
        color: color,
      ),
      arabicHeading: TextStyle(
        fontFamily: AppFonts.arabic,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: color,
      ),
    );
  }

  @override
  AppTypographyExtension copyWith({TextStyle? quranText, TextStyle? arabicHeading}) {
    return AppTypographyExtension(
      quranText: quranText ?? this.quranText,
      arabicHeading: arabicHeading ?? this.arabicHeading,
    );
  }

  @override
  AppTypographyExtension lerp(ThemeExtension<AppTypographyExtension>? other, double t) {
    if (other is! AppTypographyExtension) return this;
    return AppTypographyExtension(
      quranText: TextStyle.lerp(quranText, other.quranText, t)!,
      arabicHeading: TextStyle.lerp(arabicHeading, other.arabicHeading, t)!,
    );
  }
}

extension AppTypographyContextX on BuildContext {
  AppTypographyExtension get sakinahTypography =>
      Theme.of(this).extension<AppTypographyExtension>()!;
}
