import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/core/storage/preferences_service.dart';
import 'package:sakinah/features/dhikr/presentation/controllers/dhikr_counter_controller.dart';
import 'package:sakinah/features/dhikr/presentation/providers/dhikr_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fakes/test_database.dart';

void main() {
  const key = 'after_prayer_subhanallah';
  final now = DateTime(2026, 9, 24, 13);
  late AppDatabase db;
  late SharedPreferences prefs;

  setUp(() async {
    db = openTestDatabase();
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  tearDown(() => db.close());

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        sharedPreferencesProvider.overrideWithValue(prefs),
        dhikrClockProvider.overrideWithValue(() => now),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  Future<void> settleLoad(ProviderContainer c) async {
    for (var i = 0; i < 20 && !c.read(dhikrCounterControllerProvider(key)).loaded; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }

  test('increments, reports target, persists and survives a new session', () async {
    final c = makeContainer();
    final sub = c.listen(dhikrCounterControllerProvider(key), (_, _) {});
    await settleLoad(c);
    final controller = c.read(dhikrCounterControllerProvider(key).notifier);

    var reached = false;
    for (var i = 0; i < 33; i++) {
      reached = controller.increment(33);
    }
    expect(reached, isTrue, reason: 'the 33rd tap reaches the target');
    expect(controller.increment(33), isFalse, reason: 'counting continues past target');
    expect(c.read(dhikrCounterControllerProvider(key)).count, 34);

    await controller.flush();
    sub.close();

    final dbCount = await (db.select(
      db.dhikrLogs,
    )..where((t) => t.dhikrKey.equals(key))).getSingle();
    expect(dbCount.count, 34);
    expect(dbCount.day, AppDatabase.dayKey(now));

    // A fresh container (e.g. leaving and coming back) reads today's count.
    final c2 = makeContainer();
    c2.listen(dhikrCounterControllerProvider(key), (_, _) {});
    await settleLoad(c2);
    expect(c2.read(dhikrCounterControllerProvider(key)).count, 34);
  });

  test('debounced write lands without an explicit flush', () async {
    final c = makeContainer();
    c.listen(dhikrCounterControllerProvider(key), (_, _) {});
    await settleLoad(c);
    c.read(dhikrCounterControllerProvider(key).notifier)
      ..increment(33)
      ..increment(33);
    await Future<void>.delayed(
      DhikrCounterController.writeDelay + const Duration(milliseconds: 100),
    );
    final row = await (db.select(db.dhikrLogs)..where((t) => t.dhikrKey.equals(key))).getSingle();
    expect(row.count, 2);
  });

  test('undo only reverts taps from this session; reset clears', () async {
    await db
        .into(db.dhikrLogs)
        .insert(
          DhikrLogsCompanion.insert(
            dhikrKey: key,
            day: AppDatabase.dayKey(now),
            count: const Value(5),
          ),
        );
    final c = makeContainer();
    c.listen(dhikrCounterControllerProvider(key), (_, _) {});
    await settleLoad(c);
    final controller = c.read(dhikrCounterControllerProvider(key).notifier);
    expect(c.read(dhikrCounterControllerProvider(key)).count, 5);
    expect(c.read(dhikrCounterControllerProvider(key)).canUndo, isFalse);

    controller.increment(33);
    expect(c.read(dhikrCounterControllerProvider(key)).canUndo, isTrue);
    controller
      ..undo()
      ..undo();
    expect(c.read(dhikrCounterControllerProvider(key)).count, 5);

    await controller.reset();
    expect(c.read(dhikrCounterControllerProvider(key)).count, 0);
    final row = await (db.select(db.dhikrLogs)..where((t) => t.dhikrKey.equals(key))).getSingle();
    expect(row.count, 0);
  });

  test('today summary reflects stored counts', () async {
    await db
        .into(db.dhikrLogs)
        .insert(
          DhikrLogsCompanion.insert(
            dhikrKey: key,
            day: AppDatabase.dayKey(now),
            count: const Value(33),
          ),
        );
    await db
        .into(db.dhikrLogs)
        .insert(
          DhikrLogsCompanion.insert(
            dhikrKey: 'astaghfirullah',
            day: AppDatabase.dayKey(now),
            count: const Value(10),
          ),
        );
    final c = makeContainer();
    final summary = await c.read(todayDhikrSummaryProvider.future);
    expect(summary.totalCount, 43);
    expect(summary.completedCount, 1);
  });

  test('target cycles item default -> 33 -> 99 -> 100 and persists', () async {
    final c = makeContainer();
    const k = 'astaghfirullah'; // default 100
    c.listen(dhikrTargetProvider(k), (_, _) {});
    expect(c.read(dhikrTargetProvider(k)), 100);
    await c.read(dhikrTargetProvider(k).notifier).cycle();
    expect(c.read(dhikrTargetProvider(k)), 33);
    expect(prefs.getInt('dhikr.target.$k'), 33);
    await c.read(dhikrTargetProvider(k).notifier).cycle();
    expect(c.read(dhikrTargetProvider(k)), 99);
    await c.read(dhikrTargetProvider(k).notifier).cycle();
    expect(c.read(dhikrTargetProvider(k)), 100);
    expect(prefs.getInt('dhikr.target.$k'), isNull);
  });
}
