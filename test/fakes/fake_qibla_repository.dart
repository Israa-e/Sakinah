import 'package:sakinah/core/errors/app_failure.dart';
import 'package:sakinah/core/errors/result.dart';
import 'package:sakinah/features/qibla/domain/qibla_models.dart';
import 'package:sakinah/features/qibla/domain/qibla_repository.dart';

class FakeQiblaRepository implements QiblaRepository {
  FakeQiblaRepository.success(this._reading) : _failure = null;
  FakeQiblaRepository.failure(AppFailure failure) : _failure = failure, _reading = null;

  final QiblaReading? _reading;
  final AppFailure? _failure;

  @override
  Stream<Result<QiblaReading>> watchQibla() async* {
    final failure = _failure;
    if (failure != null) {
      yield Failure(failure);
      return;
    }
    yield Success(_reading!);
  }
}
