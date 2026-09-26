import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/preferences_service.dart';
import '../../../prayer/domain/prayer_notifications_provider.dart';
import '../../../prayer/domain/prayer_settings_provider.dart';
import '../../../profile/domain/display_name_provider.dart';
import '../../data/permission_gateway.dart';
import '../../domain/onboarding_models.dart';
import '../../domain/onboarding_status_provider.dart';

part 'onboarding_controller.g.dart';

class OnboardingData {
  const OnboardingData({
    this.locationGranted,
    this.notificationsGranted,
    this.calculationMethod = CalculationMethod.muslimWorldLeague,
    this.madhab = Madhab.shafi,
    this.goals = const {},
    this.displayName = '',
  });

  final bool? locationGranted;
  final bool? notificationsGranted;
  final CalculationMethod calculationMethod;
  final Madhab madhab;
  final Set<OnboardingGoal> goals;
  final String displayName;

  OnboardingData copyWith({
    bool? locationGranted,
    bool? notificationsGranted,
    CalculationMethod? calculationMethod,
    Madhab? madhab,
    Set<OnboardingGoal>? goals,
    String? displayName,
  }) {
    return OnboardingData(
      locationGranted: locationGranted ?? this.locationGranted,
      notificationsGranted: notificationsGranted ?? this.notificationsGranted,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      madhab: madhab ?? this.madhab,
      goals: goals ?? this.goals,
      displayName: displayName ?? this.displayName,
    );
  }
}

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingData build() {
    // Seeded from current settings so re-running onboarding (Profile →
    // Reset onboarding) starts from the user's existing choices.
    final settings = ref.read(prayerSettingsControllerProvider);
    return OnboardingData(
      calculationMethod: settings.calculationMethod,
      madhab: settings.madhab,
      displayName: ref.read(displayNameProvider) ?? '',
    );
  }

  Future<void> requestLocationPermission() async {
    final outcome = await ref.read(permissionGatewayProvider).requestLocation();
    state = state.copyWith(locationGranted: outcome.isGranted);
    await ref.read(preferencesServiceProvider).setLocationPermissionAsked(true);
  }

  Future<void> skipLocationPermission() async {
    state = state.copyWith(locationGranted: false);
    await ref.read(preferencesServiceProvider).setLocationPermissionAsked(true);
  }

  Future<void> requestNotificationPermission() async {
    final outcome = await ref.read(permissionGatewayProvider).requestNotifications();
    state = state.copyWith(notificationsGranted: outcome.isGranted);
    await ref.read(preferencesServiceProvider).setNotificationPermissionAsked(true);
  }

  Future<void> skipNotificationPermission() async {
    state = state.copyWith(notificationsGranted: false);
    await ref.read(preferencesServiceProvider).setNotificationPermissionAsked(true);
  }

  Future<void> openSystemSettings() => ref.read(permissionGatewayProvider).openSystemSettings();

  void setCalculationMethod(CalculationMethod method) {
    state = state.copyWith(calculationMethod: method);
  }

  void setMadhab(Madhab madhab) {
    state = state.copyWith(madhab: madhab);
  }

  void toggleGoal(OnboardingGoal goal) {
    final goals = Set<OnboardingGoal>.from(state.goals);
    if (!goals.remove(goal)) goals.add(goal);
    state = state.copyWith(goals: goals);
  }

  void setDisplayName(String name) {
    state = state.copyWith(displayName: name);
  }

  /// Persists every collected preference and flips the app into onboarded
  /// state. Goes through the reactive providers (not just raw preferences)
  /// so anything already watching them — prayer times, the reminder
  /// scheduler, Home's greeting — updates immediately.
  Future<void> finish() async {
    final prefs = ref.read(preferencesServiceProvider);
    final settings = ref.read(prayerSettingsControllerProvider.notifier);
    await settings.setCalculationMethod(state.calculationMethod);
    await settings.setMadhab(state.madhab);
    await prefs.setGoals(state.goals.map((g) => g.name).toList());
    await ref
        .read(prayerNotificationsEnabledProvider.notifier)
        .setEnabled(state.notificationsGranted ?? false);
    if (state.displayName.trim().isNotEmpty) {
      await ref.read(displayNameProvider.notifier).setName(state.displayName);
    }
    await ref.read(onboardingStatusProvider.notifier).complete();
  }
}
