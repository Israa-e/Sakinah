import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/app_database.dart';
import '../../data/drift_dhikr_repository.dart';
import '../../domain/dhikr_repository.dart';
import '../providers/dhikr_providers.dart';

part 'dhikr_counter_controller.g.dart';

class DhikrCounterState extends Equatable {
  const DhikrCounterState({required this.count, required this.loaded, required this.sessionTaps});

  /// Today's count for the item (persisted value + taps this session).
  final int count;

  /// Whether the stored count has been read yet.
  final bool loaded;

  /// Taps since the screen opened — undo is only offered for those.
  final int sessionTaps;

  bool get canUndo => sessionTaps > 0 && count > 0;

  DhikrCounterState copyWith({int? count, bool? loaded, int? sessionTaps}) {
    return DhikrCounterState(
      count: count ?? this.count,
      loaded: loaded ?? this.loaded,
      sessionTaps: sessionTaps ?? this.sessionTaps,
    );
  }

  @override
  List<Object?> get props => [count, loaded, sessionTaps];
}

/// Owns the live tasbeeh count for one item. Taps update memory instantly and
/// are written to Drift after a short debounce (and on dispose), so rapid
/// tapping never waits on the database.
@riverpod
class DhikrCounterController extends _$DhikrCounterController {
  static const writeDelay = Duration(milliseconds: 400);

  Timer? _debounce;
  late DhikrRepository _repo;
  late DateTime _day;
  int _latest = 0;
  bool _dirty = false;
  bool _disposed = false;

  @override
  DhikrCounterState build(String dhikrKey) {
    _repo = ref.watch(dhikrRepositoryProvider);
    _day = AppDatabase.dayKey(ref.watch(dhikrClockProvider)());
    ref.onDispose(() {
      _disposed = true;
      _debounce?.cancel();
      if (_dirty) unawaited(_repo.setCount(dhikrKey, _day, _latest));
    });
    unawaited(_load());
    return const DhikrCounterState(count: 0, loaded: false, sessionTaps: 0);
  }

  Future<void> _load() async {
    final stored = await _repo.countFor(dhikrKey, _day);
    if (_disposed) return;
    // Taps made while loading are added on top of the stored value.
    _set(state.copyWith(count: stored + state.count, loaded: true), persist: state.count > 0);
  }

  void _set(DhikrCounterState next, {bool persist = true}) {
    state = next;
    _latest = next.count;
    // Never write before the stored value is known — it would overwrite it.
    if (!persist || !next.loaded) return;
    _dirty = true;
    _debounce?.cancel();
    _debounce = Timer(writeDelay, flush);
  }

  /// Adds one. Returns `true` when this tap is the one that reaches [target].
  bool increment(int target) {
    final next = state.count + 1;
    _set(state.copyWith(count: next, sessionTaps: state.sessionTaps + 1));
    return next == target;
  }

  void undo() {
    if (!state.canUndo) return;
    _set(state.copyWith(count: state.count - 1, sessionTaps: state.sessionTaps - 1));
  }

  Future<void> reset() async {
    _debounce?.cancel();
    state = state.copyWith(count: 0, sessionTaps: 0);
    _latest = 0;
    _dirty = false;
    await _repo.reset(dhikrKey, _day);
  }

  /// Writes the pending count now.
  Future<void> flush() async {
    _debounce?.cancel();
    if (!_dirty) return;
    _dirty = false;
    await _repo.setCount(dhikrKey, _day, _latest);
  }
}
