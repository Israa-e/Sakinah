import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sakinah/app/config/locale_provider.dart';
import 'package:sakinah/app/theme/app_theme.dart';
import 'package:sakinah/core/storage/preferences_service.dart';
import 'package:sakinah/features/onboarding/data/permission_gateway.dart';
import 'package:sakinah/features/onboarding/domain/onboarding_status_provider.dart';
import 'package:sakinah/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:sakinah/features/prayer/domain/prayer_notifications_provider.dart';
import 'package:sakinah/features/prayer/domain/prayer_settings_provider.dart';
import 'package:sakinah/features/profile/domain/display_name_provider.dart';
import 'package:sakinah/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakePermissionGateway implements PermissionGateway {
  FakePermissionGateway({required this.location, required this.notifications});

  PermissionOutcome location;
  PermissionOutcome notifications;
  int settingsOpened = 0;

  @override
  Future<PermissionOutcome> requestLocation() async => location;

  @override
  Future<PermissionOutcome> requestNotifications() async => notifications;

  @override
  Future<PermissionOutcome> notificationStatus() async => notifications;

  @override
  Future<bool> openSystemSettings() async {
    settingsOpened++;
    return true;
  }
}

class _TestApp extends ConsumerWidget {
  const _TestApp({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);
    return MaterialApp.router(
      routerConfig: router,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.light(languageCode: locale.languageCode),
    );
  }
}

Future<ProviderContainer> _pump(
  WidgetTester tester, {
  required FakePermissionGateway gateway,
}) async {
  SharedPreferences.setMockInitialValues({'locale': 'en'});
  final prefs = await SharedPreferences.getInstance();
  final router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      GoRoute(
        path: '/home',
        builder: (_, _) => const Scaffold(body: Text('HOME')),
      ),
    ],
  );
  addTearDown(router.dispose);
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      permissionGatewayProvider.overrideWithValue(gateway),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: _TestApp(router: router),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

void main() {
  setUp(() {
    // Narrow phone to catch overflows (360 logical px wide).
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first
      ..physicalSize = const Size(360, 780)
      ..devicePixelRatio = 1;
  });

  tearDown(() {
    final view = TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view
      ..resetPhysicalSize()
      ..resetDevicePixelRatio();
  });

  testWidgets('walks through every step, handling a denied location, and persists choices', (
    tester,
  ) async {
    final gateway = FakePermissionGateway(
      location: PermissionOutcome.denied,
      notifications: PermissionOutcome.granted,
    );
    final container = await _pump(tester, gateway: gateway);

    // Welcome.
    expect(find.text('Sakīnah'), findsOneWidget);
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Language.
    expect(find.text('Choose your language'), findsOneWidget);
    expect(find.text('Step 1 of 5'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Location — denied keeps the user here with an explanation.
    expect(find.text('Step 2 of 5'), findsOneWidget);
    await tester.tap(find.text('Allow Location'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('location-denied')), findsOneWidget);
    await tester.ensureVisible(find.text('Open Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open Settings'));
    expect(gateway.settingsOpened, 1);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Prayer preferences.
    expect(find.text('Step 3 of 5'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('calc-method-egyptian')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('madhab-hanafi')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('madhab-hanafi')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirm & continue'));
    await tester.pumpAndSettle();

    // Notifications — granted advances automatically.
    expect(find.text('Step 4 of 5'), findsOneWidget);
    await tester.tap(find.text('Enable gentle notifications'));
    await tester.pumpAndSettle();

    // Goals + name.
    expect(find.text('Step 5 of 5'), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('onboarding-name')), 'Amina');
    await tester.ensureVisible(find.byKey(const ValueKey('goal-quran')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('goal-quran')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Complete setup'));
    await tester.pumpAndSettle();

    expect(find.text('HOME'), findsOneWidget);
    expect(container.read(onboardingStatusProvider), isTrue);
    expect(container.read(displayNameProvider), 'Amina');
    expect(container.read(prayerNotificationsEnabledProvider), isTrue);
    final settings = container.read(prayerSettingsControllerProvider);
    expect(settings.calculationMethod, CalculationMethod.egyptian);
    expect(settings.madhab, Madhab.hanafi);
    expect(container.read(preferencesServiceProvider).goals, ['quran']);
  });

  testWidgets('choosing Arabic flips the locale and text direction live', (tester) async {
    final container = await _pump(
      tester,
      gateway: FakePermissionGateway(
        location: PermissionOutcome.granted,
        notifications: PermissionOutcome.granted,
      ),
    );
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('language-ar')));
    await tester.pumpAndSettle();

    expect(container.read(appLocaleProvider).languageCode, 'ar');
    final context = tester.element(find.byKey(const ValueKey('language-ar')));
    expect(Directionality.of(context), TextDirection.rtl);
    expect(find.text('الخطوة 1 من 5'), findsOneWidget);
  });

  testWidgets('Skip finishes setup with defaults and goes home', (tester) async {
    final container = await _pump(
      tester,
      gateway: FakePermissionGateway(
        location: PermissionOutcome.granted,
        notifications: PermissionOutcome.granted,
      ),
    );
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('HOME'), findsOneWidget);
    expect(container.read(onboardingStatusProvider), isTrue);
    expect(container.read(prayerNotificationsEnabledProvider), isFalse);
  });

  testWidgets('every step lays out in Arabic at 1.3x text without overflow', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await _pump(
      tester,
      gateway: FakePermissionGateway(
        location: PermissionOutcome.denied,
        notifications: PermissionOutcome.denied,
      ),
    );
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('language-ar')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('language-ar')));
    await tester.pumpAndSettle();
    for (final label in [
      'متابعة',
      'السماح بالموقع',
      'متابعة',
      'تأكيد ومتابعة',
      'تفعيل التنبيهات',
      'متابعة',
    ]) {
      await tester.ensureVisible(find.text(label).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
    }
    expect(find.text('الخطوة 5 من 5'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
