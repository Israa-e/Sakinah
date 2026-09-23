import 'package:adhan_dart/adhan_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences_service.dart';

part 'prayer_settings_provider.g.dart';

class PrayerSettings {
  const PrayerSettings({required this.calculationMethod, required this.madhab});

  final CalculationMethod calculationMethod;
  final Madhab madhab;
}

/// Reads/writes the calculation method + madhab collected during onboarding
/// (or changed later from the Prayer screen) — the single source of truth
/// [AdhanPrayerRepository] calculates against.
@Riverpod(keepAlive: true)
class PrayerSettingsController extends _$PrayerSettingsController {
  @override
  PrayerSettings build() {
    final prefs = ref.watch(preferencesServiceProvider);
    final method = CalculationMethod.values.firstWhere(
      (m) => m.name == prefs.calculationMethod,
      orElse: () => CalculationMethod.muslimWorldLeague,
    );
    final madhab = Madhab.values.firstWhere(
      (m) => m.name == prefs.madhab,
      orElse: () => Madhab.shafi,
    );
    return PrayerSettings(calculationMethod: method, madhab: madhab);
  }

  Future<void> setCalculationMethod(CalculationMethod method) async {
    await ref.read(preferencesServiceProvider).setCalculationMethod(method.name);
    state = PrayerSettings(calculationMethod: method, madhab: state.madhab);
  }

  Future<void> setMadhab(Madhab madhab) async {
    await ref.read(preferencesServiceProvider).setMadhab(madhab.name);
    state = PrayerSettings(calculationMethod: state.calculationMethod, madhab: madhab);
  }
}
