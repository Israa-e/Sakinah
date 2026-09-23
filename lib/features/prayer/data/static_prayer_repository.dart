import '../domain/prayer_models.dart';
import '../domain/prayer_repository.dart';

/// Fallback schedule used by [AdhanPrayerRepository] whenever a real
/// location fix (fresh or cached) isn't available — e.g. permission denied,
/// GPS unavailable, first launch offline. Times are fixed offsets from local
/// midnight, not derived from astronomical calculation, hence
/// [PrayerSchedule.isEstimated].
class StaticPrayerRepository implements PrayerRepository {
  static const _offsets = {
    PrayerName.fajr: Duration(hours: 5, minutes: 12),
    PrayerName.dhuhr: Duration(hours: 12, minutes: 18),
    PrayerName.asr: Duration(hours: 15, minutes: 45),
    PrayerName.maghrib: Duration(hours: 18, minutes: 42),
    PrayerName.isha: Duration(hours: 20, minutes: 2),
  };

  @override
  Stream<PrayerSchedule> watchTodaySchedule() async* {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    yield PrayerSchedule(
      isEstimated: true,
      times: [
        for (final entry in _offsets.entries)
          PrayerTime(name: entry.key, time: midnight.add(entry.value)),
      ],
    );
  }
}
