import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/features/dhikr/data/drift_dhikr_repository.dart';

import '../../fakes/test_database.dart';

void main() {
  late AppDatabase db;
  late DriftDhikrRepository repo;
  final today = DateTime(2026, 9, 24, 15, 30);

  setUp(() {
    db = openTestDatabase();
    repo = DriftDhikrRepository(db);
  });

  tearDown(() => db.close());

  test('increment, setCount and reset persist per key and day', () async {
    await repo.increment('astaghfirullah', today);
    await repo.increment('astaghfirullah', today, by: 4);
    expect(await repo.countFor('astaghfirullah', today), 5);
    // Same calendar day at a different time maps to the same row.
    expect(await repo.countFor('astaghfirullah', DateTime(2026, 9, 24, 23, 59)), 5);
    // Other days are independent.
    expect(await repo.countFor('astaghfirullah', DateTime(2026, 9, 23)), 0);

    await repo.setCount('astaghfirullah', today, 42);
    expect(await repo.countFor('astaghfirullah', today), 42);

    await repo.reset('astaghfirullah', today);
    expect(await repo.countFor('astaghfirullah', today), 0);
  });

  test('watchCountsForDay emits today\'s counts', () async {
    await repo.setCount('after_prayer_subhanallah', today, 33);
    await repo.setCount('after_prayer_alhamdulillah', today, 10);
    await repo.setCount('after_prayer_subhanallah', DateTime(2026, 9, 20), 5);

    final counts = await repo.watchCountsForDay(today).first;
    expect(counts, {'after_prayer_subhanallah': 33, 'after_prayer_alhamdulillah': 10});
  });

  test('daily summaries cover every day in range and count completions', () async {
    await repo.setCount('after_prayer_subhanallah', today, 33); // complete
    await repo.setCount('after_prayer_allahu_akbar', today, 20); // partial
    await repo.setCount('astaghfirullah', DateTime(2026, 9, 22), 7);

    final days = await repo.watchDailySummaries(from: DateTime(2026, 9, 18), to: today).first;
    expect(days, hasLength(7));
    expect(days.first.day, DateTime(2026, 9, 18));
    expect(days.last.day, DateTime(2026, 9, 24));
    expect(days.last.totalCount, 53);
    expect(days.last.completedCount, 1);
    expect(days.last.itemCount, repo.catalog.length);
    expect(days[4].totalCount, 7);
    expect(days[4].completedCount, 0);
    expect(days.where((d) => d.hasAnyDhikr), hasLength(2));
  });
}
