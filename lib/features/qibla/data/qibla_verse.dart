/// A verified excerpt of a Quran ayah. [arabic] and [translation] are exact
/// substrings of the ayah as returned by [sourceUrl] (quran-uthmani and
/// en.sahih editions) — never retyped from memory or copied from a mockup.
class QiblaVerse {
  const QiblaVerse({
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

/// The Qibla command (an excerpt of Quran 2:144), verified against the
/// source below on 2026-09-24.
const qiblaVerse = QiblaVerse(
  surah: 2,
  ayah: 144,
  arabic: 'فَوَلِّ وَجْهَكَ شَطْرَ ٱلْمَسْجِدِ ٱلْحَرَامِ',
  translation: 'So turn your face toward al-Masjid al-Haram.',
  sourceUrl: 'https://api.alquran.cloud/v1/ayah/2:144/editions/quran-uthmani,en.sahih',
);
