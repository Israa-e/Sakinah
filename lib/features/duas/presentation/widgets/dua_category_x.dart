import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../domain/dua.dart';

extension DuaCategoryX on DuaCategory {
  String label(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      DuaCategory.forgiveness => l10n.duasCategoryForgiveness,
      DuaCategory.patience => l10n.duasCategoryPatience,
      DuaCategory.guidance => l10n.duasCategoryGuidance,
      DuaCategory.family => l10n.duasCategoryFamily,
      DuaCategory.knowledge => l10n.duasCategoryKnowledge,
      DuaCategory.hardship => l10n.duasCategoryHardship,
      DuaCategory.gratitude => l10n.duasCategoryGratitude,
    };
  }

  IconData get icon => switch (this) {
        DuaCategory.forgiveness => Icons.water_drop_outlined,
        DuaCategory.patience => Icons.self_improvement,
        DuaCategory.guidance => Icons.explore_outlined,
        DuaCategory.family => Icons.family_restroom,
        DuaCategory.knowledge => Icons.school_outlined,
        DuaCategory.hardship => Icons.healing_outlined,
        DuaCategory.gratitude => Icons.favorite_border,
      };
}

extension DuaDisplayX on Dua {
  /// Localized title for the current locale.
  String localizedTitle(BuildContext context) =>
      title(arabicLocale: Localizations.localeOf(context).languageCode == 'ar');

  /// e.g. "Quran 2:201" / "القرآن الكريم 2:201".
  String localizedReference(BuildContext context) =>
      isQuranic ? context.l10n.duasQuranReference(verseKey) : reference;

  /// e.g. "Al-Baqara 2:201" (surah name in the UI language when known).
  String surahLabel(BuildContext context) {
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    final name = ar ? surahNameAr : surahNameEn;
    if (!isQuranic || name == null) return localizedReference(context);
    return '$name $verseKey';
  }
}
