import 'package:intl/intl.dart';

import '../../../core/location/geo_coordinates.dart';

/// Shared formatting for prayer times/countdowns (Home hero, Prayer screen).
abstract final class PrayerFormat {
  /// `HH:mm` in the given locale's digits.
  static String time(DateTime time, String languageCode) =>
      DateFormat.Hm(languageCode).format(time);

  /// Whole minutes left, rounded up so the countdown never shows `00:00`
  /// while the prayer is still ahead.
  static int minutesLeft(Duration remaining) {
    if (remaining.isNegative) return 0;
    return (remaining.inSeconds + 59) ~/ 60;
  }

  /// `HH:MM` countdown from a minute count.
  static String countdown(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}';
  }

  /// `30.0444°, 31.2357°` — signed decimal degrees, locale-neutral.
  static String coordinates(GeoCoordinates c, {int digits = 2}) =>
      '${c.latitude.toStringAsFixed(digits)}°, ${c.longitude.toStringAsFixed(digits)}°';
}
