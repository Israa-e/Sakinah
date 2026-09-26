/// A verified excerpt of a Quran ayah. [arabic] and [translation] are exact
/// substrings of the ayah as returned by [sourceUrl] (quran-uthmani and
/// en.sahih editions) — never retyped from memory or copied from a mockup.
class HomeVerse {
  const HomeVerse({
    required this.surah,
    required this.ayah,
    required this.arabic,
    required this.translation,
    required this.sourceUrl,
  });

  final int surah;
  final int ayah;

  /// Uthmani script, from the `quran-uthmani` edition.
  final String arabic;

  /// Sahih International, from the `en.sahih` edition.
  final String translation;
  final String sourceUrl;

  String get reference => '$surah:$ayah';
}

/// Footer verse for Home (the second half of Quran 13:28), verified against
/// the source below on 2026-09-24.
const homeFooterVerse = HomeVerse(
  surah: 13,
  ayah: 28,
  arabic: 'أَلَا بِذِكْرِ ٱللَّهِ تَطْمَئِنُّ ٱلْقُلُوبُ',
  translation: 'Unquestionably, by the remembrance of Allah hearts are assured.',
  sourceUrl: 'https://api.alquran.cloud/v1/ayah/13:28/editions/quran-uthmani,en.sahih',
);
