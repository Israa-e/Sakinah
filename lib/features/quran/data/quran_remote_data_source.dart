import 'package:dio/dio.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/result.dart';
import '../domain/quran_models.dart';
import 'quran_text.dart';

/// Fetches Quran text + translation for one surah from api.alquran.cloud.
abstract interface class QuranRemoteDataSource {
  Future<Result<List<Ayah>>> fetchSurah(int surahNumber);
}

class DioQuranRemoteDataSource implements QuranRemoteDataSource {
  DioQuranRemoteDataSource(this._dio);

  final Dio _dio;

  static const arabicEdition = 'quran-uthmani';
  static const translationEdition = 'en.sahih';

  /// Display name of the `en.sahih` edition (the API spells it "Saheeh").
  static const translatorName = 'Sahih International';

  static String surahUrl(int surahNumber) =>
      'https://api.alquran.cloud/v1/surah/$surahNumber/editions/$arabicEdition,$translationEdition';

  @override
  Future<Result<List<Ayah>>> fetchSurah(int surahNumber) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(surahUrl(surahNumber));
      final body = response.data;
      if (body == null) {
        return const Failure(ServerFailure(debugMessage: 'Empty body'));
      }
      return Success(parseSurahEditions(body, surahNumber));
    } on DioException catch (e) {
      return Failure(_mapDioError(e));
    } on FormatException catch (e) {
      return Failure(ServerFailure(debugMessage: e.message));
    } on TypeError catch (e) {
      return Failure(ServerFailure(debugMessage: e.toString()));
    }
  }

  /// Parses `/surah/{n}/editions/quran-uthmani,en.sahih` into [Ayah]s,
  /// stripping the Bismillah the API prefixes onto ayah 1 (except 1 and 9).
  static List<Ayah> parseSurahEditions(Map<String, dynamic> body, int surahNumber) {
    final data = body['data'];
    if (data is! List || data.length < 2) {
      throw const FormatException('Unexpected editions payload');
    }
    Map<String, dynamic> editionOf(String id) => data.cast<Map<String, dynamic>>().firstWhere(
      (e) => (e['edition'] as Map<String, dynamic>)['identifier'] == id,
      orElse: () => throw FormatException('Missing edition $id'),
    );
    final arabic = (editionOf(arabicEdition)['ayahs'] as List).cast<Map<String, dynamic>>();
    final english = (editionOf(translationEdition)['ayahs'] as List).cast<Map<String, dynamic>>();
    if (arabic.isEmpty || arabic.length != english.length) {
      throw const FormatException('Edition ayah counts differ');
    }
    return [
      for (var i = 0; i < arabic.length; i++)
        Ayah(
          surahNumber: surahNumber,
          numberInSurah: arabic[i]['numberInSurah'] as int,
          globalNumber: arabic[i]['number'] as int,
          juz: arabic[i]['juz'] as int,
          textAr: QuranText.cleanAyahText(
            arabic[i]['text'] as String,
            surahNumber: surahNumber,
            ayahNumber: arabic[i]['numberInSurah'] as int,
          ),
          translation: (english[i]['text'] as String).trim(),
          translatorName: translatorName,
        ),
    ];
  }

  AppFailure _mapDioError(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => TimeoutFailure(debugMessage: e.message),
      DioExceptionType.badResponse => ServerFailure(
        statusCode: e.response?.statusCode,
        debugMessage: e.message,
      ),
      DioExceptionType.connectionError => NetworkFailure(debugMessage: e.message),
      _ => UnknownFailure(debugMessage: e.message),
    };
  }
}
