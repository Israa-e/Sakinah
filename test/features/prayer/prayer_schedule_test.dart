import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/features/prayer/domain/prayer_models.dart';

void main() {
  group('PrayerSchedule.nextFrom', () {
    final today = DateTime(2026, 1, 15);
    final schedule = PrayerSchedule(
      isEstimated: false,
      times: [
        PrayerTime(name: PrayerName.fajr, time: today.add(const Duration(hours: 5, minutes: 12))),
        PrayerTime(name: PrayerName.dhuhr, time: today.add(const Duration(hours: 12, minutes: 18))),
        PrayerTime(name: PrayerName.asr, time: today.add(const Duration(hours: 15, minutes: 45))),
        PrayerTime(name: PrayerName.maghrib, time: today.add(const Duration(hours: 18, minutes: 42))),
        PrayerTime(name: PrayerName.isha, time: today.add(const Duration(hours: 20, minutes: 2))),
      ],
    );

    test('returns the next prayer later the same day', () {
      final now = today.add(const Duration(hours: 13));
      expect(schedule.nextFrom(now).name, PrayerName.asr);
    });

    test('returns the very next prayer right after one begins', () {
      final now = today.add(const Duration(hours: 5, minutes: 13));
      expect(schedule.nextFrom(now).name, PrayerName.dhuhr);
    });

    test('wraps to tomorrow\'s Fajr once Isha has passed', () {
      final now = today.add(const Duration(hours: 23));
      final next = schedule.nextFrom(now);
      expect(next.name, PrayerName.fajr);
      expect(next.time.isAfter(now), isTrue);
      expect(next.time.difference(now), lessThan(const Duration(hours: 7)));
    });

    test('a prayer exactly at `now` is not treated as next (already begun)', () {
      final fajrTime = today.add(const Duration(hours: 5, minutes: 12));
      expect(schedule.nextFrom(fajrTime).name, PrayerName.dhuhr);
    });
  });
}
