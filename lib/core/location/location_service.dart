import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../errors/app_failure.dart';
import '../errors/result.dart';
import 'geo_coordinates.dart';

part 'location_service.g.dart';

/// Abstraction over device location so Prayer/Qibla repositories depend on
/// this, never on `package:geolocator` directly — keeps them testable and
/// keeps the permission/GPS dance in one place.
abstract interface class LocationService {
  Future<Result<GeoCoordinates>> getCurrentLocation();
}

class GeolocatorLocationService implements LocationService {
  @override
  Future<Result<GeoCoordinates>> getCurrentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return const Failure(LocationFailure(debugMessage: 'Location services disabled'));
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return const Failure(PermissionFailure(debugMessage: 'Location permission denied'));
      }

      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.medium,
            timeLimit: Duration(seconds: 10),
          ),
        );
      } catch (_) {
        position = await Geolocator.getLastKnownPosition();
      }

      if (position == null) {
        return const Failure(LocationFailure(debugMessage: 'No fix and no last-known position'));
      }
      return Success(GeoCoordinates(latitude: position.latitude, longitude: position.longitude));
    } catch (e) {
      return Failure(LocationFailure(debugMessage: e.toString()));
    }
  }
}

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) => GeolocatorLocationService();
