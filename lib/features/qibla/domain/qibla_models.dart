import 'dart:math' as math;

/// A single Qibla reading: the great-circle bearing to the Kaaba from the
/// user's current location, plus (when the compass sensor is available) the
/// device's current heading so the UI can point an arrow at it directly.
class QiblaReading {
  const QiblaReading({
    required this.qiblaBearing,
    this.deviceHeading,
    this.accuracy,
    this.latitude,
    this.longitude,
  });

  /// Coordinates of the Kaaba used for the distance readout.
  static const kaabaLatitude = 21.4225;
  static const kaabaLongitude = 39.8262;

  /// Degrees from true/magnetic north to the Kaaba, 0–360.
  final double qiblaBearing;

  /// Degrees from north the device is currently facing, 0–360. `null` when
  /// the compass sensor hasn't produced a reading (or isn't available).
  final double? deviceHeading;

  /// Degrees of possible deviation in [deviceHeading], as reported by the
  /// platform. `null` when unknown.
  final double? accuracy;

  /// The user's location this reading was computed from (for the distance
  /// and coordinate readouts). `null` when not provided.
  final double? latitude;
  final double? longitude;

  /// How far to rotate the Qibla indicator relative to the top of the
  /// screen, given the device's current heading. `null` while there's no
  /// heading yet.
  double? get relativeAngle {
    final heading = deviceHeading;
    if (heading == null) return null;
    return (qiblaBearing - heading + 360) % 360;
  }

  /// True when the compass accuracy is poor (or unknown) and the UI should
  /// prompt the user to calibrate (the common "move your phone in a figure
  /// eight" gesture).
  bool get needsCalibration => accuracy == null || accuracy!.abs() > 15;

  /// Great-circle (haversine) distance to the Kaaba in kilometres, or `null`
  /// without a location.
  double? get distanceToKaabaKm {
    final lat = latitude;
    final lng = longitude;
    if (lat == null || lng == null) return null;
    const earthRadiusKm = 6371.0;
    double rad(double deg) => deg * math.pi / 180;
    final dLat = rad(kaabaLatitude - lat);
    final dLng = rad(kaabaLongitude - lng);
    final a =
        math.pow(math.sin(dLat / 2), 2) +
        math.cos(rad(lat)) * math.cos(rad(kaabaLatitude)) * math.pow(math.sin(dLng / 2), 2);
    return earthRadiusKm * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  }
}
