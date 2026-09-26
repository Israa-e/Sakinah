import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/result.dart';
import '../../../core/logging/app_logger.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_info.dart';
import '../../../core/storage/app_database.dart';
import '../domain/quran_models.dart';
import '../domain/quran_repository.dart';
import 'quran_remote_data_source.dart';

part 'drift_quran_repository.g.dart';

const surahsAssetPath = 'assets/data/surahs.json';

/// Offline-first [QuranRepository]: surah metadata from the bundled asset,
/// ayah text from the Drift cache (filled from api.alquran.cloud on a miss).
class DriftQuranRepository implements QuranRepository {
  DriftQuranRepository({
    required this._db,
    required this._remote,
    required this._networkInfo,
    Future<String> Function()? loadSurahsJson,
    DateTime Function()? clock,
  }) : _loadSurahsJson = loadSurahsJson ?? (() => rootBundle.loadString(surahsAssetPath)),
       _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final QuranRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final Future<String> Function() _loadSurahsJson;
  final DateTime Function() _clock;
  final _log = AppLogger.of('QuranRepository');

  List<Surah>? _surahs;

  @override
  Future<List<Surah>> getSurahs() async {
    final cached = _surahs;
    if (cached != null) return cached;
    final json = jsonDecode(await _loadSurahsJson()) as Map<String, dynamic>;
    final list = (json['surahs'] as List).cast<Map<String, dynamic>>();
    return _surahs = [
      for (final s in list)
        Surah(
          number: s['number'] as int,
          nameAr: s['nameAr'] as String,
          nameEn: s['nameEn'] as String,
          meaningEn: s['meaningEn'] as String,
          ayahCount: s['ayahCount'] as int,
          revelationType: s['revelationType'] == 'Medinan'
              ? RevelationType.medinan
              : RevelationType.meccan,
        ),
    ];
  }

  @override
  Future<Result<List<Ayah>>> getSurahAyahs(int surahNumber) async {
    try {
      final surahs = await getSurahs();
      final surah = surahs.where((s) => s.number == surahNumber).firstOrNull;
      if (surah == null) {
        return Failure(ValidationFailure(debugMessage: 'No surah $surahNumber'));
      }

      final cached = await _readCache(surahNumber);
      if (cached.length == surah.ayahCount) return Success(cached);

      if (!await _networkInfo.isConnected) {
        return const Failure(NetworkFailure(debugMessage: 'Offline and not cached'));
      }

      final result = await _remote.fetchSurah(surahNumber);
      if (result case Success(:final data)) {
        if (data.length != surah.ayahCount) {
          return Failure(
            ServerFailure(debugMessage: 'Expected ${surah.ayahCount} ayahs, got ${data.length}'),
          );
        }
        await _writeCache(data);
      }
      return result;
    } on Object catch (e, st) {
      _log.warning('getSurahAyahs($surahNumber) failed', e, st);
      return Failure(CacheFailure(debugMessage: e.toString()));
    }
  }

  Future<List<Ayah>> _readCache(int surahNumber) async {
    final rows =
        await (_db.select(_db.cachedAyahs)
              ..where((t) => t.surahNumber.equals(surahNumber))
              ..orderBy([(t) => OrderingTerm.asc(t.ayahNumber)]))
            .get();
    return rows.map(_toAyah).toList();
  }

  Future<void> _writeCache(List<Ayah> ayahs) {
    return _db.batch((b) {
      b.insertAllOnConflictUpdate(_db.cachedAyahs, [
        for (final a in ayahs)
          CachedAyahsCompanion.insert(
            surahNumber: a.surahNumber,
            ayahNumber: a.numberInSurah,
            globalNumber: a.globalNumber,
            juz: a.juz,
            textAr: a.textAr,
            translationEn: a.translation,
            translatorName: a.translatorName,
          ),
      ]);
    });
  }

  static Ayah _toAyah(CachedAyah r) => Ayah(
    surahNumber: r.surahNumber,
    numberInSurah: r.ayahNumber,
    globalNumber: r.globalNumber,
    juz: r.juz,
    textAr: r.textAr,
    translation: r.translationEn,
    translatorName: r.translatorName,
  );

  @override
  Stream<List<QuranBookmark>> watchBookmarks() {
    final b = _db.ayahBookmarks;
    final c = _db.cachedAyahs;
    final query = _db.select(b).join([
      leftOuterJoin(
        c,
        c.surahNumber.equalsExp(b.surahNumber) & c.ayahNumber.equalsExp(b.ayahNumber),
      ),
    ])..orderBy([OrderingTerm.desc(b.createdAt), OrderingTerm.desc(b.id)]);
    return query.watch().map(
      (rows) => [for (final row in rows) _toBookmark(row.readTable(b), row.readTableOrNull(c))],
    );
  }

  static QuranBookmark _toBookmark(AyahBookmark row, CachedAyah? cached) => QuranBookmark(
    surahNumber: row.surahNumber,
    ayahNumber: row.ayahNumber,
    createdAt: row.createdAt,
    ayah: cached == null ? null : _toAyah(cached),
  );

  @override
  Stream<Set<int>> watchBookmarkedAyahs(int surahNumber) {
    return (_db.select(_db.ayahBookmarks)..where((t) => t.surahNumber.equals(surahNumber)))
        .watch()
        .map((rows) => {for (final r in rows) r.ayahNumber});
  }

  @override
  Future<bool> toggleBookmark(int surahNumber, int ayahNumber) {
    return _db.transaction(() async {
      final deleted = await _deleteBookmark(surahNumber, ayahNumber);
      if (deleted > 0) return false;
      await _db
          .into(_db.ayahBookmarks)
          .insert(
            AyahBookmarksCompanion.insert(
              surahNumber: surahNumber,
              ayahNumber: ayahNumber,
              createdAt: Value(_clock()),
            ),
          );
      return true;
    });
  }

  @override
  Future<void> removeBookmark(int surahNumber, int ayahNumber) =>
      _deleteBookmark(surahNumber, ayahNumber);

  Future<int> _deleteBookmark(int surahNumber, int ayahNumber) {
    return (_db.delete(
      _db.ayahBookmarks,
    )..where((t) => t.surahNumber.equals(surahNumber) & t.ayahNumber.equals(ayahNumber))).go();
  }

  @override
  Future<void> saveReflection({required String body, int? surahNumber, int? ayahNumber}) {
    return _db
        .into(_db.reflections)
        .insert(
          ReflectionsCompanion.insert(
            body: body.trim(),
            surahNumber: Value(surahNumber),
            ayahNumber: Value(ayahNumber),
            createdAt: Value(_clock()),
          ),
        );
  }

  @override
  Future<void> saveProgress(Surah surah, int ayahNumber) {
    return _db.upsertQuranProgress(
      QuranProgressEntriesCompanion.insert(
        surahNumber: surah.number,
        surahNameAr: surah.nameAr,
        surahNameEn: surah.nameEn,
        ayahNumber: ayahNumber,
        totalAyahs: surah.ayahCount,
        updatedAt: Value(_clock()),
      ),
    );
  }

  @override
  Stream<QuranReadingProgress?> watchLatestProgress() {
    return _db.watchLatestQuranProgress().map(
      (row) => row == null
          ? null
          : QuranReadingProgress(
              surahNumber: row.surahNumber,
              surahNameEn: row.surahNameEn,
              surahNameAr: row.surahNameAr,
              ayahNumber: row.ayahNumber,
              totalAyahs: row.totalAyahs,
              updatedAt: row.updatedAt,
            ),
    );
  }

  @override
  Future<void> logAyahsRead(int count) async {
    if (count <= 0) return;
    await _db
        .into(_db.readingLogs)
        .insert(
          ReadingLogsCompanion.insert(day: AppDatabase.dayKey(_clock()), ayahsRead: Value(count)),
          onConflict: DoUpdate(
            (old) => ReadingLogsCompanion.custom(ayahsRead: old.ayahsRead + Constant(count)),
          ),
        );
  }
}

@Riverpod(keepAlive: true)
QuranRemoteDataSource quranRemoteDataSource(Ref ref) {
  return DioQuranRemoteDataSource(ref.watch(dioClientProvider));
}

@Riverpod(keepAlive: true)
QuranRepository quranRepository(Ref ref) {
  return DriftQuranRepository(
    db: ref.watch(appDatabaseProvider),
    remote: ref.watch(quranRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}
