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

@DriftDatabase(tables: [QuranProgressEntries, DailyDeedEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

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
