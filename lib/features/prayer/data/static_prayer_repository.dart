import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/prayer_models.dart';
import '../domain/prayer_repository.dart';

part 'static_prayer_repository.g.dart';

/// Placeholder schedule so the Home prayer card has something real to render
/// before Phase 3 wires up location + calculation-method-based calculation.
/// Times are fixed offsets from local midnight — not derived from Adhan
/// astronomical calculation, hence [PrayerSchedule.isEstimated].
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

@Riverpod(keepAlive: true)
PrayerRepository prayerRepository(Ref ref) => StaticPrayerRepository();
