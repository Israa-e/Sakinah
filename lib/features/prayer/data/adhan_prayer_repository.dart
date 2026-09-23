import 'dart:async';

import 'package:adhan_dart/adhan_dart.dart' as adhan;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/location/geo_coordinates.dart';
import '../../../core/location/location_service.dart';
import '../../../core/storage/preferences_service.dart';
import '../domain/prayer_models.dart';
import '../domain/prayer_repository.dart';
import '../domain/prayer_settings_provider.dart';
import 'calculation_method_x.dart';
import 'static_prayer_repository.dart';

part 'adhan_prayer_repository.g.dart';

/// Real prayer time calculation: device location (fresh, falling back to the
/// last cached fix) + the user's chosen calculation method/madhab, via
/// adhan_dart. Falls back to [StaticPrayerRepository] whenever no location —
/// fresh or cached — is available at all.
class AdhanPrayerRepository implements PrayerRepository {
  AdhanPrayerRepository({
    required this.locationService,
    required this.preferencesService,
    required this.settings,
  });

  final LocationService locationService;
  final PreferencesService preferencesService;
  final PrayerSettings settings;

  @override
  Stream<PrayerSchedule> watchTodaySchedule() async* {
    final coordinates = await _resolveCoordinates();
    if (coordinates == null) {
      yield* StaticPrayerRepository().watchTodaySchedule();
      return;
    }

    final params = settings.calculationMethod.toParameters()
      ..madhab = settings.madhab;
    final times = adhan.PrayerTimes(
      date: DateTime.now(),
      coordinates: adhan.Coordinates(coordinates.latitude, coordinates.longitude),
      calculationParameters: params,
    );

    yield PrayerSchedule(
      isEstimated: false,
      times: [
        PrayerTime(name: PrayerName.fajr, time: times.fajr.toLocal()),
        PrayerTime(name: PrayerName.dhuhr, time: times.dhuhr.toLocal()),
        PrayerTime(name: PrayerName.asr, time: times.asr.toLocal()),
        PrayerTime(name: PrayerName.maghrib, time: times.maghrib.toLocal()),
        PrayerTime(name: PrayerName.isha, time: times.isha.toLocal()),
      ],
    );
  }

  Future<GeoCoordinates?> _resolveCoordinates() async {
    final result = await locationService.getCurrentLocation();
    return result.when(
      success: (coords) {
        // Cached for next time; the current calculation doesn't need to wait on it.
        unawaited(preferencesService.setLastKnownLocation(coords.latitude, coords.longitude));
        return coords;
      },
      failure: (_) {
        final cached = preferencesService.lastKnownLocation;
        if (cached == null) return null;
        return GeoCoordinates(latitude: cached.$1, longitude: cached.$2);
      },
    );
  }
}

@riverpod
PrayerRepository prayerRepository(Ref ref) {
  return AdhanPrayerRepository(
    locationService: ref.watch(locationServiceProvider),
    preferencesService: ref.watch(preferencesServiceProvider),
    settings: ref.watch(prayerSettingsControllerProvider),
  );
}
