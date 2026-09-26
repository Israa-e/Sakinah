import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

/// Continue-reading progress for the Quran feature (full schema — surahs,
/// ayahs, bookmarks, memorization — arrives with the Quran phase). Kept here
/// now because the Home screen's "Your Quran" card needs a real, reactive,
/// offline-first source rather than an in-memory placeholder.
class QuranProgressEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  TextColumn get surahNameAr => text()();
  TextColumn get surahNameEn => text()();
  IntColumn get ayahNumber => integer()();
  IntColumn get totalAyahs => integer()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// One row per calendar day for the Home screen's "Daily Deed" card.
class DailyDeedEntries extends Table {
  DateTimeColumn get day => dateTime()();
  TextColumn get deedTextEn => text()();
  TextColumn get deedTextAr => text()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {day};
}

/// Offline cache of Quran text fetched from api.alquran.cloud. Every row
/// carries its translator so unattributed translation text can't exist.
class CachedAyahs extends Table {
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();

  /// Global ayah number (1–6236) — used for per-ayah recitation audio URLs.
  IntColumn get globalNumber => integer()();
  IntColumn get juz => integer()();
  TextColumn get textAr => text()();
  TextColumn get translationEn => text()();
  TextColumn get translatorName => text()();

  @override
  Set<Column> get primaryKey => {surahNumber, ayahNumber};
}

class AyahBookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {surahNumber, ayahNumber},
      ];
}

/// Personal reflections — optionally tied to an ayah (null = general).
class Reflections extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer().nullable()();
  IntColumn get ayahNumber => integer().nullable()();
  TextColumn get body => text()();
  TextColumn get mood => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Daily tasbeeh totals per dhikr item. [dhikrKey] is the stable id of a
/// bundled, sourced dhikr item (see features/dhikr/data).
class DhikrLogs extends Table {
  TextColumn get dhikrKey => text()();
  DateTimeColumn get day => dateTime()();
  IntColumn get count => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {dhikrKey, day};
}

/// Du'as the user saved. [duaKey] is the stable id of a bundled, sourced du'a.
class SavedDuas extends Table {
  TextColumn get duaKey => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {duaKey};
}

/// Which of the five daily prayers the user marked as prayed.
class PrayerLogs extends Table {
  DateTimeColumn get day => dateTime()();

  /// `PrayerName.name` (fajr, dhuhr, asr, maghrib, isha).
  TextColumn get prayer => text()();
  BoolColumn get completed => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {day, prayer};
}

/// Ayahs read per day — feeds the Journey streak/garden.
class ReadingLogs extends Table {
  DateTimeColumn get day => dateTime()();
  IntColumn get ayahsRead => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {day};
}

@DriftDatabase(
  tables: [
    QuranProgressEntries,
    DailyDeedEntries,
    CachedAyahs,
    AyahBookmarks,
    Reflections,
    DhikrLogs,
    SavedDuas,
    PrayerLogs,
    ReadingLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(cachedAyahs);
            await m.createTable(ayahBookmarks);
            await m.createTable(reflections);
            await m.createTable(dhikrLogs);
            await m.createTable(savedDuas);
            await m.createTable(prayerLogs);
            await m.createTable(readingLogs);
          }
        },
      );

  /// Calendar-day key used by every per-day table (local midnight).
  static DateTime dayKey(DateTime d) => DateTime(d.year, d.month, d.day);

  Stream<QuranProgressEntry?> watchLatestQuranProgress() {
    final query = select(quranProgressEntries)
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
      ..limit(1);
    return query.watchSingleOrNull();
  }

  Future<void> upsertQuranProgress(QuranProgressEntriesCompanion entry) async {
    final existing = await (select(quranProgressEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
          ..limit(1))
        .getSingleOrNull();
    if (existing == null) {
      await into(quranProgressEntries).insert(entry);
    } else {
      await (update(quranProgressEntries)..where((t) => t.id.equals(existing.id)))
          .write(entry);
    }
  }

  Stream<DailyDeedEntry?> watchDailyDeed(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    return (select(dailyDeedEntries)..where((t) => t.day.equals(normalized)))
        .watchSingleOrNull();
  }

  Future<void> upsertDailyDeed(DailyDeedEntriesCompanion entry) {
    return into(dailyDeedEntries).insertOnConflictUpdate(entry);
  }

  Future<void> setDailyDeedCompleted(DateTime day, bool completed) {
    final normalized = DateTime(day.year, day.month, day.day);
    return (update(dailyDeedEntries)..where((t) => t.day.equals(normalized)))
        .write(DailyDeedEntriesCompanion(completed: Value(completed)));
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sakinah.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
