import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/logging/app_logger.dart';
import 'core/storage/preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.init();

  final logger = AppLogger.of('Main');
  FlutterError.onError = (details) {
    logger.severe('Uncaught Flutter error', details.exception, details.stack);
  };

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const SakinahApp(),
    ),
  );
}
