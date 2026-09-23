import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/features/qibla/domain/qibla_models.dart';

void main() {
  group('QiblaReading.relativeAngle', () {
    test('is null when there is no device heading yet', () {
      const reading = QiblaReading(qiblaBearing: 118);
      expect(reading.relativeAngle, isNull);
    });

    test('is zero when facing the Qibla exactly', () {
      const reading = QiblaReading(qiblaBearing: 118, deviceHeading: 118);
      expect(reading.relativeAngle, 0);
    });

    test('wraps around 360 correctly', () {
      const reading = QiblaReading(qiblaBearing: 10, deviceHeading: 350);
      expect(reading.relativeAngle, 20);
    });

    test('handles a simple offset without wrapping', () {
      const reading = QiblaReading(qiblaBearing: 200, deviceHeading: 100);
      expect(reading.relativeAngle, 100);
    });
  });

  group('QiblaReading.needsCalibration', () {
    test('true when accuracy is unknown', () {
      const reading = QiblaReading(qiblaBearing: 0, deviceHeading: 0);
      expect(reading.needsCalibration, isTrue);
    });

    test('true when accuracy is worse than 15 degrees', () {
      const reading = QiblaReading(qiblaBearing: 0, deviceHeading: 0, accuracy: 30);
      expect(reading.needsCalibration, isTrue);
    });

    test('false when accuracy is good', () {
      const reading = QiblaReading(qiblaBearing: 0, deviceHeading: 0, accuracy: 5);
      expect(reading.needsCalibration, isFalse);
    });
  });
}
