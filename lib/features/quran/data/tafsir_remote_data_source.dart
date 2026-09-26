import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/result.dart';
import '../../../core/network/dio_client.dart';

part 'tafsir_remote_data_source.g.dart';

/// Tafsir al-Muyassar (King Fahd Glorious Quran Printing Complex), served by
/// api.alquran.cloud as the `ar.muyassar` edition. This is the app's only
/// tafsir source — nothing is ever generated or paraphrased locally.
abstract interface class TafsirRemoteDataSource {
  /// The Muyassar commentary on [surah]:[ayah].
  Future<Result<String>> fetchMuyassar(int surah, int ayah);
}

abstract final class TafsirSource {
  static const edition = 'ar.muyassar';
  static const nameAr = 'التفسير الميسر — مجمع الملك فهد';
  static const nameEn = 'Tafsir al-Muyassar — King Fahd Quran Complex';

  static String ayahUrl(int surah, int ayah) =>
      'https://api.alquran.cloud/v1/ayah/$surah:$ayah/$edition';
}

class DioTafsirRemoteDataSource implements TafsirRemoteDataSource {
  DioTafsirRemoteDataSource(this._dio);

  final Dio _dio;

  /// In-memory cache for this app session (tafsir isn't persisted).
  final _cache = <(int, int), String>{};

  @override
  Future<Result<String>> fetchMuyassar(int surah, int ayah) async {
    final cached = _cache[(surah, ayah)];
    if (cached != null) return Success(cached);
    try {
      final response = await _dio.get<Map<String, dynamic>>(TafsirSource.ayahUrl(surah, ayah));
      final text = parseAyahTafsir(response.data, surah, ayah);
      _cache[(surah, ayah)] = text;
      return Success(text);
    } on DioException catch (e) {
      return Failure(switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout => TimeoutFailure(debugMessage: e.message),
        DioExceptionType.badResponse => ServerFailure(
          statusCode: e.response?.statusCode,
          debugMessage: e.message,
        ),
        DioExceptionType.connectionError => NetworkFailure(debugMessage: e.message),
        _ => UnknownFailure(debugMessage: e.message),
      });
    } on FormatException catch (e) {
      return Failure(ServerFailure(debugMessage: e.message));
    } on TypeError catch (e) {
      return Failure(ServerFailure(debugMessage: e.toString()));
    }
  }

  /// Validates the `/ayah/{s}:{a}/ar.muyassar` payload really is the
  /// Muyassar text for the requested ayah before returning it.
  static String parseAyahTafsir(Map<String, dynamic>? body, int surah, int ayah) {
    final data = body?['data'];
    if (data is! Map<String, dynamic>) throw const FormatException('Missing data');
    final edition = data['edition'];
    if (edition is! Map<String, dynamic> || edition['identifier'] != TafsirSource.edition) {
      throw const FormatException('Unexpected edition');
    }
    final surahData = data['surah'];
    if (surahData is! Map<String, dynamic> ||
        surahData['number'] != surah ||
        data['numberInSurah'] != ayah) {
      throw const FormatException('Tafsir for a different ayah');
    }
    final text = (data['text'] as String).replaceAll('﻿', '').trim();
    if (text.isEmpty) throw const FormatException('Empty tafsir');
    return text;
  }
}

@Riverpod(keepAlive: true)
TafsirRemoteDataSource tafsirRemoteDataSource(Ref ref) {
  return DioTafsirRemoteDataSource(ref.watch(dioClientProvider));
}
