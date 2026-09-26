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

/// Real prayer time calculation: the user's chosen calculation method/madhab
/// (via adhan_dart) applied to a device location.
///
/// A fresh GPS fix (`Geolocator.getCurrentPosition`) can take several
/// seconds — sometimes close to its own timeout — so this never makes the UI
/// wait on it. It emits immediately from the last cached location (or the
/// [StaticPrayerRepository] fallback if there's no cache yet), then silently
/// emits again once a fresh fix comes back, the same cache-then-refresh
/// pattern used everywhere else in the app.
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
    final cached = preferencesService.lastKnownLocation;
    if (cached != null) {
      yield _scheduleFor(GeoCoordinates(latitude: cached.$1, longitude: cached.$2));
    } else {
      yield* StaticPrayerRepository().watchTodaySchedule();
    }

    final freshResult = await locationService.getCurrentLocation();
    final fresh = freshResult.dataOrNull;
    if (fresh != null) {
      unawaited(preferencesService.setLastKnownLocation(fresh.latitude, fresh.longitude));
      yield _scheduleFor(fresh);
    }
  }

  PrayerSchedule _scheduleFor(GeoCoordinates coordinates) {
    final params = settings.calculationMethod.toParameters()..madhab = settings.madhab;
    final times = adhan.PrayerTimes(
      date: DateTime.now(),
      coordinates: adhan.Coordinates(coordinates.latitude, coordinates.longitude),
      calculationParameters: params,
    );

    return PrayerSchedule(
      isEstimated: false,
      sunrise: times.sunrise.toLocal(),
      location: coordinates,
      times: [
        PrayerTime(name: PrayerName.fajr, time: times.fajr.toLocal()),
        PrayerTime(name: PrayerName.dhuhr, time: times.dhuhr.toLocal()),
        PrayerTime(name: PrayerName.asr, time: times.asr.toLocal()),
        PrayerTime(name: PrayerName.maghrib, time: times.maghrib.toLocal()),
        PrayerTime(name: PrayerName.isha, time: times.isha.toLocal()),
      ],
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
