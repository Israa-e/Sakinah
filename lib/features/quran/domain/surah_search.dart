import 'quran_models.dart';

/// Filters [surahs] by number, English name/meaning (tolerant of the
/// transliteration variants people type, e.g. "fatiha" ↔ "Al-Faatiha",
/// "baqarah" ↔ "Al-Baqara") or Arabic name (diacritics ignored).
List<Surah> filterSurahs(List<Surah> surahs, String query) {
  final q = query.trim();
  if (q.isEmpty) return surahs;
  final number = int.tryParse(q);
  if (number != null) return surahs.where((s) => s.number == number).toList();

  final latin = _latin(q);
  final latinNoH = latin.endsWith('h') ? latin.substring(0, latin.length - 1) : latin;
  final arabic = _arabic(q);
  return surahs.where((s) {
    if (latin.isNotEmpty) {
      final name = _latin(s.nameEn);
      final bare = name.startsWith('al') ? name.substring(2) : name;
      if (name.contains(latin) || name.contains(latinNoH) || latin.contains(bare)) return true;
      if (_latin(s.meaningEn).contains(latin)) return true;
    }
    return arabic.isNotEmpty && _arabic(s.nameAr).contains(arabic);
  }).toList();
}

String _latin(String s) => s
    .toLowerCase()
    .replaceAll(RegExp('[^a-z]'), '')
    .replaceAllMapped(RegExp('([aeiou])\\1+'), (m) => m[1]!);

final _arabicMarks = RegExp('[ً-ٰٟۖ-ۭـ]');

String _arabic(String s) => s
    .replaceAll(_arabicMarks, '')
    .replaceAll(RegExp('[ٱأإآ]'), 'ا')
    .replaceAll('ة', 'ه')
    .replaceAll('ى', 'ي')
    .replaceAll(RegExp('[^ء-ي]'), '');
