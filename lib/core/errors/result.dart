import 'app_failure.dart';

/// A robust success/failure wrapper. Repository and use-case methods that can
/// fail return `Result<T>` instead of throwing — the UI pattern-matches on it
/// instead of catching raw exceptions.
sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(AppFailure failure) failure,
  }) {
    final self = this;
    return switch (self) {
      Success<T>() => success(self.data),
      Failure<T>() => failure(self.failure),
    };
  }

  T? get dataOrNull => switch (this) {
        Success<T>(:final data) => data,
        Failure<T>() => null,
      };

  bool get isSuccess => this is Success<T>;
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

final class Failure<T> extends Result<T> {
  const Failure(this.failure);

  final AppFailure failure;
}
