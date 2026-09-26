import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/dhikr_item.dart';

extension DhikrCategoryX on DhikrCategory {
  String label(AppLocalizations l10n) => switch (this) {
    DhikrCategory.afterPrayer => l10n.dhikrCategoryAfterPrayer,
    DhikrCategory.morning => l10n.dhikrCategoryMorning,
    DhikrCategory.evening => l10n.dhikrCategoryEvening,
    DhikrCategory.anytime => l10n.dhikrCategoryAnytime,
  };

  IconData get icon => switch (this) {
    DhikrCategory.afterPrayer => Icons.mosque_outlined,
    DhikrCategory.morning => Icons.wb_sunny_outlined,
    DhikrCategory.evening => Icons.nights_stay_outlined,
    DhikrCategory.anytime => Icons.all_inclusive,
  };
}
