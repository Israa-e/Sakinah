import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/app_database.dart';
import '../domain/journey_models.dart';
import '../domain/journey_repository.dart';

part 'drift_journey_repository.g.dart';

/// Computes [JourneyStats] from the per-day activity tables other features
/// write to. Rows are small (≈ one per day per item), so everything is
/// aggregated in Dart and recomputed whenever any of those tables changes.
class DriftJourneyRepository implements JourneyRepository {
  DriftJourneyRepository(this._db, {DateTime Function()? clock})
      : _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _clock;

  @override
  Stream<JourneyStats> watchStats() {
    // A trivial query that "reads from" every activity table: Drift re-runs
    // it (and so re-emits) on any write to those tables, and emits once
    // immediately on listen.
    return _db
        .customSelect(
          'SELECT 1',
          readsFrom: {
            _db.prayerLogs,
            _db.readingLogs,
            _db.dhikrLogs,
            _db.reflections,
            _db.dailyDeedEntries,
          },
        )
        .watch()
        .asyncMap((_) => loadStats());
  }

  /// One-shot computation (also used by tests).
  Future<JourneyStats> loadStats() async {
    final byDay = <DateTime, DayActivity>{};
    void add(DateTime rawDay, DayActivity Function(DateTime day) build) {
      final day = AppDatabase.dayKey(rawDay);
      final entry = build(day);
      byDay[day] = (byDay[day] ?? DayActivity(day: day)) + entry;
    }

    final prayers = await (_db.select(_db.prayerLogs)
          ..where((t) => t.completed.equals(true)))
        .get();
    for (final r in prayers) {
      add(r.day, (d) => DayActivity(day: d, prayers: 1));
    }

    for (final r in await _db.select(_db.readingLogs).get()) {
      if (r.ayahsRead > 0) add(r.day, (d) => DayActivity(day: d, ayahs: r.ayahsRead));
    }

    for (final r in await _db.select(_db.dhikrLogs).get()) {
      if (r.count > 0) add(r.day, (d) => DayActivity(day: d, dhikr: r.count));
    }

    for (final r in await _db.select(_db.reflections).get()) {
      add(r.createdAt, (d) => DayActivity(day: d, reflections: 1));
    }

    final deeds = await (_db.select(_db.dailyDeedEntries)
          ..where((t) => t.completed.equals(true)))
        .get();
    for (final r in deeds) {
      add(r.day, (d) => DayActivity(day: d, deeds: 1));
    }

    return computeJourneyStats(byDay, now: _clock());
  }
}

@Riverpod(keepAlive: true)
JourneyRepository journeyRepository(Ref ref) {
  return DriftJourneyRepository(ref.watch(appDatabaseProvider));
}
