// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_audio_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quranAudioEngineHash() => r'9e2a10026084cb521a373117dab4b2eb82e8437f';

/// Playback engine. Override in tests with a fake.
///
/// Copied from [quranAudioEngine].
@ProviderFor(quranAudioEngine)
final quranAudioEngineProvider = AutoDisposeProvider<QuranAudioEngine>.internal(
  quranAudioEngine,
  name: r'quranAudioEngineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quranAudioEngineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuranAudioEngineRef = AutoDisposeProviderRef<QuranAudioEngine>;
String _$quranAudioControllerHash() =>
    r'a92856a49bba206e3f0222e12e6ed22cc96decbb';

/// Ayah-by-ayah recitation (Mishary Rashid Alafasy) with auto-advance.
/// Every engine call is guarded: a failing platform surfaces as
/// [QuranAudioState.errorCount] increments, never as a crash.
///
/// Copied from [QuranAudioController].
@ProviderFor(QuranAudioController)
final quranAudioControllerProvider =
    AutoDisposeNotifierProvider<QuranAudioController, QuranAudioState>.internal(
      QuranAudioController.new,
      name: r'quranAudioControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$quranAudioControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$QuranAudioController = AutoDisposeNotifier<QuranAudioState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
