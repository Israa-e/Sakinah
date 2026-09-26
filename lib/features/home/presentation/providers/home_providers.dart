import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../dhikr/presentation/providers/dhikr_providers.dart';
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

/// The dhikr Home suggests right now: the first unfinished item of the
/// time-of-day category (morning / evening / after prayer), falling back to
/// that category's first item once all are done. Text, count and source all
/// come from the Dhikr feature's sourced catalog and today's `DhikrLogs`.
@riverpod
DhikrPreview todaysDhikr(Ref ref) {
  final category = ref.watch(suggestedDhikrCategoryProvider);
  final counts = ref.watch(todayDhikrCountsProvider).valueOrNull ?? const <String, int>{};
  final items = ref.watch(dhikrCatalogProvider).where((i) => i.category == category).toList();
  final item = items.firstWhere(
    (i) => (counts[i.key] ?? 0) < i.targetCount,
    orElse: () => items.first,
  );
  return DhikrPreview(
    key: item.key,
    arabicText: item.arabic,
    targetCount: item.targetCount,
    reference: item.sourceReference,
    countToday: counts[item.key] ?? 0,
  );
}
