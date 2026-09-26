import 'package:equatable/equatable.dart';

/// When a dhikr is traditionally said. Order here is the display order.
enum DhikrCategory {
  afterPrayer,
  morning,
  evening,
  anytime;

  /// Whether the items of this category are recited as one flowing set (the
  /// counter offers "Next" to move item to item), e.g. the 33/33/34 tasbih
  /// after prayer.
  bool get isSequence => this != DhikrCategory.anytime;
}

/// One bundled, sourced remembrance.
///
/// Religious text is never user-generated or fetched at random: every item is
/// part of the curated catalog and carries the exact collection + number it
/// comes from in [sourceReference].
class DhikrItem extends Equatable {
  const DhikrItem({
    required this.key,
    required this.category,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    required this.sourceReference,
    required this.targetCount,
  });

  /// Stable id, persisted in `DhikrLogs.dhikrKey`. Never rename.
  final String key;
  final DhikrCategory category;

  /// Fully vowelled Arabic text.
  final String arabic;
  final String transliteration;

  /// English meaning.
  final String translation;

  /// Mandatory hadith reference, e.g. `Sahih Muslim 596`.
  final String sourceReference;

  /// The count stated in the source (default counter target).
  final int targetCount;

  @override
  List<Object?> get props => [key];
}
