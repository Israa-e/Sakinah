import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/app_database.dart';
import '../domain/dhikr_item.dart';
import '../domain/dhikr_models.dart';
import '../domain/dhikr_repository.dart';
import 'dhikr_catalog.dart';

part 'drift_dhikr_repository.g.dart';

/// [DhikrRepository] over the bundled [dhikrCatalog] and the Drift
/// `DhikrLogs` table (one row per `dhikrKey` + day).
class DriftDhikrRepository implements DhikrRepository {
  DriftDhikrRepository(this._db, {List<DhikrItem> catalog = dhikrCatalog})
    : _catalog = catalog,
      _byKey = {for (final item in catalog) item.key: item};

  final AppDatabase _db;
  final List<DhikrItem> _catalog;
  final Map<String, DhikrItem> _byKey;

  @override
  List<DhikrItem> get catalog => _catalog;

  @override
  DhikrItem? itemByKey(String key) => _byKey[key];

  SimpleSelectStatement<$DhikrLogsTable, DhikrLog> _dayQuery(DateTime day) {
    final normalized = AppDatabase.dayKey(day);
    return _db.select(_db.dhikrLogs)..where((t) => t.day.equals(normalized));
  }

  @override
  Stream<Map<String, int>> watchCountsForDay(DateTime day) {
    return _dayQuery(day).watch().map((rows) => {for (final row in rows) row.dhikrKey: row.count});
  }

  @override
  Future<int> countFor(String key, DateTime day) async {
    final row = await (_dayQuery(day)..where((t) => t.dhikrKey.equals(key))).getSingleOrNull();
    return row?.count ?? 0;
  }

  @override
  Future<void> setCount(String key, DateTime day, int count) {
    return _db
        .into(_db.dhikrLogs)
        .insertOnConflictUpdate(
          DhikrLogsCompanion.insert(
            dhikrKey: key,
            day: AppDatabase.dayKey(day),
            count: Value(count < 0 ? 0 : count),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<void> increment(String key, DateTime day, {int by = 1}) {
    return _db.transaction(() async {
      final current = await countFor(key, day);
      await setCount(key, day, current + by);
    });
  }

  @override
  Future<void> reset(String key, DateTime day) => setCount(key, day, 0);

  @override
  Stream<List<DhikrDaySummary>> watchDailySummaries({
    required DateTime from,
    required DateTime to,
  }) {
    final start = AppDatabase.dayKey(from);
    final end = AppDatabase.dayKey(to);
    final query = _db.select(_db.dhikrLogs)..where((t) => t.day.isBetweenValues(start, end));
    return query.watch().map((rows) {
      final byDay = <DateTime, Map<String, int>>{};
      for (final row in rows) {
        final day = AppDatabase.dayKey(row.day);
        (byDay[day] ??= {})[row.dhikrKey] = row.count;
      }
      final result = <DhikrDaySummary>[];
      for (var d = start; !d.isAfter(end); d = DateTime(d.year, d.month, d.day + 1)) {
        result.add(
          DhikrDaySummary.fromCounts(day: d, catalog: _catalog, counts: byDay[d] ?? const {}),
        );
      }
      return result;
    });
  }
}

@Riverpod(keepAlive: true)
DhikrRepository dhikrRepository(Ref ref) {
  return DriftDhikrRepository(ref.watch(appDatabaseProvider));
}
