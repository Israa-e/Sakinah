import 'dart:async';

import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/features/dhikr/data/dhikr_catalog.dart';
import 'package:sakinah/features/dhikr/domain/dhikr_item.dart';
import 'package:sakinah/features/dhikr/domain/dhikr_models.dart';
import 'package:sakinah/features/dhikr/domain/dhikr_repository.dart';

/// In-memory [DhikrRepository] for widget tests (no Drift timers).
class FakeDhikrRepository implements DhikrRepository {
  FakeDhikrRepository({Map<String, int>? todayCounts, DateTime? today})
    : _today = AppDatabase.dayKey(today ?? DateTime.now()) {
    _counts[_today] = {...?todayCounts};
  }

  final DateTime _today;
  final Map<DateTime, Map<String, int>> _counts = {};
  final _changes = StreamController<void>.broadcast();

  Map<String, int> countsFor(DateTime day) => _counts[AppDatabase.dayKey(day)] ?? const {};

  @override
  List<DhikrItem> get catalog => dhikrCatalog;

  @override
  DhikrItem? itemByKey(String key) {
    for (final item in dhikrCatalog) {
      if (item.key == key) return item;
    }
    return null;
  }

  @override
  Stream<Map<String, int>> watchCountsForDay(DateTime day) async* {
    yield Map.of(countsFor(day));
    await for (final _ in _changes.stream) {
      yield Map.of(countsFor(day));
    }
  }

  @override
  Future<int> countFor(String key, DateTime day) async => countsFor(day)[key] ?? 0;

  @override
  Future<void> setCount(String key, DateTime day, int count) async {
    (_counts[AppDatabase.dayKey(day)] ??= {})[key] = count;
    _changes.add(null);
  }

  @override
  Future<void> increment(String key, DateTime day, {int by = 1}) async =>
      setCount(key, day, (countsFor(day)[key] ?? 0) + by);

  @override
  Future<void> reset(String key, DateTime day) => setCount(key, day, 0);

  @override
  Stream<List<DhikrDaySummary>> watchDailySummaries({
    required DateTime from,
    required DateTime to,
  }) async* {
    List<DhikrDaySummary> build() {
      final result = <DhikrDaySummary>[];
      final end = AppDatabase.dayKey(to);
      for (
        var d = AppDatabase.dayKey(from);
        !d.isAfter(end);
        d = DateTime(d.year, d.month, d.day + 1)
      ) {
        result.add(DhikrDaySummary.fromCounts(day: d, catalog: catalog, counts: countsFor(d)));
      }
      return result;
    }

    yield build();
    await for (final _ in _changes.stream) {
      yield build();
    }
  }

  DateTime get today => _today;
}
