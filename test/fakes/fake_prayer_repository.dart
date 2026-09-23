import 'package:sakinah/features/prayer/domain/prayer_models.dart';
import 'package:sakinah/features/prayer/domain/prayer_repository.dart';

/// A fixed, deterministic schedule for widget tests — no location/plugin
/// dependencies, so tests stay fast and hermetic.
class FakePrayerRepository implements PrayerRepository {
  FakePrayerRepository({this.isEstimated = false});

  final bool isEstimated;

  @override
  Stream<PrayerSchedule> watchTodaySchedule() async* {
    final midnight = DateTime(2026, 1, 15);
    yield PrayerSchedule(
      isEstimated: isEstimated,
      times: [
        PrayerTime(name: PrayerName.fajr, time: midnight.add(const Duration(hours: 5, minutes: 12))),
        PrayerTime(name: PrayerName.dhuhr, time: midnight.add(const Duration(hours: 12, minutes: 18))),
        PrayerTime(name: PrayerName.asr, time: midnight.add(const Duration(hours: 15, minutes: 45))),
        PrayerTime(name: PrayerName.maghrib, time: midnight.add(const Duration(hours: 18, minutes: 42))),
        PrayerTime(name: PrayerName.isha, time: midnight.add(const Duration(hours: 20, minutes: 2))),
      ],
    );
  }
}
