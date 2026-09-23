// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_notification_scheduler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prayerNotificationSchedulerHash() =>
    r'65a29bcdfa74d950c175a6db941160131e55cd66';

/// Watches the day's prayer schedule and the notifications-enabled flag and
/// keeps the device's scheduled reminders in sync. Something in the widget
/// tree must `ref.watch`/`ref.listen` this once (see `HomeScreen`) so it
/// stays alive for the life of the app — it has no UI of its own.
///
/// Copied from [PrayerNotificationScheduler].
@ProviderFor(PrayerNotificationScheduler)
final prayerNotificationSchedulerProvider =
    AsyncNotifierProvider<PrayerNotificationScheduler, void>.internal(
      PrayerNotificationScheduler.new,
      name: r'prayerNotificationSchedulerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$prayerNotificationSchedulerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PrayerNotificationScheduler = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
