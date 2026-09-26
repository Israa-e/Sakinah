// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dhikr_counter_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dhikrCounterControllerHash() =>
    r'766147e8e2c84b7d0518117aaddb04280134bfc9';

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

abstract class _$DhikrCounterController
    extends BuildlessAutoDisposeNotifier<DhikrCounterState> {
  late final String dhikrKey;

  DhikrCounterState build(String dhikrKey);
}

/// Owns the live tasbeeh count for one item. Taps update memory instantly and
/// are written to Drift after a short debounce (and on dispose), so rapid
/// tapping never waits on the database.
///
/// Copied from [DhikrCounterController].
@ProviderFor(DhikrCounterController)
const dhikrCounterControllerProvider = DhikrCounterControllerFamily();

/// Owns the live tasbeeh count for one item. Taps update memory instantly and
/// are written to Drift after a short debounce (and on dispose), so rapid
/// tapping never waits on the database.
///
/// Copied from [DhikrCounterController].
class DhikrCounterControllerFamily extends Family<DhikrCounterState> {
  /// Owns the live tasbeeh count for one item. Taps update memory instantly and
  /// are written to Drift after a short debounce (and on dispose), so rapid
  /// tapping never waits on the database.
  ///
  /// Copied from [DhikrCounterController].
  const DhikrCounterControllerFamily();

  /// Owns the live tasbeeh count for one item. Taps update memory instantly and
  /// are written to Drift after a short debounce (and on dispose), so rapid
  /// tapping never waits on the database.
  ///
  /// Copied from [DhikrCounterController].
  DhikrCounterControllerProvider call(String dhikrKey) {
    return DhikrCounterControllerProvider(dhikrKey);
  }

  @override
  DhikrCounterControllerProvider getProviderOverride(
    covariant DhikrCounterControllerProvider provider,
  ) {
    return call(provider.dhikrKey);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dhikrCounterControllerProvider';
}

/// Owns the live tasbeeh count for one item. Taps update memory instantly and
/// are written to Drift after a short debounce (and on dispose), so rapid
/// tapping never waits on the database.
///
/// Copied from [DhikrCounterController].
class DhikrCounterControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<
          DhikrCounterController,
          DhikrCounterState
        > {
  /// Owns the live tasbeeh count for one item. Taps update memory instantly and
  /// are written to Drift after a short debounce (and on dispose), so rapid
  /// tapping never waits on the database.
  ///
  /// Copied from [DhikrCounterController].
  DhikrCounterControllerProvider(String dhikrKey)
    : this._internal(
        () => DhikrCounterController()..dhikrKey = dhikrKey,
        from: dhikrCounterControllerProvider,
        name: r'dhikrCounterControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dhikrCounterControllerHash,
        dependencies: DhikrCounterControllerFamily._dependencies,
        allTransitiveDependencies:
            DhikrCounterControllerFamily._allTransitiveDependencies,
        dhikrKey: dhikrKey,
      );

  DhikrCounterControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dhikrKey,
  }) : super.internal();

  final String dhikrKey;

  @override
  DhikrCounterState runNotifierBuild(
    covariant DhikrCounterController notifier,
  ) {
    return notifier.build(dhikrKey);
  }

  @override
  Override overrideWith(DhikrCounterController Function() create) {
    return ProviderOverride(
      origin: this,
      override: DhikrCounterControllerProvider._internal(
        () => create()..dhikrKey = dhikrKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dhikrKey: dhikrKey,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<DhikrCounterController, DhikrCounterState>
  createElement() {
    return _DhikrCounterControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DhikrCounterControllerProvider &&
        other.dhikrKey == dhikrKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dhikrKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DhikrCounterControllerRef
    on AutoDisposeNotifierProviderRef<DhikrCounterState> {
  /// The parameter `dhikrKey` of this provider.
  String get dhikrKey;
}

class _DhikrCounterControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          DhikrCounterController,
          DhikrCounterState
        >
    with DhikrCounterControllerRef {
  _DhikrCounterControllerProviderElement(super.provider);

  @override
  String get dhikrKey => (origin as DhikrCounterControllerProvider).dhikrKey;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
