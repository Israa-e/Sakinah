import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences_service.dart';

part 'onboarding_status_provider.g.dart';

/// Whether the user has completed the onboarding flow at least once. The
/// router redirects on this; the onboarding flow itself flips it via
/// [complete] once the final step is confirmed.
@Riverpod(keepAlive: true)
class OnboardingStatus extends _$OnboardingStatus {
  @override
  bool build() => ref.watch(preferencesServiceProvider).isOnboardingComplete;

  Future<void> complete() async {
    await ref.read(preferencesServiceProvider).setOnboardingComplete(true);
    state = true;
  }
}
