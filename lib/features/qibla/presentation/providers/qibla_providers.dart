import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/result.dart';
import '../../data/compass_qibla_repository.dart';
import '../../domain/qibla_models.dart';

part 'qibla_providers.g.dart';

@riverpod
Stream<Result<QiblaReading>> qibla(Ref ref) {
  return ref.watch(qiblaRepositoryProvider).watchQibla();
}
