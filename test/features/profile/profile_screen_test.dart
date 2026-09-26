import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sakinah/app/config/locale_provider.dart';
import 'package:sakinah/app/config/theme_mode_provider.dart';
import 'package:sakinah/app/theme/app_theme.dart';
import 'package:sakinah/core/storage/preferences_service.dart';
import 'package:sakinah/features/onboarding/data/permission_gateway.dart';
import 'package:sakinah/features/onboarding/domain/onboarding_status_provider.dart';
import 'package:sakinah/features/prayer/domain/prayer_notifications_provider.dart';
import 'package:sakinah/features/profile/domain/display_name_provider.dart';
import 'package:sakinah/features/profile/presentation/screens/profile_screen.dart';
import 'package:sakinah/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeGateway implements PermissionGateway {
  _FakeGateway(this.notifications);

  final PermissionOutcome notifications;

  @override
  Future<PermissionOutcome> requestLocation() async => PermissionOutcome.granted;

  @override
  Future<PermissionOutcome> requestNotifications() async => notifications;

  @override
  Future<PermissionOutcome> notificationStatus() async => notifications;

  @override
  Future<bool> openSystemSettings() async => true;
}

class _App extends ConsumerWidget {
  const _App({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);
    final mode = ref.watch(appThemeModeControllerProvider);
    return MaterialApp.router(
      routerConfig: router,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      themeMode: mode.toFlutter,
      theme: AppTheme.light(languageCode: locale.languageCode),
      darkTheme: AppTheme.dark(languageCode: locale.languageCode),
    );
  }
}

Future<ProviderContainer> _pump(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  PermissionOutcome notifications = PermissionOutcome.granted,
}) async {
  SharedPreferences.setMockInitialValues({'locale': 'en', 'onboarding_complete': true, ...prefs});
  final sp = await SharedPreferences.getInstance();
  final router = GoRouter(
    initialLocation: '/profile',
    routes: [
      GoRoute(
        path: '/profile',
        builder: (_, _) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'reflections',
            builder: (_, _) => const Scaffold(body: Text('REFLECTIONS')),
          ),
        ],
      ),
      GoRoute(
        path: '/onboarding',
        builder: (_, _) => const Scaffold(body: Text('ONBOARDING')),
      ),
    ],
  );
  addTearDown(router.dispose);
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sp),
      permissionGatewayProvider.overrideWithValue(_FakeGateway(notifications)),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: _App(router: router),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

final _list = find
    .descendant(of: find.byKey(const ValueKey('profile-list')), matching: find.byType(Scrollable))
    .first;

Future<void> _reveal(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(finder, 200, scrollable: _list);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    final view = TestWidgetsFlutterBinding.ensureInitialized().platformDispatcher.views.first
      ..physicalSize = const Size(360, 780)
      ..devicePixelRatio = 1;
    addTearDown(view.resetPhysicalSize);
    addTearDown(view.resetDevicePixelRatio);
  });

  testWidgets('renders the header and every section', (tester) async {
    await _pump(tester, prefs: {DisplayName.storageKey: 'Yusuf'});

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Yusuf'), findsOneWidget);
    expect(find.text('Y'), findsOneWidget);
    expect(find.text('Muslim World League'), findsOneWidget);

    for (final label in [
      'Theme',
      'Sahih International',
      'Where our content comes from',
      "Du'as library",
      'My reflections',
      'Reset onboarding',
    ]) {
      await _reveal(tester, find.text(label));
      expect(find.text(label), findsOneWidget);
    }
  });

  testWidgets('theme toggle updates the theme-mode provider', (tester) async {
    final container = await _pump(tester);
    await _reveal(tester, find.text('Dark'));
    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    expect(container.read(appThemeModeControllerProvider), AppThemeMode.dark);

    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();
    expect(container.read(appThemeModeControllerProvider), AppThemeMode.light);
  });

  testWidgets('editing the name updates displayNameProvider', (tester) async {
    final container = await _pump(tester);
    expect(find.text('Add your name'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('profile-edit-name')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('profile-name-field')), 'Maryam');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(container.read(displayNameProvider), 'Maryam');
    expect(find.text('Maryam'), findsOneWidget);
  });

  testWidgets('notification toggle stays off when permission is denied', (tester) async {
    final container = await _pump(tester, notifications: PermissionOutcome.denied);
    await tester.tap(find.byKey(const ValueKey('profile-notifications')));
    await tester.pumpAndSettle();
    expect(container.read(prayerNotificationsEnabledProvider), isFalse);
    expect(find.text('Notifications are blocked in system settings.'), findsOneWidget);
  });

  testWidgets('notification toggle turns on when permission is granted', (tester) async {
    final container = await _pump(tester);
    await tester.tap(find.byKey(const ValueKey('profile-notifications')));
    await tester.pumpAndSettle();
    expect(container.read(prayerNotificationsEnabledProvider), isTrue);
  });

  testWidgets('reflections row navigates; reset onboarding confirms then routes', (tester) async {
    final container = await _pump(tester);
    await _reveal(tester, find.text('My reflections'));
    await tester.tap(find.text('My reflections'));
    await tester.pumpAndSettle();
    expect(find.text('REFLECTIONS'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    await _reveal(tester, find.text('Reset onboarding'));
    await tester.tap(find.text('Reset onboarding'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    expect(container.read(onboardingStatusProvider), isFalse);
    expect(find.text('ONBOARDING'), findsOneWidget);
  });

  testWidgets('lays out in Arabic, dark mode, at 1.3x text without overflow', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await _pump(tester, prefs: {'locale': 'ar', 'theme_mode': 'dark'});
    for (final label in ['السمة', 'خواطري', 'إعادة الإعداد الأولي']) {
      await _reveal(tester, find.text(label));
    }
    expect(tester.takeException(), isNull);
  });
}
