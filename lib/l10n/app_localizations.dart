import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Sakīnah'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'A calmer way to live your faith.'**
  String get appTagline;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @maybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe Later'**
  String get maybeLater;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @onboardingLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get onboardingLanguageTitle;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @onboardingLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow location to calculate accurate prayer times and Qibla.'**
  String get onboardingLocationTitle;

  /// No description provided for @allowLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow Location'**
  String get allowLocation;

  /// No description provided for @onboardingPrayerPrefsTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer preferences'**
  String get onboardingPrayerPrefsTitle;

  /// No description provided for @calculationMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Calculation method'**
  String get calculationMethodLabel;

  /// No description provided for @madhabLabel.
  ///
  /// In en, this message translates to:
  /// **'Madhab'**
  String get madhabLabel;

  /// No description provided for @onboardingNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay gently connected to your daily prayers and adhkar.'**
  String get onboardingNotificationsTitle;

  /// No description provided for @allowNotifications.
  ///
  /// In en, this message translates to:
  /// **'Allow Notifications'**
  String get allowNotifications;

  /// No description provided for @onboardingGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'What would you like to focus on?'**
  String get onboardingGoalsTitle;

  /// No description provided for @onboardingGoalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose as many as you like — you can change these later.'**
  String get onboardingGoalsSubtitle;

  /// No description provided for @goalQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get goalQuran;

  /// No description provided for @goalPrayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get goalPrayer;

  /// No description provided for @goalDhikr.
  ///
  /// In en, this message translates to:
  /// **'Dhikr'**
  String get goalDhikr;

  /// No description provided for @goalDua.
  ///
  /// In en, this message translates to:
  /// **'Du\'a'**
  String get goalDua;

  /// No description provided for @goalMemorization.
  ///
  /// In en, this message translates to:
  /// **'Memorization'**
  String get goalMemorization;

  /// No description provided for @goalConsistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get goalConsistency;

  /// No description provided for @beginJourney.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get beginJourney;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get navQuran;

  /// No description provided for @navDhikr.
  ///
  /// In en, this message translates to:
  /// **'Dhikr'**
  String get navDhikr;

  /// No description provided for @navJourney.
  ///
  /// In en, this message translates to:
  /// **'Journey'**
  String get navJourney;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Assalamu Alaikum'**
  String get homeGreeting;

  /// No description provided for @dailyIntentionTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s intention'**
  String get dailyIntentionTitle;

  /// No description provided for @dailyIntentionText.
  ///
  /// In en, this message translates to:
  /// **'Take a few minutes to reconnect with Allah today.'**
  String get dailyIntentionText;

  /// No description provided for @begin.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get begin;

  /// No description provided for @yourQuran.
  ///
  /// In en, this message translates to:
  /// **'Your Quran'**
  String get yourQuran;

  /// No description provided for @continueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue reading'**
  String get continueReading;

  /// No description provided for @ayahLabel.
  ///
  /// In en, this message translates to:
  /// **'Ayah {number}'**
  String ayahLabel(int number);

  /// No description provided for @todaysDhikr.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Dhikr'**
  String get todaysDhikr;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @dailyDeedTitle.
  ///
  /// In en, this message translates to:
  /// **'A small good deed'**
  String get dailyDeedTitle;

  /// No description provided for @markAsDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as done'**
  String get markAsDone;

  /// No description provided for @markedAsDone.
  ///
  /// In en, this message translates to:
  /// **'Done for today'**
  String get markedAsDone;

  /// No description provided for @prayerCountdown.
  ///
  /// In en, this message translates to:
  /// **'in {time}'**
  String prayerCountdown(String time);

  /// No description provided for @prayerEstimatedNotice.
  ///
  /// In en, this message translates to:
  /// **'Estimated — will sync with your location soon'**
  String get prayerEstimatedNotice;

  /// No description provided for @prayerFajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get prayerFajr;

  /// No description provided for @prayerDhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get prayerDhuhr;

  /// No description provided for @prayerAsr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get prayerAsr;

  /// No description provided for @prayerMaghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get prayerMaghrib;

  /// No description provided for @prayerIsha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get prayerIsha;

  /// No description provided for @offlineNotice.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline — showing your saved data.'**
  String get offlineNotice;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @comingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoonTitle;

  /// No description provided for @comingSoonBody.
  ///
  /// In en, this message translates to:
  /// **'This part of Sakīnah is still being built with care.'**
  String get comingSoonBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
