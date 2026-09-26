import 'prayer_models.dart';

/// Which of the five daily prayers the user has marked as prayed. Days are
/// always normalized to local midnight (`AppDatabase.dayKey`) by the
/// implementation, so callers may pass any time within the day.
abstract interface class PrayerLogRepository {
  /// Prayers marked as prayed on [day]; re-emits whenever a log changes.
  Stream<Set<PrayerName>> watchLoggedPrayers(DateTime day);

  /// Prayers marked as prayed for every day in `[from, to]` (inclusive, by
  /// calendar day), keyed by local midnight. Days with nothing logged are
  /// absent. Intended for streaks/Journey summaries.
  Stream<Map<DateTime, Set<PrayerName>>> watchLoggedPrayersBetween(DateTime from, DateTime to);

  Future<void> setPrayed(DateTime day, PrayerName prayer, {required bool prayed});

  /// Flips [prayer]'s logged state on [day]; returns the new state.
  Future<bool> togglePrayed(DateTime day, PrayerName prayer);
}
