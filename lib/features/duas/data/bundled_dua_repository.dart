import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/app_database.dart';
import '../domain/dua.dart';
import '../domain/dua_repository.dart';

part 'bundled_dua_repository.g.dart';

const duasAssetPath = 'assets/data/duas.json';

/// Catalog from the bundled `assets/data/duas.json`; saved state in Drift.
class BundledDuaRepository implements DuaRepository {
  BundledDuaRepository(this._db, {AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  final AppDatabase _db;
  final AssetBundle _bundle;
  List<Dua>? _cache;

  @override
  Future<List<Dua>> loadCatalog() async {
    final cached = _cache;
    if (cached != null) return cached;
    final raw = await _bundle.loadString(duasAssetPath);
    final catalog = parseDuaCatalog(raw);
    _cache = catalog;
    return catalog;
  }

  @override
  Stream<List<String>> watchSavedKeys() {
    final query = _db.select(_db.savedDuas)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.watch().map((rows) => [for (final r in rows) r.duaKey]);
  }

  @override
  Future<void> setSaved(String duaKey, {required bool saved}) async {
    if (saved) {
      await _db.into(_db.savedDuas).insert(
            SavedDuasCompanion.insert(duaKey: duaKey),
            mode: InsertMode.insertOrIgnore,
          );
    } else {
      await (_db.delete(_db.savedDuas)..where((t) => t.duaKey.equals(duaKey))).go();
    }
  }
}

/// Parses the catalog JSON (`{"duas": [...]}`).
List<Dua> parseDuaCatalog(String raw) {
  final json = jsonDecode(raw) as Map<String, dynamic>;
  final items = json['duas'] as List<dynamic>;
  return [for (final item in items) Dua.fromJson(item as Map<String, dynamic>)];
}

@Riverpod(keepAlive: true)
DuaRepository duaRepository(Ref ref) {
  return BundledDuaRepository(ref.watch(appDatabaseProvider));
}
