import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/result.dart';
import '../../../../core/storage/preferences_service.dart';
import '../../data/drift_quran_repository.dart';
import '../../data/quran_page_index_loader.dart';
import '../../data/tafsir_remote_data_source.dart';
import '../../domain/mushaf_page.dart';
import '../../domain/quran_models.dart';

part 'quran_providers.g.dart';

/// All 114 surahs (bundled metadata — never needs the network).
@Riverpod(keepAlive: true)
Future<List<Surah>> surahList(Ref ref) {
  return ref.watch(quranRepositoryProvider).getSurahs();
}

@riverpod
Future<Surah?> surahByNumber(Ref ref, int number) async {
  final surahs = await ref.watch(surahListProvider.future);
  return surahs.where((s) => s.number == number).firstOrNull;
}

/// Ayahs of one surah. Errors carry the typed `AppFailure` from the
/// repository so the UI can say "offline and not saved" vs a generic error.
@riverpod
Future<List<Ayah>> surahAyahs(Ref ref, int surahNumber) async {
  final result = await ref.watch(quranRepositoryProvider).getSurahAyahs(surahNumber);
  return switch (result) {
    Success(:final data) => data,
    Failure(:final failure) => throw failure,
  };
}

@riverpod
Stream<Set<int>> bookmarkedAyahs(Ref ref, int surahNumber) {
  return ref.watch(quranRepositoryProvider).watchBookmarkedAyahs(surahNumber);
}

@riverpod
Stream<List<QuranBookmark>> quranBookmarks(Ref ref) {
  return ref.watch(quranRepositoryProvider).watchBookmarks();
}

/// Latest "continue reading" position (also what Home's card reflects).
@riverpod
Stream<QuranReadingProgress?> quranReadingProgress(Ref ref) {
  return ref.watch(quranRepositoryProvider).watchLatestProgress();
}

/// Reader font scale (applies to Arabic and translation), persisted.
///
/// Hand-written (not generated) because it depends on the manual
/// `sharedPreferencesProvider` from core.
final quranTextScaleProvider = NotifierProvider.autoDispose<QuranTextScale, double>(
  QuranTextScale.new,
);

class QuranTextScale extends AutoDisposeNotifier<double> {
  static const prefsKey = 'quran.textScale';
  static const min = 0.8;
  static const max = 1.6;
  static const defaultScale = 1.0;

  @override
  double build() {
    final stored = ref.watch(sharedPreferencesProvider).getDouble(prefsKey);
    return (stored ?? defaultScale).clamp(min, max);
  }

  Future<void> set(double value) async {
    state = value.clamp(min, max);
    await ref.read(sharedPreferencesProvider).setDouble(prefsKey, state);
  }
}

/// One mushaf page: the ayahs of the 1–2 surahs it spans, loaded through the
/// repository's per-surah cache (fetched once, then available offline).
/// Errors carry the repository's `AppFailure`.
@riverpod
Future<MushafPageContent> mushafPage(Ref ref, int page) async {
  final index = await ref.watch(quranPageIndexProvider.future);
  final surahs = await ref.watch(surahListProvider.future);
  final p = index.clampPage(page);
  final ranges = index.rangesForPage(p);
  final lists = await Future.wait([
    for (final r in ranges) ref.watch(surahAyahsProvider(r.surah).future),
  ]);
  return MushafPageContent(
    page: p,
    juz: index.juzOfPage(p),
    segments: [
      for (var i = 0; i < ranges.length; i++)
        MushafPageSegment(
          surah: surahs.firstWhere((s) => s.number == ranges[i].surah),
          ayahs: [
            for (final a in lists[i])
              if (ranges[i].contains(a.surahNumber, a.numberInSurah)) a,
          ],
        ),
    ],
  );
}

/// Tafsir al-Muyassar for one ayah (see [TafsirSource]); errors carry the
/// typed `AppFailure`.
@riverpod
Future<String> ayahTafsir(Ref ref, int surah, int ayah) async {
  final result = await ref.watch(tafsirRemoteDataSourceProvider).fetchMuyassar(surah, ayah);
  return switch (result) {
    Success(:final data) => data,
    Failure(:final failure) => throw failure,
  };
}

/// Horizontal (page swipe) / vertical (continuous scroll), persisted.
final mushafDisplayModeProvider =
    NotifierProvider.autoDispose<MushafDisplayModeSetting, MushafDisplayMode>(
      MushafDisplayModeSetting.new,
    );

class MushafDisplayModeSetting extends AutoDisposeNotifier<MushafDisplayMode> {
  static const prefsKey = 'quran.displayMode';

  @override
  MushafDisplayMode build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(prefsKey);
    return MushafDisplayMode.values.firstWhere(
      (m) => m.name == raw,
      orElse: () => MushafDisplayMode.horizontal,
    );
  }

  Future<void> set(MushafDisplayMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(prefsKey, mode.name);
  }
}

/// Mushaf colour theme, persisted.
final mushafColorProvider = NotifierProvider.autoDispose<MushafColorSetting, MushafColor>(
  MushafColorSetting.new,
);

class MushafColorSetting extends AutoDisposeNotifier<MushafColor> {
  static const prefsKey = 'quran.mushafColor';

  @override
  MushafColor build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(prefsKey);
    return MushafColor.values.firstWhere((c) => c.name == raw, orElse: () => MushafColor.sand);
  }

  Future<void> set(MushafColor color) async {
    state = color;
    await ref.read(sharedPreferencesProvider).setString(prefsKey, color.name);
  }
}

/// Reader-local night mode. `null` (never toggled) follows the app theme.
final mushafNightModeProvider = NotifierProvider.autoDispose<MushafNightMode, bool?>(
  MushafNightMode.new,
);

class MushafNightMode extends AutoDisposeNotifier<bool?> {
  static const prefsKey = 'quran.nightMode';

  @override
  bool? build() => ref.watch(sharedPreferencesProvider).getBool(prefsKey);

  Future<void> set({required bool night}) async {
    state = night;
    await ref.read(sharedPreferencesProvider).setBool(prefsKey, night);
  }
}

/// Whether the first-run reader coach marks were already shown.
final quranCoachMarksSeenProvider = NotifierProvider.autoDispose<QuranCoachMarksSeen, bool>(
  QuranCoachMarksSeen.new,
);

class QuranCoachMarksSeen extends AutoDisposeNotifier<bool> {
  static const prefsKey = 'quran.coachMarksSeen';

  @override
  bool build() => ref.watch(sharedPreferencesProvider).getBool(prefsKey) ?? false;

  Future<void> markSeen() async {
    state = true;
    await ref.read(sharedPreferencesProvider).setBool(prefsKey, true);
  }
}
