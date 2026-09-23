import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_service.g.dart';

/// Overridden in `main()` with the real, awaited [SharedPreferences] instance.
/// Never read before that override is applied.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden in main()');
});

enum AppThemeMode { system, light, dark }

/// Typed wrapper around the small, non-relational flags the app needs on
/// every cold start (locale, theme, onboarding progress). Structured/queryable
/// data lives in Drift instead — see `app_database.dart`.
class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  static const _kLocale = 'locale';
  static const _kThemeMode = 'theme_mode';
  static const _kOnboardingComplete = 'onboarding_complete';
  static const _kLocationPermissionAsked = 'location_permission_asked';
  static const _kNotificationPermissionAsked = 'notification_permission_asked';
  static const _kCalculationMethod = 'calculation_method';
  static const _kMadhab = 'madhab';
  static const _kGoals = 'onboarding_goals';

  String? get locale => _prefs.getString(_kLocale);
  Future<void> setLocale(String languageCode) => _prefs.setString(_kLocale, languageCode);

  AppThemeMode get themeMode {
    final raw = _prefs.getString(_kThemeMode);
    return AppThemeMode.values.firstWhere(
      (m) => m.name == raw,
      orElse: () => AppThemeMode.system,
    );
  }

  Future<void> setThemeMode(AppThemeMode mode) => _prefs.setString(_kThemeMode, mode.name);

  bool get isOnboardingComplete => _prefs.getBool(_kOnboardingComplete) ?? false;
  Future<void> setOnboardingComplete(bool value) =>
      _prefs.setBool(_kOnboardingComplete, value);

  bool get locationPermissionAsked => _prefs.getBool(_kLocationPermissionAsked) ?? false;
  Future<void> setLocationPermissionAsked(bool value) =>
      _prefs.setBool(_kLocationPermissionAsked, value);

  bool get notificationPermissionAsked =>
      _prefs.getBool(_kNotificationPermissionAsked) ?? false;
  Future<void> setNotificationPermissionAsked(bool value) =>
      _prefs.setBool(_kNotificationPermissionAsked, value);

  String? get calculationMethod => _prefs.getString(_kCalculationMethod);
  Future<void> setCalculationMethod(String method) =>
      _prefs.setString(_kCalculationMethod, method);

  String? get madhab => _prefs.getString(_kMadhab);
  Future<void> setMadhab(String madhab) => _prefs.setString(_kMadhab, madhab);

  List<String> get goals => _prefs.getStringList(_kGoals) ?? const [];
  Future<void> setGoals(List<String> goals) => _prefs.setStringList(_kGoals, goals);
}

@Riverpod(keepAlive: true)
PreferencesService preferencesService(Ref ref) {
  return PreferencesService(ref.watch(sharedPreferencesProvider));
}
