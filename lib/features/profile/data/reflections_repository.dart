import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/app_database.dart';

part 'reflections_repository.g.dart';

/// Read/delete access to the user's saved reflections (written by the Quran
/// reader). Newest first.
class ReflectionsRepository {
  ReflectionsRepository(this._db);

  final AppDatabase _db;

  Stream<List<Reflection>> watchAll() {
    final query = _db.select(_db.reflections)
      ..orderBy([(r) => OrderingTerm.desc(r.createdAt), (r) => OrderingTerm.desc(r.id)]);
    return query.watch();
  }

  Future<void> delete(int id) => (_db.delete(_db.reflections)..where((r) => r.id.equals(id))).go();
}

@Riverpod(keepAlive: true)
ReflectionsRepository reflectionsRepository(Ref ref) =>
    ReflectionsRepository(ref.watch(appDatabaseProvider));

@riverpod
Stream<List<Reflection>> reflectionsList(Ref ref) =>
    ref.watch(reflectionsRepositoryProvider).watchAll();
