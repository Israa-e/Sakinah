// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$surahListHash() => r'd14461640f46283679b6a91f26064abf78453ecf';

/// All 114 surahs (bundled metadata — never needs the network).
///
/// Copied from [surahList].
@ProviderFor(surahList)
final surahListProvider = FutureProvider<List<Surah>>.internal(
  surahList,
  name: r'surahListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$surahListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SurahListRef = FutureProviderRef<List<Surah>>;
String _$surahByNumberHash() => r'dec6cfdf034b3769f85aa23f5ea3dc5c60e888ce';

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

/// See also [surahByNumber].
@ProviderFor(surahByNumber)
const surahByNumberProvider = SurahByNumberFamily();

/// See also [surahByNumber].
class SurahByNumberFamily extends Family<AsyncValue<Surah?>> {
  /// See also [surahByNumber].
  const SurahByNumberFamily();

  /// See also [surahByNumber].
  SurahByNumberProvider call(int number) {
    return SurahByNumberProvider(number);
  }

  @override
  SurahByNumberProvider getProviderOverride(
    covariant SurahByNumberProvider provider,
  ) {
    return call(provider.number);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'surahByNumberProvider';
}

/// See also [surahByNumber].
class SurahByNumberProvider extends AutoDisposeFutureProvider<Surah?> {
  /// See also [surahByNumber].
  SurahByNumberProvider(int number)
    : this._internal(
        (ref) => surahByNumber(ref as SurahByNumberRef, number),
        from: surahByNumberProvider,
        name: r'surahByNumberProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$surahByNumberHash,
        dependencies: SurahByNumberFamily._dependencies,
        allTransitiveDependencies:
            SurahByNumberFamily._allTransitiveDependencies,
        number: number,
      );

  SurahByNumberProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number,
  }) : super.internal();

  final int number;

  @override
  Override overrideWith(
    FutureOr<Surah?> Function(SurahByNumberRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SurahByNumberProvider._internal(
        (ref) => create(ref as SurahByNumberRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        number: number,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Surah?> createElement() {
    return _SurahByNumberProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SurahByNumberProvider && other.number == number;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SurahByNumberRef on AutoDisposeFutureProviderRef<Surah?> {
  /// The parameter `number` of this provider.
  int get number;
}

class _SurahByNumberProviderElement
    extends AutoDisposeFutureProviderElement<Surah?>
    with SurahByNumberRef {
  _SurahByNumberProviderElement(super.provider);

  @override
  int get number => (origin as SurahByNumberProvider).number;
}

String _$surahAyahsHash() => r'928758d0208fb008bb0373cf90f55dffa55f9c9e';

/// Ayahs of one surah. Errors carry the typed `AppFailure` from the
/// repository so the UI can say "offline and not saved" vs a generic error.
///
/// Copied from [surahAyahs].
@ProviderFor(surahAyahs)
const surahAyahsProvider = SurahAyahsFamily();

/// Ayahs of one surah. Errors carry the typed `AppFailure` from the
/// repository so the UI can say "offline and not saved" vs a generic error.
///
/// Copied from [surahAyahs].
class SurahAyahsFamily extends Family<AsyncValue<List<Ayah>>> {
  /// Ayahs of one surah. Errors carry the typed `AppFailure` from the
  /// repository so the UI can say "offline and not saved" vs a generic error.
  ///
  /// Copied from [surahAyahs].
  const SurahAyahsFamily();

  /// Ayahs of one surah. Errors carry the typed `AppFailure` from the
  /// repository so the UI can say "offline and not saved" vs a generic error.
  ///
  /// Copied from [surahAyahs].
  SurahAyahsProvider call(int surahNumber) {
    return SurahAyahsProvider(surahNumber);
  }

  @override
  SurahAyahsProvider getProviderOverride(
    covariant SurahAyahsProvider provider,
  ) {
    return call(provider.surahNumber);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'surahAyahsProvider';
}

/// Ayahs of one surah. Errors carry the typed `AppFailure` from the
/// repository so the UI can say "offline and not saved" vs a generic error.
///
/// Copied from [surahAyahs].
class SurahAyahsProvider extends AutoDisposeFutureProvider<List<Ayah>> {
  /// Ayahs of one surah. Errors carry the typed `AppFailure` from the
  /// repository so the UI can say "offline and not saved" vs a generic error.
  ///
  /// Copied from [surahAyahs].
  SurahAyahsProvider(int surahNumber)
    : this._internal(
        (ref) => surahAyahs(ref as SurahAyahsRef, surahNumber),
        from: surahAyahsProvider,
        name: r'surahAyahsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$surahAyahsHash,
        dependencies: SurahAyahsFamily._dependencies,
        allTransitiveDependencies: SurahAyahsFamily._allTransitiveDependencies,
        surahNumber: surahNumber,
      );

  SurahAyahsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surahNumber,
  }) : super.internal();

  final int surahNumber;

  @override
  Override overrideWith(
    FutureOr<List<Ayah>> Function(SurahAyahsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SurahAyahsProvider._internal(
        (ref) => create(ref as SurahAyahsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surahNumber: surahNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Ayah>> createElement() {
    return _SurahAyahsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SurahAyahsProvider && other.surahNumber == surahNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surahNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SurahAyahsRef on AutoDisposeFutureProviderRef<List<Ayah>> {
  /// The parameter `surahNumber` of this provider.
  int get surahNumber;
}

class _SurahAyahsProviderElement
    extends AutoDisposeFutureProviderElement<List<Ayah>>
    with SurahAyahsRef {
  _SurahAyahsProviderElement(super.provider);

  @override
  int get surahNumber => (origin as SurahAyahsProvider).surahNumber;
}

String _$bookmarkedAyahsHash() => r'2e7b5b920ff9a88c001a3e4c409e4b7e2833a845';

/// See also [bookmarkedAyahs].
@ProviderFor(bookmarkedAyahs)
const bookmarkedAyahsProvider = BookmarkedAyahsFamily();

/// See also [bookmarkedAyahs].
class BookmarkedAyahsFamily extends Family<AsyncValue<Set<int>>> {
  /// See also [bookmarkedAyahs].
  const BookmarkedAyahsFamily();

  /// See also [bookmarkedAyahs].
  BookmarkedAyahsProvider call(int surahNumber) {
    return BookmarkedAyahsProvider(surahNumber);
  }

  @override
  BookmarkedAyahsProvider getProviderOverride(
    covariant BookmarkedAyahsProvider provider,
  ) {
    return call(provider.surahNumber);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bookmarkedAyahsProvider';
}

/// See also [bookmarkedAyahs].
class BookmarkedAyahsProvider extends AutoDisposeStreamProvider<Set<int>> {
  /// See also [bookmarkedAyahs].
  BookmarkedAyahsProvider(int surahNumber)
    : this._internal(
        (ref) => bookmarkedAyahs(ref as BookmarkedAyahsRef, surahNumber),
        from: bookmarkedAyahsProvider,
        name: r'bookmarkedAyahsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$bookmarkedAyahsHash,
        dependencies: BookmarkedAyahsFamily._dependencies,
        allTransitiveDependencies:
            BookmarkedAyahsFamily._allTransitiveDependencies,
        surahNumber: surahNumber,
      );

  BookmarkedAyahsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surahNumber,
  }) : super.internal();

  final int surahNumber;

  @override
  Override overrideWith(
    Stream<Set<int>> Function(BookmarkedAyahsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BookmarkedAyahsProvider._internal(
        (ref) => create(ref as BookmarkedAyahsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surahNumber: surahNumber,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Set<int>> createElement() {
    return _BookmarkedAyahsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookmarkedAyahsProvider && other.surahNumber == surahNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surahNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BookmarkedAyahsRef on AutoDisposeStreamProviderRef<Set<int>> {
  /// The parameter `surahNumber` of this provider.
  int get surahNumber;
}

class _BookmarkedAyahsProviderElement
    extends AutoDisposeStreamProviderElement<Set<int>>
    with BookmarkedAyahsRef {
  _BookmarkedAyahsProviderElement(super.provider);

  @override
  int get surahNumber => (origin as BookmarkedAyahsProvider).surahNumber;
}

String _$quranBookmarksHash() => r'9e6f208ab4cd610cb702f358c0da5d265cb3ea82';

/// See also [quranBookmarks].
@ProviderFor(quranBookmarks)
final quranBookmarksProvider =
    AutoDisposeStreamProvider<List<QuranBookmark>>.internal(
      quranBookmarks,
      name: r'quranBookmarksProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$quranBookmarksHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuranBookmarksRef = AutoDisposeStreamProviderRef<List<QuranBookmark>>;
String _$quranReadingProgressHash() =>
    r'3f6fea98dc9fcc724ea9ee83c56e9aaea4c9630c';

/// Latest "continue reading" position (also what Home's card reflects).
///
/// Copied from [quranReadingProgress].
@ProviderFor(quranReadingProgress)
final quranReadingProgressProvider =
    AutoDisposeStreamProvider<QuranReadingProgress?>.internal(
      quranReadingProgress,
      name: r'quranReadingProgressProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$quranReadingProgressHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuranReadingProgressRef =
    AutoDisposeStreamProviderRef<QuranReadingProgress?>;
String _$mushafPageHash() => r'05ab8df2694265ce0fb37c1b0eb2d102ac9e39c3';

/// One mushaf page: the ayahs of the 1–2 surahs it spans, loaded through the
/// repository's per-surah cache (fetched once, then available offline).
/// Errors carry the repository's `AppFailure`.
///
/// Copied from [mushafPage].
@ProviderFor(mushafPage)
const mushafPageProvider = MushafPageFamily();

/// One mushaf page: the ayahs of the 1–2 surahs it spans, loaded through the
/// repository's per-surah cache (fetched once, then available offline).
/// Errors carry the repository's `AppFailure`.
///
/// Copied from [mushafPage].
class MushafPageFamily extends Family<AsyncValue<MushafPageContent>> {
  /// One mushaf page: the ayahs of the 1–2 surahs it spans, loaded through the
  /// repository's per-surah cache (fetched once, then available offline).
  /// Errors carry the repository's `AppFailure`.
  ///
  /// Copied from [mushafPage].
  const MushafPageFamily();

  /// One mushaf page: the ayahs of the 1–2 surahs it spans, loaded through the
  /// repository's per-surah cache (fetched once, then available offline).
  /// Errors carry the repository's `AppFailure`.
  ///
  /// Copied from [mushafPage].
  MushafPageProvider call(int page) {
    return MushafPageProvider(page);
  }

  @override
  MushafPageProvider getProviderOverride(
    covariant MushafPageProvider provider,
  ) {
    return call(provider.page);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mushafPageProvider';
}

/// One mushaf page: the ayahs of the 1–2 surahs it spans, loaded through the
/// repository's per-surah cache (fetched once, then available offline).
/// Errors carry the repository's `AppFailure`.
///
/// Copied from [mushafPage].
class MushafPageProvider extends AutoDisposeFutureProvider<MushafPageContent> {
  /// One mushaf page: the ayahs of the 1–2 surahs it spans, loaded through the
  /// repository's per-surah cache (fetched once, then available offline).
  /// Errors carry the repository's `AppFailure`.
  ///
  /// Copied from [mushafPage].
  MushafPageProvider(int page)
    : this._internal(
        (ref) => mushafPage(ref as MushafPageRef, page),
        from: mushafPageProvider,
        name: r'mushafPageProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$mushafPageHash,
        dependencies: MushafPageFamily._dependencies,
        allTransitiveDependencies: MushafPageFamily._allTransitiveDependencies,
        page: page,
      );

  MushafPageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final int page;

  @override
  Override overrideWith(
    FutureOr<MushafPageContent> Function(MushafPageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MushafPageProvider._internal(
        (ref) => create(ref as MushafPageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MushafPageContent> createElement() {
    return _MushafPageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MushafPageProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MushafPageRef on AutoDisposeFutureProviderRef<MushafPageContent> {
  /// The parameter `page` of this provider.
  int get page;
}

class _MushafPageProviderElement
    extends AutoDisposeFutureProviderElement<MushafPageContent>
    with MushafPageRef {
  _MushafPageProviderElement(super.provider);

  @override
  int get page => (origin as MushafPageProvider).page;
}

String _$ayahTafsirHash() => r'11ad8c7f4e497529724abd752396e8a2073da50e';

/// Tafsir al-Muyassar for one ayah (see [TafsirSource]); errors carry the
/// typed `AppFailure`.
///
/// Copied from [ayahTafsir].
@ProviderFor(ayahTafsir)
const ayahTafsirProvider = AyahTafsirFamily();

/// Tafsir al-Muyassar for one ayah (see [TafsirSource]); errors carry the
/// typed `AppFailure`.
///
/// Copied from [ayahTafsir].
class AyahTafsirFamily extends Family<AsyncValue<String>> {
  /// Tafsir al-Muyassar for one ayah (see [TafsirSource]); errors carry the
  /// typed `AppFailure`.
  ///
  /// Copied from [ayahTafsir].
  const AyahTafsirFamily();

  /// Tafsir al-Muyassar for one ayah (see [TafsirSource]); errors carry the
  /// typed `AppFailure`.
  ///
  /// Copied from [ayahTafsir].
  AyahTafsirProvider call(int surah, int ayah) {
    return AyahTafsirProvider(surah, ayah);
  }

  @override
  AyahTafsirProvider getProviderOverride(
    covariant AyahTafsirProvider provider,
  ) {
    return call(provider.surah, provider.ayah);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ayahTafsirProvider';
}

/// Tafsir al-Muyassar for one ayah (see [TafsirSource]); errors carry the
/// typed `AppFailure`.
///
/// Copied from [ayahTafsir].
class AyahTafsirProvider extends AutoDisposeFutureProvider<String> {
  /// Tafsir al-Muyassar for one ayah (see [TafsirSource]); errors carry the
  /// typed `AppFailure`.
  ///
  /// Copied from [ayahTafsir].
  AyahTafsirProvider(int surah, int ayah)
    : this._internal(
        (ref) => ayahTafsir(ref as AyahTafsirRef, surah, ayah),
        from: ayahTafsirProvider,
        name: r'ayahTafsirProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$ayahTafsirHash,
        dependencies: AyahTafsirFamily._dependencies,
        allTransitiveDependencies: AyahTafsirFamily._allTransitiveDependencies,
        surah: surah,
        ayah: ayah,
      );

  AyahTafsirProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surah,
    required this.ayah,
  }) : super.internal();

  final int surah;
  final int ayah;

  @override
  Override overrideWith(
    FutureOr<String> Function(AyahTafsirRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AyahTafsirProvider._internal(
        (ref) => create(ref as AyahTafsirRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surah: surah,
        ayah: ayah,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _AyahTafsirProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AyahTafsirProvider &&
        other.surah == surah &&
        other.ayah == ayah;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surah.hashCode);
    hash = _SystemHash.combine(hash, ayah.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AyahTafsirRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `surah` of this provider.
  int get surah;

  /// The parameter `ayah` of this provider.
  int get ayah;
}

class _AyahTafsirProviderElement
    extends AutoDisposeFutureProviderElement<String>
    with AyahTafsirRef {
  _AyahTafsirProviderElement(super.provider);

  @override
  int get surah => (origin as AyahTafsirProvider).surah;
  @override
  int get ayah => (origin as AyahTafsirProvider).ayah;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
