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

  /// No description provided for @prayerScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get prayerScreenTitle;

  /// No description provided for @prayerSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer preferences'**
  String get prayerSettingsTitle;

  /// No description provided for @prayerNotificationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Prayer notifications'**
  String get prayerNotificationsLabel;

  /// No description provided for @prayerNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get a gentle reminder when each prayer time begins.'**
  String get prayerNotificationsSubtitle;

  /// No description provided for @qiblaButton.
  ///
  /// In en, this message translates to:
  /// **'Qibla direction'**
  String get qiblaButton;

  /// No description provided for @qiblaTitle.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get qiblaTitle;

  /// No description provided for @qiblaFacingIt.
  ///
  /// In en, this message translates to:
  /// **'You\'re facing the Qibla'**
  String get qiblaFacingIt;

  /// No description provided for @qiblaCalibrateHint.
  ///
  /// In en, this message translates to:
  /// **'Move your phone in a figure-eight to calibrate the compass'**
  String get qiblaCalibrateHint;

  /// No description provided for @qiblaPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location access is needed to find the Qibla direction.'**
  String get qiblaPermissionDenied;

  /// No description provided for @qiblaLocationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t determine your location. Check your connection and try again.'**
  String get qiblaLocationUnavailable;

  /// No description provided for @qiblaSensorUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This device doesn\'t have a compass sensor.'**
  String get qiblaSensorUnavailable;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @quranTitle.
  ///
  /// In en, this message translates to:
  /// **'The Noble Quran'**
  String get quranTitle;

  /// No description provided for @quranSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search surah by name or number'**
  String get quranSearchHint;

  /// No description provided for @quranNoSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No surah matches “{query}”'**
  String quranNoSearchResults(String query);

  /// No description provided for @quranSurahsHeader.
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get quranSurahsHeader;

  /// No description provided for @quranStartReadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Begin your reading'**
  String get quranStartReadingTitle;

  /// No description provided for @quranStartReadingBody.
  ///
  /// In en, this message translates to:
  /// **'Open Al-Fatihah and your place will be kept here.'**
  String get quranStartReadingBody;

  /// No description provided for @quranProgressAyahOf.
  ///
  /// In en, this message translates to:
  /// **'Ayah {ayah} of {total}'**
  String quranProgressAyahOf(int ayah, int total);

  /// No description provided for @quranAyahCount.
  ///
  /// In en, this message translates to:
  /// **'{count} ayahs'**
  String quranAyahCount(int count);

  /// No description provided for @quranMeccan.
  ///
  /// In en, this message translates to:
  /// **'Meccan'**
  String get quranMeccan;

  /// No description provided for @quranMedinan.
  ///
  /// In en, this message translates to:
  /// **'Medinan'**
  String get quranMedinan;

  /// No description provided for @quranBookmarksTitle.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get quranBookmarksTitle;

  /// No description provided for @quranBookmarksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} saved ayahs'**
  String quranBookmarksCount(int count);

  /// No description provided for @quranBookmarksEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get quranBookmarksEmptyTitle;

  /// No description provided for @quranBookmarksEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Tap the bookmark on any ayah to keep it here.'**
  String get quranBookmarksEmptyBody;

  /// No description provided for @quranRemoveBookmark.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get quranRemoveBookmark;

  /// No description provided for @quranJuzAyahRange.
  ///
  /// In en, this message translates to:
  /// **'Juz {juz} • Ayah {from}–{to}'**
  String quranJuzAyahRange(int juz, int from, int to);

  /// No description provided for @quranModeRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get quranModeRead;

  /// No description provided for @quranModeTranslation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get quranModeTranslation;

  /// No description provided for @quranModeTafsir.
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get quranModeTafsir;

  /// No description provided for @quranTafsirUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Tafsir isn\'t available yet'**
  String get quranTafsirUnavailableTitle;

  /// No description provided for @quranTafsirUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'We only show commentary from a licensed, clearly attributed source. Until one is added, read the translation or consult a trusted scholar.'**
  String get quranTafsirUnavailableBody;

  /// No description provided for @quranAyahSelected.
  ///
  /// In en, this message translates to:
  /// **'Ayah {number} • Selected'**
  String quranAyahSelected(int number);

  /// No description provided for @quranSurahCitation.
  ///
  /// In en, this message translates to:
  /// **'Surah {name} {reference}'**
  String quranSurahCitation(String name, String reference);

  /// No description provided for @quranReflectionPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Reflection focus'**
  String get quranReflectionPromptTitle;

  /// No description provided for @quranReflectionPromptBody.
  ///
  /// In en, this message translates to:
  /// **'Sit with this ayah for a moment. What is it inviting you to notice today?'**
  String get quranReflectionPromptBody;

  /// No description provided for @quranActionListen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get quranActionListen;

  /// No description provided for @quranActionBookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get quranActionBookmark;

  /// No description provided for @quranActionBookmarked.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get quranActionBookmarked;

  /// No description provided for @quranActionReflect.
  ///
  /// In en, this message translates to:
  /// **'Reflect'**
  String get quranActionReflect;

  /// No description provided for @quranActionShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get quranActionShare;

  /// No description provided for @quranActionCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get quranActionCopy;

  /// No description provided for @quranCopied.
  ///
  /// In en, this message translates to:
  /// **'Ayah copied to clipboard'**
  String get quranCopied;

  /// No description provided for @quranShareCopied.
  ///
  /// In en, this message translates to:
  /// **'Ayah copied — paste it anywhere to share'**
  String get quranShareCopied;

  /// No description provided for @quranBookmarkAdded.
  ///
  /// In en, this message translates to:
  /// **'Ayah bookmarked'**
  String get quranBookmarkAdded;

  /// No description provided for @quranBookmarkRemoved.
  ///
  /// In en, this message translates to:
  /// **'Bookmark removed'**
  String get quranBookmarkRemoved;

  /// No description provided for @quranReciterName.
  ///
  /// In en, this message translates to:
  /// **'Mishary Rashid Alafasy'**
  String get quranReciterName;

  /// No description provided for @quranAudioUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Recitation couldn\'t be played right now'**
  String get quranAudioUnavailable;

  /// No description provided for @quranPlayRecitation.
  ///
  /// In en, this message translates to:
  /// **'Play recitation'**
  String get quranPlayRecitation;

  /// No description provided for @quranPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get quranPause;

  /// No description provided for @quranPlay.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get quranPlay;

  /// No description provided for @quranPreviousAyah.
  ///
  /// In en, this message translates to:
  /// **'Previous ayah'**
  String get quranPreviousAyah;

  /// No description provided for @quranNextAyah.
  ///
  /// In en, this message translates to:
  /// **'Next ayah'**
  String get quranNextAyah;

  /// No description provided for @quranStopRecitation.
  ///
  /// In en, this message translates to:
  /// **'Stop recitation'**
  String get quranStopRecitation;

  /// No description provided for @quranTextSize.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get quranTextSize;

  /// No description provided for @quranTextSizeReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get quranTextSizeReset;

  /// No description provided for @quranReflectTitle.
  ///
  /// In en, this message translates to:
  /// **'Reflect on this ayah'**
  String get quranReflectTitle;

  /// No description provided for @quranReflectHint.
  ///
  /// In en, this message translates to:
  /// **'Write what this ayah stirs in your heart…'**
  String get quranReflectHint;

  /// No description provided for @quranReflectSave.
  ///
  /// In en, this message translates to:
  /// **'Save reflection'**
  String get quranReflectSave;

  /// No description provided for @quranReflectionSaved.
  ///
  /// In en, this message translates to:
  /// **'Reflection saved'**
  String get quranReflectionSaved;

  /// No description provided for @quranLoadError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load this surah. Please try again.'**
  String get quranLoadError;

  /// No description provided for @quranOfflineNotCached.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline and this surah isn\'t saved yet. Connect once and it will be kept for offline reading.'**
  String get quranOfflineNotCached;

  /// No description provided for @quranSurahNotFound.
  ///
  /// In en, this message translates to:
  /// **'This surah could not be found.'**
  String get quranSurahNotFound;

  /// No description provided for @quranTranslatorLabel.
  ///
  /// In en, this message translates to:
  /// **'Sahih International'**
  String get quranTranslatorLabel;

  /// No description provided for @journeyEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Spiritual sanctuary'**
  String get journeyEyebrow;

  /// No description provided for @journeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Journey'**
  String get journeyTitle;

  /// No description provided for @journeyGardenName.
  ///
  /// In en, this message translates to:
  /// **'بُسْتَانُ السَّكِينَةِ'**
  String get journeyGardenName;

  /// No description provided for @journeyLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String journeyLevel(int level);

  /// No description provided for @journeyXpProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} / {target} XP'**
  String journeyXpProgress(int current, int target);

  /// No description provided for @journeyLevelCaption.
  ///
  /// In en, this message translates to:
  /// **'Growing with consistency'**
  String get journeyLevelCaption;

  /// No description provided for @journeyStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Your garden awaits} =1{1 day of consistency} other{{count} days of consistency}}'**
  String journeyStreakDays(int count);

  /// No description provided for @journeyStageSeed.
  ///
  /// In en, this message translates to:
  /// **'Seed'**
  String get journeyStageSeed;

  /// No description provided for @journeyStageSprout.
  ///
  /// In en, this message translates to:
  /// **'Sprout'**
  String get journeyStageSprout;

  /// No description provided for @journeyStageSapling.
  ///
  /// In en, this message translates to:
  /// **'Sapling'**
  String get journeyStageSapling;

  /// No description provided for @journeyStageBlooming.
  ///
  /// In en, this message translates to:
  /// **'Blooming'**
  String get journeyStageBlooming;

  /// No description provided for @journeyStageFlourishing.
  ///
  /// In en, this message translates to:
  /// **'Flourishing tree'**
  String get journeyStageFlourishing;

  /// No description provided for @journeyStageMessageSeed.
  ///
  /// In en, this message translates to:
  /// **'Every garden begins with a single seed. One small act today plants yours.'**
  String get journeyStageMessageSeed;

  /// No description provided for @journeyStageMessageSprout.
  ///
  /// In en, this message translates to:
  /// **'Your first roots are taking hold. Gentle steps, kept up, go a long way.'**
  String get journeyStageMessageSprout;

  /// No description provided for @journeyStageMessageSapling.
  ///
  /// In en, this message translates to:
  /// **'Steady and growing. Your small daily moments are adding up.'**
  String get journeyStageMessageSapling;

  /// No description provided for @journeyStageMessageBlooming.
  ///
  /// In en, this message translates to:
  /// **'Your garden is blooming. Keep tending it, one calm day at a time.'**
  String get journeyStageMessageBlooming;

  /// No description provided for @journeyStageMessageFlourishing.
  ///
  /// In en, this message translates to:
  /// **'A flourishing tree, rooted in steady days. Rest in its shade and keep tending it.'**
  String get journeyStageMessageFlourishing;

  /// No description provided for @journeyStageProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} → {next}'**
  String journeyStageProgress(String current, String next);

  /// No description provided for @journeyNextInDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Next in 1 day} other{Next in {count} days}}'**
  String journeyNextInDays(int count);

  /// No description provided for @journeyStageMax.
  ///
  /// In en, this message translates to:
  /// **'Fully grown'**
  String get journeyStageMax;

  /// No description provided for @journeyStreakTitle.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get journeyStreakTitle;

  /// No description provided for @journeyDaysUnit.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{day} other{days}}'**
  String journeyDaysUnit(int count);

  /// No description provided for @journeyBestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best: {count}'**
  String journeyBestStreak(int count);

  /// No description provided for @journeyStreakOpenToday.
  ///
  /// In en, this message translates to:
  /// **'Today is still open — any small act keeps it going.'**
  String get journeyStreakOpenToday;

  /// No description provided for @journeyStreakTendedToday.
  ///
  /// In en, this message translates to:
  /// **'Today is tended. Well done.'**
  String get journeyStreakTendedToday;

  /// No description provided for @journeyStreakStart.
  ///
  /// In en, this message translates to:
  /// **'Begin today — a prayer, an ayah or a dhikr counts.'**
  String get journeyStreakStart;

  /// No description provided for @journeyLevelCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Growth level'**
  String get journeyLevelCardTitle;

  /// No description provided for @journeyXpToNext.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP to next level'**
  String journeyXpToNext(int xp);

  /// No description provided for @journeyXpNote.
  ///
  /// In en, this message translates to:
  /// **'XP is just a gentle mirror of your consistency — not a measure of reward.'**
  String get journeyXpNote;

  /// No description provided for @journeyWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get journeyWeekTitle;

  /// No description provided for @journeyActiveDays.
  ///
  /// In en, this message translates to:
  /// **'{count} / 7 active days'**
  String journeyActiveDays(int count);

  /// No description provided for @journeyDeedsThisWeek.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No daily deeds completed yet} =1{1 daily deed completed} other{{count} daily deeds completed}}'**
  String journeyDeedsThisWeek(int count);

  /// No description provided for @journeyHabitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly habits'**
  String get journeyHabitsTitle;

  /// No description provided for @journeyHabitReflection.
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get journeyHabitReflection;

  /// No description provided for @journeyHabitDays.
  ///
  /// In en, this message translates to:
  /// **'{count} / 7 days'**
  String journeyHabitDays(int count);

  /// No description provided for @journeyAyahsTotal.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 ayah} other{{count} ayahs}}'**
  String journeyAyahsTotal(int count);

  /// No description provided for @journeyPrayersTotal.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 prayer} other{{count} prayers}}'**
  String journeyPrayersTotal(int count);

  /// No description provided for @journeyDhikrTotal.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 dhikr} other{{count} dhikr}}'**
  String journeyDhikrTotal(int count);

  /// No description provided for @journeyReflectionsTotal.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 reflection} other{{count} reflections}}'**
  String journeyReflectionsTotal(int count);

  /// No description provided for @journeyGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your intentions'**
  String get journeyGoalsTitle;

  /// No description provided for @journeyGoalsDefaultHint.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t chosen focus areas yet — here are gentle places to begin.'**
  String get journeyGoalsDefaultHint;

  /// No description provided for @journeyGoalPrayerProgress.
  ///
  /// In en, this message translates to:
  /// **'{count} / 5 prayers today'**
  String journeyGoalPrayerProgress(int count);

  /// No description provided for @journeyGoalQuranProgress.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No ayahs read yet today} =1{1 ayah read today} other{{count} ayahs read today}}'**
  String journeyGoalQuranProgress(int count);

  /// No description provided for @journeyGoalDhikrProgress.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No dhikr yet today} =1{1 dhikr today} other{{count} dhikr today}}'**
  String journeyGoalDhikrProgress(int count);

  /// No description provided for @journeyGoalConsistencyProgress.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Begin your streak today} =1{1-day streak} other{{count}-day streak}}'**
  String journeyGoalConsistencyProgress(int count);

  /// No description provided for @journeyGoalDuaHint.
  ///
  /// In en, this message translates to:
  /// **'Explore du\'as for today'**
  String get journeyGoalDuaHint;

  /// No description provided for @journeyGoalMemorizationHint.
  ///
  /// In en, this message translates to:
  /// **'Continue in the Quran reader'**
  String get journeyGoalMemorizationHint;

  /// No description provided for @journeyGoalDoneToday.
  ///
  /// In en, this message translates to:
  /// **'Done today'**
  String get journeyGoalDoneToday;

  /// No description provided for @journeyMilestonesTitle.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get journeyMilestonesTitle;

  /// No description provided for @journeyMilestonesCount.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} reached'**
  String journeyMilestonesCount(int done, int total);

  /// No description provided for @journeyMilestoneFirstStep.
  ///
  /// In en, this message translates to:
  /// **'First step'**
  String get journeyMilestoneFirstStep;

  /// No description provided for @journeyMilestoneFirstReflection.
  ///
  /// In en, this message translates to:
  /// **'First reflection'**
  String get journeyMilestoneFirstReflection;

  /// No description provided for @journeyMilestoneFivePrayers.
  ///
  /// In en, this message translates to:
  /// **'All five prayers in a day'**
  String get journeyMilestoneFivePrayers;

  /// No description provided for @journeyMilestoneAyahs100.
  ///
  /// In en, this message translates to:
  /// **'100 ayahs read'**
  String get journeyMilestoneAyahs100;

  /// No description provided for @journeyMilestoneStreak7.
  ///
  /// In en, this message translates to:
  /// **'7-day streak'**
  String get journeyMilestoneStreak7;

  /// No description provided for @journeyMilestoneStreak30.
  ///
  /// In en, this message translates to:
  /// **'30-day streak'**
  String get journeyMilestoneStreak30;

  /// No description provided for @journeyMilestoneLevel5.
  ///
  /// In en, this message translates to:
  /// **'Reached level 5'**
  String get journeyMilestoneLevel5;

  /// No description provided for @journeyMilestoneLocked.
  ///
  /// In en, this message translates to:
  /// **'Not reached yet'**
  String get journeyMilestoneLocked;

  /// No description provided for @journeyStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Plant your first seed'**
  String get journeyStartTitle;

  /// No description provided for @journeyStartBody.
  ///
  /// In en, this message translates to:
  /// **'Your garden grows from small, steady moments. Choose one to begin.'**
  String get journeyStartBody;

  /// No description provided for @journeyActionLogPrayer.
  ///
  /// In en, this message translates to:
  /// **'Log a prayer'**
  String get journeyActionLogPrayer;

  /// No description provided for @journeyActionRead.
  ///
  /// In en, this message translates to:
  /// **'Read Quran'**
  String get journeyActionRead;

  /// No description provided for @journeyActionDhikr.
  ///
  /// In en, this message translates to:
  /// **'Begin dhikr'**
  String get journeyActionDhikr;

  /// No description provided for @journeyActionReflect.
  ///
  /// In en, this message translates to:
  /// **'Write today\'s reflection'**
  String get journeyActionReflect;

  /// No description provided for @journeyError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load your journey.'**
  String get journeyError;

  /// No description provided for @dhikrBrandSubtitle.
  ///
  /// In en, this message translates to:
  /// **'سكينة • طمأنينة'**
  String get dhikrBrandSubtitle;

  /// No description provided for @dhikrProfileTooltip.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get dhikrProfileTooltip;

  /// No description provided for @dhikrEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Mindful remembrance'**
  String get dhikrEyebrow;

  /// No description provided for @dhikrTitle.
  ///
  /// In en, this message translates to:
  /// **'Dhikr & Sanctuary'**
  String get dhikrTitle;

  /// No description provided for @dhikrTitleArabic.
  ///
  /// In en, this message translates to:
  /// **'الأذكار والسكينة'**
  String get dhikrTitleArabic;

  /// No description provided for @dhikrTabCounter.
  ///
  /// In en, this message translates to:
  /// **'Tasbeeh Counter'**
  String get dhikrTabCounter;

  /// No description provided for @dhikrTabGarden.
  ///
  /// In en, this message translates to:
  /// **'Garden Journey'**
  String get dhikrTabGarden;

  /// No description provided for @dhikrCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get dhikrCategoryAll;

  /// No description provided for @dhikrCategoryAfterPrayer.
  ///
  /// In en, this message translates to:
  /// **'After Prayer'**
  String get dhikrCategoryAfterPrayer;

  /// No description provided for @dhikrCategoryMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning Adhkar'**
  String get dhikrCategoryMorning;

  /// No description provided for @dhikrCategoryEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening Adhkar'**
  String get dhikrCategoryEvening;

  /// No description provided for @dhikrCategoryAnytime.
  ///
  /// In en, this message translates to:
  /// **'Anytime'**
  String get dhikrCategoryAnytime;

  /// No description provided for @dhikrCompletedOf.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} completed'**
  String dhikrCompletedOf(int completed, int total);

  /// No description provided for @dhikrCurrentCycle.
  ///
  /// In en, this message translates to:
  /// **'Current cycle'**
  String get dhikrCurrentCycle;

  /// No description provided for @dhikrAllDoneToday.
  ///
  /// In en, this message translates to:
  /// **'All completed today — may Allah accept'**
  String get dhikrAllDoneToday;

  /// No description provided for @dhikrTimes.
  ///
  /// In en, this message translates to:
  /// **'{count} times'**
  String dhikrTimes(int count);

  /// No description provided for @dhikrTodayProgress.
  ///
  /// In en, this message translates to:
  /// **'Today {count} / {target}'**
  String dhikrTodayProgress(int count, int target);

  /// No description provided for @dhikrSource.
  ///
  /// In en, this message translates to:
  /// **'Source: {source}'**
  String dhikrSource(String source);

  /// No description provided for @dhikrSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Adhkar Sanctuary'**
  String get dhikrSectionTitle;

  /// No description provided for @dhikrAuthenticBadge.
  ///
  /// In en, this message translates to:
  /// **'Sourced from hadith'**
  String get dhikrAuthenticBadge;

  /// No description provided for @dhikrDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get dhikrDone;

  /// No description provided for @dhikrGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get dhikrGoal;

  /// No description provided for @dhikrTapToCount.
  ///
  /// In en, this message translates to:
  /// **'Tap to count'**
  String get dhikrTapToCount;

  /// No description provided for @dhikrCounterSemantics.
  ///
  /// In en, this message translates to:
  /// **'Tap to count. {count} of {target}'**
  String dhikrCounterSemantics(int count, int target);

  /// No description provided for @dhikrReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get dhikrReset;

  /// No description provided for @dhikrResetConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset today\'s count?'**
  String get dhikrResetConfirmTitle;

  /// No description provided for @dhikrResetConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Today\'s count for this dhikr will go back to zero.'**
  String get dhikrResetConfirmBody;

  /// No description provided for @dhikrCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dhikrCancel;

  /// No description provided for @dhikrUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get dhikrUndo;

  /// No description provided for @dhikrHapticsOn.
  ///
  /// In en, this message translates to:
  /// **'Gentle'**
  String get dhikrHapticsOn;

  /// No description provided for @dhikrHapticsOff.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get dhikrHapticsOff;

  /// No description provided for @dhikrHapticsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Haptic feedback'**
  String get dhikrHapticsTooltip;

  /// No description provided for @dhikrTargetTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change target'**
  String get dhikrTargetTooltip;

  /// No description provided for @dhikrTargetReached.
  ///
  /// In en, this message translates to:
  /// **'Target reached — may Allah accept. You may keep going.'**
  String get dhikrTargetReached;

  /// No description provided for @dhikrNext.
  ///
  /// In en, this message translates to:
  /// **'Next: {name}'**
  String dhikrNext(String name);

  /// No description provided for @dhikrSetComplete.
  ///
  /// In en, this message translates to:
  /// **'Set complete — may Allah accept'**
  String get dhikrSetComplete;

  /// No description provided for @dhikrBackToList.
  ///
  /// In en, this message translates to:
  /// **'Back to adhkar'**
  String get dhikrBackToList;

  /// No description provided for @dhikrNotFound.
  ///
  /// In en, this message translates to:
  /// **'This dhikr could not be found.'**
  String get dhikrNotFound;

  /// No description provided for @dhikrGardenEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Today\'s remembrance'**
  String get dhikrGardenEyebrow;

  /// No description provided for @dhikrGardenTitle.
  ///
  /// In en, this message translates to:
  /// **'Your garden grows with every dhikr'**
  String get dhikrGardenTitle;

  /// No description provided for @dhikrTodayCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Dhikr today'**
  String get dhikrTodayCountLabel;

  /// No description provided for @dhikrCompletedLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get dhikrCompletedLabel;

  /// No description provided for @dhikrWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get dhikrWeekTitle;

  /// No description provided for @dhikrDaysActive.
  ///
  /// In en, this message translates to:
  /// **'{count} of 7 days'**
  String dhikrDaysActive(int count);

  /// No description provided for @dhikrOpenGarden.
  ///
  /// In en, this message translates to:
  /// **'Open your garden'**
  String get dhikrOpenGarden;

  /// No description provided for @duasLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Du\'as Sanctuary'**
  String get duasLibraryTitle;

  /// No description provided for @duasLibrarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Authentic supplications from the Quran'**
  String get duasLibrarySubtitle;

  /// No description provided for @duasSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by need or feeling'**
  String get duasSearchHint;

  /// No description provided for @duasClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get duasClearSearch;

  /// No description provided for @duasCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get duasCategoryAll;

  /// No description provided for @duasCategoryForgiveness.
  ///
  /// In en, this message translates to:
  /// **'Forgiveness'**
  String get duasCategoryForgiveness;

  /// No description provided for @duasCategoryPatience.
  ///
  /// In en, this message translates to:
  /// **'Patience'**
  String get duasCategoryPatience;

  /// No description provided for @duasCategoryGuidance.
  ///
  /// In en, this message translates to:
  /// **'Guidance'**
  String get duasCategoryGuidance;

  /// No description provided for @duasCategoryFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get duasCategoryFamily;

  /// No description provided for @duasCategoryKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Knowledge'**
  String get duasCategoryKnowledge;

  /// No description provided for @duasCategoryHardship.
  ///
  /// In en, this message translates to:
  /// **'Hardship & relief'**
  String get duasCategoryHardship;

  /// No description provided for @duasCategoryGratitude.
  ///
  /// In en, this message translates to:
  /// **'Gratitude'**
  String get duasCategoryGratitude;

  /// No description provided for @duasShowSaved.
  ///
  /// In en, this message translates to:
  /// **'Show saved du\'as'**
  String get duasShowSaved;

  /// No description provided for @duasShowAll.
  ///
  /// In en, this message translates to:
  /// **'Show all du\'as'**
  String get duasShowAll;

  /// No description provided for @duasSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved du\'as'**
  String get duasSavedTitle;

  /// No description provided for @duasFeaturedLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily featured'**
  String get duasFeaturedLabel;

  /// No description provided for @duasQuranSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Du\'as from the Quran'**
  String get duasQuranSectionTitle;

  /// No description provided for @duasQuranSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Supplications of the prophets and the believers'**
  String get duasQuranSectionSubtitle;

  /// No description provided for @duasCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 du\'a} other{{count} du\'as}}'**
  String duasCount(int count);

  /// No description provided for @duasNoResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'No du\'as found'**
  String get duasNoResultsTitle;

  /// No description provided for @duasNoResultsMessage.
  ///
  /// In en, this message translates to:
  /// **'Try another word or category.'**
  String get duasNoResultsMessage;

  /// No description provided for @duasNoSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'No saved du\'as yet'**
  String get duasNoSavedTitle;

  /// No description provided for @duasNoSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap the bookmark on any du\'a to keep it here.'**
  String get duasNoSavedMessage;

  /// No description provided for @duasSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get duasSave;

  /// No description provided for @duasSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get duasSaved;

  /// No description provided for @duasSaveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Save du\'a'**
  String get duasSaveTooltip;

  /// No description provided for @duasUnsaveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from saved'**
  String get duasUnsaveTooltip;

  /// No description provided for @duasCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get duasCopy;

  /// No description provided for @duasCopied.
  ///
  /// In en, this message translates to:
  /// **'Du\'a copied'**
  String get duasCopied;

  /// No description provided for @duasTranslationBy.
  ///
  /// In en, this message translates to:
  /// **'Translation: {translator}'**
  String duasTranslationBy(String translator);

  /// No description provided for @duasQuranReference.
  ///
  /// In en, this message translates to:
  /// **'Quran {verse}'**
  String duasQuranReference(String verse);

  /// No description provided for @duasOpenInQuran.
  ///
  /// In en, this message translates to:
  /// **'Open in Quran'**
  String get duasOpenInQuran;

  /// No description provided for @duasReciteTitle.
  ///
  /// In en, this message translates to:
  /// **'Recite'**
  String get duasReciteTitle;

  /// No description provided for @duasReciteHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to count your recitations'**
  String get duasReciteHint;

  /// No description provided for @duasReciteCountSemantics.
  ///
  /// In en, this message translates to:
  /// **'Recited {count} times'**
  String duasReciteCountSemantics(int count);

  /// No description provided for @duasReciteReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get duasReciteReset;

  /// No description provided for @duasLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the du\'a library.'**
  String get duasLoadError;

  /// No description provided for @duasNotFound.
  ///
  /// In en, this message translates to:
  /// **'This du\'a couldn\'t be found.'**
  String get duasNotFound;

  /// No description provided for @duasDhikrCardEyebrow.
  ///
  /// In en, this message translates to:
  /// **'A moment of stillness'**
  String get duasDhikrCardEyebrow;

  /// No description provided for @duasDhikrCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiet dhikr & istighfar'**
  String get duasDhikrCardTitle;

  /// No description provided for @duasDhikrCardBody.
  ///
  /// In en, this message translates to:
  /// **'Set aside a few minutes for remembrance and a calm heart.'**
  String get duasDhikrCardBody;

  /// No description provided for @duasDhikrCardAction.
  ///
  /// In en, this message translates to:
  /// **'Open dhikr'**
  String get duasDhikrCardAction;

  /// No description provided for @askTitle.
  ///
  /// In en, this message translates to:
  /// **'Ask Sakīnah'**
  String get askTitle;

  /// No description provided for @askSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A companion grounded in verified sources'**
  String get askSubtitle;

  /// No description provided for @askTopBarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verified companion & sanctuary'**
  String get askTopBarSubtitle;

  /// No description provided for @askKnowledgeEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Knowledge sanctuary'**
  String get askKnowledgeEyebrow;

  /// No description provided for @askVerifiedSources.
  ///
  /// In en, this message translates to:
  /// **'Verified sources'**
  String get askVerifiedSources;

  /// No description provided for @askInputHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about the Quran, du\'as and worship…'**
  String get askInputHint;

  /// No description provided for @askSend.
  ///
  /// In en, this message translates to:
  /// **'Send question'**
  String get askSend;

  /// No description provided for @askSuggestedTitle.
  ///
  /// In en, this message translates to:
  /// **'Suggested questions'**
  String get askSuggestedTitle;

  /// No description provided for @askSuggestionAnxiety.
  ///
  /// In en, this message translates to:
  /// **'Du\'a for anxiety and peace'**
  String get askSuggestionAnxiety;

  /// No description provided for @askSuggestionAyah.
  ///
  /// In en, this message translates to:
  /// **'What does Ayah 2:143 mean?'**
  String get askSuggestionAyah;

  /// No description provided for @askSuggestionFasting.
  ///
  /// In en, this message translates to:
  /// **'Etiquette of fasting'**
  String get askSuggestionFasting;

  /// No description provided for @askDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'For learning purposes. For personal religious rulings, consult a qualified scholar.'**
  String get askDisclaimer;

  /// No description provided for @askYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get askYou;

  /// No description provided for @askAnswerTitle.
  ///
  /// In en, this message translates to:
  /// **'Sakīnah\'s answer'**
  String get askAnswerTitle;

  /// No description provided for @askAnswerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Grounded in the sources below'**
  String get askAnswerSubtitle;

  /// No description provided for @askSourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get askSourcesTitle;

  /// No description provided for @askSourceQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran {reference}'**
  String askSourceQuran(String reference);

  /// No description provided for @askSourceHadith.
  ///
  /// In en, this message translates to:
  /// **'Hadith · {reference}'**
  String askSourceHadith(String reference);

  /// No description provided for @askNoSources.
  ///
  /// In en, this message translates to:
  /// **'No sources were returned with this answer — please treat it with caution.'**
  String get askNoSources;

  /// No description provided for @askThinking.
  ///
  /// In en, this message translates to:
  /// **'Searching verified sources…'**
  String get askThinking;

  /// No description provided for @askUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Ask Sakīnah isn\'t available yet'**
  String get askUnavailableTitle;

  /// No description provided for @askUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'re preparing a service that answers only from verified Quran and hadith sources. Until it\'s ready, you can explore the du\'a library.'**
  String get askUnavailableMessage;

  /// No description provided for @askBrowseDuas.
  ///
  /// In en, this message translates to:
  /// **'Browse du\'as'**
  String get askBrowseDuas;

  /// No description provided for @askErrorOffline.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Connect to the internet and try again.'**
  String get askErrorOffline;

  /// No description provided for @askErrorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The answer took too long. Please try again.'**
  String get askErrorTimeout;

  /// No description provided for @askErrorServer.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on our side. Please try again.'**
  String get askErrorServer;

  /// No description provided for @askErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t get an answer. Please try again.'**
  String get askErrorGeneric;

  /// No description provided for @askExploreDuasTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore du\'as'**
  String get askExploreDuasTitle;

  /// No description provided for @askCollections.
  ///
  /// In en, this message translates to:
  /// **'{count} collections'**
  String askCollections(int count);

  /// No description provided for @askFeaturedDuaLabel.
  ///
  /// In en, this message translates to:
  /// **'Featured daily du\'a'**
  String get askFeaturedDuaLabel;

  /// No description provided for @askViewLibrary.
  ///
  /// In en, this message translates to:
  /// **'View library'**
  String get askViewLibrary;

  /// No description provided for @onboardingWelcomeBadge.
  ///
  /// In en, this message translates to:
  /// **'Sanctuary of serenity'**
  String get onboardingWelcomeBadge;

  /// No description provided for @onboardingWelcomeWordmark.
  ///
  /// In en, this message translates to:
  /// **'سَكِينَة'**
  String get onboardingWelcomeWordmark;

  /// No description provided for @onboardingWelcomeFootnote.
  ///
  /// In en, this message translates to:
  /// **'Setup takes about a minute'**
  String get onboardingWelcomeFootnote;

  /// No description provided for @onboardingStepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String onboardingStepOf(int current, int total);

  /// No description provided for @onboardingSkipSetup.
  ///
  /// In en, this message translates to:
  /// **'Skip setup'**
  String get onboardingSkipSetup;

  /// No description provided for @onboardingLanguageBadge.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get onboardingLanguageBadge;

  /// No description provided for @onboardingLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language. You can change this anytime from your profile.'**
  String get onboardingLanguageSubtitle;

  /// No description provided for @onboardingLanguageEnglishDesc.
  ///
  /// In en, this message translates to:
  /// **'English interface and translations'**
  String get onboardingLanguageEnglishDesc;

  /// No description provided for @onboardingLanguageArabicDesc.
  ///
  /// In en, this message translates to:
  /// **'Full Arabic interface, right to left'**
  String get onboardingLanguageArabicDesc;

  /// No description provided for @onboardingLanguageNote.
  ///
  /// In en, this message translates to:
  /// **'Quran verses are always shown in their original Arabic script, whichever language you choose.'**
  String get onboardingLanguageNote;

  /// No description provided for @onboardingLocationHeadline.
  ///
  /// In en, this message translates to:
  /// **'Accurate prayer times & Qibla'**
  String get onboardingLocationHeadline;

  /// No description provided for @onboardingLocationAutoTitle.
  ///
  /// In en, this message translates to:
  /// **'Automatic precision'**
  String get onboardingLocationAutoTitle;

  /// No description provided for @onboardingLocationAutoBody.
  ///
  /// In en, this message translates to:
  /// **'Uses your location to calculate local prayer times and the Qibla direction.'**
  String get onboardingLocationAutoBody;

  /// No description provided for @onboardingRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get onboardingRecommended;

  /// No description provided for @onboardingLocationPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy first: your coordinates stay on your device and are never shared.'**
  String get onboardingLocationPrivacy;

  /// No description provided for @onboardingLocationGranted.
  ///
  /// In en, this message translates to:
  /// **'Location enabled — prayer times will follow where you are.'**
  String get onboardingLocationGranted;

  /// No description provided for @onboardingLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location is off. Prayer times will be approximate until you allow it in system settings.'**
  String get onboardingLocationDenied;

  /// No description provided for @onboardingSettingsHint.
  ///
  /// In en, this message translates to:
  /// **'You can change this anytime from your profile.'**
  String get onboardingSettingsHint;

  /// No description provided for @onboardingPrayerPrefsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the method your local mosque follows. If you\'re unsure, the default works well for most regions.'**
  String get onboardingPrayerPrefsSubtitle;

  /// No description provided for @onboardingCalcAuthority.
  ///
  /// In en, this message translates to:
  /// **'Calculation authority'**
  String get onboardingCalcAuthority;

  /// No description provided for @onboardingMethodAngles.
  ///
  /// In en, this message translates to:
  /// **'Fajr {fajr}°, Isha {isha}°'**
  String onboardingMethodAngles(String fajr, String isha);

  /// No description provided for @onboardingMethodAnglesInterval.
  ///
  /// In en, this message translates to:
  /// **'Fajr {fajr}°, Isha {minutes} min after Maghrib'**
  String onboardingMethodAnglesInterval(String fajr, int minutes);

  /// No description provided for @onboardingMethodMwl.
  ///
  /// In en, this message translates to:
  /// **'Muslim World League'**
  String get onboardingMethodMwl;

  /// No description provided for @onboardingMethodEgyptian.
  ///
  /// In en, this message translates to:
  /// **'Egyptian General Authority of Survey'**
  String get onboardingMethodEgyptian;

  /// No description provided for @onboardingMethodKarachi.
  ///
  /// In en, this message translates to:
  /// **'University of Islamic Sciences, Karachi'**
  String get onboardingMethodKarachi;

  /// No description provided for @onboardingMethodUmmAlQura.
  ///
  /// In en, this message translates to:
  /// **'Umm al-Qura University, Makkah'**
  String get onboardingMethodUmmAlQura;

  /// No description provided for @onboardingMethodIsna.
  ///
  /// In en, this message translates to:
  /// **'Islamic Society of North America (ISNA)'**
  String get onboardingMethodIsna;

  /// No description provided for @onboardingMethodGulf.
  ///
  /// In en, this message translates to:
  /// **'Gulf Region'**
  String get onboardingMethodGulf;

  /// No description provided for @onboardingMethodSingapore.
  ///
  /// In en, this message translates to:
  /// **'Singapore'**
  String get onboardingMethodSingapore;

  /// No description provided for @onboardingMethodTurkiye.
  ///
  /// In en, this message translates to:
  /// **'Türkiye (Diyanet)'**
  String get onboardingMethodTurkiye;

  /// No description provided for @onboardingMethodMoonsighting.
  ///
  /// In en, this message translates to:
  /// **'Moonsighting Committee'**
  String get onboardingMethodMoonsighting;

  /// No description provided for @onboardingMadhabSection.
  ///
  /// In en, this message translates to:
  /// **'Asr calculation (madhab)'**
  String get onboardingMadhabSection;

  /// No description provided for @onboardingMadhabStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get onboardingMadhabStandard;

  /// No description provided for @onboardingMadhabStandardSchools.
  ///
  /// In en, this message translates to:
  /// **'Shafi\'i, Maliki, Hanbali'**
  String get onboardingMadhabStandardSchools;

  /// No description provided for @onboardingMadhabStandardDesc.
  ///
  /// In en, this message translates to:
  /// **'Asr begins when a shadow equals the object\'s length'**
  String get onboardingMadhabStandardDesc;

  /// No description provided for @onboardingMadhabHanafi.
  ///
  /// In en, this message translates to:
  /// **'Hanafi'**
  String get onboardingMadhabHanafi;

  /// No description provided for @onboardingMadhabHanafiSchools.
  ///
  /// In en, this message translates to:
  /// **'Later Asr'**
  String get onboardingMadhabHanafiSchools;

  /// No description provided for @onboardingMadhabHanafiDesc.
  ///
  /// In en, this message translates to:
  /// **'Asr begins when a shadow is twice the object\'s length'**
  String get onboardingMadhabHanafiDesc;

  /// No description provided for @onboardingConfirmContinue.
  ///
  /// In en, this message translates to:
  /// **'Confirm & continue'**
  String get onboardingConfirmContinue;

  /// No description provided for @onboardingNotificationsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Peaceful reminders'**
  String get onboardingNotificationsHeadline;

  /// No description provided for @onboardingNotifPrayerTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer time reminders'**
  String get onboardingNotifPrayerTitle;

  /// No description provided for @onboardingNotifPrayerBody.
  ///
  /// In en, this message translates to:
  /// **'A quiet notification as each of the five daily prayers begins.'**
  String get onboardingNotifPrayerBody;

  /// No description provided for @onboardingNotifReassurance.
  ///
  /// In en, this message translates to:
  /// **'No spam, no promotions — only prayer times.'**
  String get onboardingNotifReassurance;

  /// No description provided for @onboardingNotifEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable gentle notifications'**
  String get onboardingNotifEnable;

  /// No description provided for @onboardingDecideLater.
  ///
  /// In en, this message translates to:
  /// **'Decide later'**
  String get onboardingDecideLater;

  /// No description provided for @onboardingNotifGranted.
  ///
  /// In en, this message translates to:
  /// **'Reminders are on.'**
  String get onboardingNotifGranted;

  /// No description provided for @onboardingNotifDenied.
  ///
  /// In en, this message translates to:
  /// **'Notifications are blocked. You can allow them later in system settings.'**
  String get onboardingNotifDenied;

  /// No description provided for @onboardingGoalQuranTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Quran recitation'**
  String get onboardingGoalQuranTitle;

  /// No description provided for @onboardingGoalPrayerTitle.
  ///
  /// In en, this message translates to:
  /// **'Salah on time'**
  String get onboardingGoalPrayerTitle;

  /// No description provided for @onboardingGoalDhikrTitle.
  ///
  /// In en, this message translates to:
  /// **'Morning & evening dhikr'**
  String get onboardingGoalDhikrTitle;

  /// No description provided for @onboardingGoalDuaTitle.
  ///
  /// In en, this message translates to:
  /// **'Reflections & du\'a'**
  String get onboardingGoalDuaTitle;

  /// No description provided for @onboardingGoalConsistencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Spiritual habit garden'**
  String get onboardingGoalConsistencyTitle;

  /// No description provided for @onboardingGoalMemorizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran memorization'**
  String get onboardingGoalMemorizationTitle;

  /// No description provided for @onboardingNameLabel.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get onboardingNameLabel;

  /// No description provided for @onboardingNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name (optional)'**
  String get onboardingNameHint;

  /// No description provided for @onboardingGoalsTip.
  ///
  /// In en, this message translates to:
  /// **'Your choices only shape suggestions — nothing is locked in.'**
  String get onboardingGoalsTip;

  /// No description provided for @onboardingComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete setup'**
  String get onboardingComplete;

  /// No description provided for @profileHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your sanctuary settings'**
  String get profileHeaderSubtitle;

  /// No description provided for @profileAddName.
  ///
  /// In en, this message translates to:
  /// **'Add your name'**
  String get profileAddName;

  /// No description provided for @profileEditName.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get profileEditName;

  /// No description provided for @profileNameDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get profileNameDialogTitle;

  /// No description provided for @profileSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profileSave;

  /// No description provided for @profileCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileCancel;

  /// No description provided for @profileDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get profileDelete;

  /// No description provided for @profileSectionPrayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get profileSectionPrayer;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Prayer reminders'**
  String get profileNotifications;

  /// No description provided for @profileNotificationsBody.
  ///
  /// In en, this message translates to:
  /// **'Notify me when each prayer begins'**
  String get profileNotificationsBody;

  /// No description provided for @profileNotificationsDenied.
  ///
  /// In en, this message translates to:
  /// **'Notifications are blocked in system settings.'**
  String get profileNotificationsDenied;

  /// No description provided for @profileRefreshLocation.
  ///
  /// In en, this message translates to:
  /// **'Refresh location'**
  String get profileRefreshLocation;

  /// No description provided for @profileRefreshLocationBody.
  ///
  /// In en, this message translates to:
  /// **'Update prayer times for where you are now'**
  String get profileRefreshLocationBody;

  /// No description provided for @profileLocationUpdated.
  ///
  /// In en, this message translates to:
  /// **'Location updated — prayer times refreshed.'**
  String get profileLocationUpdated;

  /// No description provided for @profileLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission is off.'**
  String get profileLocationDenied;

  /// No description provided for @profileLocationFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t get your location. Check that location services are on and try again.'**
  String get profileLocationFailed;

  /// No description provided for @profileSectionAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get profileSectionAppearance;

  /// No description provided for @profileTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profileTheme;

  /// No description provided for @profileThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get profileThemeSystem;

  /// No description provided for @profileThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get profileThemeLight;

  /// No description provided for @profileThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get profileThemeDark;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileSectionQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get profileSectionQuran;

  /// No description provided for @profileTranslation.
  ///
  /// In en, this message translates to:
  /// **'English translation'**
  String get profileTranslation;

  /// No description provided for @profileTranslationValue.
  ///
  /// In en, this message translates to:
  /// **'Sahih International'**
  String get profileTranslationValue;

  /// No description provided for @profileSectionContent.
  ///
  /// In en, this message translates to:
  /// **'Content & sources'**
  String get profileSectionContent;

  /// No description provided for @profileSources.
  ///
  /// In en, this message translates to:
  /// **'Where our content comes from'**
  String get profileSources;

  /// No description provided for @profileSourcesBody.
  ///
  /// In en, this message translates to:
  /// **'All Quran text (Uthmani script) and its English translation (Sahih International) are retrieved from api.alquran.cloud. Every du\'a and dhikr is shown with its source reference — a Quran verse or a named hadith collection and number. Nothing religious is paraphrased or generated.'**
  String get profileSourcesBody;

  /// No description provided for @profileSectionExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get profileSectionExplore;

  /// No description provided for @profileDuasLibrary.
  ///
  /// In en, this message translates to:
  /// **'Du\'as library'**
  String get profileDuasLibrary;

  /// No description provided for @profileAskSakinah.
  ///
  /// In en, this message translates to:
  /// **'Ask Sakīnah'**
  String get profileAskSakinah;

  /// No description provided for @profileReflections.
  ///
  /// In en, this message translates to:
  /// **'My reflections'**
  String get profileReflections;

  /// No description provided for @profileSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get profileSectionAbout;

  /// No description provided for @profileAbout.
  ///
  /// In en, this message translates to:
  /// **'About Sakīnah'**
  String get profileAbout;

  /// No description provided for @profileVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String profileVersion(String version);

  /// No description provided for @profileResetOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Reset onboarding'**
  String get profileResetOnboarding;

  /// No description provided for @profileResetOnboardingBody.
  ///
  /// In en, this message translates to:
  /// **'Run the welcome setup again. Your data stays.'**
  String get profileResetOnboardingBody;

  /// No description provided for @profileResetConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset onboarding?'**
  String get profileResetConfirmTitle;

  /// No description provided for @profileResetConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll go through the welcome steps again. Your reflections, progress and saved items are kept.'**
  String get profileResetConfirmBody;

  /// No description provided for @profileResetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get profileResetConfirm;

  /// No description provided for @profileReflectionsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No reflections yet'**
  String get profileReflectionsEmptyTitle;

  /// No description provided for @profileReflectionsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Reflections you write while reading the Quran will appear here.'**
  String get profileReflectionsEmptyBody;

  /// No description provided for @profileReflectionAyahRef.
  ///
  /// In en, this message translates to:
  /// **'Quran {surah}:{ayah}'**
  String profileReflectionAyahRef(int surah, int ayah);

  /// No description provided for @profileReflectionSurahRef.
  ///
  /// In en, this message translates to:
  /// **'Surah {surah}'**
  String profileReflectionSurahRef(int surah);

  /// No description provided for @profileReflectionDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this reflection?'**
  String get profileReflectionDeleteTitle;

  /// No description provided for @profileReflectionDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This can\'t be undone.'**
  String get profileReflectionDeleteBody;

  /// No description provided for @profileReflectionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Reflection deleted'**
  String get profileReflectionDeleted;

  /// No description provided for @homeNotificationsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get homeNotificationsTooltip;

  /// No description provided for @homeNextPrayer.
  ///
  /// In en, this message translates to:
  /// **'Next prayer'**
  String get homeNextPrayer;

  /// No description provided for @homeMidnight.
  ///
  /// In en, this message translates to:
  /// **'Midnight'**
  String get homeMidnight;

  /// No description provided for @homeLastThird.
  ///
  /// In en, this message translates to:
  /// **'Last third'**
  String get homeLastThird;

  /// No description provided for @homeLocationPending.
  ///
  /// In en, this message translates to:
  /// **'Location pending'**
  String get homeLocationPending;

  /// No description provided for @homeTimelineHint.
  ///
  /// In en, this message translates to:
  /// **'Long-press a prayer that has begun to mark it as prayed.'**
  String get homeTimelineHint;

  /// No description provided for @homeQuickQibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get homeQuickQibla;

  /// No description provided for @homeQuickDuas.
  ///
  /// In en, this message translates to:
  /// **'Du\'as'**
  String get homeQuickDuas;

  /// No description provided for @homeQuickAsk.
  ///
  /// In en, this message translates to:
  /// **'Ask Sakīnah'**
  String get homeQuickAsk;

  /// No description provided for @homeDhikrTarget.
  ///
  /// In en, this message translates to:
  /// **'Target: {count}'**
  String homeDhikrTarget(int count);

  /// No description provided for @homeDhikrProgress.
  ///
  /// In en, this message translates to:
  /// **'{count} of {target} complete'**
  String homeDhikrProgress(int count, int target);

  /// No description provided for @homeQuranSurahName.
  ///
  /// In en, this message translates to:
  /// **'Surah {name}'**
  String homeQuranSurahName(String name);

  /// No description provided for @homeQuranAyahJuz.
  ///
  /// In en, this message translates to:
  /// **'Ayah {ayah} • Juz {juz}'**
  String homeQuranAyahJuz(int ayah, int juz);

  /// No description provided for @homeQuranCompletion.
  ///
  /// In en, this message translates to:
  /// **'Surah completion'**
  String get homeQuranCompletion;

  /// No description provided for @homeQuranPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String homeQuranPercent(int percent);

  /// No description provided for @homeQuranEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Begin with Al-Fatiha'**
  String get homeQuranEmptyTitle;

  /// No description provided for @homeQuranEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Your reading progress will appear here once you start.'**
  String get homeQuranEmptyBody;

  /// No description provided for @homeQuranStartReading.
  ///
  /// In en, this message translates to:
  /// **'Start reading'**
  String get homeQuranStartReading;

  /// No description provided for @homeVerseSource.
  ///
  /// In en, this message translates to:
  /// **'Quran {reference} · Sahih International'**
  String homeVerseSource(String reference);

  /// No description provided for @prayerQiblaTitle.
  ///
  /// In en, this message translates to:
  /// **'Qibla & Prayer'**
  String get prayerQiblaTitle;

  /// No description provided for @prayerTabTimes.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTabTimes;

  /// No description provided for @prayerTabQibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get prayerTabQibla;

  /// No description provided for @prayerNextPrayer.
  ///
  /// In en, this message translates to:
  /// **'Next prayer'**
  String get prayerNextPrayer;

  /// No description provided for @prayerTodaysSchedule.
  ///
  /// In en, this message translates to:
  /// **'Today\'s schedule'**
  String get prayerTodaysSchedule;

  /// No description provided for @prayerSunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get prayerSunrise;

  /// No description provided for @prayerMarkPrayed.
  ///
  /// In en, this message translates to:
  /// **'Mark {prayer} as prayed'**
  String prayerMarkPrayed(String prayer);

  /// No description provided for @prayerUnmarkPrayed.
  ///
  /// In en, this message translates to:
  /// **'Unmark {prayer}'**
  String prayerUnmarkPrayed(String prayer);

  /// No description provided for @prayerNotYetTime.
  ///
  /// In en, this message translates to:
  /// **'Not yet time'**
  String get prayerNotYetTime;

  /// No description provided for @prayerLoggedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} of 5 prayers logged today'**
  String prayerLoggedCount(int count);

  /// No description provided for @prayerCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get prayerCurrentLocation;

  /// No description provided for @prayerMadhabHanafi.
  ///
  /// In en, this message translates to:
  /// **'Hanafi'**
  String get prayerMadhabHanafi;

  /// No description provided for @prayerMadhabShafi.
  ///
  /// In en, this message translates to:
  /// **'Shafi\'i, Maliki & Hanbali'**
  String get prayerMadhabShafi;

  /// No description provided for @prayerChangeSettings.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get prayerChangeSettings;

  /// No description provided for @prayerMoreSettings.
  ///
  /// In en, this message translates to:
  /// **'More settings in Profile'**
  String get prayerMoreSettings;

  /// No description provided for @qiblaTurnRight.
  ///
  /// In en, this message translates to:
  /// **'Turn {degrees}° to the right'**
  String qiblaTurnRight(int degrees);

  /// No description provided for @qiblaTurnLeft.
  ///
  /// In en, this message translates to:
  /// **'Turn {degrees}° to the left'**
  String qiblaTurnLeft(int degrees);

  /// No description provided for @qiblaBearing.
  ///
  /// In en, this message translates to:
  /// **'Qibla bearing: {degrees}°'**
  String qiblaBearing(String degrees);

  /// No description provided for @qiblaDistance.
  ///
  /// In en, this message translates to:
  /// **'{km} km to Makkah'**
  String qiblaDistance(String km);

  /// No description provided for @qiblaWaitingForCompass.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the compass…'**
  String get qiblaWaitingForCompass;

  /// No description provided for @qiblaVerseSource.
  ///
  /// In en, this message translates to:
  /// **'Quran {reference} · Sahih International'**
  String qiblaVerseSource(String reference);

  /// No description provided for @qiblaDirN.
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get qiblaDirN;

  /// No description provided for @qiblaDirNE.
  ///
  /// In en, this message translates to:
  /// **'NE'**
  String get qiblaDirNE;

  /// No description provided for @qiblaDirE.
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get qiblaDirE;

  /// No description provided for @qiblaDirSE.
  ///
  /// In en, this message translates to:
  /// **'SE'**
  String get qiblaDirSE;

  /// No description provided for @qiblaDirS.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get qiblaDirS;

  /// No description provided for @qiblaDirSW.
  ///
  /// In en, this message translates to:
  /// **'SW'**
  String get qiblaDirSW;

  /// No description provided for @qiblaDirW.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get qiblaDirW;

  /// No description provided for @qiblaDirNW.
  ///
  /// In en, this message translates to:
  /// **'NW'**
  String get qiblaDirNW;

  /// No description provided for @quranJuzAyah.
  ///
  /// In en, this message translates to:
  /// **'Juz {juz} • Ayah {ayah}'**
  String quranJuzAyah(int juz, int ayah);

  /// No description provided for @homeGreetingNamed.
  ///
  /// In en, this message translates to:
  /// **'Assalamu Alaikum, {name}'**
  String homeGreetingNamed(String name);

  /// No description provided for @quranMenuTafseer.
  ///
  /// In en, this message translates to:
  /// **'Tafseer'**
  String get quranMenuTafseer;

  /// No description provided for @quranMenuTranslate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get quranMenuTranslate;

  /// No description provided for @quranMenuListen.
  ///
  /// In en, this message translates to:
  /// **'Listen to verses'**
  String get quranMenuListen;

  /// No description provided for @quranMenuAddFavorite.
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get quranMenuAddFavorite;

  /// No description provided for @quranMenuRemoveFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get quranMenuRemoveFavorite;

  /// No description provided for @quranTafsirSourceName.
  ///
  /// In en, this message translates to:
  /// **'Tafsir al-Muyassar — King Fahd Quran Complex'**
  String get quranTafsirSourceName;

  /// No description provided for @quranTafsirLoadError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load the tafseer. Check your connection and try again.'**
  String get quranTafsirLoadError;

  /// No description provided for @quranTranslationBy.
  ///
  /// In en, this message translates to:
  /// **'Translation: {name}'**
  String quranTranslationBy(String name);

  /// No description provided for @quranMushafDisplay.
  ///
  /// In en, this message translates to:
  /// **'Mushaf display'**
  String get quranMushafDisplay;

  /// No description provided for @quranDisplayHorizontal.
  ///
  /// In en, this message translates to:
  /// **'Horizontal'**
  String get quranDisplayHorizontal;

  /// No description provided for @quranDisplayVertical.
  ///
  /// In en, this message translates to:
  /// **'Vertical'**
  String get quranDisplayVertical;

  /// No description provided for @quranIndexTitle.
  ///
  /// In en, this message translates to:
  /// **'The index'**
  String get quranIndexTitle;

  /// No description provided for @quranSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get quranSearchTitle;

  /// No description provided for @quranAudios.
  ///
  /// In en, this message translates to:
  /// **'Audios'**
  String get quranAudios;

  /// No description provided for @quranNightMode.
  ///
  /// In en, this message translates to:
  /// **'Night mode'**
  String get quranNightMode;

  /// No description provided for @quranColorYourMushaf.
  ///
  /// In en, this message translates to:
  /// **'Color your mushaf'**
  String get quranColorYourMushaf;

  /// No description provided for @quranReferenceMarks.
  ///
  /// In en, this message translates to:
  /// **'Reference marks'**
  String get quranReferenceMarks;

  /// No description provided for @quranFeaturesSection.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get quranFeaturesSection;

  /// No description provided for @quranFavoriteSection.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get quranFavoriteSection;

  /// No description provided for @quranColorSand.
  ///
  /// In en, this message translates to:
  /// **'Sand'**
  String get quranColorSand;

  /// No description provided for @quranColorBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get quranColorBlue;

  /// No description provided for @quranColorGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get quranColorGreen;

  /// No description provided for @quranJuzLabel.
  ///
  /// In en, this message translates to:
  /// **'Juz {juz}'**
  String quranJuzLabel(int juz);

  /// No description provided for @quranPageLabel.
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String quranPageLabel(int page);

  /// No description provided for @quranQuickNavigation.
  ///
  /// In en, this message translates to:
  /// **'Quick navigation'**
  String get quranQuickNavigation;

  /// No description provided for @quranNextPage.
  ///
  /// In en, this message translates to:
  /// **'Next page'**
  String get quranNextPage;

  /// No description provided for @quranPreviousPage.
  ///
  /// In en, this message translates to:
  /// **'Previous page'**
  String get quranPreviousPage;

  /// No description provided for @quranReaderMenu.
  ///
  /// In en, this message translates to:
  /// **'Mushaf menu'**
  String get quranReaderMenu;

  /// No description provided for @quranCoachMenu.
  ///
  /// In en, this message translates to:
  /// **'Side menu: display, index, search, colours and more'**
  String get quranCoachMenu;

  /// No description provided for @quranCoachTapAyah.
  ///
  /// In en, this message translates to:
  /// **'Tap any ayah for tafseer, translation, recitation and favorites'**
  String get quranCoachTapAyah;

  /// No description provided for @quranCoachPinch.
  ///
  /// In en, this message translates to:
  /// **'Pinch with two fingers to resize the text'**
  String get quranCoachPinch;

  /// No description provided for @quranCoachQuickNav.
  ///
  /// In en, this message translates to:
  /// **'Tap the page to show quick navigation'**
  String get quranCoachQuickNav;

  /// No description provided for @quranCoachGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get quranCoachGotIt;

  /// No description provided for @quranPageNotFound.
  ///
  /// In en, this message translates to:
  /// **'This page could not be found.'**
  String get quranPageNotFound;

  /// No description provided for @quranClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get quranClose;
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
