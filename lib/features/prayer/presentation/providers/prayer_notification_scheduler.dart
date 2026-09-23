import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/config/locale_provider.dart';
import '../../../../core/notifications/notification_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/prayer_notifications_provider.dart';
import '../prayer_name_x.dart';
import 'prayer_providers.dart';

part 'prayer_notification_scheduler.g.dart';

/// Watches the day's prayer schedule and the notifications-enabled flag and
/// keeps the device's scheduled reminders in sync. Something in the widget
/// tree must `ref.watch`/`ref.listen` this once (see `HomeScreen`) so it
/// stays alive for the life of the app — it has no UI of its own.
@Riverpod(keepAlive: true)
class PrayerNotificationScheduler extends _$PrayerNotificationScheduler {
  @override
  Future<void> build() async {
    final notifications = ref.watch(notificationServiceProvider);
    final enabled = ref.watch(prayerNotificationsEnabledProvider);

    if (!enabled) {
      await notifications.cancelAll();
      return;
    }

    final schedule = ref.watch(todayPrayerScheduleProvider).valueOrNull;
    if (schedule == null) return;

    final l10n = lookupAppLocalizations(ref.watch(appLocaleProvider));
    await notifications.scheduleAll([
      for (final t in schedule.times) (t.name.index, t.name.label(l10n), t.time),
    ]);
  }
}
