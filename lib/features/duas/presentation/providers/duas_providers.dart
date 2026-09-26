import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/bundled_dua_repository.dart';
import '../../domain/dua.dart';

part 'duas_providers.g.dart';

/// The full bundled du'a catalog (loaded once per session).
@Riverpod(keepAlive: true)
Future<List<Dua>> duaCatalog(Ref ref) {
  return ref.watch(duaRepositoryProvider).loadCatalog();
}

/// One du'a by its stable key, or `null` if the key isn't in the catalog.
@riverpod
Future<Dua?> duaByKey(Ref ref, String duaKey) async {
  final catalog = await ref.watch(duaCatalogProvider.future);
  for (final dua in catalog) {
    if (dua.key == duaKey) return dua;
  }
  return null;
}

/// Keys of the user's saved du'as (newest first), backed by Drift.
@Riverpod(keepAlive: true)
class SavedDuaKeys extends _$SavedDuaKeys {
  @override
  Stream<List<String>> build() => ref.watch(duaRepositoryProvider).watchSavedKeys();

  Future<void> setSaved(String duaKey, {required bool saved}) {
    return ref.read(duaRepositoryProvider).setSaved(duaKey, saved: saved);
  }

  Future<void> toggle(String duaKey) {
    final saved = state.valueOrNull?.contains(duaKey) ?? false;
    return setSaved(duaKey, saved: !saved);
  }
}

@riverpod
bool isDuaSaved(Ref ref, String duaKey) {
  return ref.watch(savedDuaKeysProvider.select((v) => v.valueOrNull?.contains(duaKey) ?? false));
}

/// Saved du'as resolved against the catalog, newest saved first.
@riverpod
Future<List<Dua>> savedDuas(Ref ref) async {
  final catalog = await ref.watch(duaCatalogProvider.future);
  final keys = await ref.watch(savedDuaKeysProvider.future);
  final byKey = {for (final d in catalog) d.key: d};
  return [
    for (final k in keys)
      if (byKey[k] != null) byKey[k]!,
  ];
}

/// A different du'a each calendar day, stable within the day.
@riverpod
Future<Dua?> featuredDua(Ref ref) async {
  final catalog = await ref.watch(duaCatalogProvider.future);
  if (catalog.isEmpty) return null;
  final now = DateTime.now();
  final dayOfYear = now.difference(DateTime(now.year)).inDays;
  return catalog[dayOfYear % catalog.length];
}

class DuaLibraryFilterState {
  const DuaLibraryFilterState({this.query = '', this.category, this.savedOnly = false});

  final String query;

  /// `null` = all categories.
  final DuaCategory? category;
  final bool savedOnly;

  bool get isFiltering => query.trim().isNotEmpty || category != null || savedOnly;

  DuaLibraryFilterState copyWith({
    String? query,
    DuaCategory? Function()? category,
    bool? savedOnly,
  }) {
    return DuaLibraryFilterState(
      query: query ?? this.query,
      category: category != null ? category() : this.category,
      savedOnly: savedOnly ?? this.savedOnly,
    );
  }
}

/// Library search / category / saved-only filter (screen-local UI state).
@riverpod
class DuaLibraryFilter extends _$DuaLibraryFilter {
  @override
  DuaLibraryFilterState build() => const DuaLibraryFilterState();

  void setQuery(String query) => state = state.copyWith(query: query);

  void setCategory(DuaCategory? category) => state = state.copyWith(category: () => category);

  void setSavedOnly({required bool savedOnly}) => state = state.copyWith(savedOnly: savedOnly);

  void toggleSavedOnly() => setSavedOnly(savedOnly: !state.savedOnly);
}

/// Catalog after applying [DuaLibraryFilter].
@riverpod
Future<List<Dua>> filteredDuas(Ref ref) async {
  final filter = ref.watch(duaLibraryFilterProvider);
  final catalog = await ref.watch(duaCatalogProvider.future);
  final saved = filter.savedOnly
      ? (await ref.watch(savedDuaKeysProvider.future)).toSet()
      : const <String>{};
  return filterDuas(catalog, filter, savedKeys: saved);
}

/// Pure filtering logic (exposed for tests).
List<Dua> filterDuas(
  List<Dua> catalog,
  DuaLibraryFilterState filter, {
  Set<String> savedKeys = const {},
}) {
  final needle = normalizeForSearch(filter.query);
  return [
    for (final dua in catalog)
      if ((filter.category == null || dua.category == filter.category) &&
          (!filter.savedOnly || savedKeys.contains(dua.key)) &&
          (needle.isEmpty || _haystack(dua).contains(needle)))
        dua,
  ];
}

String _haystack(Dua d) => normalizeForSearch(
      [
        d.titleEn,
        d.titleAr,
        d.translation,
        d.arabic,
        d.reference,
        d.category.name,
        d.surahNameEn ?? '',
        d.surahNameAr ?? '',
      ].join(' '),
    );

final _arabicMarks = RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED\u0640]', unicode: true);
final _alifForms = RegExp(r'[\u0622\u0623\u0625\u0671]', unicode: true);

/// Lower-cases and strips Arabic diacritics/tatweel and unifies alif forms so
/// "رب" matches "رَبِّ" and "اتنا" matches "ءَاتِنَا"-style spellings loosely.
String normalizeForSearch(String input) => input
    .toLowerCase()
    .replaceAll(_arabicMarks, '')
    .replaceAll(_alifForms, '\u0627')
    .replaceAll('\u0649', '\u064A')
    .trim();
