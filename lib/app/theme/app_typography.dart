import 'package:flutter/material.dart';

/// Font family names — must match the `family:` entries registered in
/// pubspec.yaml under `flutter/fonts`.
abstract final class AppFonts {
  static const String latin = 'Plus Jakarta Sans';
  static const String arabic = 'IBM Plex Sans Arabic';
  static const String quran = 'Amiri';
  static const String quranFallback = 'Noto Naskh Arabic';
}

/// Sakīnah's type scale, mapped from the design tokens onto Material's
/// [TextTheme] slots so the rest of the app keeps using
/// `Theme.of(context).textTheme.*`:
///
/// | design token        | TextTheme slot   |
/// |---------------------|------------------|
/// | display-lg          | displayLarge     |
/// | display-lg-mobile   | displayMedium    |
/// | headline-lg         | headlineLarge    |
/// | headline-md         | headlineMedium   |
/// | (h3, 20px)          | headlineSmall    |
/// | title-lg            | titleLarge       |
/// | title-md            | titleMedium      |
/// | body-lg/md/sm       | bodyLarge/Medium/Small |
/// | (button)            | labelLarge       |
/// | label-md            | labelMedium      |
/// | label-sm            | labelSmall       |
///
/// Quran text and Arabic UI text are script-specific (always Arabic script,
/// regardless of the active app locale) so they live in
/// [AppTypographyExtension] instead of the locale-dependent TextTheme.
abstract final class AppTypography {
  static TextTheme textTheme({required String languageCode, required Color color}) {
    final isArabic = languageCode == 'ar';
    final base = isArabic ? AppFonts.arabic : AppFonts.latin;
    final fallback = isArabic ? const [AppFonts.latin] : const [AppFonts.arabic];
    TextStyle style(double size, double lineHeight, FontWeight weight, {double em = 0}) {
      return TextStyle(
        fontFamily: base,
        fontFamilyFallback: fallback,
        fontSize: size,
        fontWeight: weight,
        // Arabic script needs extra vertical room for diacritics.
        height: (lineHeight / size) * (isArabic ? 1.1 : 1.0),
        letterSpacing: isArabic ? 0 : em * size,
        color: color,
      );
    }

    return TextTheme(
      displayLarge: style(36, 44, FontWeight.w600, em: -0.02),
      displayMedium: style(30, 38, FontWeight.w600, em: -0.015),
      displaySmall: style(28, 36, FontWeight.w600, em: -0.01),
      headlineLarge: style(26, 34, FontWeight.w600, em: -0.01),
      headlineMedium: style(22, 28, FontWeight.w600),
      headlineSmall: style(20, 26, FontWeight.w600),
      titleLarge: style(18, 24, FontWeight.w600),
      titleMedium: style(16, 22, FontWeight.w500),
      titleSmall: style(14, 20, FontWeight.w600),
      bodyLarge: style(16, 26, FontWeight.w400),
      bodyMedium: style(14, 22, FontWeight.w400),
      bodySmall: style(12, 18, FontWeight.w400),
      labelLarge: style(15, 20, FontWeight.w600, em: 0.01),
      labelMedium: style(13, 18, FontWeight.w500, em: 0.01),
      labelSmall: style(11, 16, FontWeight.w600, em: 0.04),
    );
  }
}

/// Extra, script-specific styles that don't map onto Material's [TextTheme].
@immutable
class AppTypographyExtension extends ThemeExtension<AppTypographyExtension> {
  const AppTypographyExtension({
    required this.quranText,
    required this.quranTextMedium,
    required this.arabicHeading,
    required this.arabicUi,
    required this.counter,
  });

  /// `arabic-verse-lg` — the focused ayah / du'a (28px, generous leading).
  final TextStyle quranText;

  /// `arabic-verse-md` — list rows, previews, dhikr cards (22px).
  final TextStyle quranTextMedium;

  final TextStyle arabicHeading;

  /// `arabic-ui-md` — Arabic labels inside an otherwise Latin UI.
  final TextStyle arabicUi;

  /// Tasbeeh counter numerals (48px semibold).
  final TextStyle counter;

  factory AppTypographyExtension.build({required Color color}) {
    return AppTypographyExtension(
      quranText: TextStyle(
        fontFamily: AppFonts.quran,
        fontFamilyFallback: const [AppFonts.quranFallback],
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 2.0,
        color: color,
      ),
      quranTextMedium: TextStyle(
        fontFamily: AppFonts.quran,
        fontFamilyFallback: const [AppFonts.quranFallback],
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 1.95,
        color: color,
      ),
      arabicHeading: TextStyle(
        fontFamily: AppFonts.arabic,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: color,
      ),
      arabicUi: TextStyle(
        fontFamily: AppFonts.arabic,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.6,
        color: color,
      ),
      counter: TextStyle(
        fontFamily: AppFonts.latin,
        fontSize: 48,
        fontWeight: FontWeight.w600,
        height: 1.1,
        letterSpacing: -0.96,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }

  @override
  AppTypographyExtension copyWith({
    TextStyle? quranText,
    TextStyle? quranTextMedium,
    TextStyle? arabicHeading,
    TextStyle? arabicUi,
    TextStyle? counter,
  }) {
    return AppTypographyExtension(
      quranText: quranText ?? this.quranText,
      quranTextMedium: quranTextMedium ?? this.quranTextMedium,
      arabicHeading: arabicHeading ?? this.arabicHeading,
      arabicUi: arabicUi ?? this.arabicUi,
      counter: counter ?? this.counter,
    );
  }

  @override
  AppTypographyExtension lerp(ThemeExtension<AppTypographyExtension>? other, double t) {
    if (other is! AppTypographyExtension) return this;
    return AppTypographyExtension(
      quranText: TextStyle.lerp(quranText, other.quranText, t)!,
      quranTextMedium: TextStyle.lerp(quranTextMedium, other.quranTextMedium, t)!,
      arabicHeading: TextStyle.lerp(arabicHeading, other.arabicHeading, t)!,
      arabicUi: TextStyle.lerp(arabicUi, other.arabicUi, t)!,
      counter: TextStyle.lerp(counter, other.counter, t)!,
    );
  }
}

extension AppTypographyContextX on BuildContext {
  AppTypographyExtension get sakinahTypography {
    final theme = Theme.of(this);
    return theme.extension<AppTypographyExtension>() ??
        AppTypographyExtension.build(color: theme.colorScheme.onSurface);
  }
}
