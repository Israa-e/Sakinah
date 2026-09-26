import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/logging/app_logger.dart';
import '../../data/just_audio_engine.dart';
import '../../domain/quran_audio_engine.dart';
import '../../domain/quran_models.dart';

part 'quran_audio_controller.g.dart';

/// Playback engine. Override in tests with a fake.
@riverpod
QuranAudioEngine quranAudioEngine(Ref ref) {
  final engine = JustAudioEngine();
  ref.onDispose(engine.dispose);
  return engine;
}

class QuranAudioState {
  const QuranAudioState({
    this.queue = const [],
    this.index = -1,
    this.playing = false,
    this.loading = false,
    this.position = Duration.zero,
    this.duration,
    this.errorCount = 0,
  });

  final List<Ayah> queue;
  final int index;
  final bool playing;
  final bool loading;
  final Duration position;
  final Duration? duration;

  /// Incremented on every playback failure so the UI can show a snackbar.
  final int errorCount;

  Ayah? get current => index >= 0 && index < queue.length ? queue[index] : null;
  bool get isActive => current != null;
  bool get hasNext => index < queue.length - 1;
  bool get hasPrevious => index > 0;

  double get progress {
    final d = duration;
    if (d == null || d.inMilliseconds == 0) return 0;
    return (position.inMilliseconds / d.inMilliseconds).clamp(0, 1).toDouble();
  }

  QuranAudioState copyWith({
    List<Ayah>? queue,
    int? index,
    bool? playing,
    bool? loading,
    Duration? position,
    Duration? Function()? duration,
    int? errorCount,
  }) {
    return QuranAudioState(
      queue: queue ?? this.queue,
      index: index ?? this.index,
      playing: playing ?? this.playing,
      loading: loading ?? this.loading,
      position: position ?? this.position,
      duration: duration != null ? duration() : this.duration,
      errorCount: errorCount ?? this.errorCount,
    );
  }
}

/// Ayah-by-ayah recitation (Mishary Rashid Alafasy) with auto-advance.
/// Every engine call is guarded: a failing platform surfaces as
/// [QuranAudioState.errorCount] increments, never as a crash.
@riverpod
class QuranAudioController extends _$QuranAudioController {
  late QuranAudioEngine _engine;
  final _log = AppLogger.of('QuranAudioController');
  int _generation = 0;

  @override
  QuranAudioState build() {
    _engine = ref.watch(quranAudioEngineProvider);
    final sub = _engine.events.listen(_onEvent);
    ref.onDispose(() {
      unawaited(sub.cancel());
      unawaited(_guard(_engine.stop));
    });
    return const QuranAudioState();
  }

  /// Starts reciting [ayahs] from [ayahNumber] and continues to the end.
  Future<void> playFrom(List<Ayah> ayahs, int ayahNumber) async {
    final start = ayahs.indexWhere((a) => a.numberInSurah == ayahNumber);
    if (start < 0) return;
    state = state.copyWith(queue: ayahs);
    await _playIndex(start);
  }

  Future<void> togglePlayPause() async {
    if (!state.isActive) return;
    if (state.playing) {
      state = state.copyWith(playing: false);
      await _guard(_engine.pause);
    } else {
      state = state.copyWith(playing: true);
      final ok = await _guard(_engine.play);
      if (!ok) _fail();
    }
  }

  Future<void> next() async {
    if (state.hasNext) await _playIndex(state.index + 1);
  }

  Future<void> previous() async {
    if (state.hasPrevious) await _playIndex(state.index - 1);
  }

  Future<void> stop() async {
    _generation++;
    state = QuranAudioState(errorCount: state.errorCount);
    await _guard(_engine.stop);
  }

  Future<void> _playIndex(int index) async {
    final generation = ++_generation;
    state = state.copyWith(
      index: index,
      loading: true,
      playing: true,
      position: Duration.zero,
      duration: () => null,
    );
    final url = alafasyAyahUrl(state.queue[index].globalNumber);
    final loaded = await _guard(() => _engine.load(url));
    if (generation != _generation) return;
    if (!loaded) return _fail();
    final played = await _guard(_engine.play);
    if (generation != _generation) return;
    if (!played) return _fail();
    state = state.copyWith(loading: false);
  }

  void _fail() {
    _generation++;
    state = state.copyWith(playing: false, loading: false, errorCount: state.errorCount + 1);
  }

  void _onEvent(QuranAudioEvent event) {
    if (!state.isActive) return;
    switch (event) {
      case AudioPositionChanged(:final position):
        state = state.copyWith(position: position);
      case AudioDurationChanged(:final duration):
        state = state.copyWith(duration: () => duration);
      case AudioPlayingChanged(:final playing):
        if (!state.loading) state = state.copyWith(playing: playing);
      case AudioCompleted():
        if (state.loading) return;
        if (state.hasNext) {
          unawaited(_playIndex(state.index + 1));
        } else {
          unawaited(stop());
        }
      case AudioErrored():
        _fail();
    }
  }

  Future<bool> _guard(Future<void> Function() action) async {
    try {
      await action();
      return true;
    } on Object catch (e, st) {
      _log.warning('Audio call failed', e, st);
      return false;
    }
  }
}
