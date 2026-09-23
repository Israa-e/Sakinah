import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/app_database.dart';
import '../domain/home_models.dart';
import '../domain/home_repository.dart';
import 'daily_deed_suggestions.dart';

part 'drift_home_repository.g.dart';

class DriftHomeRepository implements HomeRepository {
  DriftHomeRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<QuranProgressInfo?> watchQuranProgress() {
    return _db.watchLatestQuranProgress().map((row) {
      if (row == null) return null;
      return QuranProgressInfo(
        surahNumber: row.surahNumber,
        surahNameAr: row.surahNameAr,
        surahNameEn: row.surahNameEn,
        ayahNumber: row.ayahNumber,
        totalAyahs: row.totalAyahs,
      );
    });
  }

  @override
  Stream<DailyDeed> watchDailyDeed(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    return _ensureDeedExists(normalized).asStream().asyncExpand((_) {
      return _db.watchDailyDeed(normalized).map((row) {
        final suggestion = suggestionForDay(normalized);
        return DailyDeed(
          day: normalized,
          textEn: row?.deedTextEn ?? suggestion.en,
          textAr: row?.deedTextAr ?? suggestion.ar,
          completed: row?.completed ?? false,
        );
      });
    });
  }

  Future<void> _ensureDeedExists(DateTime normalizedDay) async {
    final suggestion = suggestionForDay(normalizedDay);
    await _db.upsertDailyDeed(
      DailyDeedEntriesCompanion.insert(
        day: normalizedDay,
        deedTextEn: suggestion.en,
        deedTextAr: suggestion.ar,
      ),
    );
  }

  @override
  Future<void> setDailyDeedCompleted(DateTime day, bool completed) {
    final normalized = DateTime(day.year, day.month, day.day);
    return _db.setDailyDeedCompleted(normalized, completed);
  }
}

@Riverpod(keepAlive: true)
HomeRepository homeRepository(Ref ref) {
  return DriftHomeRepository(ref.watch(appDatabaseProvider));
}
