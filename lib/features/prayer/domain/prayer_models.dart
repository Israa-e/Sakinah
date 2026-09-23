enum PrayerName { fajr, dhuhr, asr, maghrib, isha }

class PrayerTime {
  const PrayerTime({required this.name, required this.time});

  final PrayerName name;
  final DateTime time;
}

/// A day's five prayer times. [isEstimated] is true while this is backed by
/// [StaticPrayerRepository] rather than a real location + calculation-method
/// derived schedule (see Phase 3 in the project spec).
class PrayerSchedule {
  const PrayerSchedule({required this.times, required this.isEstimated});

  final List<PrayerTime> times;
  final bool isEstimated;

  /// The next prayer relative to [now], wrapping to tomorrow's Fajr
  /// (approximated as +24h on today's Fajr) once Isha has passed.
  PrayerTime nextFrom(DateTime now) {
    for (final t in times) {
      if (t.time.isAfter(now)) return t;
    }
    final fajr = times.first;
    return PrayerTime(name: fajr.name, time: fajr.time.add(const Duration(days: 1)));
  }
}
