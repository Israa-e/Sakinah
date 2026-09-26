import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/features/quran/data/tafsir_remote_data_source.dart';
import 'package:sakinah/features/quran/domain/quran_page_index.dart';

import 'quran_fakes.dart';

void main() {
  late QuranPageIndex index;

  setUpAll(() async => index = await loadTestPageIndex());

  group('QuranPageIndex', () {
    test('has 604 pages and 114 surahs', () {
      expect(index.lastPage, 604);
      expect(index.surahCount, 114);
    });

    test('page 1 is Al-Fatihah 1–7 and page 2 is Al-Baqarah 1–5', () {
      expect(index.rangesForPage(1), [const AyahRange(1, 1, 7)]);
      expect(index.rangesForPage(2), [const AyahRange(2, 1, 5)]);
      expect(index.juzOfPage(1), 1);
      expect(index.juzOfPage(2), 1);
    });

    test('maps ayahs to pages', () {
      expect(index.pageOf(2, 5), 2);
      expect(index.pageOf(2, 6), 3);
      expect(index.pageOf(1, 7), 1);
      expect(index.pageOf(114, 1), 604);
      expect(index.pageOf(114, 6), 604);
    });

    test('juz 2 starts at 2:142 on its own page', () {
      final page = index.pageOf(2, 142);
      expect(index.firstPageOfJuz(2), page);
      expect(index.juzOf(2, 141), 1);
      expect(index.juzOf(2, 142), 2);
      expect(index.juzOfPage(page), 2);
      expect(index.juzOfPage(page - 1), 1);
    });

    test('surah start pages', () {
      expect(index.firstPageOfSurah(1), 1);
      expect(index.firstPageOfSurah(2), 2);
      expect(index.firstPageOfSurah(3), 50);
      expect(index.firstPageOfSurah(9), 187);
      expect(index.rangesForPage(186).last, const AyahRange(8, 70, 75));
      expect(index.surahOfPage(187), 9);
    });

    test('a page can span surahs and the last page ends at 114:6', () {
      // Page 106 closes An-Nisa and opens Al-Ma'idah.
      expect(index.rangesForPage(106), const [AyahRange(4, 176, 176), AyahRange(5, 1, 2)]);
      final last = index.rangesForPage(604);
      expect(last.first.surah, 112);
      expect(last.last, const AyahRange(114, 1, 6));
    });

    test('pages cover every ayah exactly once, in order', () {
      var total = 0;
      (int, int)? previous;
      for (var p = 1; p <= index.lastPage; p++) {
        for (final r in index.rangesForPage(p)) {
          expect(r.from <= r.to, isTrue, reason: 'page $p $r');
          if (previous != null) {
            final (ps, pa) = previous;
            final continues = r.surah == ps && r.from == pa + 1;
            final nextSurah = r.surah == ps + 1 && r.from == 1 && pa == index.ayahCount(ps);
            expect(continues || nextSurah, isTrue, reason: 'page $p $r after $previous');
          }
          previous = (r.surah, r.to);
          total += r.length;
          expect(index.pageOf(r.surah, r.from), p);
        }
      }
      expect(total, 6236);
    });
  });

  group('Tafsir al-Muyassar parsing', () {
    Map<String, dynamic> body({int surah = 2, int ayah = 5, String edition = 'ar.muyassar'}) => {
      'code': 200,
      'data': {
        'text': '﻿نص التفسير',
        'edition': {'identifier': edition},
        'surah': {'number': surah},
        'numberInSurah': ayah,
      },
    };

    test('returns the text for the requested ayah', () {
      expect(DioTafsirRemoteDataSource.parseAyahTafsir(body(), 2, 5), 'نص التفسير');
    });

    test('rejects a different ayah or edition', () {
      expect(
        () => DioTafsirRemoteDataSource.parseAyahTafsir(body(ayah: 6), 2, 5),
        throwsFormatException,
      );
      expect(
        () => DioTafsirRemoteDataSource.parseAyahTafsir(body(edition: 'en.sahih'), 2, 5),
        throwsFormatException,
      );
      expect(() => DioTafsirRemoteDataSource.parseAyahTafsir(null, 2, 5), throwsFormatException);
    });

    test('attribution names the source', () {
      expect(TafsirSource.ayahUrl(2, 5), 'https://api.alquran.cloud/v1/ayah/2:5/ar.muyassar');
      expect(TafsirSource.nameEn, contains('King Fahd'));
      expect(TafsirSource.nameAr, contains('الميسر'));
    });
  });
}
