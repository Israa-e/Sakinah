// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingStatusHash() => r'255a2cc154e9981c611d48bd036693c38156a68a';

/// Whether the user has completed the onboarding flow at least once. The
/// router redirects on this; the onboarding flow itself flips it via
/// [complete] once the final step is confirmed.
///
/// Copied from [OnboardingStatus].
@ProviderFor(OnboardingStatus)
final onboardingStatusProvider =
    NotifierProvider<OnboardingStatus, bool>.internal(
      OnboardingStatus.new,
      name: r'onboardingStatusProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingStatusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnboardingStatus = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
