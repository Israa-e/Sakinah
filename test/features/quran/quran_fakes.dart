import 'dart:async';
import 'dart:io';

import 'package:sakinah/core/errors/app_failure.dart';
import 'package:sakinah/core/errors/result.dart';
import 'package:sakinah/features/quran/data/quran_page_index_loader.dart';
import 'package:sakinah/features/quran/data/tafsir_remote_data_source.dart';
import 'package:sakinah/features/quran/domain/quran_audio_engine.dart';
import 'package:sakinah/features/quran/domain/quran_models.dart';
import 'package:sakinah/features/quran/domain/quran_page_index.dart';
import 'package:sakinah/features/quran/domain/quran_repository.dart';

const testSurahs = [
  Surah(
    number: 1,
    nameAr: 'سُورَةُ ٱلْفَاتِحَةِ',
    nameEn: 'Al-Faatiha',
    meaningEn: 'The Opening',
    ayahCount: 7,
    revelationType: RevelationType.meccan,
  ),
  Surah(
    number: 2,
    nameAr: 'سُورَةُ البَقَرَةِ',
    nameEn: 'Al-Baqara',
    meaningEn: 'The Cow',
    ayahCount: 286,
    revelationType: RevelationType.medinan,
  ),
  Surah(
    number: 3,
    nameAr: 'سُورَةُ آلِ عِمۡرَانَ',
    nameEn: 'Aal-i-Imraan',
    meaningEn: 'The Family of Imraan',
    ayahCount: 200,
    revelationType: RevelationType.medinan,
  ),
];

/// Test-only placeholder ayahs (never shipped) — deterministic and
/// clearly fake so no real scripture is paraphrased in fixtures.
List<Ayah> fakeAyahs(int surah, int count) => [
  for (var i = 1; i <= count; i++)
    Ayah(
      surahNumber: surah,
      numberInSurah: i,
      globalNumber: 1000 + i,
      juz: 1 + i ~/ 100,
      textAr: 'نص-$surah-$i',
      translation: 'translation $surah:$i',
      translatorName: 'Sahih International',
    ),
];

class FakeQuranRepository implements QuranRepository {
  FakeQuranRepository({this.ayahFailure});

  final AppFailure? ayahFailure;
  final toggled = <(int, int)>[];
  final reflections = <(String, int?, int?)>[];
  final progress = <(int, int)>[];
  int ayahsLogged = 0;
  final _bookmarks = <(int, int)>{};
  final _bookmarkCtrl = StreamController<void>.broadcast();

  @override
  Future<List<Surah>> getSurahs() async => testSurahs;

  @override
  Future<Result<List<Ayah>>> getSurahAyahs(int surahNumber) async {
    final failure = ayahFailure;
    if (failure != null) return Failure(failure);
    final surah = testSurahs.firstWhere((s) => s.number == surahNumber);
    return Success(fakeAyahs(surahNumber, surah.ayahCount));
  }

  @override
  Stream<Set<int>> watchBookmarkedAyahs(int surahNumber) async* {
    Set<int> current() => {
      for (final b in _bookmarks)
        if (b.$1 == surahNumber) b.$2,
    };
    yield current();
    await for (final _ in _bookmarkCtrl.stream) {
      yield current();
    }
  }

  @override
  Stream<List<QuranBookmark>> watchBookmarks() async* {
    List<QuranBookmark> current() => [
      for (final b in _bookmarks)
        QuranBookmark(surahNumber: b.$1, ayahNumber: b.$2, createdAt: DateTime(2026)),
    ];
    yield current();
    await for (final _ in _bookmarkCtrl.stream) {
      yield current();
    }
  }

  @override
  Future<bool> toggleBookmark(int surahNumber, int ayahNumber) async {
    toggled.add((surahNumber, ayahNumber));
    final key = (surahNumber, ayahNumber);
    final added = _bookmarks.add(key);
    if (!added) _bookmarks.remove(key);
    _bookmarkCtrl.add(null);
    return added;
  }

  @override
  Future<void> removeBookmark(int surahNumber, int ayahNumber) async {
    _bookmarks.remove((surahNumber, ayahNumber));
    _bookmarkCtrl.add(null);
  }

  @override
  Future<void> saveReflection({required String body, int? surahNumber, int? ayahNumber}) async {
    reflections.add((body, surahNumber, ayahNumber));
  }

  @override
  Future<void> saveProgress(Surah surah, int ayahNumber) async {
    progress.add((surah.number, ayahNumber));
  }

  @override
  Stream<QuranReadingProgress?> watchLatestProgress() => Stream.value(null);

  @override
  Future<void> logAyahsRead(int count) async => ayahsLogged += count;
}

class FakeAudioEngine implements QuranAudioEngine {
  FakeAudioEngine({this.failLoad = false});

  final bool failLoad;
  final loaded = <String>[];
  final _events = StreamController<QuranAudioEvent>.broadcast();

  void complete() => _events.add(const AudioCompleted());

  @override
  Stream<QuranAudioEvent> get events => _events.stream;

  @override
  Future<void> load(String url) async {
    if (failLoad) throw StateError('no audio backend');
    loaded.add(url);
  }

  @override
  Future<void> play() async {}

  @override
  Future<void> pause() async {}

  @override
  Future<void> stop() async {}

  @override
  Future<void> dispose() => _events.close();
}

/// Test-only tafsir source; the text is an obvious placeholder.
class FakeTafsirRemote implements TafsirRemoteDataSource {
  FakeTafsirRemote({this.failure});

  AppFailure? failure;
  final requested = <(int, int)>[];

  @override
  Future<Result<String>> fetchMuyassar(int surah, int ayah) async {
    requested.add((surah, ayah));
    final f = failure;
    if (f != null) return Failure(f);
    return Success('tafsir-placeholder $surah:$ayah');
  }
}

/// The real bundled page index, read straight from the asset files.
Future<QuranPageIndex> loadTestPageIndex() =>
    loadQuranPageIndex(loadString: (path) => File(path).readAsString());
