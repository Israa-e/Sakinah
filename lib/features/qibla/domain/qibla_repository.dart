import '../../../core/errors/result.dart';
import 'qibla_models.dart';

abstract interface class QiblaRepository {
  /// Emits a new [Result] each time the compass updates. `Failure` covers
  /// permission denied, location unavailable, and compass-sensor-unavailable
  /// — the UI renders a distinct state for each (see `QiblaScreen`).
  Stream<Result<QiblaReading>> watchQibla();
}
