import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/core/errors/app_failure.dart';
import 'package:sakinah/core/errors/result.dart';
import 'package:sakinah/core/network/network_info.dart';
import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/features/quran/data/drift_quran_repository.dart';
import 'package:sakinah/features/quran/data/quran_remote_data_source.dart';
import 'package:sakinah/features/quran/data/quran_text.dart';
import 'package:sakinah/features/quran/domain/quran_models.dart';

import '../../fakes/test_database.dart';
import 'quran_fakes.dart';

class _FakeRemote implements QuranRemoteDataSource {
  int calls = 0;

  @override
  Future<Result<List<Ayah>>> fetchSurah(int surahNumber) async {
    calls++;
    return Success(fakeAyahs(surahNumber, surahNumber == 1 ? 7 : 286));
  }
}

class _FakeNetwork implements NetworkInfo {
  _FakeNetwork(this.online);

  bool online;

  @override
  Future<bool> get isConnected async => online;

  @override
  Stream<bool> get onConnectivityChanged => Stream.value(online);
}

void main() {
  late AppDatabase db;
  late _FakeRemote remote;
  late _FakeNetwork network;
  late DriftQuranRepository repo;

  setUp(() {
    db = openTestDatabase();
    remote = _FakeRemote();
    network = _FakeNetwork(true);
    repo = DriftQuranRepository(
      db: db,
      remote: remote,
      networkInfo: network,
      loadSurahsJson: () => File('assets/data/surahs.json').readAsString(),
    );
  });

  tearDown(() => db.close());

  test('loads all 114 surahs from the bundled asset', () async {
    final surahs = await repo.getSurahs();
    expect(surahs, hasLength(114));
    expect(surahs[1].ayahCount, 286);
    expect(surahs[1].revelationType, RevelationType.medinan);
    expect(surahs[8].hasBismillahHeader, isFalse);
  });

  test('fetches on cache miss, then serves from the Drift cache', () async {
    final first = await repo.getSurahAyahs(1);
    expect(first.dataOrNull, hasLength(7));
    expect(remote.calls, 1);

    final rows = await db.select(db.cachedAyahs).get();
    expect(rows, hasLength(7));
    expect(rows.every((r) => r.translatorName == 'Sahih International'), isTrue);

    network.online = false;
    final second = await repo.getSurahAyahs(1);
    expect(second.dataOrNull, hasLength(7));
    expect(remote.calls, 1);
  });

  test('offline and not cached yields a NetworkFailure', () async {
    network.online = false;
    final result = await repo.getSurahAyahs(2);
    expect(result, isA<Failure<List<Ayah>>>());
    expect((result as Failure<List<Ayah>>).failure, isA<NetworkFailure>());
    expect(remote.calls, 0);
  });

  test('bookmarks toggle and carry cached ayah text', () async {
    await repo.getSurahAyahs(1);
    expect(await repo.toggleBookmark(1, 3), isTrue);
    final bookmarks = await repo.watchBookmarks().first;
    expect(bookmarks.single.ayahNumber, 3);
    expect(bookmarks.single.ayah?.translation, 'translation 1:3');
    expect(await repo.watchBookmarkedAyahs(1).first, {3});

    expect(await repo.toggleBookmark(1, 3), isFalse);
    expect(await repo.watchBookmarks().first, isEmpty);
  });

  test('progress, reflections and reading logs persist', () async {
    final surahs = await repo.getSurahs();
    await repo.saveProgress(surahs[1], 255);
    final progress = await repo.watchLatestProgress().first;
    expect(progress?.surahNumber, 2);
    expect(progress?.ayahNumber, 255);
    expect(progress?.totalAyahs, 286);

    await repo.saveReflection(body: '  a note ', surahNumber: 2, ayahNumber: 255);
    final reflection = await db.select(db.reflections).getSingle();
    expect(reflection.body, 'a note');
    expect(reflection.ayahNumber, 255);

    await repo.logAyahsRead(3);
    await repo.logAyahsRead(2);
    final log = await db.select(db.readingLogs).getSingle();
    expect(log.ayahsRead, 5);
    expect(log.day, AppDatabase.dayKey(DateTime.now()));
  });

  group('QuranText', () {
    test('strips the API-prefixed Bismillah, including spelling variants', () {
      // Quran 97:1 as returned by the quran-uthmani edition.
      const raw =
          'بِّسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ إِنَّآ أَنزَلْنَٰهُ فِى لَيْلَةِ ٱلْقَدْرِ';
      expect(
        QuranText.cleanAyahText(raw, surahNumber: 97, ayahNumber: 1),
        'إِنَّآ أَنزَلْنَٰهُ فِى لَيْلَةِ ٱلْقَدْرِ',
      );
      // Al-Fatihah's first ayah *is* the Bismillah — kept.
      expect(
        QuranText.cleanAyahText('﻿${QuranText.bismillah}', surahNumber: 1, ayahNumber: 1),
        QuranText.bismillah,
      );
    });

    test('formats ayah glyphs with Arabic-Indic digits', () {
      expect(QuranText.ayahGlyph(143), '﴿١٤٣﴾');
    });
  });

  test('parses the editions payload and names the translator', () {
    final body = {
      'data': [
        {
          'edition': {'identifier': 'quran-uthmani'},
          'ayahs': [
            {'number': 6126, 'numberInSurah': 1, 'juz': 30, 'text': 'x'},
          ],
        },
        {
          'edition': {'identifier': 'en.sahih'},
          'ayahs': [
            {'number': 6126, 'numberInSurah': 1, 'juz': 30, 'text': ' y '},
          ],
        },
      ],
    };
    final ayahs = DioQuranRemoteDataSource.parseSurahEditions(body, 97);
    expect(ayahs.single.globalNumber, 6126);
    expect(ayahs.single.translation, 'y');
    expect(ayahs.single.translatorName, 'Sahih International');
  });
}
