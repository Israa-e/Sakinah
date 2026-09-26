import '../../../core/errors/app_failure.dart';
import '../../../core/errors/result.dart';
import 'ask_models.dart';

/// Returned when no Ask Sakīnah backend URL is configured for this build.
///
/// `AppFailure` is a sealed hierarchy owned by `core/`, so this is a canonical
/// const instance (compare with [isAskServiceNotConfigured]) rather than a new
/// subclass.
const AppFailure askServiceNotConfigured =
    ValidationFailure(debugMessage: 'ASK_SAKINAH_URL is not configured');

bool isAskServiceNotConfigured(AppFailure failure) =>
    identical(failure, askServiceNotConfigured);

abstract interface class AskRepository {
  /// Whether a backend is configured at all (false → show "unavailable").
  bool get isConfigured;

  Future<Result<AskAnswer>> ask(String question, AskLanguage language);
}
