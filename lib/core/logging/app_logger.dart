import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// Central logging setup. Call [AppLogger.init] once in `main()`.
///
/// Use `AppLogger.of('FeatureName')` to get a tagged logger — tags make it
/// possible to filter noisy subsystems (e.g. audio, network) in DevTools.
abstract final class AppLogger {
  static bool _initialized = false;

  static void init() {
    if (_initialized) return;
    _initialized = true;
    Logger.root.level = kDebugMode ? Level.ALL : Level.WARNING;
    Logger.root.onRecord.listen((record) {
      developer.log(
        record.message,
        time: record.time,
        sequenceNumber: record.sequenceNumber,
        level: record.level.value,
        name: record.loggerName,
        error: record.error,
        stackTrace: record.stackTrace,
      );
    });
  }

  static Logger of(String tag) => Logger(tag);
}
