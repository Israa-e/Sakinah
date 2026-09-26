import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/preferences_service.dart';
import '../../../onboarding/domain/onboarding_models.dart';
import '../../data/drift_journey_repository.dart';
import '../../domain/journey_models.dart';

part 'journey_providers.g.dart';

/// Live journey stats (streak, level, garden stage, activity). Other features
/// (e.g. Home's streak chip) can watch this directly.
@riverpod
Stream<JourneyStats> journeyStats(Ref ref) {
  return ref.watch(journeyRepositoryProvider).watchStats();
}

/// The focus areas the user picked during onboarding (read-only).
@riverpod
List<OnboardingGoal> journeySelectedGoals(Ref ref) {
  final raw = ref.watch(preferencesServiceProvider).goals;
  return [
    for (final goal in OnboardingGoal.values)
      if (raw.contains(goal.name)) goal,
  ];
}

/// Goals shown when the user skipped choosing any during onboarding.
const journeyDefaultGoals = [
  OnboardingGoal.prayer,
  OnboardingGoal.quran,
  OnboardingGoal.dhikr,
];
