/// Calculation method and madhab are genuine domain concepts owned by the
/// Prayer feature (real angles/adjustments per method) — re-exported here so
/// onboarding's preference step and Prayer's settings screen share the exact
/// same, single source of truth instead of two parallel enums drifting apart.
library;

export 'package:adhan_dart/adhan_dart.dart' show CalculationMethod, Madhab;

enum OnboardingGoal { quran, prayer, dhikr, dua, memorization, consistency }
