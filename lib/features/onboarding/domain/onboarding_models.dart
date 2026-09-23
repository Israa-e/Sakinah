/// Prayer time calculation conventions. Names are the organizations/methods
/// themselves (not translated) since that's how they're referenced in both
/// languages; the real calculation engine arrives in the Prayer phase — this
/// only records the user's preference.
enum CalculationMethod {
  muslimWorldLeague('Muslim World League'),
  egyptian('Egyptian General Authority'),
  karachi('University of Islamic Sciences, Karachi'),
  ummAlQura('Umm Al-Qura University, Makkah'),
  northAmerica('Islamic Society of North America'),
  singapore('Majlis Ugama Islam Singapura'),
  turkey('Diyanet İşleri Başkanlığı');

  const CalculationMethod(this.label);

  final String label;
}

enum Madhab {
  standard('Shafi\'i, Maliki & Hanbali'),
  hanafi('Hanafi');

  const Madhab(this.label);

  final String label;
}

enum OnboardingGoal { quran, prayer, dhikr, dua, memorization, consistency }
