// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prayerSettingsControllerHash() =>
    r'80a689fcc48fcef3ab083d90e3f4a82992bbe14b';

/// Reads/writes the calculation method + madhab collected during onboarding
/// (or changed later from the Prayer screen) — the single source of truth
/// [AdhanPrayerRepository] calculates against.
///
/// Copied from [PrayerSettingsController].
@ProviderFor(PrayerSettingsController)
final prayerSettingsControllerProvider =
    NotifierProvider<PrayerSettingsController, PrayerSettings>.internal(
      PrayerSettingsController.new,
      name: r'prayerSettingsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$prayerSettingsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PrayerSettingsController = Notifier<PrayerSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
