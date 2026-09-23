import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences_service.dart';

part 'prayer_notifications_provider.g.dart';

/// Whether prayer-time reminders are turned on. Reactive on its own (unlike
/// reading `PreferencesService` directly, which doesn't notify watchers when
/// the underlying flag changes) so [PrayerNotificationScheduler] and the
/// Prayer screen's toggle stay in sync.
@Riverpod(keepAlive: true)
class PrayerNotificationsEnabled extends _$PrayerNotificationsEnabled {
  @override
  bool build() => ref.watch(preferencesServiceProvider).prayerNotificationsEnabled;

  Future<void> setEnabled(bool value) async {
    await ref.read(preferencesServiceProvider).setPrayerNotificationsEnabled(value);
    state = value;
  }
}
