import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sakinah/app/app.dart';
import 'package:sakinah/app/router/app_router.dart';
import 'package:sakinah/core/storage/app_database.dart';
import 'package:sakinah/core/storage/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Smoke test on a real device/desktop: boots the real app (real fonts,
/// Drift, network) and visits every route, failing on any Flutter error.
/// Set SCREENSHOT_DIR (via --dart-define) to also save a PNG per screen.
const _screenshotDir = String.fromEnvironment('SCREENSHOT_DIR');

const _routes = [
  '/home',
  '/prayer',
  '/qibla',
  '/quran',
  '/quran/surah/2?ayah=143',
  '/quran/page/2',
  '/quran/bookmarks',
  '/dhikr',
  '/dhikr/counter/astaghfirullah',
  '/journey',
  '/profile',
  '/profile/reflections',
  '/duas',
  '/duas/yunus-dhun-nun',
  '/ask',
];

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final boundaryKey = GlobalKey();

  Future<ProviderContainer> boot(WidgetTester tester, Map<String, Object> prefsValues) async {
    SharedPreferences.setMockInitialValues(prefsValues);
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appDatabaseProvider.overrideWithValue(AppDatabase.forTesting(NativeDatabase.memory())),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      RepaintBoundary(
        key: boundaryKey,
        child: UncontrolledProviderScope(container: container, child: const SakinahApp()),
      ),
    );
    return container;
  }

  /// Lets real async work (network, Drift, timers) run while pumping frames;
  /// pumpAndSettle can't be used because some screens animate forever.
  Future<void> settle(WidgetTester tester, {int ms = 2500}) async {
    for (var elapsed = 0; elapsed < ms; elapsed += 250) {
      await tester.pump();
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
    await tester.pump();
  }

  Future<void> capture(String name) async {
    if (_screenshotDir.isEmpty) return;
    final boundary = boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 1.5);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    await File('$_screenshotDir/$name.png').writeAsBytes(bytes!.buffer.asUint8List());
  }

  Future<void> visitAll(WidgetTester tester, ProviderContainer container, String variant) async {
    final router = container.read(appRouterProvider);
    for (final route in _routes) {
      final errors = <String>[];
      final previous = FlutterError.onError;
      FlutterError.onError = (details) => errors.add(details.toString());
      router.go(route);
      final slow = route.startsWith('/quran/surah') || route.startsWith('/quran/page');
      await settle(tester, ms: slow ? 5000 : 2500);
      FlutterError.onError = previous;
      final name = '$variant${route.replaceAll(RegExp('[^a-z0-9]+'), '_')}';
      await capture(name);
      expect(errors, isEmpty, reason: '$route ($variant):\n${errors.join('\n---\n')}');
    }
  }

  testWidgets('onboarding welcome renders on first launch', (tester) async {
    final container = await boot(tester, {});
    await settle(tester);
    expect(container.read(appRouterProvider).state.matchedLocation, AppRoutes.onboarding);
    await capture('onboarding_welcome');
  });

  testWidgets('every screen renders — English, light', (tester) async {
    final container = await boot(tester, {'onboarding_complete': true, 'theme_mode': 'light'});
    await visitAll(tester, container, 'en_light');
  });

  testWidgets('every screen renders — Arabic, dark', (tester) async {
    final container = await boot(tester, {
      'onboarding_complete': true,
      'locale': 'ar',
      'theme_mode': 'dark',
    });
    await visitAll(tester, container, 'ar_dark');
  });
}
