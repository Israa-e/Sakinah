import '../../../core/location/geo_coordinates.dart';

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
  const PrayerSchedule({
    required this.times,
    required this.isEstimated,
    this.sunrise,
    this.location,
  });

  final List<PrayerTime> times;
  final bool isEstimated;

  /// Shuruq — informational only (not a prayer, never logged or notified).
  final DateTime? sunrise;

  /// The coordinates this schedule was calculated for; `null` for the
  /// estimated fallback schedule.
  final GeoCoordinates? location;

  /// The calendar day (local midnight) this schedule belongs to.
  DateTime get day {
    final first = times.first.time;
    return DateTime(first.year, first.month, first.day);
  }

  PrayerTime timeOf(PrayerName name) => times.firstWhere((t) => t.name == name);

  /// The next prayer relative to [now], wrapping to tomorrow's Fajr
  /// (approximated as +24h on today's Fajr) once Isha has passed.
  PrayerTime nextFrom(DateTime now) {
    for (final t in times) {
      if (t.time.isAfter(now)) return t;
    }
    final fajr = times.first;
    return PrayerTime(name: fajr.name, time: fajr.time.add(const Duration(days: 1)));
  }

  /// Whether [name]'s time has already begun at [now] (and so can be logged).
  bool hasBegun(PrayerName name, DateTime now) => !timeOf(name).time.isAfter(now);

  /// The Islamic night runs from Maghrib to the following Fajr (approximated
  /// as today's Fajr + 24h). Its midpoint and the start of its last third are
  /// the standard derivations — no separate astronomical calculation needed.
  Duration get _night {
    final maghrib = timeOf(PrayerName.maghrib).time;
    final nextFajr = timeOf(PrayerName.fajr).time.add(const Duration(days: 1));
    return nextFajr.difference(maghrib);
  }

  DateTime get midnight => timeOf(PrayerName.maghrib).time.add(_night ~/ 2);

  DateTime get lastThird => timeOf(PrayerName.maghrib).time.add((_night * 2) ~/ 3);
}
