import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../logging/app_logger.dart';

part 'notification_service.g.dart';

/// Thin wrapper over `flutter_local_notifications` for scheduling prayer-time
/// reminders. Every platform call is defensive — a notification failing to
/// schedule (unsupported platform, denied permission, ...) must never crash
/// the app; it's logged and swallowed, same as any other OS-boundary failure.
class NotificationService {
  NotificationService() : _plugin = FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  final _logger = AppLogger.of('Notifications');
  bool _timeZoneReady = false;

  static const _androidChannel = AndroidNotificationChannel(
    'prayer_times',
    'Prayer times',
    description: 'Reminders when a prayer time begins',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    try {
      tz_data.initializeTimeZones();
      final local = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(local.identifier));
      _timeZoneReady = true;
    } catch (e, st) {
      _logger.warning('Falling back to UTC — could not resolve device timezone', e, st);
    }

    try {
      await _plugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ),
      );
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_androidChannel);
    } catch (e, st) {
      _logger.warning('Notification plugin failed to initialize', e, st);
    }
  }

  /// Schedules one reminder per upcoming prayer `(id, name, time)` triple,
  /// replacing whatever was scheduled before. Times already in the past are
  /// skipped. `id`s should be small and stable (e.g. 0–4 for the five daily
  /// prayers) so re-scheduling naturally overwrites yesterday's alarms.
  Future<void> scheduleAll(List<(int id, String title, DateTime time)> reminders) async {
    if (!_timeZoneReady) return;

    for (final (id, title, time) in reminders) {
      await cancel(id);
      if (time.isBefore(DateTime.now())) continue;
      try {
        await _plugin.zonedSchedule(
          id,
          title,
          null,
          tz.TZDateTime.from(time, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'prayer_times',
              'Prayer times',
              channelDescription: 'Reminders when a prayer time begins',
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      } catch (e, st) {
        _logger.warning('Could not schedule notification $id ($title)', e, st);
      }
    }
  }

  Future<void> cancel(int id) async {
    try {
      await _plugin.cancel(id);
    } catch (e, st) {
      _logger.warning('Could not cancel notification $id', e, st);
    }
  }

  Future<void> cancelAll() async {
    try {
      await _plugin.cancelAll();
    } catch (e, st) {
      _logger.warning('Could not cancel notifications', e, st);
    }
  }
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) => NotificationService();
