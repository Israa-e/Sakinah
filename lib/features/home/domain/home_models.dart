class QuranProgressInfo {
  const QuranProgressInfo({
    required this.surahNumber,
    required this.surahNameAr,
    required this.surahNameEn,
    required this.ayahNumber,
    required this.totalAyahs,
    this.juz,
  });

  final int surahNumber;
  final String surahNameAr;
  final String surahNameEn;
  final int ayahNumber;
  final int totalAyahs;

  /// The juz containing the current ayah, when known.
  final int? juz;

  double get progress => totalAyahs == 0 ? 0 : (ayahNumber / totalAyahs).clamp(0, 1);
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

/// What the Home "Today's Dhikr" card shows, derived by `todaysDhikrProvider`
/// from the Dhikr feature's sourced catalog and today's counts.
class DhikrPreview {
  const DhikrPreview({
    required this.key,
    required this.arabicText,
    required this.targetCount,
    this.reference,
    this.countToday,
  });

  /// Stable Dhikr catalog key — opens that item's counter.
  final String key;
  final String arabicText;
  final int targetCount;

  /// Hadith source (e.g. collection + number), shown under the text when set.
  final String? reference;

  /// Today's tally toward [targetCount]; the progress ring is hidden when null.
  final int? countToday;
}
