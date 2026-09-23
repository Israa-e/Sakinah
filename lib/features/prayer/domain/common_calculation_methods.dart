import 'package:adhan_dart/adhan_dart.dart';

/// A curated subset of [CalculationMethod]'s 20+ values for pickers (the
/// full enum is still available/valid — this just keeps the onboarding and
/// settings dropdowns from overwhelming a first-time user with methods most
/// people will never need).
const List<CalculationMethod> commonCalculationMethods = [
  CalculationMethod.muslimWorldLeague,
  CalculationMethod.egyptian,
  CalculationMethod.karachi,
  CalculationMethod.ummAlQura,
  CalculationMethod.northAmerica,
  CalculationMethod.gulfRegion,
  CalculationMethod.singapore,
  CalculationMethod.turkiye,
  CalculationMethod.moonsightingCommittee,
];
