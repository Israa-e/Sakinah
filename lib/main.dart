import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/logging/app_logger.dart';
import 'core/notifications/notification_service.dart';
import 'core/storage/preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.init();

  final logger = AppLogger.of('Main');
  FlutterError.onError = (details) {
    logger.severe('Uncaught Flutter error', details.exception, details.stack);
  };

  final sharedPreferences = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(sharedPreferences)],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SakinahApp(),
    ),
  );

  // Doesn't gate the first frame — the notification plugin only needs to be
  // ready by the time PrayerNotificationScheduler tries to use it, which is
  // well after startup.
  unawaited(container.read(notificationServiceProvider).initialize());
}
