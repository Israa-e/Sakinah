// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duas_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$duaCatalogHash() => r'c4a3680b64f03441a29b7c7b66ef55359fbc8a43';

/// The full bundled du'a catalog (loaded once per session).
///
/// Copied from [duaCatalog].
@ProviderFor(duaCatalog)
final duaCatalogProvider = FutureProvider<List<Dua>>.internal(
  duaCatalog,
  name: r'duaCatalogProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$duaCatalogHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DuaCatalogRef = FutureProviderRef<List<Dua>>;
String _$duaByKeyHash() => r'6c1bc980e2d7f7e70782197a96f4cabe9e02d5f8';

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

/// One du'a by its stable key, or `null` if the key isn't in the catalog.
///
/// Copied from [duaByKey].
@ProviderFor(duaByKey)
const duaByKeyProvider = DuaByKeyFamily();

/// One du'a by its stable key, or `null` if the key isn't in the catalog.
///
/// Copied from [duaByKey].
class DuaByKeyFamily extends Family<AsyncValue<Dua?>> {
  /// One du'a by its stable key, or `null` if the key isn't in the catalog.
  ///
  /// Copied from [duaByKey].
  const DuaByKeyFamily();

  /// One du'a by its stable key, or `null` if the key isn't in the catalog.
  ///
  /// Copied from [duaByKey].
  DuaByKeyProvider call(String duaKey) {
    return DuaByKeyProvider(duaKey);
  }

  @override
  DuaByKeyProvider getProviderOverride(covariant DuaByKeyProvider provider) {
    return call(provider.duaKey);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'duaByKeyProvider';
}

/// One du'a by its stable key, or `null` if the key isn't in the catalog.
///
/// Copied from [duaByKey].
class DuaByKeyProvider extends AutoDisposeFutureProvider<Dua?> {
  /// One du'a by its stable key, or `null` if the key isn't in the catalog.
  ///
  /// Copied from [duaByKey].
  DuaByKeyProvider(String duaKey)
    : this._internal(
        (ref) => duaByKey(ref as DuaByKeyRef, duaKey),
        from: duaByKeyProvider,
        name: r'duaByKeyProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$duaByKeyHash,
        dependencies: DuaByKeyFamily._dependencies,
        allTransitiveDependencies: DuaByKeyFamily._allTransitiveDependencies,
        duaKey: duaKey,
      );

  DuaByKeyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.duaKey,
  }) : super.internal();

  final String duaKey;

  @override
  Override overrideWith(FutureOr<Dua?> Function(DuaByKeyRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: DuaByKeyProvider._internal(
        (ref) => create(ref as DuaByKeyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        duaKey: duaKey,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Dua?> createElement() {
    return _DuaByKeyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DuaByKeyProvider && other.duaKey == duaKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, duaKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DuaByKeyRef on AutoDisposeFutureProviderRef<Dua?> {
  /// The parameter `duaKey` of this provider.
  String get duaKey;
}

class _DuaByKeyProviderElement extends AutoDisposeFutureProviderElement<Dua?>
    with DuaByKeyRef {
  _DuaByKeyProviderElement(super.provider);

  @override
  String get duaKey => (origin as DuaByKeyProvider).duaKey;
}

String _$isDuaSavedHash() => r'404c2e37022151fe80f318009a1a3fdf19647d2d';

/// See also [isDuaSaved].
@ProviderFor(isDuaSaved)
const isDuaSavedProvider = IsDuaSavedFamily();

/// See also [isDuaSaved].
class IsDuaSavedFamily extends Family<bool> {
  /// See also [isDuaSaved].
  const IsDuaSavedFamily();

  /// See also [isDuaSaved].
  IsDuaSavedProvider call(String duaKey) {
    return IsDuaSavedProvider(duaKey);
  }

  @override
  IsDuaSavedProvider getProviderOverride(
    covariant IsDuaSavedProvider provider,
  ) {
    return call(provider.duaKey);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isDuaSavedProvider';
}

/// See also [isDuaSaved].
class IsDuaSavedProvider extends AutoDisposeProvider<bool> {
  /// See also [isDuaSaved].
  IsDuaSavedProvider(String duaKey)
    : this._internal(
        (ref) => isDuaSaved(ref as IsDuaSavedRef, duaKey),
        from: isDuaSavedProvider,
        name: r'isDuaSavedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isDuaSavedHash,
        dependencies: IsDuaSavedFamily._dependencies,
        allTransitiveDependencies: IsDuaSavedFamily._allTransitiveDependencies,
        duaKey: duaKey,
      );

  IsDuaSavedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.duaKey,
  }) : super.internal();

  final String duaKey;

  @override
  Override overrideWith(bool Function(IsDuaSavedRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: IsDuaSavedProvider._internal(
        (ref) => create(ref as IsDuaSavedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        duaKey: duaKey,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsDuaSavedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsDuaSavedProvider && other.duaKey == duaKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, duaKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsDuaSavedRef on AutoDisposeProviderRef<bool> {
  /// The parameter `duaKey` of this provider.
  String get duaKey;
}

class _IsDuaSavedProviderElement extends AutoDisposeProviderElement<bool>
    with IsDuaSavedRef {
  _IsDuaSavedProviderElement(super.provider);

  @override
  String get duaKey => (origin as IsDuaSavedProvider).duaKey;
}

String _$savedDuasHash() => r'0aedb6a76d96a4cf7e58f31efe22080b5ac57e6c';

/// Saved du'as resolved against the catalog, newest saved first.
///
/// Copied from [savedDuas].
@ProviderFor(savedDuas)
final savedDuasProvider = AutoDisposeFutureProvider<List<Dua>>.internal(
  savedDuas,
  name: r'savedDuasProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$savedDuasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SavedDuasRef = AutoDisposeFutureProviderRef<List<Dua>>;
String _$featuredDuaHash() => r'1ea14357b52e9986c5ef7f88afe0f1aa2de81c5d';

/// A different du'a each calendar day, stable within the day.
///
/// Copied from [featuredDua].
@ProviderFor(featuredDua)
final featuredDuaProvider = AutoDisposeFutureProvider<Dua?>.internal(
  featuredDua,
  name: r'featuredDuaProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featuredDuaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedDuaRef = AutoDisposeFutureProviderRef<Dua?>;
String _$filteredDuasHash() => r'663bc04d6e0374ce3f66485a1de9221f57ff7972';

/// Catalog after applying [DuaLibraryFilter].
///
/// Copied from [filteredDuas].
@ProviderFor(filteredDuas)
final filteredDuasProvider = AutoDisposeFutureProvider<List<Dua>>.internal(
  filteredDuas,
  name: r'filteredDuasProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredDuasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredDuasRef = AutoDisposeFutureProviderRef<List<Dua>>;
String _$savedDuaKeysHash() => r'9dfb90ccf4103075c9f9646cf0b8143b4b0b6419';

/// Keys of the user's saved du'as (newest first), backed by Drift.
///
/// Copied from [SavedDuaKeys].
@ProviderFor(SavedDuaKeys)
final savedDuaKeysProvider =
    StreamNotifierProvider<SavedDuaKeys, List<String>>.internal(
      SavedDuaKeys.new,
      name: r'savedDuaKeysProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$savedDuaKeysHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SavedDuaKeys = StreamNotifier<List<String>>;
String _$duaLibraryFilterHash() => r'20a8478b5c078f97bb4143f052d9f7e53a9e119b';

/// Library search / category / saved-only filter (screen-local UI state).
///
/// Copied from [DuaLibraryFilter].
@ProviderFor(DuaLibraryFilter)
final duaLibraryFilterProvider =
    AutoDisposeNotifierProvider<
      DuaLibraryFilter,
      DuaLibraryFilterState
    >.internal(
      DuaLibraryFilter.new,
      name: r'duaLibraryFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$duaLibraryFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DuaLibraryFilter = AutoDisposeNotifier<DuaLibraryFilterState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
