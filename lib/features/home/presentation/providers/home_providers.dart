import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/drift_home_repository.dart';
import '../../domain/home_models.dart';

part 'home_providers.g.dart';

@riverpod
Stream<QuranProgressInfo?> quranProgress(Ref ref) {
  return ref.watch(homeRepositoryProvider).watchQuranProgress();
}

@riverpod
Stream<DailyDeed> dailyDeed(Ref ref) {
  final today = DateTime.now();
  return ref.watch(homeRepositoryProvider).watchDailyDeed(today);
}

/// Fixed until the Dhikr feature (Phase 5) ships real rotation — see
/// [DhikrPreview] doc comment on why the content itself is safe to hardcode.
@riverpod
DhikrPreview todaysDhikr(Ref ref) {
  return const DhikrPreview(arabicText: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', targetCount: 33);
}
