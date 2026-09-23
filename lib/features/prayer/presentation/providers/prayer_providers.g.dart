// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayPrayerScheduleHash() =>
    r'471c91abcf2f6ac75aa3339f09a497898017a327';

/// See also [todayPrayerSchedule].
@ProviderFor(todayPrayerSchedule)
final todayPrayerScheduleProvider =
    AutoDisposeStreamProvider<PrayerSchedule>.internal(
      todayPrayerSchedule,
      name: r'todayPrayerScheduleProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayPrayerScheduleHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayPrayerScheduleRef = AutoDisposeStreamProviderRef<PrayerSchedule>;
String _$clockTickHash() => r'4cf1c375bee32c368f2067327a1eb13c90d7779a';

/// Ticks once a second so the countdown updates live without re-fetching the
/// schedule — only this narrow provider (and whatever `select`s just the
/// remaining-duration text) rebuilds every tick.
///
/// Copied from [clockTick].
@ProviderFor(clockTick)
final clockTickProvider = AutoDisposeStreamProvider<DateTime>.internal(
  clockTick,
  name: r'clockTickProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clockTickHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClockTickRef = AutoDisposeStreamProviderRef<DateTime>;
String _$nextPrayerHash() => r'3f0f5099ed2bc14b68f1e020074a9ad8308da04c';

/// `null` while the schedule or clock haven't produced a first value yet.
///
/// Copied from [nextPrayer].
@ProviderFor(nextPrayer)
final nextPrayerProvider = AutoDisposeProvider<NextPrayerInfo?>.internal(
  nextPrayer,
  name: r'nextPrayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nextPrayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NextPrayerRef = AutoDisposeProviderRef<NextPrayerInfo?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
