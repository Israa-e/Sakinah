/// Closed set of failure kinds the UI can react to. New failure sources should
/// map onto one of these — the presentation layer resolves each to a localized,
/// user-friendly message. Raw exceptions must never reach the UI directly.
sealed class AppFailure {
  const AppFailure({this.debugMessage});

  /// Technical detail for logs only — never shown to the user.
  final String? debugMessage;
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure({super.debugMessage});
}

final class TimeoutFailure extends AppFailure {
  const TimeoutFailure({super.debugMessage});
}

final class ServerFailure extends AppFailure {
  const ServerFailure({this.statusCode, super.debugMessage});

  final int? statusCode;
}

final class CacheFailure extends AppFailure {
  const CacheFailure({super.debugMessage});
}

final class PermissionFailure extends AppFailure {
  const PermissionFailure({super.debugMessage});
}

final class LocationFailure extends AppFailure {
  const LocationFailure({super.debugMessage});
}

final class AudioFailure extends AppFailure {
  const AudioFailure({super.debugMessage});
}

final class SensorFailure extends AppFailure {
  const SensorFailure({super.debugMessage});
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure({super.debugMessage});
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure({super.debugMessage});
}
