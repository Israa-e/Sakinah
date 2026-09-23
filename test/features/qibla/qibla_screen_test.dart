import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/core/errors/app_failure.dart';
import 'package:sakinah/features/qibla/data/compass_qibla_repository.dart';
import 'package:sakinah/features/qibla/domain/qibla_models.dart';
import 'package:sakinah/features/qibla/presentation/screens/qibla_screen.dart';
import 'package:sakinah/l10n/app_localizations.dart';

import '../../fakes/fake_qibla_repository.dart';

void main() {
  Future<void> pumpQiblaScreen(WidgetTester tester, FakeQiblaRepository fake) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [qiblaRepositoryProvider.overrideWithValue(fake)],
        child: const MaterialApp(
          locale: Locale('en'),
          supportedLocales: [Locale('en'), Locale('ar')],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: QiblaScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows a friendly message when location permission is denied', (tester) async {
    await pumpQiblaScreen(
      tester,
      FakeQiblaRepository.failure(const PermissionFailure()),
    );

    expect(find.text('Location access is needed to find the Qibla direction.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('shows a friendly message when the compass sensor is unavailable', (tester) async {
    await pumpQiblaScreen(
      tester,
      FakeQiblaRepository.failure(const SensorFailure()),
    );

    expect(find.text("This device doesn't have a compass sensor."), findsOneWidget);
  });

  testWidgets('shows the compass and heading once a reading arrives', (tester) async {
    await pumpQiblaScreen(
      tester,
      FakeQiblaRepository.success(
        const QiblaReading(qiblaBearing: 118, deviceHeading: 18, accuracy: 5),
      ),
    );

    expect(find.byIcon(Icons.navigation), findsOneWidget);
    expect(find.text('100°'), findsOneWidget);
  });

  testWidgets('shows the facing-Qibla message when heading matches the bearing', (tester) async {
    await pumpQiblaScreen(
      tester,
      FakeQiblaRepository.success(
        const QiblaReading(qiblaBearing: 118, deviceHeading: 118, accuracy: 5),
      ),
    );

    expect(find.text("You're facing the Qibla"), findsOneWidget);
  });
}
