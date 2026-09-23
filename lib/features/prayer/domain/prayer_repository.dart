import 'prayer_models.dart';

/// Real Adhan-based calculation (location + calculation method + madhab from
/// onboarding) lands in Phase 3. UI code should only ever depend on this
/// interface, never on a concrete implementation, so swapping the data
/// source later touches no presentation code.
abstract interface class PrayerRepository {
  Stream<PrayerSchedule> watchTodaySchedule();
}
