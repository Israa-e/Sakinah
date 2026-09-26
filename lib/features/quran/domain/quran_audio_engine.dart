/// Playback events emitted by a [QuranAudioEngine].
sealed class QuranAudioEvent {
  const QuranAudioEvent();
}

final class AudioPositionChanged extends QuranAudioEvent {
  const AudioPositionChanged(this.position);
  final Duration position;
}

final class AudioDurationChanged extends QuranAudioEvent {
  const AudioDurationChanged(this.duration);
  final Duration? duration;
}

final class AudioPlayingChanged extends QuranAudioEvent {
  const AudioPlayingChanged(this.playing);
  final bool playing;
}

final class AudioCompleted extends QuranAudioEvent {
  const AudioCompleted();
}

final class AudioErrored extends QuranAudioEvent {
  const AudioErrored(this.error);
  final Object error;
}

/// Minimal playback surface so the reader can be tested with a fake and so
/// platform failures (e.g. no just_audio backend on Linux) stay contained.
/// Implementations may throw from [load]/[play]; callers must catch.
abstract interface class QuranAudioEngine {
  Stream<QuranAudioEvent> get events;

  Future<void> load(String url);

  Future<void> play();

  Future<void> pause();

  Future<void> stop();

  Future<void> dispose();
}

/// Per-ayah recitation by Mishary Rashid Alafasy (128 kbps).
String alafasyAyahUrl(int globalAyahNumber) =>
    'https://cdn.islamic.network/quran/audio/128/ar.alafasy/$globalAyahNumber.mp3';
