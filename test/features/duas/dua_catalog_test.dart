import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/features/duas/data/bundled_dua_repository.dart';
import 'package:sakinah/features/duas/domain/dua.dart';
import 'package:sakinah/features/duas/presentation/providers/duas_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late List<Dua> catalog;

  setUpAll(() async {
    catalog = parseDuaCatalog(await rootBundle.loadString(duasAssetPath));
  });

  test('catalog is non-empty and keys are unique', () {
    expect(catalog, isNotEmpty);
    expect(catalog.map((d) => d.key).toSet().length, catalog.length);
  });

  test('every entry has text, translation, translator, reference and source', () {
    for (final d in catalog) {
      expect(d.arabic.trim(), isNotEmpty, reason: d.key);
      expect(d.translation.trim(), isNotEmpty, reason: d.key);
      expect(d.titleEn.trim(), isNotEmpty, reason: d.key);
      expect(d.titleAr.trim(), isNotEmpty, reason: d.key);
      expect(d.translator.trim(), isNotEmpty, reason: d.key);
      expect(d.reference.trim(), isNotEmpty, reason: d.key);
      expect(d.sourceUrl, startsWith('https://'), reason: d.key);
    }
  });

  test('Quranic entries are consistent with their reference and source URL', () {
    for (final d in catalog.where((d) => d.isQuranic)) {
      expect(d.reference, 'Quran ${d.surah}:${d.ayah}', reason: d.key);
      expect(d.translator, 'Sahih International', reason: d.key);
      expect(
        d.sourceUrl,
        'https://api.alquran.cloud/v1/ayah/${d.surah}:${d.ayah}/editions/quran-uthmani,en.sahih',
        reason: d.key,
      );
    }
  });

  test('every category has at least one du\'a', () {
    for (final c in DuaCategory.values) {
      expect(catalog.any((d) => d.category == c), isTrue, reason: c.name);
    }
  });

  group('filterDuas', () {
    test('filters by category', () {
      final family = filterDuas(
        catalog,
        const DuaLibraryFilterState(category: DuaCategory.family),
      );
      expect(family, isNotEmpty);
      expect(family.every((d) => d.category == DuaCategory.family), isTrue);
    });

    test('searches English titles/translations case-insensitively', () {
      final results = filterDuas(catalog, const DuaLibraryFilterState(query: 'KNOWLEDGE'));
      expect(results.map((d) => d.key), contains('increase-knowledge'));
    });

    test('searches Arabic ignoring diacritics', () {
      final results = filterDuas(catalog, const DuaLibraryFilterState(query: 'علما'));
      expect(results.map((d) => d.key), contains('increase-knowledge'));
    });

    test('search + category combine, and saved-only restricts to saved keys', () {
      expect(
        filterDuas(
          catalog,
          const DuaLibraryFilterState(query: 'knowledge', category: DuaCategory.family),
        ),
        isEmpty,
      );
      final saved = filterDuas(
        catalog,
        const DuaLibraryFilterState(savedOnly: true),
        savedKeys: {'yunus-dhun-nun'},
      );
      expect(saved.map((d) => d.key), ['yunus-dhun-nun']);
    });
  });
}
