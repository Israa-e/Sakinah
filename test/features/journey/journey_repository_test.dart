import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/features/journey/data/drift_journey_repository.dart';
import 'package:sakinah/features/journey/domain/journey_models.dart';

import '../../fakes/test_database.dart';

void main() {
  late AppDatabase db;
  late DriftJourneyRepository repo;
  final now = DateTime(2026, 9, 24, 12);
  DateTime day(int d) => DateTime(2026, 9, d);

  setUp(() {
    db = openTestDatabase();
    repo = DriftJourneyRepository(db, clock: () => now);
  });

  tearDown(() => db.close());

  Future<void> prayer(DateTime d, String name) => db
      .into(db.prayerLogs)
      .insert(PrayerLogsCompanion.insert(day: d, prayer: name));

  Future<void> read(DateTime d, int ayahs) => db
      .into(db.readingLogs)
      .insert(ReadingLogsCompanion.insert(day: d, ayahsRead: Value(ayahs)));

  test('brand-new user has an empty, seed-stage journey', () async {
    final s = await repo.loadStats();
    expect(s.isEmpty, isTrue);
    expect(s.currentStreak, 0);
    expect(s.bestStreak, 0);
    expect(s.totalXp, 0);
    expect(s.level, 1);
    expect(s.gardenStage, GardenStage.seed);
    expect(s.daysToNextStage, 1);
    expect(s.last30Days, hasLength(30));
    expect(s.last30Days.last.day, day(24));
    expect(s.milestones, isEmpty);
  });

  test('streak restarts after a gap; best streak is remembered', () async {
    for (var d = 10; d <= 14; d++) {
      await read(day(d), 3);
    }
    for (var d = 22; d <= 24; d++) {
      await prayer(day(d), 'fajr');
    }
    final s = await repo.loadStats();
    expect(s.currentStreak, 3);
    expect(s.bestStreak, 5);
    expect(s.isActiveToday, isTrue);
    expect(s.weekTotals.activeDays, 3);
    expect(s.weekTotals.prayerDays, 3);
    expect(s.weekTotals.quranDays, 0);
  });

  test('streak still counts when today is empty but yesterday was active', () async {
    for (var d = 21; d <= 23; d++) {
      await db.into(db.dhikrLogs).insert(
            DhikrLogsCompanion.insert(dhikrKey: 'tasbih', day: day(d), count: const Value(33)),
          );
    }
    final s = await repo.loadStats();
    expect(s.currentStreak, 3);
    expect(s.isActiveToday, isFalse);
  });

  test('streak is zero once a whole day has been missed', () async {
    await read(day(22), 5);
    final s = await repo.loadStats();
    expect(s.currentStreak, 0);
    expect(s.bestStreak, 1);
  });

  test('xp, level, garden stage and milestones follow JourneyRules', () async {
    // Yesterday: 5 prayers (50) + 120 ayahs (120) + 105 dhikr (10)
    //            + 1 reflection (15) + 1 completed deed (10) = 205 XP.
    for (final p in ['fajr', 'dhuhr', 'asr', 'maghrib', 'isha']) {
      await prayer(day(23), p);
    }
    await read(day(23), 120);
    await db.into(db.dhikrLogs).insert(
          DhikrLogsCompanion.insert(dhikrKey: 'a', day: day(23), count: const Value(105)),
        );
    await db.into(db.reflections).insert(
          ReflectionsCompanion.insert(body: 'x', createdAt: Value(DateTime(2026, 9, 23, 21, 40))),
        );
    await db.into(db.dailyDeedEntries).insert(
          DailyDeedEntriesCompanion.insert(
            day: day(23),
            deedTextEn: 'e',
            deedTextAr: 'a',
            completed: const Value(true),
          ),
        );
    // An uncompleted deed and an unticked prayer don't count.
    await db.into(db.dailyDeedEntries).insert(
          DailyDeedEntriesCompanion.insert(day: day(24), deedTextEn: 'e', deedTextAr: 'a'),
        );
    await db.into(db.prayerLogs).insert(
          PrayerLogsCompanion.insert(day: day(24), prayer: 'fajr', completed: const Value(false)),
        );

    var s = await repo.loadStats();
    expect(s.totalXp, 205);
    expect(s.level, 1);
    expect(s.xpIntoLevel, 205);
    expect(s.isActiveToday, isFalse);
    expect(s.currentStreak, 1);
    expect(s.gardenStage, GardenStage.sprout);
    expect(s.daysToNextStage, 2);
    expect(s.milestones, {
      JourneyMilestone.firstStep,
      JourneyMilestone.firstReflection,
      JourneyMilestone.fivePrayersInADay,
      JourneyMilestone.ayahs100,
    });

    // Today: 5 more prayers → 255 XP → level 2, 5 XP into it.
    for (final p in ['dhuhr', 'asr', 'maghrib', 'isha']) {
      await prayer(day(24), p);
    }
    await (db.update(db.prayerLogs)..where((t) => t.day.equals(day(24)) & t.prayer.equals('fajr')))
        .write(const PrayerLogsCompanion(completed: Value(true)));
    s = await repo.loadStats();
    expect(s.totalXp, 255);
    expect(s.level, 2);
    expect(s.xpIntoLevel, 5);
    expect(s.currentStreak, 2);
    expect(s.todayActivity.prayers, 5);
  });

  test('watchStats re-emits when an activity table changes', () async {
    final streaks = <int>[];
    final sub = repo.watchStats().listen((s) => streaks.add(s.currentStreak));
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await read(day(24), 2);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await sub.cancel();
    expect(streaks, [0, 1]);
  });

  group('JourneyRules', () {
    test('xp formula floors dhikr', () {
      expect(
        JourneyRules.xpFor(prayers: 1, ayahs: 2, dhikr: 19, reflections: 1, deeds: 1),
        10 + 2 + 1 + 15 + 10,
      );
    });

    test('garden stage takes the higher of streak and level', () {
      expect(JourneyRules.stageFor(streak: 0, level: 1), GardenStage.seed);
      expect(JourneyRules.stageFor(streak: 7, level: 1), GardenStage.blooming);
      expect(JourneyRules.stageFor(streak: 0, level: 10), GardenStage.flourishing);
      expect(JourneyRules.stageFor(streak: 3, level: 2), GardenStage.sapling);
      expect(JourneyRules.daysToNextStage(GardenStage.flourishing, 40), isNull);
    });
  });
}
