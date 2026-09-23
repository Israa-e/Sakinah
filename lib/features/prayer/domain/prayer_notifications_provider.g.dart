// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_notifications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prayerNotificationsEnabledHash() =>
    r'0e408b80b7e3818f0248d06da82792848930a15e';

/// Whether prayer-time reminders are turned on. Reactive on its own (unlike
/// reading `PreferencesService` directly, which doesn't notify watchers when
/// the underlying flag changes) so [PrayerNotificationScheduler] and the
/// Prayer screen's toggle stay in sync.
///
/// Copied from [PrayerNotificationsEnabled].
@ProviderFor(PrayerNotificationsEnabled)
final prayerNotificationsEnabledProvider =
    NotifierProvider<PrayerNotificationsEnabled, bool>.internal(
      PrayerNotificationsEnabled.new,
      name: r'prayerNotificationsEnabledProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$prayerNotificationsEnabledHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PrayerNotificationsEnabled = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
