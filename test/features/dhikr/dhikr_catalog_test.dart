import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/features/dhikr/data/dhikr_catalog.dart';
import 'package:sakinah/features/dhikr/domain/dhikr_item.dart';

void main() {
  test('every catalog item carries a source reference and complete text', () {
    expect(dhikrCatalog, isNotEmpty);
    for (final item in dhikrCatalog) {
      expect(item.sourceReference.trim(), isNotEmpty, reason: item.key);
      expect(
        item.sourceReference,
        matches(RegExp(r'(Sahih|Sunan|Jami)')),
        reason: '${item.key} must cite a named collection',
      );
      expect(item.arabic.trim(), isNotEmpty, reason: item.key);
      expect(item.transliteration.trim(), isNotEmpty, reason: item.key);
      expect(item.translation.trim(), isNotEmpty, reason: item.key);
      expect(item.targetCount, greaterThan(0), reason: item.key);
    }
  });

  test('keys are unique and stable-looking', () {
    final keys = dhikrCatalog.map((i) => i.key).toList();
    expect(keys.toSet(), hasLength(keys.length));
    for (final key in keys) {
      expect(key, matches(RegExp(r'^[a-z0-9_]+$')));
    }
  });

  test('post-prayer set is 33 / 33 / 34 from Sahih Muslim 596, in order', () {
    final set = dhikrCatalog.where((i) => i.category == DhikrCategory.afterPrayer).toList();
    expect(set.map((i) => i.targetCount), [33, 33, 34]);
    expect(set.map((i) => i.sourceReference).toSet(), {'Sahih Muslim 596'});
  });

  test('every category has at least one item', () {
    for (final category in DhikrCategory.values) {
      expect(dhikrCatalog.any((i) => i.category == category), isTrue, reason: category.name);
    }
  });
}
