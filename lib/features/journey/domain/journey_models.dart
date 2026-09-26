import 'package:flutter/foundation.dart';

/// Stages of the spiritual garden illustration, in growth order.
enum GardenStage { seed, sprout, sapling, blooming, flourishing }

/// Derived, app-invented achievements shown on the Journey screen.
enum JourneyMilestone {
  firstStep,
  firstReflection,
  fivePrayersInADay,
  ayahs100,
  streak7,
  streak30,
  level5,
}

/// Everything the user did on one calendar day (local midnight key).
@immutable
class DayActivity {
  const DayActivity({
    required this.day,
    this.prayers = 0,
    this.ayahs = 0,
    this.dhikr = 0,
    this.reflections = 0,
    this.deeds = 0,
  });

  final DateTime day;

  /// Prayers marked as prayed (0–5).
  final int prayers;
  final int ayahs;

  /// Total tasbeeh count across every dhikr item.
  final int dhikr;
  final int reflections;

  /// Completed daily deeds (0 or 1 — one deed per day).
  final int deeds;

  /// A day counts toward the streak if *anything* happened.
  bool get isActive =>
      prayers > 0 || ayahs > 0 || dhikr > 0 || reflections > 0 || deeds > 0;

  int get xp => JourneyRules.xpFor(
        prayers: prayers,
        ayahs: ayahs,
        dhikr: dhikr,
        reflections: reflections,
        deeds: deeds,
      );

  DayActivity operator +(DayActivity other) => DayActivity(
        day: day,
        prayers: prayers + other.prayers,
        ayahs: ayahs + other.ayahs,
        dhikr: dhikr + other.dhikr,
        reflections: reflections + other.reflections,
        deeds: deeds + other.deeds,
      );
}

/// Totals for a window of days (the Journey screen uses the last 7).
@immutable
class ActivityTotals {
  const ActivityTotals({
    this.prayers = 0,
    this.ayahs = 0,
    this.dhikr = 0,
    this.reflections = 0,
    this.deeds = 0,
    this.activeDays = 0,
    this.prayerDays = 0,
    this.quranDays = 0,
    this.dhikrDays = 0,
    this.reflectionDays = 0,
  });

  factory ActivityTotals.of(Iterable<DayActivity> days) {
    var t = const ActivityTotals();
    for (final d in days) {
      t = ActivityTotals(
        prayers: t.prayers + d.prayers,
        ayahs: t.ayahs + d.ayahs,
        dhikr: t.dhikr + d.dhikr,
        reflections: t.reflections + d.reflections,
        deeds: t.deeds + d.deeds,
        activeDays: t.activeDays + (d.isActive ? 1 : 0),
        prayerDays: t.prayerDays + (d.prayers > 0 ? 1 : 0),
        quranDays: t.quranDays + (d.ayahs > 0 ? 1 : 0),
        dhikrDays: t.dhikrDays + (d.dhikr > 0 ? 1 : 0),
        reflectionDays: t.reflectionDays + (d.reflections > 0 ? 1 : 0),
      );
    }
    return t;
  }

  final int prayers;
  final int ayahs;
  final int dhikr;
  final int reflections;
  final int deeds;
  final int activeDays;
  final int prayerDays;
  final int quranDays;
  final int dhikrDays;
  final int reflectionDays;
}

@immutable
class JourneyStats {
  const JourneyStats({
    required this.today,
    required this.currentStreak,
    required this.bestStreak,
    required this.totalXp,
    required this.gardenStage,
    required this.daysToNextStage,
    required this.last30Days,
    required this.weekTotals,
    required this.allTime,
    required this.milestones,
  });

  final DateTime today;

  /// Consecutive active days ending today, or ending yesterday if today has
  /// no activity yet (the streak isn't "broken" until a full day passes).
  final int currentStreak;
  final int bestStreak;
  final int totalXp;
  final GardenStage gardenStage;

  /// Streak days still needed to reach the next stage; null when fully grown.
  final int? daysToNextStage;

  /// Oldest → newest, exactly 30 entries, the last one is today.
  final List<DayActivity> last30Days;

  /// Totals over [last7Days].
  final ActivityTotals weekTotals;
  final ActivityTotals allTime;
  final Set<JourneyMilestone> milestones;

  List<DayActivity> get last7Days => last30Days.sublist(last30Days.length - 7);
  DayActivity get todayActivity => last30Days.last;
  bool get isActiveToday => todayActivity.isActive;

  /// True for a brand-new user who hasn't logged anything yet.
  bool get isEmpty => allTime.activeDays == 0;

  int get level => JourneyRules.levelFor(totalXp);
  int get xpIntoLevel => totalXp % JourneyRules.xpPerLevel;
  int get xpPerLevel => JourneyRules.xpPerLevel;
  double get levelProgress => xpIntoLevel / JourneyRules.xpPerLevel;

  GardenStage? get nextStage => gardenStage == GardenStage.flourishing
      ? null
      : GardenStage.values[gardenStage.index + 1];
}

/// The app's gamification rules. These are *invented* by Sakīnah as a gentle
/// consistency mirror — they carry no religious meaning (no claim about
/// reward/ajr) and are deliberately simple:
///
/// * XP = prayers × 10 + ayahs × 1 + ⌊dhikr ÷ 10⌋ + reflections × 15 +
///   completed daily deeds × 10 (dhikr floored per day).
/// * A new level every [xpPerLevel] XP, starting at level 1.
/// * Garden stage = the higher of the stage earned by the current streak
///   ([streakThresholds]) and by level ([levelThresholds]) — so a missed day
///   never shrinks a garden that long-term effort has grown.
abstract final class JourneyRules {
  static const xpPerLevel = 250;

  /// Minimum current streak for sprout, sapling, blooming, flourishing.
  static const streakThresholds = [1, 3, 7, 21];

  /// Minimum level for sprout, sapling, blooming, flourishing.
  static const levelThresholds = [2, 4, 7, 10];

  static int xpFor({
    required int prayers,
    required int ayahs,
    required int dhikr,
    required int reflections,
    required int deeds,
  }) =>
      prayers * 10 + ayahs + dhikr ~/ 10 + reflections * 15 + deeds * 10;

  static int levelFor(int xp) => xp ~/ xpPerLevel + 1;

  static GardenStage stageFor({required int streak, required int level}) {
    var byStreak = 0;
    var byLevel = 0;
    for (var i = 0; i < streakThresholds.length; i++) {
      if (streak >= streakThresholds[i]) byStreak = i + 1;
      if (level >= levelThresholds[i]) byLevel = i + 1;
    }
    return GardenStage.values[byStreak > byLevel ? byStreak : byLevel];
  }

  /// Streak days needed before the garden reaches the stage after [stage].
  static int? daysToNextStage(GardenStage stage, int streak) {
    if (stage == GardenStage.flourishing) return null;
    final needed = streakThresholds[stage.index] - streak;
    return needed < 1 ? 1 : needed;
  }
}

/// Pure computation of [JourneyStats] from per-day activity. Kept separate
/// from Drift so it can be unit-tested and reasoned about in isolation.
JourneyStats computeJourneyStats(
  Map<DateTime, DayActivity> byDay, {
  required DateTime now,
}) {
  final today = DateTime(now.year, now.month, now.day);
  DateTime shift(int days) => DateTime(today.year, today.month, today.day + days);
  DayActivity at(DateTime d) => byDay[d] ?? DayActivity(day: d);

  // Current streak.
  var cursor = at(today).isActive ? today : shift(-1);
  var current = 0;
  while (at(cursor).isActive) {
    current++;
    cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
  }

  // Best streak across all history.
  final activeDays = byDay.values.where((d) => d.isActive).map((d) => d.day).toList()
    ..sort();
  var best = 0;
  var run = 0;
  DateTime? previous;
  for (final d in activeDays) {
    final isNext = previous != null &&
        DateTime(previous.year, previous.month, previous.day + 1) == d;
    run = isNext ? run + 1 : 1;
    if (run > best) best = run;
    previous = d;
  }
  if (current > best) best = current;

  final allTime = ActivityTotals.of(byDay.values);
  // Dhikr is floored per day (see JourneyRules), so sum per-day XP.
  final totalXp = byDay.values.fold<int>(0, (sum, d) => sum + d.xp);
  final level = JourneyRules.levelFor(totalXp);
  final stage = JourneyRules.stageFor(streak: current, level: level);

  final last30 = [for (var i = 29; i >= 0; i--) at(shift(-i))];

  final milestones = <JourneyMilestone>{
    if (allTime.activeDays > 0) JourneyMilestone.firstStep,
    if (allTime.reflections > 0) JourneyMilestone.firstReflection,
    if (byDay.values.any((d) => d.prayers >= 5)) JourneyMilestone.fivePrayersInADay,
    if (allTime.ayahs >= 100) JourneyMilestone.ayahs100,
    if (best >= 7) JourneyMilestone.streak7,
    if (best >= 30) JourneyMilestone.streak30,
    if (level >= 5) JourneyMilestone.level5,
  };

  return JourneyStats(
    today: today,
    currentStreak: current,
    bestStreak: best,
    totalXp: totalXp,
    gardenStage: stage,
    daysToNextStage: JourneyRules.daysToNextStage(stage, current),
    last30Days: last30,
    weekTotals: ActivityTotals.of(last30.sublist(23)),
    allTime: allTime,
    milestones: milestones,
  );
}
