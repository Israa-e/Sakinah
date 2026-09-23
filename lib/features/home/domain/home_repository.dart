import 'home_models.dart';

abstract interface class HomeRepository {
  /// `null` when the user hasn't started reading yet — Home renders the
  /// "no Quran progress" state for that, rather than faking a first entry.
  Stream<QuranProgressInfo?> watchQuranProgress();

  /// Emits today's deed, inserting one deterministically (by day-of-year)
  /// the first time it's requested for that day.
  Stream<DailyDeed> watchDailyDeed(DateTime day);

  Future<void> setDailyDeedCompleted(DateTime day, bool completed);
}
