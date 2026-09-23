// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioClientHash() => r'ae7f99975c189904a00152f56812987b3a8d1403';

/// Shared Dio instance. Base URL is intentionally left unset here — each
/// remote data source composes its own path off this client, and no secret
/// credential is ever configured client-side (see ARCHITECTURE.md § Security).
///
/// Copied from [dioClient].
@ProviderFor(dioClient)
final dioClientProvider = Provider<Dio>.internal(
  dioClient,
  name: r'dioClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dioClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioClientRef = ProviderRef<Dio>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
