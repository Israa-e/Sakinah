import 'journey_models.dart';

abstract class JourneyRepository {
  /// Emits fresh stats immediately and again whenever any activity table
  /// (prayers, reading, dhikr, reflections, daily deeds) changes.
  Stream<JourneyStats> watchStats();
}
