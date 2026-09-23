// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Sakīnah';

  @override
  String get appTagline => 'A calmer way to live your faith.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get continueLabel => 'Continue';

  @override
  String get back => 'Back';

  @override
  String get skip => 'Skip';

  @override
  String get maybeLater => 'Maybe Later';

  @override
  String get retry => 'Retry';

  @override
  String get onboardingLanguageTitle => 'Choose your language';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get onboardingLocationTitle =>
      'Allow location to calculate accurate prayer times and Qibla.';

  @override
  String get allowLocation => 'Allow Location';

  @override
  String get onboardingPrayerPrefsTitle => 'Prayer preferences';

  @override
  String get calculationMethodLabel => 'Calculation method';

  @override
  String get madhabLabel => 'Madhab';

  @override
  String get onboardingNotificationsTitle =>
      'Stay gently connected to your daily prayers and adhkar.';

  @override
  String get allowNotifications => 'Allow Notifications';

  @override
  String get onboardingGoalsTitle => 'What would you like to focus on?';

  @override
  String get onboardingGoalsSubtitle =>
      'Choose as many as you like — you can change these later.';

  @override
  String get goalQuran => 'Quran';

  @override
  String get goalPrayer => 'Prayer';

  @override
  String get goalDhikr => 'Dhikr';

  @override
  String get goalDua => 'Du\'a';

  @override
  String get goalMemorization => 'Memorization';

  @override
  String get goalConsistency => 'Consistency';

  @override
  String get beginJourney => 'Begin';

  @override
  String get navHome => 'Home';

  @override
  String get navQuran => 'Quran';

  @override
  String get navDhikr => 'Dhikr';

  @override
  String get navJourney => 'Journey';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeGreeting => 'Assalamu Alaikum';

  @override
  String get dailyIntentionTitle => 'Today\'s intention';

  @override
  String get dailyIntentionText =>
      'Take a few minutes to reconnect with Allah today.';

  @override
  String get begin => 'Begin';

  @override
  String get yourQuran => 'Your Quran';

  @override
  String get continueReading => 'Continue reading';

  @override
  String ayahLabel(int number) {
    return 'Ayah $number';
  }

  @override
  String get todaysDhikr => 'Today\'s Dhikr';

  @override
  String get start => 'Start';

  @override
  String get dailyDeedTitle => 'A small good deed';

  @override
  String get markAsDone => 'Mark as done';

  @override
  String get markedAsDone => 'Done for today';

  @override
  String prayerCountdown(String time) {
    return 'in $time';
  }

  @override
  String get prayerEstimatedNotice =>
      'Estimated — will sync with your location soon';

  @override
  String get prayerFajr => 'Fajr';

  @override
  String get prayerDhuhr => 'Dhuhr';

  @override
  String get prayerAsr => 'Asr';

  @override
  String get prayerMaghrib => 'Maghrib';

  @override
  String get prayerIsha => 'Isha';

  @override
  String get offlineNotice => 'You\'re offline — showing your saved data.';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get comingSoonTitle => 'Coming soon';

  @override
  String get comingSoonBody =>
      'This part of Sakīnah is still being built with care.';

  @override
  String get prayerScreenTitle => 'Prayer';

  @override
  String get prayerSettingsTitle => 'Prayer preferences';

  @override
  String get prayerNotificationsLabel => 'Prayer notifications';

  @override
  String get prayerNotificationsSubtitle =>
      'Get a gentle reminder when each prayer time begins.';

  @override
  String get qiblaButton => 'Qibla direction';

  @override
  String get qiblaTitle => 'Qibla';

  @override
  String get qiblaFacingIt => 'You\'re facing the Qibla';

  @override
  String get qiblaCalibrateHint =>
      'Move your phone in a figure-eight to calibrate the compass';

  @override
  String get qiblaPermissionDenied =>
      'Location access is needed to find the Qibla direction.';

  @override
  String get qiblaLocationUnavailable =>
      'Couldn\'t determine your location. Check your connection and try again.';

  @override
  String get qiblaSensorUnavailable =>
      'This device doesn\'t have a compass sensor.';

  @override
  String get openSettings => 'Open Settings';
}
