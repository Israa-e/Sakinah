import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/preferences_service.dart';
import '../../domain/onboarding_models.dart';
import '../../domain/onboarding_status_provider.dart';

part 'onboarding_controller.g.dart';

class OnboardingData {
  const OnboardingData({
    this.locationGranted,
    this.notificationsGranted,
    this.calculationMethod = CalculationMethod.muslimWorldLeague,
    this.madhab = Madhab.standard,
    this.goals = const {},
  });

  final bool? locationGranted;
  final bool? notificationsGranted;
  final CalculationMethod calculationMethod;
  final Madhab madhab;
  final Set<OnboardingGoal> goals;

  OnboardingData copyWith({
    bool? locationGranted,
    bool? notificationsGranted,
    CalculationMethod? calculationMethod,
    Madhab? madhab,
    Set<OnboardingGoal>? goals,
  }) {
    return OnboardingData(
      locationGranted: locationGranted ?? this.locationGranted,
      notificationsGranted: notificationsGranted ?? this.notificationsGranted,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      madhab: madhab ?? this.madhab,
      goals: goals ?? this.goals,
    );
  }
}

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingData build() => const OnboardingData();

  Future<void> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    state = state.copyWith(locationGranted: status.isGranted);
    await ref.read(preferencesServiceProvider).setLocationPermissionAsked(true);
  }

  Future<void> skipLocationPermission() async {
    state = state.copyWith(locationGranted: false);
    await ref.read(preferencesServiceProvider).setLocationPermissionAsked(true);
  }

  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    state = state.copyWith(notificationsGranted: status.isGranted);
    await ref.read(preferencesServiceProvider).setNotificationPermissionAsked(true);
  }

  Future<void> skipNotificationPermission() async {
    state = state.copyWith(notificationsGranted: false);
    await ref.read(preferencesServiceProvider).setNotificationPermissionAsked(true);
  }

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

  /// Persists every collected preference and flips the app into onboarded
  /// state. The router reacts to [OnboardingStatus] and takes the user to
  /// Home on its own.
  Future<void> finish() async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setCalculationMethod(state.calculationMethod.name);
    await prefs.setMadhab(state.madhab.name);
    await prefs.setGoals(state.goals.map((g) => g.name).toList());
    await ref.read(onboardingStatusProvider.notifier).complete();
  }
}
