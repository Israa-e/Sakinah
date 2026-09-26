import '../../../core/errors/result.dart';
import 'quran_models.dart';

/// Single source of truth for Quran text, bookmarks, reflections and
/// reading progress. Implementations must never fabricate text: ayahs come
/// from the offline cache or api.alquran.cloud, nothing else.
abstract interface class QuranRepository {
  /// All 114 surahs from the bundled metadata asset (works offline).
  Future<List<Surah>> getSurahs();

  /// Ayahs of [surahNumber]: cached copy first, otherwise fetched, cached,
  /// then returned. Offline + not cached yields a [NetworkFailure].
  Future<Result<List<Ayah>>> getSurahAyahs(int surahNumber);

  Stream<List<QuranBookmark>> watchBookmarks();

  /// Ayah numbers bookmarked within [surahNumber].
  Stream<Set<int>> watchBookmarkedAyahs(int surahNumber);

  /// Adds or removes the bookmark; returns `true` when now bookmarked.
  Future<bool> toggleBookmark(int surahNumber, int ayahNumber);

  Future<void> removeBookmark(int surahNumber, int ayahNumber);

  Future<void> saveReflection({required String body, int? surahNumber, int? ayahNumber});

  /// Records [ayahNumber] of [surah] as the continue-reading position.
  Future<void> saveProgress(Surah surah, int ayahNumber);

  Stream<QuranReadingProgress?> watchLatestProgress();

  /// Adds [count] to today's ayahs-read total (Journey streak).
  Future<void> logAyahsRead(int count);
}
