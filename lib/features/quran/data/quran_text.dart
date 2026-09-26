/// Text helpers for Quran strings coming from api.alquran.cloud.
abstract final class QuranText {
  /// The Bismillah exactly as the `quran-uthmani` edition gives Quran 1:1
  /// (https://api.alquran.cloud/v1/ayah/1:1/quran-uthmani, BOM removed).
  /// Used only as the decorative surah header.
  static const bismillah = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';

  static final _diacritics = RegExp('[ً-ٰٟۖ-ۭـ]');

  /// Letters only: strips tashkeel/Quranic marks and normalises alef wasla,
  /// so differently-vowelled spellings compare equal.
  static String skeleton(String s) =>
      s.replaceAll('﻿', '').replaceAll('ٱ', 'ا').replaceAll(_diacritics, '');

  /// Removes the BOM and — for ayah 1 of every surah except 1 and 9 — the
  /// Bismillah the API prefixes (it is shown as a header instead). Verified
  /// against all 114 surahs of the `quran-uthmani` edition.
  static String cleanAyahText(String text, {required int surahNumber, required int ayahNumber}) {
    final cleaned = text.replaceAll('﻿', '').trim();
    if (ayahNumber != 1 || surahNumber == 1 || surahNumber == 9) return cleaned;
    final words = cleaned.split(' ');
    if (words.length > 4 && skeleton(words.take(4).join(' ')) == skeleton(bismillah)) {
      return words.skip(4).join(' ').trim();
    }
    return cleaned;
  }

  static const _arabicIndic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  /// `143` → `١٤٣`.
  static String arabicIndicDigits(int n) =>
      n.toString().split('').map((d) => _arabicIndic[int.parse(d)]).join();

  /// Ornamental ayah-end marker, e.g. `﴿١٤٣﴾`.
  static String ayahGlyph(int n) => '﴿${arabicIndicDigits(n)}﴾';
}
