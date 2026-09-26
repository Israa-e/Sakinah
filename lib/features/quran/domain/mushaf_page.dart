import 'package:equatable/equatable.dart';

import 'quran_models.dart';

/// The part of one surah printed on a mushaf page.
class MushafPageSegment extends Equatable {
  const MushafPageSegment({required this.surah, required this.ayahs});

  final Surah surah;
  final List<Ayah> ayahs;

  /// The page shows this surah's opening (title box + Bismillah).
  bool get startsSurah => ayahs.isNotEmpty && ayahs.first.numberInSurah == 1;

  @override
  List<Object?> get props => [surah, ayahs];
}

/// Everything needed to lay out one page of the Madani mushaf.
class MushafPageContent extends Equatable {
  const MushafPageContent({required this.page, required this.juz, required this.segments});

  final int page;
  final int juz;
  final List<MushafPageSegment> segments;

  List<Ayah> get ayahs => [for (final s in segments) ...s.ayahs];

  Ayah? get firstAyah =>
      segments.isEmpty || segments.first.ayahs.isEmpty ? null : segments.first.ayahs.first;

  /// Surah the page opens with (used for the header plaque).
  Surah get surah => segments.first.surah;

  Surah? surahOf(int number) => segments.where((s) => s.surah.number == number).firstOrNull?.surah;

  Ayah? ayah(int surah, int ayah) =>
      ayahs.where((a) => a.surahNumber == surah && a.numberInSurah == ayah).firstOrNull;

  @override
  List<Object?> get props => [page, juz, segments];
}

/// Mushaf display: swipe pages right-to-left, or scroll them continuously.
enum MushafDisplayMode { horizontal, vertical }

/// "Colour your mushaf" choices.
enum MushafColor { sand, blue, green }
