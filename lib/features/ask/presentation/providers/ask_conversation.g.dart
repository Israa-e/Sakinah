// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ask_conversation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$askServiceConfiguredHash() =>
    r'e0ae992f121f6d031149409ea94fbe5d79f9fa6e';

/// Whether a backend is configured for this build.
///
/// Copied from [askServiceConfigured].
@ProviderFor(askServiceConfigured)
final askServiceConfiguredProvider = AutoDisposeProvider<bool>.internal(
  askServiceConfigured,
  name: r'askServiceConfiguredProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$askServiceConfiguredHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AskServiceConfiguredRef = AutoDisposeProviderRef<bool>;
String _$askConversationHash() => r'948c6ed5157e497c1c693af1f73c1b49a7f59359';

/// In-memory conversation (cleared when the Ask screen is left).
///
/// Copied from [AskConversation].
@ProviderFor(AskConversation)
final askConversationProvider =
    AutoDisposeNotifierProvider<AskConversation, List<AskExchange>>.internal(
      AskConversation.new,
      name: r'askConversationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$askConversationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AskConversation = AutoDisposeNotifier<List<AskExchange>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
