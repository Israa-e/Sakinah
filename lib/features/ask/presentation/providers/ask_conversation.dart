import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/result.dart';
import '../../data/remote_ask_repository.dart';
import '../../domain/ask_models.dart';

part 'ask_conversation.g.dart';

/// One exchange: the user's question plus its (pending/answered/failed) reply.
class AskExchange {
  const AskExchange({
    required this.id,
    required this.question,
    required this.language,
    this.answer,
    this.failure,
  });

  final int id;
  final String question;
  final AskLanguage language;
  final AskAnswer? answer;
  final AppFailure? failure;

  bool get isPending => answer == null && failure == null;

  AskExchange resolved(Result<AskAnswer> result) => AskExchange(
        id: id,
        question: question,
        language: language,
        answer: result.dataOrNull,
        failure: switch (result) {
          Failure(:final failure) => failure,
          Success() => null,
        },
      );

  AskExchange pending() => AskExchange(id: id, question: question, language: language);
}

/// Whether a backend is configured for this build.
@riverpod
bool askServiceConfigured(Ref ref) => ref.watch(askRepositoryProvider).isConfigured;

/// In-memory conversation (cleared when the Ask screen is left).
@riverpod
class AskConversation extends _$AskConversation {
  int _nextId = 0;
  bool _disposed = false;

  @override
  List<AskExchange> build() {
    ref.onDispose(() => _disposed = true);
    return const [];
  }

  bool get isBusy => state.any((e) => e.isPending);

  Future<void> ask(String question, AskLanguage language) async {
    final trimmed = question.trim();
    if (trimmed.isEmpty || isBusy) return;
    final exchange = AskExchange(id: _nextId++, question: trimmed, language: language);
    state = [...state, exchange];
    await _resolve(exchange);
  }

  /// Re-sends a failed question in place.
  Future<void> retry(int id) async {
    final index = state.indexWhere((e) => e.id == id);
    if (index < 0 || isBusy) return;
    final pending = state[index].pending();
    state = [...state]..[index] = pending;
    await _resolve(pending);
  }

  Future<void> _resolve(AskExchange exchange) async {
    final repository = ref.read(askRepositoryProvider);
    final result = await repository.ask(exchange.question, exchange.language);
    if (_disposed) return;
    final index = state.indexWhere((e) => e.id == exchange.id);
    if (index < 0) return;
    state = [...state]..[index] = exchange.resolved(result);
  }
}
