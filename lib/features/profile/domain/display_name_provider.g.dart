// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'display_name_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$displayNameHash() => r'ed9ab7dadcd2a4627989296fd192e12c5eac3383';

/// The name the user asked to be greeted by, or `null` when they skipped it.
/// Set during onboarding (Goals step) and editable from the Profile header.
///
/// Copied from [DisplayName].
@ProviderFor(DisplayName)
final displayNameProvider = NotifierProvider<DisplayName, String?>.internal(
  DisplayName.new,
  name: r'displayNameProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$displayNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DisplayName = Notifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
