import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/adhan_prayer_repository.dart';
import '../../data/drift_prayer_log_repository.dart';
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
  const NextPrayerInfo({required this.schedule, required this.prayer, required this.remaining});

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
  return NextPrayerInfo(schedule: schedule, prayer: next, remaining: next.time.difference(now));
}

/// Prayers marked as prayed on [day] (any time within the day). UI passes
/// the displayed schedule's [PrayerSchedule.day] so the checks always match
/// the times on screen.
@riverpod
Stream<Set<PrayerName>> prayerLogsForDay(Ref ref, DateTime day) {
  return ref.watch(prayerLogRepositoryProvider).watchLoggedPrayers(day);
}

/// The slow-changing part of [nextPrayer]: which prayer is next and which
/// have passed. Recomputed every tick but — thanks to value equality — only
/// notifies watchers when the next prayer actually changes, so timelines and
/// lists don't rebuild every second (only the countdown text does).
class PrayerDayState {
  const PrayerDayState({required this.schedule, required this.next});

  final PrayerSchedule schedule;
  final PrayerTime next;

  /// True once [name]'s time has begun (every prayer after Isha, when the
  /// next prayer is tomorrow's Fajr).
  bool isPassed(PrayerName name) => schedule.timeOf(name).time.isBefore(next.time);

  bool isNext(PrayerName name) => next.name == name && next.time == schedule.timeOf(name).time;

  @override
  bool operator ==(Object other) =>
      other is PrayerDayState &&
      identical(other.schedule, schedule) &&
      other.next.name == next.name &&
      other.next.time == next.time;

  @override
  int get hashCode => Object.hash(identityHashCode(schedule), next.name, next.time);
}

@riverpod
PrayerDayState? prayerDayState(Ref ref) {
  final info = ref.watch(nextPrayerProvider);
  if (info == null) return null;
  return PrayerDayState(schedule: info.schedule, next: info.prayer);
}
