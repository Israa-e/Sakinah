import 'package:adhan_dart/adhan_dart.dart';

/// Maps our persisted [CalculationMethod] choice to adhan_dart's concrete
/// [CalculationParameters] (fajr/isha angles etc. per method) — kept as one
/// exhaustive switch so adding a method to the enum forces updating this too.
extension CalculationMethodParametersX on CalculationMethod {
  CalculationParameters toParameters() => switch (this) {
        CalculationMethod.algerian => CalculationMethodParameters.algerian(),
        CalculationMethod.dubai => CalculationMethodParameters.dubai(),
        CalculationMethod.egyptian => CalculationMethodParameters.egyptian(),
        CalculationMethod.france => CalculationMethodParameters.france(),
        CalculationMethod.gulfRegion => CalculationMethodParameters.gulfRegion(),
        CalculationMethod.indonesian => CalculationMethodParameters.indonesian(),
        CalculationMethod.jafari => CalculationMethodParameters.jafari(),
        CalculationMethod.jordan => CalculationMethodParameters.jordan(),
        CalculationMethod.karachi => CalculationMethodParameters.karachi(),
        CalculationMethod.kuwait => CalculationMethodParameters.kuwait(),
        CalculationMethod.moonsightingCommittee =>
          CalculationMethodParameters.moonsightingCommittee(),
        CalculationMethod.morocco => CalculationMethodParameters.morocco(),
        CalculationMethod.muslimWorldLeague =>
          CalculationMethodParameters.muslimWorldLeague(),
        CalculationMethod.northAmerica => CalculationMethodParameters.northAmerica(),
        CalculationMethod.other => CalculationMethodParameters.other(),
        CalculationMethod.portugal => CalculationMethodParameters.portugal(),
        CalculationMethod.qatar => CalculationMethodParameters.qatar(),
        CalculationMethod.russia => CalculationMethodParameters.russia(),
        CalculationMethod.singapore => CalculationMethodParameters.singapore(),
        CalculationMethod.tehran => CalculationMethodParameters.tehran(),
        CalculationMethod.tunisia => CalculationMethodParameters.tunisia(),
        CalculationMethod.turkiye => CalculationMethodParameters.turkiye(),
        CalculationMethod.ummAlQura => CalculationMethodParameters.ummAlQura(),
      };
}
