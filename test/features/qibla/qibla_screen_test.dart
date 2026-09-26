import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/app/theme/app_theme.dart';
import 'package:sakinah/core/errors/app_failure.dart';
import 'package:sakinah/core/network/network_info.dart';
import 'package:sakinah/features/qibla/data/compass_qibla_repository.dart';
import 'package:sakinah/features/qibla/domain/qibla_models.dart';
import 'package:sakinah/features/qibla/presentation/screens/qibla_screen.dart';
import 'package:sakinah/l10n/app_localizations.dart';

import '../../fakes/fake_qibla_repository.dart';

void main() {
  Future<void> pumpQiblaScreen(
    WidgetTester tester,
    FakeQiblaRepository fake, {
    Locale locale = const Locale('en'),
    ThemeMode themeMode = ThemeMode.light,
    double textScale = 1,
    Size size = const Size(390, 1400),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          qiblaRepositoryProvider.overrideWithValue(fake),
          isOnlineProvider.overrideWith((ref) => Stream.value(true)),
        ],
        child: MaterialApp(
          locale: locale,
          theme: AppTheme.light(languageCode: locale.languageCode),
          darkTheme: AppTheme.dark(languageCode: locale.languageCode),
          themeMode: themeMode,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
          home: const QiblaScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows a friendly message when location permission is denied', (tester) async {
    await pumpQiblaScreen(tester, FakeQiblaRepository.failure(const PermissionFailure()));

    expect(find.text('Location access is needed to find the Qibla direction.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('shows a friendly message when the compass sensor is unavailable', (tester) async {
    await pumpQiblaScreen(tester, FakeQiblaRepository.failure(const SensorFailure()));

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
    expect(find.text('118°'), findsOneWidget); // bearing in the hub
    expect(find.text('Turn 100° to the right'), findsOneWidget);
  });

  testWidgets('tells the user to turn left when the Qibla is behind their left side', (
    tester,
  ) async {
    await pumpQiblaScreen(
      tester,
      FakeQiblaRepository.success(
        const QiblaReading(qiblaBearing: 118, deviceHeading: 218, accuracy: 5),
      ),
    );

    expect(find.text('Turn 100° to the left'), findsOneWidget);
  });

  testWidgets('shows distance to Makkah and the calibration hint', (tester) async {
    await pumpQiblaScreen(
      tester,
      FakeQiblaRepository.success(
        const QiblaReading(
          qiblaBearing: 136,
          deviceHeading: 0,
          latitude: 30.0444,
          longitude: 31.2357,
        ),
      ),
    );

    // Cairo → Kaaba is roughly 1,280 km great-circle.
    expect(find.textContaining('km to Makkah'), findsOneWidget);
    expect(find.textContaining('figure-eight'), findsOneWidget);
    expect(find.textContaining('2:144'), findsOneWidget);
  });

  testWidgets('offers Open Settings when location permission is denied', (tester) async {
    await pumpQiblaScreen(tester, FakeQiblaRepository.failure(const PermissionFailure()));
    expect(find.text('Open Settings'), findsOneWidget);
  });

  testWidgets('lays out in Arabic, dark mode, 360px wide at 1.3x text', (tester) async {
    await pumpQiblaScreen(
      tester,
      FakeQiblaRepository.success(
        const QiblaReading(
          qiblaBearing: 136,
          deviceHeading: 20,
          accuracy: 30,
          latitude: 30.0444,
          longitude: 31.2357,
        ),
      ),
      locale: const Locale('ar'),
      themeMode: ThemeMode.dark,
      textScale: 1.3,
      size: const Size(360, 1600),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('136°'), findsOneWidget);
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
