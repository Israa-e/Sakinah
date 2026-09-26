/// Kind of citation returned by the Ask Sakīnah service.
enum AskSourceType {
  quran,
  hadith,
  other;

  static AskSourceType parse(String? value) => switch (value) {
        'quran' => AskSourceType.quran,
        'hadith' => AskSourceType.hadith,
        _ => AskSourceType.other,
      };
}

class AskSource {
  const AskSource({required this.type, required this.reference});

  final AskSourceType type;

  /// e.g. "13:28" or "Sahih al-Bukhari 6407" — shown verbatim.
  final String reference;
}

/// A grounded answer from the backend (system design §5.2). The app never
/// composes answers itself; it only renders what the service returned.
class AskAnswer {
  const AskAnswer({required this.answer, required this.sources, this.disclaimer});

  final String answer;
  final List<AskSource> sources;

  /// Server-provided disclaimer; the UI falls back to its localized copy.
  final String? disclaimer;
}

enum AskLanguage { ar, en }
