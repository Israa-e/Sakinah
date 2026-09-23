// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quranProgressHash() => r'cdfc2926c195734da2c7ac6013ae80757ed53a43';

/// See also [quranProgress].
@ProviderFor(quranProgress)
final quranProgressProvider =
    AutoDisposeStreamProvider<QuranProgressInfo?>.internal(
      quranProgress,
      name: r'quranProgressProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$quranProgressHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuranProgressRef = AutoDisposeStreamProviderRef<QuranProgressInfo?>;
String _$dailyDeedHash() => r'8a503310aae6d650bd265a07d57175d206a36dd9';

/// See also [dailyDeed].
@ProviderFor(dailyDeed)
final dailyDeedProvider = AutoDisposeStreamProvider<DailyDeed>.internal(
  dailyDeed,
  name: r'dailyDeedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyDeedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DailyDeedRef = AutoDisposeStreamProviderRef<DailyDeed>;
String _$todaysDhikrHash() => r'1442e751f38c47ed996de6009af70c304d324782';

/// Fixed until the Dhikr feature (Phase 5) ships real rotation — see
/// [DhikrPreview] doc comment on why the content itself is safe to hardcode.
///
/// Copied from [todaysDhikr].
@ProviderFor(todaysDhikr)
final todaysDhikrProvider = AutoDisposeProvider<DhikrPreview>.internal(
  todaysDhikr,
  name: r'todaysDhikrProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todaysDhikrHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodaysDhikrRef = AutoDisposeProviderRef<DhikrPreview>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
