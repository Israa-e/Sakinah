import 'package:equatable/equatable.dart';

import 'dhikr_item.dart';

/// Today's (or any day's) dhikr roll-up, consumed by Home and Journey.
class DhikrDaySummary extends Equatable {
  const DhikrDaySummary({
    required this.day,
    required this.totalCount,
    required this.completedCount,
    required this.itemCount,
  });

  /// Normalized with `AppDatabase.dayKey`.
  final DateTime day;

  /// Sum of every tasbeeh tap that day, across all items.
  final int totalCount;

  /// Items whose count reached their sourced target ([DhikrItem.targetCount]).
  final int completedCount;

  /// Number of items in the catalog.
  final int itemCount;

  double get completionRatio => itemCount == 0 ? 0 : completedCount / itemCount;

  bool get hasAnyDhikr => totalCount > 0;

  /// Builds a summary from raw per-key counts for [day].
  factory DhikrDaySummary.fromCounts({
    required DateTime day,
    required List<DhikrItem> catalog,
    required Map<String, int> counts,
  }) {
    var total = 0;
    for (final c in counts.values) {
      total += c;
    }
    final completed = catalog.where((i) => (counts[i.key] ?? 0) >= i.targetCount).length;
    return DhikrDaySummary(
      day: day,
      totalCount: total,
      completedCount: completed,
      itemCount: catalog.length,
    );
  }

  @override
  List<Object?> get props => [day, totalCount, completedCount, itemCount];
}

/// Progress within one category for a given day.
class DhikrCategoryProgress extends Equatable {
  const DhikrCategoryProgress({
    required this.category,
    required this.completed,
    required this.total,
  });

  final DhikrCategory? category;
  final int completed;
  final int total;

  double get ratio => total == 0 ? 0 : completed / total;
  bool get isComplete => total > 0 && completed >= total;

  @override
  List<Object?> get props => [category, completed, total];
}
