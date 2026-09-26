/// First (surah, ayah) of each of the 30 ajza', in order — from
/// `https://api.alquran.cloud/v1/meta` (`data.juzs.references`), fetched
/// 2026-09-24. Structural metadata only, no Quran text.
const List<(int, int)> juzStarts = [
  (1, 1), (2, 142), (2, 253), (3, 93), (4, 24), (4, 148), (5, 82), (6, 111), //
  (7, 88), (8, 41), (9, 93), (11, 6), (12, 53), (15, 1), (17, 1), (18, 75), //
  (21, 1), (23, 1), (25, 21), (27, 56), (29, 46), (33, 31), (36, 28), (39, 32), //
  (41, 47), (46, 1), (51, 31), (58, 1), (67, 1), (78, 1),
];

/// The juz (1–30) containing [surah]:[ayah].
int juzFor(int surah, int ayah) {
  var juz = 1;
  for (var i = 0; i < juzStarts.length; i++) {
    final (s, a) = juzStarts[i];
    if (surah > s || (surah == s && ayah >= a)) {
      juz = i + 1;
    } else {
      break;
    }
  }
  return juz;
}
