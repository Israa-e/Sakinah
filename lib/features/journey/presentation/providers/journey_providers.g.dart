// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$journeyStatsHash() => r'a19792642e58dc3384b719d085c8cd11b95a7458';

/// Live journey stats (streak, level, garden stage, activity). Other features
/// (e.g. Home's streak chip) can watch this directly.
///
/// Copied from [journeyStats].
@ProviderFor(journeyStats)
final journeyStatsProvider = AutoDisposeStreamProvider<JourneyStats>.internal(
  journeyStats,
  name: r'journeyStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journeyStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JourneyStatsRef = AutoDisposeStreamProviderRef<JourneyStats>;
String _$journeySelectedGoalsHash() =>
    r'9b7bd6aa8e5c0c8c42689ca24254e8192725e76e';

/// The focus areas the user picked during onboarding (read-only).
///
/// Copied from [journeySelectedGoals].
@ProviderFor(journeySelectedGoals)
final journeySelectedGoalsProvider =
    AutoDisposeProvider<List<OnboardingGoal>>.internal(
      journeySelectedGoals,
      name: r'journeySelectedGoalsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$journeySelectedGoalsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JourneySelectedGoalsRef = AutoDisposeProviderRef<List<OnboardingGoal>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
