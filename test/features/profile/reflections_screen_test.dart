import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/app/theme/app_theme.dart';
import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/features/profile/presentation/screens/reflections_screen.dart';
import 'package:sakinah/l10n/app_localizations.dart';

import '../../fakes/test_database.dart';

Future<void> _pump(WidgetTester tester, AppDatabase db) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light(languageCode: 'en'),
        home: const ReflectionsScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Unmounts the tree, flushes drift's zero-duration stream-cleanup timer,
/// then closes the database outside the fake-async zone.
Future<void> _unmount(WidgetTester tester, AppDatabase db) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(Duration.zero);
  await tester.runAsync(db.close);
}

void main() {
  testWidgets('shows the empty state when there are no reflections', (tester) async {
    final db = openTestDatabase();
    await _pump(tester, db);
    expect(find.text('No reflections yet'), findsOneWidget);
    await _unmount(tester, db);
  });

  testWidgets('lists reflections newest first and deletes after confirming', (tester) async {
    final db = openTestDatabase();
    await tester.runAsync(() async {
      await db
          .into(db.reflections)
          .insert(
            ReflectionsCompanion.insert(
              body: 'Older thought',
              createdAt: Value(DateTime(2026, 1, 5)),
            ),
          );
      await db
          .into(db.reflections)
          .insert(
            ReflectionsCompanion.insert(
              body: 'Newer thought',
              surahNumber: const Value(2),
              ayahNumber: const Value(201),
              createdAt: Value(DateTime(2026, 3, 5)),
            ),
          );
    });

    await _pump(tester, db);

    final newer = tester.getTopLeft(find.text('Newer thought'));
    final older = tester.getTopLeft(find.text('Older thought'));
    expect(newer.dy, lessThan(older.dy));
    expect(find.text('QURAN 2:201'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('delete-reflection-1')));
    await tester.pumpAndSettle();
    expect(find.text('Delete this reflection?'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('confirm-delete-reflection')));
    await tester.pumpAndSettle();

    expect(find.text('Older thought'), findsNothing);
    expect(find.text('Newer thought'), findsOneWidget);
    await _unmount(tester, db);
  });
}
