import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/app_database.dart';
import '../domain/prayer_log_repository.dart';
import '../domain/prayer_models.dart';

part 'drift_prayer_log_repository.g.dart';

/// [PrayerLogRepository] over the Drift `PrayerLogs` table (one row per
/// day + prayer). Un-marking deletes the row rather than storing
/// `completed = false`, so "logged" always means "a row exists and is
/// completed" and the table never accumulates empty rows.
class DriftPrayerLogRepository implements PrayerLogRepository {
  DriftPrayerLogRepository(this._db);

  final AppDatabase _db;

  static PrayerName? _parse(String raw) {
    for (final name in PrayerName.values) {
      if (name.name == raw) return name;
    }
    return null;
  }

  @override
  Stream<Set<PrayerName>> watchLoggedPrayers(DateTime day) {
    final key = AppDatabase.dayKey(day);
    final query = _db.select(_db.prayerLogs)
      ..where((t) => t.day.equals(key) & t.completed.equals(true));
    return query.watch().map((rows) => {for (final row in rows) ?_parse(row.prayer)});
  }

  @override
  Stream<Map<DateTime, Set<PrayerName>>> watchLoggedPrayersBetween(DateTime from, DateTime to) {
    final start = AppDatabase.dayKey(from);
    final end = AppDatabase.dayKey(to);
    final query = _db.select(_db.prayerLogs)
      ..where(
        (t) =>
            t.day.isBiggerOrEqualValue(start) &
            t.day.isSmallerOrEqualValue(end) &
            t.completed.equals(true),
      );
    return query.watch().map((rows) {
      final result = <DateTime, Set<PrayerName>>{};
      for (final row in rows) {
        final name = _parse(row.prayer);
        if (name == null) continue;
        result.putIfAbsent(AppDatabase.dayKey(row.day), () => <PrayerName>{}).add(name);
      }
      return result;
    });
  }

  @override
  Future<void> setPrayed(DateTime day, PrayerName prayer, {required bool prayed}) async {
    final key = AppDatabase.dayKey(day);
    if (prayed) {
      await _db
          .into(_db.prayerLogs)
          .insertOnConflictUpdate(
            PrayerLogsCompanion.insert(day: key, prayer: prayer.name, completed: const Value(true)),
          );
    } else {
      await (_db.delete(
        _db.prayerLogs,
      )..where((t) => t.day.equals(key) & t.prayer.equals(prayer.name))).go();
    }
  }

  @override
  Future<bool> togglePrayed(DateTime day, PrayerName prayer) async {
    final key = AppDatabase.dayKey(day);
    final existing =
        await (_db.select(_db.prayerLogs)..where(
              (t) => t.day.equals(key) & t.prayer.equals(prayer.name) & t.completed.equals(true),
            ))
            .getSingleOrNull();
    final prayed = existing == null;
    await setPrayed(key, prayer, prayed: prayed);
    return prayed;
  }
}

@Riverpod(keepAlive: true)
PrayerLogRepository prayerLogRepository(Ref ref) {
  return DriftPrayerLogRepository(ref.watch(appDatabaseProvider));
}
