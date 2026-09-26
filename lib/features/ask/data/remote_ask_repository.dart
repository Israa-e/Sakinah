import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/result.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_info.dart';
import '../domain/ask_models.dart';
import '../domain/ask_repository.dart';

part 'remote_ask_repository.g.dart';

/// `--dart-define=ASK_SAKINAH_URL=https://…` (no trailing `/api/ask`).
const askSakinahUrlFromEnvironment = String.fromEnvironment('ASK_SAKINAH_URL');

/// Talks to our own Ask Sakīnah backend (`POST {base}/api/ask`). No provider
/// credential ever lives in the app; see ARCHITECTURE.md § Security.
class RemoteAskRepository implements AskRepository {
  RemoteAskRepository(this._dio, this._networkInfo, {required String baseUrl})
      : _baseUrl = baseUrl.trim();

  final Dio _dio;
  final String _baseUrl;
  final NetworkInfo _networkInfo;

  @override
  bool get isConfigured => _baseUrl.isNotEmpty;

  Uri get _endpoint {
    final base = _baseUrl.endsWith('/') ? _baseUrl.substring(0, _baseUrl.length - 1) : _baseUrl;
    return Uri.parse('$base/api/ask');
  }

  @override
  Future<Result<AskAnswer>> ask(String question, AskLanguage language) async {
    if (!isConfigured) return const Failure(askServiceNotConfigured);
    final trimmed = question.trim();
    if (trimmed.isEmpty) {
      return const Failure(ValidationFailure(debugMessage: 'Empty question'));
    }
    if (!await _networkInfo.isConnected) {
      return const Failure(NetworkFailure(debugMessage: 'Offline'));
    }
    try {
      final response = await _dio.postUri<Object?>(
        _endpoint,
        data: {'question': trimmed, 'language': language.name},
        options: Options(contentType: Headers.jsonContentType, responseType: ResponseType.json),
      );
      final answer = parseAskResponse(response.data);
      if (answer == null) {
        return const Failure(ServerFailure(debugMessage: 'Malformed /api/ask response'));
      }
      return Success(answer);
    } on DioException catch (e) {
      return Failure(_mapDioError(e));
    } on Object catch (e) {
      return Failure(UnknownFailure(debugMessage: '$e'));
    }
  }

  AppFailure _mapDioError(DioException e) => switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          TimeoutFailure(debugMessage: e.message),
        DioExceptionType.connectionError => NetworkFailure(debugMessage: e.message),
        DioExceptionType.badResponse =>
          ServerFailure(statusCode: e.response?.statusCode, debugMessage: e.message),
        _ => UnknownFailure(debugMessage: e.message),
      };
}

/// Validates and parses `{answer, sources[], disclaimer}`; `null` if malformed.
AskAnswer? parseAskResponse(Object? data) {
  if (data is! Map) return null;
  final answer = data['answer'];
  if (answer is! String || answer.trim().isEmpty) return null;
  final rawSources = data['sources'];
  final sources = <AskSource>[];
  if (rawSources is List) {
    for (final s in rawSources) {
      if (s is Map && s['reference'] is String && (s['reference'] as String).trim().isNotEmpty) {
        sources.add(AskSource(
          type: AskSourceType.parse(s['type'] as String?),
          reference: (s['reference'] as String).trim(),
        ));
      }
    }
  }
  final disclaimer = data['disclaimer'];
  return AskAnswer(
    answer: answer.trim(),
    sources: sources,
    disclaimer: disclaimer is String && disclaimer.trim().isNotEmpty ? disclaimer.trim() : null,
  );
}

/// Base URL of the Ask Sakīnah backend; empty = not configured.
@Riverpod(keepAlive: true)
String askBaseUrl(Ref ref) => askSakinahUrlFromEnvironment;

@Riverpod(keepAlive: true)
AskRepository askRepository(Ref ref) {
  return RemoteAskRepository(
    ref.watch(dioClientProvider),
    ref.watch(networkInfoProvider),
    baseUrl: ref.watch(askBaseUrlProvider),
  );
}
