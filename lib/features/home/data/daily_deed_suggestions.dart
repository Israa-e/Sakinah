/// Generic good-deed prompts (not textual religious quotations, so none
/// carry a source citation — contrast with Duas, which always must).
/// Rotates deterministically by day-of-year so the same day always shows the
/// same suggestion for a given user, without needing a network call.
class DailyDeedSuggestion {
  const DailyDeedSuggestion({required this.en, required this.ar});

  final String en;
  final String ar;
}

const dailyDeedSuggestions = [
  DailyDeedSuggestion(
    en: 'Send a kind message to someone you love.',
    ar: 'أرسل رسالة لطيفة لشخص تحبه.',
  ),
  DailyDeedSuggestion(
    en: 'Give in charity, even if small.',
    ar: 'تصدّق ولو بشيء بسيط.',
  ),
  DailyDeedSuggestion(
    en: 'Call a family member you haven\'t spoken to in a while.',
    ar: 'اتصل بأحد أفراد عائلتك لم تتحدث معه منذ فترة.',
  ),
  DailyDeedSuggestion(
    en: 'Help someone carry something heavy.',
    ar: 'ساعد شخصًا على حمل شيء ثقيل.',
  ),
  DailyDeedSuggestion(
    en: 'Share food with a neighbor.',
    ar: 'شارك طعامك مع جار.',
  ),
  DailyDeedSuggestion(
    en: 'Smile at someone today — it counts.',
    ar: 'ابتسم لأحدهم اليوم — فهي تُحتسب.',
  ),
  DailyDeedSuggestion(
    en: 'Remove something harmful from a shared path.',
    ar: 'أزل أذى عن طريق يشترك فيه الناس.',
  ),
];

DailyDeedSuggestion suggestionForDay(DateTime day) {
  final dayOfYear = day.difference(DateTime(day.year)).inDays;
  return dailyDeedSuggestions[dayOfYear % dailyDeedSuggestions.length];
}
