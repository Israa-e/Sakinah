class QuranProgressInfo {
  const QuranProgressInfo({
    required this.surahNumber,
    required this.surahNameAr,
    required this.surahNameEn,
    required this.ayahNumber,
    required this.totalAyahs,
  });

  final int surahNumber;
  final String surahNameAr;
  final String surahNameEn;
  final int ayahNumber;
  final int totalAyahs;

  double get progress => totalAyahs == 0 ? 0 : ayahNumber / totalAyahs;
}

class DailyDeed {
  const DailyDeed({
    required this.day,
    required this.textEn,
    required this.textAr,
    required this.completed,
  });

  final DateTime day;
  final String textEn;
  final String textAr;
  final bool completed;
}

/// Fixed placeholder content until the Dhikr feature (Phase 5) can surface a
/// real rotating "dhikr of the day." Arabic text and count are the well
/// known authentic dhikr said after prayer — not invented content.
class DhikrPreview {
  const DhikrPreview({required this.arabicText, required this.targetCount});

  final String arabicText;
  final int targetCount;
}
