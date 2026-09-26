import 'package:sakinah/core/location/geo_coordinates.dart';
import 'package:sakinah/features/prayer/domain/prayer_models.dart';
import 'package:sakinah/features/prayer/domain/prayer_repository.dart';

/// The fixed day every [FakePrayerRepository] schedule belongs to. Tests that
/// depend on "now" override `clockTickProvider` with a time on this day.
final fakePrayerDay = DateTime(2026, 1, 15);

/// A fixed, deterministic schedule for widget tests — no location/plugin
/// dependencies, so tests stay fast and hermetic.
class FakePrayerRepository implements PrayerRepository {
  FakePrayerRepository({this.isEstimated = false, this.location, this.withSunrise = false});

  final bool isEstimated;
  final GeoCoordinates? location;
  final bool withSunrise;

  @override
  Stream<PrayerSchedule> watchTodaySchedule() async* {
    final midnight = fakePrayerDay;
    yield PrayerSchedule(
      isEstimated: isEstimated,
      location: location,
      sunrise: withSunrise ? midnight.add(const Duration(hours: 6, minutes: 40)) : null,
      times: [
        PrayerTime(
          name: PrayerName.fajr,
          time: midnight.add(const Duration(hours: 5, minutes: 12)),
        ),
        PrayerTime(
          name: PrayerName.dhuhr,
          time: midnight.add(const Duration(hours: 12, minutes: 18)),
        ),
        PrayerTime(
          name: PrayerName.asr,
          time: midnight.add(const Duration(hours: 15, minutes: 45)),
        ),
        PrayerTime(
          name: PrayerName.maghrib,
          time: midnight.add(const Duration(hours: 18, minutes: 42)),
        ),
        PrayerTime(
          name: PrayerName.isha,
          time: midnight.add(const Duration(hours: 20, minutes: 2)),
        ),
      ],
    );
  }
}
