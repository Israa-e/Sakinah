import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/static_prayer_repository.dart';
import '../../domain/prayer_models.dart';

part 'prayer_providers.g.dart';

@riverpod
Stream<PrayerSchedule> todayPrayerSchedule(Ref ref) {
  return ref.watch(prayerRepositoryProvider).watchTodaySchedule();
}

/// Ticks once a second so the countdown updates live without re-fetching the
/// schedule — only this narrow provider (and whatever `select`s just the
/// remaining-duration text) rebuilds every tick.
@riverpod
Stream<DateTime> clockTick(Ref ref) async* {
  yield DateTime.now();
  yield* Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
}

class NextPrayerInfo {
  const NextPrayerInfo({
    required this.schedule,
    required this.prayer,
    required this.remaining,
  });

  final PrayerSchedule schedule;
  final PrayerTime prayer;
  final Duration remaining;
}

/// `null` while the schedule or clock haven't produced a first value yet.
@riverpod
NextPrayerInfo? nextPrayer(Ref ref) {
  final schedule = ref.watch(todayPrayerScheduleProvider).valueOrNull;
  final now = ref.watch(clockTickProvider).valueOrNull;
  if (schedule == null || now == null) return null;

  final next = schedule.nextFrom(now);
  return NextPrayerInfo(
    schedule: schedule,
    prayer: next,
    remaining: next.time.difference(now),
  );
}
