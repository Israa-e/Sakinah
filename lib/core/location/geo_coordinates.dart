/// Plain lat/lng value, independent of any specific location or prayer-math
/// package — [LocationService] and the Prayer/Qibla features convert to
/// whatever third-party type they need at their own boundary.
class GeoCoordinates {
  const GeoCoordinates({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}
