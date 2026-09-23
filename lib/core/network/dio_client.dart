import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../logging/app_logger.dart';

part 'dio_client.g.dart';

const _connectTimeout = Duration(seconds: 10);
const _receiveTimeout = Duration(seconds: 15);

/// Shared Dio instance. Base URL is intentionally left unset here — each
/// remote data source composes its own path off this client, and no secret
/// credential is ever configured client-side (see ARCHITECTURE.md § Security).
@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
    ),
  );

  if (kDebugMode) {
    final logger = AppLogger.of('Network');
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.fine('→ ${options.method} ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          logger.fine('← ${response.statusCode} ${response.requestOptions.uri}');
          handler.next(response);
        },
        onError: (error, handler) {
          logger.warning('✗ ${error.requestOptions.uri}', error);
          handler.next(error);
        },
      ),
    );
  }

  return dio;
}
