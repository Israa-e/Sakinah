import 'dhikr_item.dart';
import 'dhikr_models.dart';

/// Source of truth for the dhikr catalog and the per-day tasbeeh counts.
/// All `day` arguments are normalized internally with `AppDatabase.dayKey`.
abstract interface class DhikrRepository {
  /// Bundled, sourced catalog in display order.
  List<DhikrItem> get catalog;

  DhikrItem? itemByKey(String key);

  /// `dhikrKey -> count` for [day]; only keys with a stored row appear.
  Stream<Map<String, int>> watchCountsForDay(DateTime day);

  Future<int> countFor(String key, DateTime day);

  /// Overwrites the stored count (used by the debounced counter).
  Future<void> setCount(String key, DateTime day, int count);

  Future<void> increment(String key, DateTime day, {int by = 1});

  Future<void> reset(String key, DateTime day);

  /// One summary per calendar day in `[from, to]` (inclusive), including days
  /// without any dhikr (zero counts), oldest first.
  Stream<List<DhikrDaySummary>> watchDailySummaries({required DateTime from, required DateTime to});
}
