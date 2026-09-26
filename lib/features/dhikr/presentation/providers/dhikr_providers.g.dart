// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dhikr_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dhikrClockHash() => r'7f5e2a3a123e16833598cfd3e3765049da2ba5e8';

/// Injectable clock so tests can pin "today".
///
/// Copied from [dhikrClock].
@ProviderFor(dhikrClock)
final dhikrClockProvider = Provider<DateTime Function()>.internal(
  dhikrClock,
  name: r'dhikrClockProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dhikrClockHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DhikrClockRef = ProviderRef<DateTime Function()>;
String _$dhikrCatalogHash() => r'fa0698584509b9370639342c578e3c531500738b';

/// The bundled, sourced catalog in display order.
///
/// Copied from [dhikrCatalog].
@ProviderFor(dhikrCatalog)
final dhikrCatalogProvider = Provider<List<DhikrItem>>.internal(
  dhikrCatalog,
  name: r'dhikrCatalogProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dhikrCatalogHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DhikrCatalogRef = ProviderRef<List<DhikrItem>>;
String _$dhikrItemHash() => r'10abdaf2760fd69137d0fe339b82057a04f30cbc';

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

/// Catalog lookup by stable key; `null` for an unknown key.
///
/// Copied from [dhikrItem].
@ProviderFor(dhikrItem)
const dhikrItemProvider = DhikrItemFamily();

/// Catalog lookup by stable key; `null` for an unknown key.
///
/// Copied from [dhikrItem].
class DhikrItemFamily extends Family<DhikrItem?> {
  /// Catalog lookup by stable key; `null` for an unknown key.
  ///
  /// Copied from [dhikrItem].
  const DhikrItemFamily();

  /// Catalog lookup by stable key; `null` for an unknown key.
  ///
  /// Copied from [dhikrItem].
  DhikrItemProvider call(String key) {
    return DhikrItemProvider(key);
  }

  @override
  DhikrItemProvider getProviderOverride(covariant DhikrItemProvider provider) {
    return call(provider.key);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dhikrItemProvider';
}

/// Catalog lookup by stable key; `null` for an unknown key.
///
/// Copied from [dhikrItem].
class DhikrItemProvider extends AutoDisposeProvider<DhikrItem?> {
  /// Catalog lookup by stable key; `null` for an unknown key.
  ///
  /// Copied from [dhikrItem].
  DhikrItemProvider(String key)
    : this._internal(
        (ref) => dhikrItem(ref as DhikrItemRef, key),
        from: dhikrItemProvider,
        name: r'dhikrItemProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dhikrItemHash,
        dependencies: DhikrItemFamily._dependencies,
        allTransitiveDependencies: DhikrItemFamily._allTransitiveDependencies,
        key: key,
      );

  DhikrItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final String key;

  @override
  Override overrideWith(DhikrItem? Function(DhikrItemRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: DhikrItemProvider._internal(
        (ref) => create(ref as DhikrItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<DhikrItem?> createElement() {
    return _DhikrItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DhikrItemProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DhikrItemRef on AutoDisposeProviderRef<DhikrItem?> {
  /// The parameter `key` of this provider.
  String get key;
}

class _DhikrItemProviderElement extends AutoDisposeProviderElement<DhikrItem?>
    with DhikrItemRef {
  _DhikrItemProviderElement(super.provider);

  @override
  String get key => (origin as DhikrItemProvider).key;
}

String _$todayDhikrCountsHash() => r'ead8e94082db84d1cf4d74941af9657ff79f407a';

/// Today's `dhikrKey -> count`.
///
/// Copied from [todayDhikrCounts].
@ProviderFor(todayDhikrCounts)
final todayDhikrCountsProvider =
    AutoDisposeStreamProvider<Map<String, int>>.internal(
      todayDhikrCounts,
      name: r'todayDhikrCountsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayDhikrCountsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayDhikrCountsRef = AutoDisposeStreamProviderRef<Map<String, int>>;
String _$todayDhikrSummaryHash() => r'9fe83811aac956ba8b09e21d4ee61c90891d0961';

/// Today's roll-up (total taps, items completed / catalog size). Consumed by
/// Home's "Today's Dhikr" card and Journey.
///
/// Copied from [todayDhikrSummary].
@ProviderFor(todayDhikrSummary)
final todayDhikrSummaryProvider =
    AutoDisposeStreamProvider<DhikrDaySummary>.internal(
      todayDhikrSummary,
      name: r'todayDhikrSummaryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayDhikrSummaryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayDhikrSummaryRef = AutoDisposeStreamProviderRef<DhikrDaySummary>;
String _$dhikrWeekSummariesHash() =>
    r'133016ce6b058f880411d5231e48a8eaf37fdea8';

/// Last 7 days (oldest first, today last).
///
/// Copied from [dhikrWeekSummaries].
@ProviderFor(dhikrWeekSummaries)
final dhikrWeekSummariesProvider =
    AutoDisposeStreamProvider<List<DhikrDaySummary>>.internal(
      dhikrWeekSummaries,
      name: r'dhikrWeekSummariesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dhikrWeekSummariesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DhikrWeekSummariesRef =
    AutoDisposeStreamProviderRef<List<DhikrDaySummary>>;
String _$dhikrCategoryProgressHash() =>
    r'4e9ba8c604c249ed9e30b56d93f95461f5314409';

/// Today's progress for one category (`null` = whole catalog).
///
/// Copied from [dhikrCategoryProgress].
@ProviderFor(dhikrCategoryProgress)
const dhikrCategoryProgressProvider = DhikrCategoryProgressFamily();

/// Today's progress for one category (`null` = whole catalog).
///
/// Copied from [dhikrCategoryProgress].
class DhikrCategoryProgressFamily extends Family<DhikrCategoryProgress> {
  /// Today's progress for one category (`null` = whole catalog).
  ///
  /// Copied from [dhikrCategoryProgress].
  const DhikrCategoryProgressFamily();

  /// Today's progress for one category (`null` = whole catalog).
  ///
  /// Copied from [dhikrCategoryProgress].
  DhikrCategoryProgressProvider call(DhikrCategory? category) {
    return DhikrCategoryProgressProvider(category);
  }

  @override
  DhikrCategoryProgressProvider getProviderOverride(
    covariant DhikrCategoryProgressProvider provider,
  ) {
    return call(provider.category);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dhikrCategoryProgressProvider';
}

/// Today's progress for one category (`null` = whole catalog).
///
/// Copied from [dhikrCategoryProgress].
class DhikrCategoryProgressProvider
    extends AutoDisposeProvider<DhikrCategoryProgress> {
  /// Today's progress for one category (`null` = whole catalog).
  ///
  /// Copied from [dhikrCategoryProgress].
  DhikrCategoryProgressProvider(DhikrCategory? category)
    : this._internal(
        (ref) =>
            dhikrCategoryProgress(ref as DhikrCategoryProgressRef, category),
        from: dhikrCategoryProgressProvider,
        name: r'dhikrCategoryProgressProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dhikrCategoryProgressHash,
        dependencies: DhikrCategoryProgressFamily._dependencies,
        allTransitiveDependencies:
            DhikrCategoryProgressFamily._allTransitiveDependencies,
        category: category,
      );

  DhikrCategoryProgressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final DhikrCategory? category;

  @override
  Override overrideWith(
    DhikrCategoryProgress Function(DhikrCategoryProgressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DhikrCategoryProgressProvider._internal(
        (ref) => create(ref as DhikrCategoryProgressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<DhikrCategoryProgress> createElement() {
    return _DhikrCategoryProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DhikrCategoryProgressProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DhikrCategoryProgressRef
    on AutoDisposeProviderRef<DhikrCategoryProgress> {
  /// The parameter `category` of this provider.
  DhikrCategory? get category;
}

class _DhikrCategoryProgressProviderElement
    extends AutoDisposeProviderElement<DhikrCategoryProgress>
    with DhikrCategoryProgressRef {
  _DhikrCategoryProgressProviderElement(super.provider);

  @override
  DhikrCategory? get category =>
      (origin as DhikrCategoryProgressProvider).category;
}

String _$suggestedDhikrCategoryHash() =>
    r'8dc9fb4ebd397c680253d8736bfdd6618bd026a1';

/// The category that fits the time of day: morning adhkar until midday,
/// evening adhkar from mid-afternoon, otherwise the post-prayer set.
///
/// Copied from [suggestedDhikrCategory].
@ProviderFor(suggestedDhikrCategory)
final suggestedDhikrCategoryProvider =
    AutoDisposeProvider<DhikrCategory>.internal(
      suggestedDhikrCategory,
      name: r'suggestedDhikrCategoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$suggestedDhikrCategoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SuggestedDhikrCategoryRef = AutoDisposeProviderRef<DhikrCategory>;
String _$dhikrViewHash() => r'53484c0171bd2090ad0b955adc02529df875de3c';

/// See also [DhikrView].
@ProviderFor(DhikrView)
final dhikrViewProvider =
    AutoDisposeNotifierProvider<DhikrView, DhikrViewMode>.internal(
      DhikrView.new,
      name: r'dhikrViewProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dhikrViewHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DhikrView = AutoDisposeNotifier<DhikrViewMode>;
String _$dhikrCategoryFilterHash() =>
    r'e36d9b9ace4de1e2fb9919e377e0f8955d201495';

/// Selected category chip on the tab root (`null` = all).
///
/// Copied from [DhikrCategoryFilter].
@ProviderFor(DhikrCategoryFilter)
final dhikrCategoryFilterProvider =
    AutoDisposeNotifierProvider<DhikrCategoryFilter, DhikrCategory?>.internal(
      DhikrCategoryFilter.new,
      name: r'dhikrCategoryFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dhikrCategoryFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DhikrCategoryFilter = AutoDisposeNotifier<DhikrCategory?>;
String _$dhikrHapticsHash() => r'5b88b3333f8f2c75a4c13706471e28644a80a458';

/// Whether tasbeeh taps vibrate. Persisted in SharedPreferences.
///
/// Copied from [DhikrHaptics].
@ProviderFor(DhikrHaptics)
final dhikrHapticsProvider = NotifierProvider<DhikrHaptics, bool>.internal(
  DhikrHaptics.new,
  name: r'dhikrHapticsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dhikrHapticsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DhikrHaptics = Notifier<bool>;
String _$dhikrTargetHash() => r'f34fb3fbb7ae255fd38af1f213d399e4bfd6685f';

abstract class _$DhikrTarget extends BuildlessAutoDisposeNotifier<int> {
  late final String dhikrKey;

  int build(String dhikrKey);
}

/// The counter target for one item: its sourced count by default, or the
/// user's chosen preset (33 / 99 / 100). Persisted per item.
///
/// Copied from [DhikrTarget].
@ProviderFor(DhikrTarget)
const dhikrTargetProvider = DhikrTargetFamily();

/// The counter target for one item: its sourced count by default, or the
/// user's chosen preset (33 / 99 / 100). Persisted per item.
///
/// Copied from [DhikrTarget].
class DhikrTargetFamily extends Family<int> {
  /// The counter target for one item: its sourced count by default, or the
  /// user's chosen preset (33 / 99 / 100). Persisted per item.
  ///
  /// Copied from [DhikrTarget].
  const DhikrTargetFamily();

  /// The counter target for one item: its sourced count by default, or the
  /// user's chosen preset (33 / 99 / 100). Persisted per item.
  ///
  /// Copied from [DhikrTarget].
  DhikrTargetProvider call(String dhikrKey) {
    return DhikrTargetProvider(dhikrKey);
  }

  @override
  DhikrTargetProvider getProviderOverride(
    covariant DhikrTargetProvider provider,
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
  String? get name => r'dhikrTargetProvider';
}

/// The counter target for one item: its sourced count by default, or the
/// user's chosen preset (33 / 99 / 100). Persisted per item.
///
/// Copied from [DhikrTarget].
class DhikrTargetProvider
    extends AutoDisposeNotifierProviderImpl<DhikrTarget, int> {
  /// The counter target for one item: its sourced count by default, or the
  /// user's chosen preset (33 / 99 / 100). Persisted per item.
  ///
  /// Copied from [DhikrTarget].
  DhikrTargetProvider(String dhikrKey)
    : this._internal(
        () => DhikrTarget()..dhikrKey = dhikrKey,
        from: dhikrTargetProvider,
        name: r'dhikrTargetProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dhikrTargetHash,
        dependencies: DhikrTargetFamily._dependencies,
        allTransitiveDependencies: DhikrTargetFamily._allTransitiveDependencies,
        dhikrKey: dhikrKey,
      );

  DhikrTargetProvider._internal(
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
  int runNotifierBuild(covariant DhikrTarget notifier) {
    return notifier.build(dhikrKey);
  }

  @override
  Override overrideWith(DhikrTarget Function() create) {
    return ProviderOverride(
      origin: this,
      override: DhikrTargetProvider._internal(
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
  AutoDisposeNotifierProviderElement<DhikrTarget, int> createElement() {
    return _DhikrTargetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DhikrTargetProvider && other.dhikrKey == dhikrKey;
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
mixin DhikrTargetRef on AutoDisposeNotifierProviderRef<int> {
  /// The parameter `dhikrKey` of this provider.
  String get dhikrKey;
}

class _DhikrTargetProviderElement
    extends AutoDisposeNotifierProviderElement<DhikrTarget, int>
    with DhikrTargetRef {
  _DhikrTargetProviderElement(super.provider);

  @override
  String get dhikrKey => (origin as DhikrTargetProvider).dhikrKey;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
