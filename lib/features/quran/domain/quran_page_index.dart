import 'package:equatable/equatable.dart';

/// A contiguous run of ayahs of one surah (inclusive bounds).
class AyahRange extends Equatable {
  const AyahRange(this.surah, this.from, this.to);

  final int surah;
  final int from;
  final int to;

  bool contains(int surahNumber, int ayah) => surahNumber == surah && ayah >= from && ayah <= to;

  int get length => to - from + 1;

  @override
  List<Object?> get props => [surah, from, to];

  @override
  String toString() => '$surah:$from-$to';
}

/// Page/juz geometry of the 604-page Madani mushaf, derived from the
/// first ayah of every page and juz (`assets/data/quran_pages.json`, from
/// api.alquran.cloud/v1/meta) plus each surah's ayah count.
class QuranPageIndex {
  QuranPageIndex({
    required List<(int, int)> pageStarts,
    required List<(int, int)> juzStarts,
    required List<int> ayahCounts,
  }) : assert(pageStarts.isNotEmpty),
       _pageStarts = List.unmodifiable(pageStarts),
       _juzStarts = List.unmodifiable(juzStarts),
       _ayahCounts = List.unmodifiable(ayahCounts);

  /// [json] is the decoded `quran_pages.json`; [ayahCounts] lists the ayah
  /// count of surah 1..114 in order.
  factory QuranPageIndex.fromJson(Map<String, dynamic> json, List<int> ayahCounts) {
    (int, int) pair(Object? e) {
      final l = (e! as List).cast<int>();
      return (l[0], l[1]);
    }

    return QuranPageIndex(
      pageStarts: [for (final e in json['pages'] as List) pair(e)],
      juzStarts: [for (final e in json['juzs'] as List) pair(e)],
      ayahCounts: ayahCounts,
    );
  }

  static const firstPage = 1;

  final List<(int, int)> _pageStarts;
  final List<(int, int)> _juzStarts;
  final List<int> _ayahCounts;

  int get pageCount => _pageStarts.length;

  int get lastPage => _pageStarts.length;

  int get surahCount => _ayahCounts.length;

  int ayahCount(int surah) => _ayahCounts[surah - 1];

  int clampPage(int page) => page.clamp(firstPage, lastPage);

  static int _compare((int, int) a, (int, int) b) => a.$1 != b.$1 ? a.$1 - b.$1 : a.$2 - b.$2;

  /// Index of the last entry in [starts] that is <= (surah, ayah).
  static int _floor(List<(int, int)> starts, int surah, int ayah) {
    var lo = 0;
    var hi = starts.length - 1;
    var found = 0;
    while (lo <= hi) {
      final mid = (lo + hi) >> 1;
      if (_compare(starts[mid], (surah, ayah)) <= 0) {
        found = mid;
        lo = mid + 1;
      } else {
        hi = mid - 1;
      }
    }
    return found;
  }

  /// First ayah printed on [page].
  (int, int) pageStart(int page) => _pageStarts[clampPage(page) - 1];

  /// The ayah ranges printed on [page], in reading order (a page can span
  /// the end of one surah and the start of the next).
  List<AyahRange> rangesForPage(int page) {
    final p = clampPage(page);
    final (startSurah, startAyah) = _pageStarts[p - 1];
    // Last ayah on the page: the one before the next page's first ayah.
    final int endSurah;
    final int endAyah;
    if (p == lastPage) {
      endSurah = surahCount;
      endAyah = ayahCount(surahCount);
    } else {
      final (ns, na) = _pageStarts[p];
      if (na > 1) {
        endSurah = ns;
        endAyah = na - 1;
      } else {
        endSurah = ns - 1;
        endAyah = ayahCount(ns - 1);
      }
    }
    return [
      for (var s = startSurah; s <= endSurah; s++)
        AyahRange(s, s == startSurah ? startAyah : 1, s == endSurah ? endAyah : ayahCount(s)),
    ];
  }

  /// Page on which [surah]:[ayah] is printed.
  int pageOf(int surah, int ayah) => _floor(_pageStarts, surah, ayah) + 1;

  int firstPageOfSurah(int surah) => pageOf(surah, 1);

  /// Juz (1–30) containing [surah]:[ayah].
  int juzOf(int surah, int ayah) => _floor(_juzStarts, surah, ayah) + 1;

  /// Juz of the first ayah on [page].
  int juzOfPage(int page) {
    final (s, a) = pageStart(page);
    return juzOf(s, a);
  }

  /// First page of [juz].
  int firstPageOfJuz(int juz) {
    final (s, a) = _juzStarts[juz.clamp(1, _juzStarts.length) - 1];
    return pageOf(s, a);
  }

  /// Surah whose text the page opens with (the header name for the page).
  int surahOfPage(int page) => pageStart(page).$1;
}
