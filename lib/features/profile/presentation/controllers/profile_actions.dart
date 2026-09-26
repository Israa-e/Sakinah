import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/location/location_service.dart';
import '../../../../core/storage/preferences_service.dart';
import '../../../onboarding/data/permission_gateway.dart';
import '../../../prayer/data/adhan_prayer_repository.dart';
import '../../../prayer/domain/prayer_notifications_provider.dart';

part 'profile_actions.g.dart';

enum LocationRefreshOutcome { updated, permissionDenied, failed }

enum NotificationToggleOutcome { enabled, disabled, permissionDenied }

/// Side-effectful Profile actions that need more than a single provider
/// write (OS permission prompts, GPS fix + cache + recompute).
@riverpod
class ProfileActions extends _$ProfileActions {
  @override
  void build() {}

  Future<NotificationToggleOutcome> setPrayerNotifications(bool enabled) async {
    final toggle = ref.read(prayerNotificationsEnabledProvider.notifier);
    if (!enabled) {
      await toggle.setEnabled(false);
      return NotificationToggleOutcome.disabled;
    }
    final outcome = await ref.read(permissionGatewayProvider).requestNotifications();
    if (!outcome.isGranted) {
      await toggle.setEnabled(false);
      return NotificationToggleOutcome.permissionDenied;
    }
    await toggle.setEnabled(true);
    return NotificationToggleOutcome.enabled;
  }

  /// Takes a fresh location fix, caches it, and forces prayer times (and the
  /// reminders scheduled from them) to recompute.
  Future<LocationRefreshOutcome> refreshLocation() async {
    final result = await ref.read(locationServiceProvider).getCurrentLocation();
    switch (result) {
      case Success(:final data):
        await ref
            .read(preferencesServiceProvider)
            .setLastKnownLocation(data.latitude, data.longitude);
        ref.invalidate(prayerRepositoryProvider);
        return LocationRefreshOutcome.updated;
      case Failure(failure: PermissionFailure()):
        return LocationRefreshOutcome.permissionDenied;
      case Failure():
        return LocationRefreshOutcome.failed;
    }
  }

  Future<bool> openSystemSettings() => ref.read(permissionGatewayProvider).openSystemSettings();
}
