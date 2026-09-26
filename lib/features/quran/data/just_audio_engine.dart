import 'dart:async';

import 'package:just_audio/just_audio.dart';

import '../../../core/logging/app_logger.dart';
import '../domain/quran_audio_engine.dart';

/// [QuranAudioEngine] backed by `just_audio`. The player is created lazily on
/// first [load] so merely opening the reader never touches the platform
/// plugin (which has no backend on Linux desktop).
class JustAudioEngine implements QuranAudioEngine {
  final _events = StreamController<QuranAudioEvent>.broadcast();
  final _subs = <StreamSubscription<Object?>>[];
  final _log = AppLogger.of('QuranAudio');
  AudioPlayer? _player;

  @override
  Stream<QuranAudioEvent> get events => _events.stream;

  AudioPlayer _ensurePlayer() {
    final existing = _player;
    if (existing != null) return existing;
    final player = AudioPlayer();
    _subs
      ..add(player.positionStream.listen((p) => _emit(AudioPositionChanged(p))))
      ..add(player.durationStream.listen((d) => _emit(AudioDurationChanged(d))))
      ..add(player.playingStream.listen((p) => _emit(AudioPlayingChanged(p))))
      ..add(
        player.processingStateStream.listen(
          (s) {
            if (s == ProcessingState.completed) _emit(const AudioCompleted());
          },
          onError: (Object e, StackTrace st) {
            _log.warning('Playback error', e, st);
            _emit(AudioErrored(e));
          },
        ),
      );
    return _player = player;
  }

  void _emit(QuranAudioEvent e) {
    if (!_events.isClosed) _events.add(e);
  }

  @override
  Future<void> load(String url) async {
    await _ensurePlayer().setUrl(url);
  }

  @override
  Future<void> play() async {
    final player = _ensurePlayer();
    // `play()` completes only when playback stops, so don't await it —
    // forward late failures as events instead.
    unawaited(
      player.play().catchError((Object e, StackTrace st) {
        _log.warning('play() failed', e, st);
        _emit(AudioErrored(e));
      }),
    );
  }

  @override
  Future<void> pause() async => _player?.pause();

  @override
  Future<void> stop() async => _player?.stop();

  @override
  Future<void> dispose() async {
    for (final s in _subs) {
      await s.cancel();
    }
    _subs.clear();
    try {
      await _player?.dispose();
    } on Object catch (e) {
      _log.fine('dispose failed', e);
    }
    _player = null;
    await _events.close();
  }
}
