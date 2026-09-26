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
String _$prayerLogsForDayHash() => r'3e9bf2e8d6d9da84b64fa2306c087fb5cf3978d3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Prayers marked as prayed on [day] (any time within the day). UI passes
/// the displayed schedule's [PrayerSchedule.day] so the checks always match
/// the times on screen.
///
/// Copied from [prayerLogsForDay].
@ProviderFor(prayerLogsForDay)
const prayerLogsForDayProvider = PrayerLogsForDayFamily();

/// Prayers marked as prayed on [day] (any time within the day). UI passes
/// the displayed schedule's [PrayerSchedule.day] so the checks always match
/// the times on screen.
///
/// Copied from [prayerLogsForDay].
class PrayerLogsForDayFamily extends Family<AsyncValue<Set<PrayerName>>> {
  /// Prayers marked as prayed on [day] (any time within the day). UI passes
  /// the displayed schedule's [PrayerSchedule.day] so the checks always match
  /// the times on screen.
  ///
  /// Copied from [prayerLogsForDay].
  const PrayerLogsForDayFamily();

  /// Prayers marked as prayed on [day] (any time within the day). UI passes
  /// the displayed schedule's [PrayerSchedule.day] so the checks always match
  /// the times on screen.
  ///
  /// Copied from [prayerLogsForDay].
  PrayerLogsForDayProvider call(DateTime day) {
    return PrayerLogsForDayProvider(day);
  }

  @override
  PrayerLogsForDayProvider getProviderOverride(
    covariant PrayerLogsForDayProvider provider,
  ) {
    return call(provider.day);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'prayerLogsForDayProvider';
}

/// Prayers marked as prayed on [day] (any time within the day). UI passes
/// the displayed schedule's [PrayerSchedule.day] so the checks always match
/// the times on screen.
///
/// Copied from [prayerLogsForDay].
class PrayerLogsForDayProvider
    extends AutoDisposeStreamProvider<Set<PrayerName>> {
  /// Prayers marked as prayed on [day] (any time within the day). UI passes
  /// the displayed schedule's [PrayerSchedule.day] so the checks always match
  /// the times on screen.
  ///
  /// Copied from [prayerLogsForDay].
  PrayerLogsForDayProvider(DateTime day)
    : this._internal(
        (ref) => prayerLogsForDay(ref as PrayerLogsForDayRef, day),
        from: prayerLogsForDayProvider,
        name: r'prayerLogsForDayProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$prayerLogsForDayHash,
        dependencies: PrayerLogsForDayFamily._dependencies,
        allTransitiveDependencies:
            PrayerLogsForDayFamily._allTransitiveDependencies,
        day: day,
      );

  PrayerLogsForDayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.day,
  }) : super.internal();

  final DateTime day;

  @override
  Override overrideWith(
    Stream<Set<PrayerName>> Function(PrayerLogsForDayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrayerLogsForDayProvider._internal(
        (ref) => create(ref as PrayerLogsForDayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        day: day,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Set<PrayerName>> createElement() {
    return _PrayerLogsForDayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrayerLogsForDayProvider && other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PrayerLogsForDayRef on AutoDisposeStreamProviderRef<Set<PrayerName>> {
  /// The parameter `day` of this provider.
  DateTime get day;
}

class _PrayerLogsForDayProviderElement
    extends AutoDisposeStreamProviderElement<Set<PrayerName>>
    with PrayerLogsForDayRef {
  _PrayerLogsForDayProviderElement(super.provider);

  @override
  DateTime get day => (origin as PrayerLogsForDayProvider).day;
}

String _$prayerDayStateHash() => r'ac34b7995f0f0262fccba62c2f4e91275d67c3f0';

/// See also [prayerDayState].
@ProviderFor(prayerDayState)
final prayerDayStateProvider = AutoDisposeProvider<PrayerDayState?>.internal(
  prayerDayState,
  name: r'prayerDayStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$prayerDayStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PrayerDayStateRef = AutoDisposeProviderRef<PrayerDayState?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
