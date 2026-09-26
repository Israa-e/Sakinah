/// Library categories. The JSON asset stores [DuaCategory.name].
enum DuaCategory {
  forgiveness,
  patience,
  guidance,
  family,
  knowledge,
  hardship,
  gratitude;

  static DuaCategory? tryParse(String value) {
    for (final c in values) {
      if (c.name == value) return c;
    }
    return null;
  }
}

/// A bundled, sourced supplication. Every du'a in the catalog is a whole
/// Quranic ayah whose Arabic text and translation were fetched verbatim from
/// api.alquran.cloud (see `tool/fetch_duas.py`) — never typed by hand.
class Dua {
  const Dua({
    required this.key,
    required this.category,
    required this.titleEn,
    required this.titleAr,
    required this.arabic,
    required this.translation,
    required this.translator,
    required this.reference,
    required this.sourceUrl,
    this.surah,
    this.ayah,
    this.surahNameEn,
    this.surahNameAr,
  });

  factory Dua.fromJson(Map<String, dynamic> json) {
    final category = DuaCategory.tryParse(json['category'] as String);
    if (category == null) {
      throw FormatException('Unknown du\'a category: ${json['category']}');
    }
    return Dua(
      key: json['key'] as String,
      category: category,
      titleEn: json['titleEn'] as String,
      titleAr: json['titleAr'] as String,
      arabic: json['arabic'] as String,
      translation: json['translation'] as String,
      translator: json['translator'] as String,
      reference: json['reference'] as String,
      sourceUrl: json['sourceUrl'] as String,
      surah: json['surah'] as int?,
      ayah: json['ayah'] as int?,
      surahNameEn: json['surahNameEn'] as String?,
      surahNameAr: json['surahNameAr'] as String?,
    );
  }

  /// Stable id — also the primary key in the `SavedDuas` table.
  final String key;
  final DuaCategory category;
  final String titleEn;
  final String titleAr;
  final String arabic;
  final String translation;

  /// Named translator, e.g. "Sahih International".
  final String translator;

  /// Canonical citation, e.g. "Quran 2:201".
  final String reference;
  final String sourceUrl;

  /// Set for Quranic du'as — lets the UI deep-link into the Quran reader.
  final int? surah;
  final int? ayah;
  final String? surahNameEn;
  final String? surahNameAr;

  bool get isQuranic => surah != null && ayah != null;

  /// "2:201" for Quranic du'as, otherwise the raw [reference].
  String get verseKey => isQuranic ? '$surah:$ayah' : reference;

  String title({required bool arabicLocale}) => arabicLocale ? titleAr : titleEn;

  /// Plain-text form used for copying: text, translation and full citation.
  String toShareText() =>
      '$arabic\n\n$translation\n\n— $reference · $translator';
}
