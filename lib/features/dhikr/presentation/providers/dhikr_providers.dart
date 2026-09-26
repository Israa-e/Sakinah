import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/app_database.dart';
import '../../../../core/storage/preferences_service.dart';
import '../../data/drift_dhikr_repository.dart';
import '../../domain/dhikr_item.dart';
import '../../domain/dhikr_models.dart';

export '../../domain/dhikr_item.dart';
export '../../domain/dhikr_models.dart';

part 'dhikr_providers.g.dart';

/// Injectable clock so tests can pin "today".
@Riverpod(keepAlive: true)
DateTime Function() dhikrClock(Ref ref) => DateTime.now;

/// The bundled, sourced catalog in display order.
@Riverpod(keepAlive: true)
List<DhikrItem> dhikrCatalog(Ref ref) => ref.watch(dhikrRepositoryProvider).catalog;

/// Catalog lookup by stable key; `null` for an unknown key.
@riverpod
DhikrItem? dhikrItem(Ref ref, String key) => ref.watch(dhikrRepositoryProvider).itemByKey(key);

/// Today's `dhikrKey -> count`.
@riverpod
Stream<Map<String, int>> todayDhikrCounts(Ref ref) {
  final today = AppDatabase.dayKey(ref.watch(dhikrClockProvider)());
  return ref.watch(dhikrRepositoryProvider).watchCountsForDay(today);
}

/// Today's roll-up (total taps, items completed / catalog size). Consumed by
/// Home's "Today's Dhikr" card and Journey.
@riverpod
Stream<DhikrDaySummary> todayDhikrSummary(Ref ref) {
  final today = AppDatabase.dayKey(ref.watch(dhikrClockProvider)());
  final repo = ref.watch(dhikrRepositoryProvider);
  return repo
      .watchCountsForDay(today)
      .map(
        (counts) => DhikrDaySummary.fromCounts(day: today, catalog: repo.catalog, counts: counts),
      );
}

/// Last 7 days (oldest first, today last).
@riverpod
Stream<List<DhikrDaySummary>> dhikrWeekSummaries(Ref ref) {
  final today = AppDatabase.dayKey(ref.watch(dhikrClockProvider)());
  final from = DateTime(today.year, today.month, today.day - 6);
  return ref.watch(dhikrRepositoryProvider).watchDailySummaries(from: from, to: today);
}

/// Today's progress for one category (`null` = whole catalog).
@riverpod
DhikrCategoryProgress dhikrCategoryProgress(Ref ref, DhikrCategory? category) {
  final counts = ref.watch(todayDhikrCountsProvider).valueOrNull ?? const <String, int>{};
  final items = ref
      .watch(dhikrCatalogProvider)
      .where((i) => category == null || i.category == category)
      .toList();
  final completed = items.where((i) => (counts[i.key] ?? 0) >= i.targetCount).length;
  return DhikrCategoryProgress(category: category, completed: completed, total: items.length);
}

/// The category that fits the time of day: morning adhkar until midday,
/// evening adhkar from mid-afternoon, otherwise the post-prayer set.
@riverpod
DhikrCategory suggestedDhikrCategory(Ref ref) {
  final hour = ref.watch(dhikrClockProvider)().hour;
  if (hour >= 3 && hour < 12) return DhikrCategory.morning;
  if (hour >= 15 && hour < 22) return DhikrCategory.evening;
  return DhikrCategory.afterPrayer;
}

/// Tab root view: adhkar/counter list vs. garden summary.
enum DhikrViewMode { counter, garden }

@riverpod
class DhikrView extends _$DhikrView {
  @override
  DhikrViewMode build() => DhikrViewMode.counter;

  void select(DhikrViewMode mode) => state = mode;
}

/// Selected category chip on the tab root (`null` = all).
@riverpod
class DhikrCategoryFilter extends _$DhikrCategoryFilter {
  @override
  DhikrCategory? build() => null;

  void select(DhikrCategory? category) => state = category;
}

/// Whether tasbeeh taps vibrate. Persisted in SharedPreferences.
@Riverpod(keepAlive: true)
class DhikrHaptics extends _$DhikrHaptics {
  static const prefsKey = 'dhikr.haptics_enabled';

  @override
  bool build() => ref.watch(sharedPreferencesProvider).getBool(prefsKey) ?? true;

  Future<void> toggle() async {
    state = !state;
    await ref.read(sharedPreferencesProvider).setBool(prefsKey, state);
  }
}

/// The counter target for one item: its sourced count by default, or the
/// user's chosen preset (33 / 99 / 100). Persisted per item.
@riverpod
class DhikrTarget extends _$DhikrTarget {
  static String prefsKey(String dhikrKey) => 'dhikr.target.$dhikrKey';

  @override
  int build(String dhikrKey) {
    final stored = ref.watch(sharedPreferencesProvider).getInt(prefsKey(dhikrKey));
    return stored ?? _defaultTarget;
  }

  int get _defaultTarget => ref.read(dhikrItemProvider(dhikrKey))?.targetCount ?? 33;

  Future<void> cycle() async {
    final opts = dhikrTargetOptions(_defaultTarget);
    final next = opts[(opts.indexOf(state) + 1) % opts.length];
    state = next;
    final prefs = ref.read(sharedPreferencesProvider);
    if (next == _defaultTarget) {
      await prefs.remove(prefsKey(dhikrKey));
    } else {
      await prefs.setInt(prefsKey(dhikrKey), next);
    }
  }
}

/// Counter target presets: the item's sourced count first, then 33 / 99 /
/// 100, without duplicates.
List<int> dhikrTargetOptions(int defaultTarget) => {defaultTarget, 33, 99, 100}.toList();
