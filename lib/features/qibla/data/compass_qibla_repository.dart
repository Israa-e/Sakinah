import 'package:adhan_dart/adhan_dart.dart' show Coordinates, Qibla;
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/result.dart';
import '../../../core/location/geo_coordinates.dart';
import '../../../core/location/location_service.dart';
import '../domain/qibla_models.dart';
import '../domain/qibla_repository.dart';

part 'compass_qibla_repository.g.dart';

class CompassQiblaRepository implements QiblaRepository {
  CompassQiblaRepository(this._locationService);

  final LocationService _locationService;

  @override
  Stream<Result<QiblaReading>> watchQibla() async* {
    final locationResult = await _locationService.getCurrentLocation();
    AppFailure? locationFailure;
    GeoCoordinates? coords;
    locationResult.when(success: (c) => coords = c, failure: (f) => locationFailure = f);

    if (coords == null) {
      yield Failure(locationFailure ?? const LocationFailure());
      return;
    }

    final bearing = Qibla.qibla(Coordinates(coords!.latitude, coords!.longitude));

    final compassStream = FlutterCompass.events;
    if (compassStream == null) {
      yield const Failure(SensorFailure(debugMessage: 'Compass not supported on this device'));
      return;
    }

    yield* _readingsFrom(compassStream, bearing);
  }

  Stream<Result<QiblaReading>> _readingsFrom(
    Stream<CompassEvent> events,
    double bearing,
  ) async* {
    try {
      await for (final event in events) {
        yield Success(
          QiblaReading(
            qiblaBearing: bearing,
            deviceHeading: event.heading,
            accuracy: event.accuracy,
          ),
        );
      }
    } catch (e) {
      yield Failure(SensorFailure(debugMessage: e.toString()));
    }
  }
}

@riverpod
QiblaRepository qiblaRepository(Ref ref) {
  return CompassQiblaRepository(ref.watch(locationServiceProvider));
}
