import 'package:equatable/equatable.dart';

enum RevelationType { meccan, medinan }

/// Surah metadata (bundled from api.alquran.cloud — see
/// `assets/data/surahs.json`), available offline from first launch.
class Surah extends Equatable {
  const Surah({
    required this.number,
    required this.nameAr,
    required this.nameEn,
    required this.meaningEn,
    required this.ayahCount,
    required this.revelationType,
  });

  final int number;
  final String nameAr;
  final String nameEn;
  final String meaningEn;
  final int ayahCount;
  final RevelationType revelationType;

  /// Surah At-Tawbah (9) opens without the Bismillah.
  bool get hasBismillahHeader => number != 1 && number != 9;

  @override
  List<Object?> get props => [number, nameAr, nameEn, meaningEn, ayahCount, revelationType];
}

/// One ayah with its Uthmani Arabic text and an attributed translation.
class Ayah extends Equatable {
  const Ayah({
    required this.surahNumber,
    required this.numberInSurah,
    required this.globalNumber,
    required this.juz,
    required this.textAr,
    required this.translation,
    required this.translatorName,
  });

  final int surahNumber;
  final int numberInSurah;

  /// 1–6236 across the whole mushaf; used for per-ayah recitation audio.
  final int globalNumber;
  final int juz;
  final String textAr;
  final String translation;
  final String translatorName;

  /// `2:255`-style reference.
  String get reference => '$surahNumber:$numberInSurah';

  @override
  List<Object?> get props => [
    surahNumber,
    numberInSurah,
    globalNumber,
    juz,
    textAr,
    translation,
    translatorName,
  ];
}

class QuranBookmark extends Equatable {
  const QuranBookmark({
    required this.surahNumber,
    required this.ayahNumber,
    required this.createdAt,
    this.ayah,
  });

  final int surahNumber;
  final int ayahNumber;
  final DateTime createdAt;

  /// Cached text for a preview, when the surah has been downloaded.
  final Ayah? ayah;

  @override
  List<Object?> get props => [surahNumber, ayahNumber, createdAt, ayah];
}

/// The user's latest reading position ("continue reading").
class QuranReadingProgress extends Equatable {
  const QuranReadingProgress({
    required this.surahNumber,
    required this.surahNameEn,
    required this.surahNameAr,
    required this.ayahNumber,
    required this.totalAyahs,
    required this.updatedAt,
  });

  final int surahNumber;
  final String surahNameEn;
  final String surahNameAr;
  final int ayahNumber;
  final int totalAyahs;
  final DateTime updatedAt;

  double get fraction => totalAyahs == 0 ? 0 : (ayahNumber / totalAyahs).clamp(0, 1);

  @override
  List<Object?> get props => [
    surahNumber,
    surahNameEn,
    surahNameAr,
    ayahNumber,
    totalAyahs,
    updatedAt,
  ];
}
