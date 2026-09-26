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

  @override
  String get quranTitle => 'The Noble Quran';

  @override
  String get quranSearchHint => 'Search surah by name or number';

  @override
  String quranNoSearchResults(String query) {
    return 'No surah matches “$query”';
  }

  @override
  String get quranSurahsHeader => 'Surahs';

  @override
  String get quranStartReadingTitle => 'Begin your reading';

  @override
  String get quranStartReadingBody =>
      'Open Al-Fatihah and your place will be kept here.';

  @override
  String quranProgressAyahOf(int ayah, int total) {
    return 'Ayah $ayah of $total';
  }

  @override
  String quranAyahCount(int count) {
    return '$count ayahs';
  }

  @override
  String get quranMeccan => 'Meccan';

  @override
  String get quranMedinan => 'Medinan';

  @override
  String get quranBookmarksTitle => 'Bookmarks';

  @override
  String quranBookmarksCount(int count) {
    return '$count saved ayahs';
  }

  @override
  String get quranBookmarksEmptyTitle => 'No bookmarks yet';

  @override
  String get quranBookmarksEmptyBody =>
      'Tap the bookmark on any ayah to keep it here.';

  @override
  String get quranRemoveBookmark => 'Remove';

  @override
  String quranJuzAyahRange(int juz, int from, int to) {
    return 'Juz $juz • Ayah $from–$to';
  }

  @override
  String get quranModeRead => 'Read';

  @override
  String get quranModeTranslation => 'Translation';

  @override
  String get quranModeTafsir => 'Tafsir';

  @override
  String get quranTafsirUnavailableTitle => 'Tafsir isn\'t available yet';

  @override
  String get quranTafsirUnavailableBody =>
      'We only show commentary from a licensed, clearly attributed source. Until one is added, read the translation or consult a trusted scholar.';

  @override
  String quranAyahSelected(int number) {
    return 'Ayah $number • Selected';
  }

  @override
  String quranSurahCitation(String name, String reference) {
    return 'Surah $name $reference';
  }

  @override
  String get quranReflectionPromptTitle => 'Reflection focus';

  @override
  String get quranReflectionPromptBody =>
      'Sit with this ayah for a moment. What is it inviting you to notice today?';

  @override
  String get quranActionListen => 'Listen';

  @override
  String get quranActionBookmark => 'Bookmark';

  @override
  String get quranActionBookmarked => 'Saved';

  @override
  String get quranActionReflect => 'Reflect';

  @override
  String get quranActionShare => 'Share';

  @override
  String get quranActionCopy => 'Copy';

  @override
  String get quranCopied => 'Ayah copied to clipboard';

  @override
  String get quranShareCopied => 'Ayah copied — paste it anywhere to share';

  @override
  String get quranBookmarkAdded => 'Ayah bookmarked';

  @override
  String get quranBookmarkRemoved => 'Bookmark removed';

  @override
  String get quranReciterName => 'Mishary Rashid Alafasy';

  @override
  String get quranAudioUnavailable =>
      'Recitation couldn\'t be played right now';

  @override
  String get quranPlayRecitation => 'Play recitation';

  @override
  String get quranPause => 'Pause';

  @override
  String get quranPlay => 'Play';

  @override
  String get quranPreviousAyah => 'Previous ayah';

  @override
  String get quranNextAyah => 'Next ayah';

  @override
  String get quranStopRecitation => 'Stop recitation';

  @override
  String get quranTextSize => 'Text size';

  @override
  String get quranTextSizeReset => 'Reset';

  @override
  String get quranReflectTitle => 'Reflect on this ayah';

  @override
  String get quranReflectHint => 'Write what this ayah stirs in your heart…';

  @override
  String get quranReflectSave => 'Save reflection';

  @override
  String get quranReflectionSaved => 'Reflection saved';

  @override
  String get quranLoadError =>
      'We couldn\'t load this surah. Please try again.';

  @override
  String get quranOfflineNotCached =>
      'You\'re offline and this surah isn\'t saved yet. Connect once and it will be kept for offline reading.';

  @override
  String get quranSurahNotFound => 'This surah could not be found.';

  @override
  String get quranTranslatorLabel => 'Sahih International';

  @override
  String get journeyEyebrow => 'Spiritual sanctuary';

  @override
  String get journeyTitle => 'Your Journey';

  @override
  String get journeyGardenName => 'بُسْتَانُ السَّكِينَةِ';

  @override
  String journeyLevel(int level) {
    return 'Level $level';
  }

  @override
  String journeyXpProgress(int current, int target) {
    return '$current / $target XP';
  }

  @override
  String get journeyLevelCaption => 'Growing with consistency';

  @override
  String journeyStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days of consistency',
      one: '1 day of consistency',
      zero: 'Your garden awaits',
    );
    return '$_temp0';
  }

  @override
  String get journeyStageSeed => 'Seed';

  @override
  String get journeyStageSprout => 'Sprout';

  @override
  String get journeyStageSapling => 'Sapling';

  @override
  String get journeyStageBlooming => 'Blooming';

  @override
  String get journeyStageFlourishing => 'Flourishing tree';

  @override
  String get journeyStageMessageSeed =>
      'Every garden begins with a single seed. One small act today plants yours.';

  @override
  String get journeyStageMessageSprout =>
      'Your first roots are taking hold. Gentle steps, kept up, go a long way.';

  @override
  String get journeyStageMessageSapling =>
      'Steady and growing. Your small daily moments are adding up.';

  @override
  String get journeyStageMessageBlooming =>
      'Your garden is blooming. Keep tending it, one calm day at a time.';

  @override
  String get journeyStageMessageFlourishing =>
      'A flourishing tree, rooted in steady days. Rest in its shade and keep tending it.';

  @override
  String journeyStageProgress(String current, String next) {
    return '$current → $next';
  }

  @override
  String journeyNextInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Next in $count days',
      one: 'Next in 1 day',
    );
    return '$_temp0';
  }

  @override
  String get journeyStageMax => 'Fully grown';

  @override
  String get journeyStreakTitle => 'Current streak';

  @override
  String journeyDaysUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return '$_temp0';
  }

  @override
  String journeyBestStreak(int count) {
    return 'Best: $count';
  }

  @override
  String get journeyStreakOpenToday =>
      'Today is still open — any small act keeps it going.';

  @override
  String get journeyStreakTendedToday => 'Today is tended. Well done.';

  @override
  String get journeyStreakStart =>
      'Begin today — a prayer, an ayah or a dhikr counts.';

  @override
  String get journeyLevelCardTitle => 'Growth level';

  @override
  String journeyXpToNext(int xp) {
    return '$xp XP to next level';
  }

  @override
  String get journeyXpNote =>
      'XP is just a gentle mirror of your consistency — not a measure of reward.';

  @override
  String get journeyWeekTitle => 'Last 7 days';

  @override
  String journeyActiveDays(int count) {
    return '$count / 7 active days';
  }

  @override
  String journeyDeedsThisWeek(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count daily deeds completed',
      one: '1 daily deed completed',
      zero: 'No daily deeds completed yet',
    );
    return '$_temp0';
  }

  @override
  String get journeyHabitsTitle => 'Weekly habits';

  @override
  String get journeyHabitReflection => 'Reflection';

  @override
  String journeyHabitDays(int count) {
    return '$count / 7 days';
  }

  @override
  String journeyAyahsTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ayahs',
      one: '1 ayah',
    );
    return '$_temp0';
  }

  @override
  String journeyPrayersTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count prayers',
      one: '1 prayer',
    );
    return '$_temp0';
  }

  @override
  String journeyDhikrTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dhikr',
      one: '1 dhikr',
    );
    return '$_temp0';
  }

  @override
  String journeyReflectionsTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reflections',
      one: '1 reflection',
    );
    return '$_temp0';
  }

  @override
  String get journeyGoalsTitle => 'Your intentions';

  @override
  String get journeyGoalsDefaultHint =>
      'You haven\'t chosen focus areas yet — here are gentle places to begin.';

  @override
  String journeyGoalPrayerProgress(int count) {
    return '$count / 5 prayers today';
  }

  @override
  String journeyGoalQuranProgress(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ayahs read today',
      one: '1 ayah read today',
      zero: 'No ayahs read yet today',
    );
    return '$_temp0';
  }

  @override
  String journeyGoalDhikrProgress(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dhikr today',
      one: '1 dhikr today',
      zero: 'No dhikr yet today',
    );
    return '$_temp0';
  }

  @override
  String journeyGoalConsistencyProgress(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count-day streak',
      one: '1-day streak',
      zero: 'Begin your streak today',
    );
    return '$_temp0';
  }

  @override
  String get journeyGoalDuaHint => 'Explore du\'as for today';

  @override
  String get journeyGoalMemorizationHint => 'Continue in the Quran reader';

  @override
  String get journeyGoalDoneToday => 'Done today';

  @override
  String get journeyMilestonesTitle => 'Milestones';

  @override
  String journeyMilestonesCount(int done, int total) {
    return '$done of $total reached';
  }

  @override
  String get journeyMilestoneFirstStep => 'First step';

  @override
  String get journeyMilestoneFirstReflection => 'First reflection';

  @override
  String get journeyMilestoneFivePrayers => 'All five prayers in a day';

  @override
  String get journeyMilestoneAyahs100 => '100 ayahs read';

  @override
  String get journeyMilestoneStreak7 => '7-day streak';

  @override
  String get journeyMilestoneStreak30 => '30-day streak';

  @override
  String get journeyMilestoneLevel5 => 'Reached level 5';

  @override
  String get journeyMilestoneLocked => 'Not reached yet';

  @override
  String get journeyStartTitle => 'Plant your first seed';

  @override
  String get journeyStartBody =>
      'Your garden grows from small, steady moments. Choose one to begin.';

  @override
  String get journeyActionLogPrayer => 'Log a prayer';

  @override
  String get journeyActionRead => 'Read Quran';

  @override
  String get journeyActionDhikr => 'Begin dhikr';

  @override
  String get journeyActionReflect => 'Write today\'s reflection';

  @override
  String get journeyError => 'We couldn\'t load your journey.';

  @override
  String get dhikrBrandSubtitle => 'سكينة • طمأنينة';

  @override
  String get dhikrProfileTooltip => 'Profile';

  @override
  String get dhikrEyebrow => 'Mindful remembrance';

  @override
  String get dhikrTitle => 'Dhikr & Sanctuary';

  @override
  String get dhikrTitleArabic => 'الأذكار والسكينة';

  @override
  String get dhikrTabCounter => 'Tasbeeh Counter';

  @override
  String get dhikrTabGarden => 'Garden Journey';

  @override
  String get dhikrCategoryAll => 'All';

  @override
  String get dhikrCategoryAfterPrayer => 'After Prayer';

  @override
  String get dhikrCategoryMorning => 'Morning Adhkar';

  @override
  String get dhikrCategoryEvening => 'Evening Adhkar';

  @override
  String get dhikrCategoryAnytime => 'Anytime';

  @override
  String dhikrCompletedOf(int completed, int total) {
    return '$completed of $total completed';
  }

  @override
  String get dhikrCurrentCycle => 'Current cycle';

  @override
  String get dhikrAllDoneToday => 'All completed today — may Allah accept';

  @override
  String dhikrTimes(int count) {
    return '$count times';
  }

  @override
  String dhikrTodayProgress(int count, int target) {
    return 'Today $count / $target';
  }

  @override
  String dhikrSource(String source) {
    return 'Source: $source';
  }

  @override
  String get dhikrSectionTitle => 'Adhkar Sanctuary';

  @override
  String get dhikrAuthenticBadge => 'Sourced from hadith';

  @override
  String get dhikrDone => 'Done';

  @override
  String get dhikrGoal => 'Goal';

  @override
  String get dhikrTapToCount => 'Tap to count';

  @override
  String dhikrCounterSemantics(int count, int target) {
    return 'Tap to count. $count of $target';
  }

  @override
  String get dhikrReset => 'Reset';

  @override
  String get dhikrResetConfirmTitle => 'Reset today\'s count?';

  @override
  String get dhikrResetConfirmBody =>
      'Today\'s count for this dhikr will go back to zero.';

  @override
  String get dhikrCancel => 'Cancel';

  @override
  String get dhikrUndo => 'Undo';

  @override
  String get dhikrHapticsOn => 'Gentle';

  @override
  String get dhikrHapticsOff => 'Mute';

  @override
  String get dhikrHapticsTooltip => 'Haptic feedback';

  @override
  String get dhikrTargetTooltip => 'Change target';

  @override
  String get dhikrTargetReached =>
      'Target reached — may Allah accept. You may keep going.';

  @override
  String dhikrNext(String name) {
    return 'Next: $name';
  }

  @override
  String get dhikrSetComplete => 'Set complete — may Allah accept';

  @override
  String get dhikrBackToList => 'Back to adhkar';

  @override
  String get dhikrNotFound => 'This dhikr could not be found.';

  @override
  String get dhikrGardenEyebrow => 'Today\'s remembrance';

  @override
  String get dhikrGardenTitle => 'Your garden grows with every dhikr';

  @override
  String get dhikrTodayCountLabel => 'Dhikr today';

  @override
  String get dhikrCompletedLabel => 'Completed';

  @override
  String get dhikrWeekTitle => 'This week';

  @override
  String dhikrDaysActive(int count) {
    return '$count of 7 days';
  }

  @override
  String get dhikrOpenGarden => 'Open your garden';

  @override
  String get duasLibraryTitle => 'Du\'as Sanctuary';

  @override
  String get duasLibrarySubtitle => 'Authentic supplications from the Quran';

  @override
  String get duasSearchHint => 'Search by need or feeling';

  @override
  String get duasClearSearch => 'Clear search';

  @override
  String get duasCategoryAll => 'All';

  @override
  String get duasCategoryForgiveness => 'Forgiveness';

  @override
  String get duasCategoryPatience => 'Patience';

  @override
  String get duasCategoryGuidance => 'Guidance';

  @override
  String get duasCategoryFamily => 'Family';

  @override
  String get duasCategoryKnowledge => 'Knowledge';

  @override
  String get duasCategoryHardship => 'Hardship & relief';

  @override
  String get duasCategoryGratitude => 'Gratitude';

  @override
  String get duasShowSaved => 'Show saved du\'as';

  @override
  String get duasShowAll => 'Show all du\'as';

  @override
  String get duasSavedTitle => 'Saved du\'as';

  @override
  String get duasFeaturedLabel => 'Daily featured';

  @override
  String get duasQuranSectionTitle => 'Du\'as from the Quran';

  @override
  String get duasQuranSectionSubtitle =>
      'Supplications of the prophets and the believers';

  @override
  String duasCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count du\'as',
      one: '1 du\'a',
    );
    return '$_temp0';
  }

  @override
  String get duasNoResultsTitle => 'No du\'as found';

  @override
  String get duasNoResultsMessage => 'Try another word or category.';

  @override
  String get duasNoSavedTitle => 'No saved du\'as yet';

  @override
  String get duasNoSavedMessage =>
      'Tap the bookmark on any du\'a to keep it here.';

  @override
  String get duasSave => 'Save';

  @override
  String get duasSaved => 'Saved';

  @override
  String get duasSaveTooltip => 'Save du\'a';

  @override
  String get duasUnsaveTooltip => 'Remove from saved';

  @override
  String get duasCopy => 'Copy';

  @override
  String get duasCopied => 'Du\'a copied';

  @override
  String duasTranslationBy(String translator) {
    return 'Translation: $translator';
  }

  @override
  String duasQuranReference(String verse) {
    return 'Quran $verse';
  }

  @override
  String get duasOpenInQuran => 'Open in Quran';

  @override
  String get duasReciteTitle => 'Recite';

  @override
  String get duasReciteHint => 'Tap to count your recitations';

  @override
  String duasReciteCountSemantics(int count) {
    return 'Recited $count times';
  }

  @override
  String get duasReciteReset => 'Reset';

  @override
  String get duasLoadError => 'Couldn\'t load the du\'a library.';

  @override
  String get duasNotFound => 'This du\'a couldn\'t be found.';

  @override
  String get duasDhikrCardEyebrow => 'A moment of stillness';

  @override
  String get duasDhikrCardTitle => 'Quiet dhikr & istighfar';

  @override
  String get duasDhikrCardBody =>
      'Set aside a few minutes for remembrance and a calm heart.';

  @override
  String get duasDhikrCardAction => 'Open dhikr';

  @override
  String get askTitle => 'Ask Sakīnah';

  @override
  String get askSubtitle => 'A companion grounded in verified sources';

  @override
  String get askTopBarSubtitle => 'Verified companion & sanctuary';

  @override
  String get askKnowledgeEyebrow => 'Knowledge sanctuary';

  @override
  String get askVerifiedSources => 'Verified sources';

  @override
  String get askInputHint => 'Ask about the Quran, du\'as and worship…';

  @override
  String get askSend => 'Send question';

  @override
  String get askSuggestedTitle => 'Suggested questions';

  @override
  String get askSuggestionAnxiety => 'Du\'a for anxiety and peace';

  @override
  String get askSuggestionAyah => 'What does Ayah 2:143 mean?';

  @override
  String get askSuggestionFasting => 'Etiquette of fasting';

  @override
  String get askDisclaimer =>
      'For learning purposes. For personal religious rulings, consult a qualified scholar.';

  @override
  String get askYou => 'You';

  @override
  String get askAnswerTitle => 'Sakīnah\'s answer';

  @override
  String get askAnswerSubtitle => 'Grounded in the sources below';

  @override
  String get askSourcesTitle => 'Sources';

  @override
  String askSourceQuran(String reference) {
    return 'Quran $reference';
  }

  @override
  String askSourceHadith(String reference) {
    return 'Hadith · $reference';
  }

  @override
  String get askNoSources =>
      'No sources were returned with this answer — please treat it with caution.';

  @override
  String get askThinking => 'Searching verified sources…';

  @override
  String get askUnavailableTitle => 'Ask Sakīnah isn\'t available yet';

  @override
  String get askUnavailableMessage =>
      'We\'re preparing a service that answers only from verified Quran and hadith sources. Until it\'s ready, you can explore the du\'a library.';

  @override
  String get askBrowseDuas => 'Browse du\'as';

  @override
  String get askErrorOffline =>
      'You\'re offline. Connect to the internet and try again.';

  @override
  String get askErrorTimeout => 'The answer took too long. Please try again.';

  @override
  String get askErrorServer =>
      'Something went wrong on our side. Please try again.';

  @override
  String get askErrorGeneric => 'Couldn\'t get an answer. Please try again.';

  @override
  String get askExploreDuasTitle => 'Explore du\'as';

  @override
  String askCollections(int count) {
    return '$count collections';
  }

  @override
  String get askFeaturedDuaLabel => 'Featured daily du\'a';

  @override
  String get askViewLibrary => 'View library';

  @override
  String get onboardingWelcomeBadge => 'Sanctuary of serenity';

  @override
  String get onboardingWelcomeWordmark => 'سَكِينَة';

  @override
  String get onboardingWelcomeFootnote => 'Setup takes about a minute';

  @override
  String onboardingStepOf(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get onboardingSkipSetup => 'Skip setup';

  @override
  String get onboardingLanguageBadge => 'Language';

  @override
  String get onboardingLanguageSubtitle =>
      'Select your preferred language. You can change this anytime from your profile.';

  @override
  String get onboardingLanguageEnglishDesc =>
      'English interface and translations';

  @override
  String get onboardingLanguageArabicDesc =>
      'Full Arabic interface, right to left';

  @override
  String get onboardingLanguageNote =>
      'Quran verses are always shown in their original Arabic script, whichever language you choose.';

  @override
  String get onboardingLocationHeadline => 'Accurate prayer times & Qibla';

  @override
  String get onboardingLocationAutoTitle => 'Automatic precision';

  @override
  String get onboardingLocationAutoBody =>
      'Uses your location to calculate local prayer times and the Qibla direction.';

  @override
  String get onboardingRecommended => 'Recommended';

  @override
  String get onboardingLocationPrivacy =>
      'Privacy first: your coordinates stay on your device and are never shared.';

  @override
  String get onboardingLocationGranted =>
      'Location enabled — prayer times will follow where you are.';

  @override
  String get onboardingLocationDenied =>
      'Location is off. Prayer times will be approximate until you allow it in system settings.';

  @override
  String get onboardingSettingsHint =>
      'You can change this anytime from your profile.';

  @override
  String get onboardingPrayerPrefsSubtitle =>
      'Choose the method your local mosque follows. If you\'re unsure, the default works well for most regions.';

  @override
  String get onboardingCalcAuthority => 'Calculation authority';

  @override
  String onboardingMethodAngles(String fajr, String isha) {
    return 'Fajr $fajr°, Isha $isha°';
  }

  @override
  String onboardingMethodAnglesInterval(String fajr, int minutes) {
    return 'Fajr $fajr°, Isha $minutes min after Maghrib';
  }

  @override
  String get onboardingMethodMwl => 'Muslim World League';

  @override
  String get onboardingMethodEgyptian => 'Egyptian General Authority of Survey';

  @override
  String get onboardingMethodKarachi =>
      'University of Islamic Sciences, Karachi';

  @override
  String get onboardingMethodUmmAlQura => 'Umm al-Qura University, Makkah';

  @override
  String get onboardingMethodIsna => 'Islamic Society of North America (ISNA)';

  @override
  String get onboardingMethodGulf => 'Gulf Region';

  @override
  String get onboardingMethodSingapore => 'Singapore';

  @override
  String get onboardingMethodTurkiye => 'Türkiye (Diyanet)';

  @override
  String get onboardingMethodMoonsighting => 'Moonsighting Committee';

  @override
  String get onboardingMadhabSection => 'Asr calculation (madhab)';

  @override
  String get onboardingMadhabStandard => 'Standard';

  @override
  String get onboardingMadhabStandardSchools => 'Shafi\'i, Maliki, Hanbali';

  @override
  String get onboardingMadhabStandardDesc =>
      'Asr begins when a shadow equals the object\'s length';

  @override
  String get onboardingMadhabHanafi => 'Hanafi';

  @override
  String get onboardingMadhabHanafiSchools => 'Later Asr';

  @override
  String get onboardingMadhabHanafiDesc =>
      'Asr begins when a shadow is twice the object\'s length';

  @override
  String get onboardingConfirmContinue => 'Confirm & continue';

  @override
  String get onboardingNotificationsHeadline => 'Peaceful reminders';

  @override
  String get onboardingNotifPrayerTitle => 'Prayer time reminders';

  @override
  String get onboardingNotifPrayerBody =>
      'A quiet notification as each of the five daily prayers begins.';

  @override
  String get onboardingNotifReassurance =>
      'No spam, no promotions — only prayer times.';

  @override
  String get onboardingNotifEnable => 'Enable gentle notifications';

  @override
  String get onboardingDecideLater => 'Decide later';

  @override
  String get onboardingNotifGranted => 'Reminders are on.';

  @override
  String get onboardingNotifDenied =>
      'Notifications are blocked. You can allow them later in system settings.';

  @override
  String get onboardingGoalQuranTitle => 'Daily Quran recitation';

  @override
  String get onboardingGoalPrayerTitle => 'Salah on time';

  @override
  String get onboardingGoalDhikrTitle => 'Morning & evening dhikr';

  @override
  String get onboardingGoalDuaTitle => 'Reflections & du\'a';

  @override
  String get onboardingGoalConsistencyTitle => 'Spiritual habit garden';

  @override
  String get onboardingGoalMemorizationTitle => 'Quran memorization';

  @override
  String get onboardingNameLabel => 'What should we call you?';

  @override
  String get onboardingNameHint => 'Your name (optional)';

  @override
  String get onboardingGoalsTip =>
      'Your choices only shape suggestions — nothing is locked in.';

  @override
  String get onboardingComplete => 'Complete setup';

  @override
  String get profileHeaderSubtitle => 'Your sanctuary settings';

  @override
  String get profileAddName => 'Add your name';

  @override
  String get profileEditName => 'Edit name';

  @override
  String get profileNameDialogTitle => 'Your name';

  @override
  String get profileSave => 'Save';

  @override
  String get profileCancel => 'Cancel';

  @override
  String get profileDelete => 'Delete';

  @override
  String get profileSectionPrayer => 'Prayer';

  @override
  String get profileNotifications => 'Prayer reminders';

  @override
  String get profileNotificationsBody => 'Notify me when each prayer begins';

  @override
  String get profileNotificationsDenied =>
      'Notifications are blocked in system settings.';

  @override
  String get profileRefreshLocation => 'Refresh location';

  @override
  String get profileRefreshLocationBody =>
      'Update prayer times for where you are now';

  @override
  String get profileLocationUpdated =>
      'Location updated — prayer times refreshed.';

  @override
  String get profileLocationDenied => 'Location permission is off.';

  @override
  String get profileLocationFailed =>
      'Couldn\'t get your location. Check that location services are on and try again.';

  @override
  String get profileSectionAppearance => 'Appearance';

  @override
  String get profileTheme => 'Theme';

  @override
  String get profileThemeSystem => 'System';

  @override
  String get profileThemeLight => 'Light';

  @override
  String get profileThemeDark => 'Dark';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileSectionQuran => 'Quran';

  @override
  String get profileTranslation => 'English translation';

  @override
  String get profileTranslationValue => 'Sahih International';

  @override
  String get profileSectionContent => 'Content & sources';

  @override
  String get profileSources => 'Where our content comes from';

  @override
  String get profileSourcesBody =>
      'All Quran text (Uthmani script) and its English translation (Sahih International) are retrieved from api.alquran.cloud. Every du\'a and dhikr is shown with its source reference — a Quran verse or a named hadith collection and number. Nothing religious is paraphrased or generated.';

  @override
  String get profileSectionExplore => 'Explore';

  @override
  String get profileDuasLibrary => 'Du\'as library';

  @override
  String get profileAskSakinah => 'Ask Sakīnah';

  @override
  String get profileReflections => 'My reflections';

  @override
  String get profileSectionAbout => 'About';

  @override
  String get profileAbout => 'About Sakīnah';

  @override
  String profileVersion(String version) {
    return 'Version $version';
  }

  @override
  String get profileResetOnboarding => 'Reset onboarding';

  @override
  String get profileResetOnboardingBody =>
      'Run the welcome setup again. Your data stays.';

  @override
  String get profileResetConfirmTitle => 'Reset onboarding?';

  @override
  String get profileResetConfirmBody =>
      'You\'ll go through the welcome steps again. Your reflections, progress and saved items are kept.';

  @override
  String get profileResetConfirm => 'Reset';

  @override
  String get profileReflectionsEmptyTitle => 'No reflections yet';

  @override
  String get profileReflectionsEmptyBody =>
      'Reflections you write while reading the Quran will appear here.';

  @override
  String profileReflectionAyahRef(int surah, int ayah) {
    return 'Quran $surah:$ayah';
  }

  @override
  String profileReflectionSurahRef(int surah) {
    return 'Surah $surah';
  }

  @override
  String get profileReflectionDeleteTitle => 'Delete this reflection?';

  @override
  String get profileReflectionDeleteBody => 'This can\'t be undone.';

  @override
  String get profileReflectionDeleted => 'Reflection deleted';

  @override
  String get homeNotificationsTooltip => 'Notifications';

  @override
  String get homeNextPrayer => 'Next prayer';

  @override
  String get homeMidnight => 'Midnight';

  @override
  String get homeLastThird => 'Last third';

  @override
  String get homeLocationPending => 'Location pending';

  @override
  String get homeTimelineHint =>
      'Long-press a prayer that has begun to mark it as prayed.';

  @override
  String get homeQuickQibla => 'Qibla';

  @override
  String get homeQuickDuas => 'Du\'as';

  @override
  String get homeQuickAsk => 'Ask Sakīnah';

  @override
  String homeDhikrTarget(int count) {
    return 'Target: $count';
  }

  @override
  String homeDhikrProgress(int count, int target) {
    return '$count of $target complete';
  }

  @override
  String homeQuranSurahName(String name) {
    return 'Surah $name';
  }

  @override
  String homeQuranAyahJuz(int ayah, int juz) {
    return 'Ayah $ayah • Juz $juz';
  }

  @override
  String get homeQuranCompletion => 'Surah completion';

  @override
  String homeQuranPercent(int percent) {
    return '$percent%';
  }

  @override
  String get homeQuranEmptyTitle => 'Begin with Al-Fatiha';

  @override
  String get homeQuranEmptyBody =>
      'Your reading progress will appear here once you start.';

  @override
  String get homeQuranStartReading => 'Start reading';

  @override
  String homeVerseSource(String reference) {
    return 'Quran $reference · Sahih International';
  }

  @override
  String get prayerQiblaTitle => 'Qibla & Prayer';

  @override
  String get prayerTabTimes => 'Prayer Times';

  @override
  String get prayerTabQibla => 'Qibla';

  @override
  String get prayerNextPrayer => 'Next prayer';

  @override
  String get prayerTodaysSchedule => 'Today\'s schedule';

  @override
  String get prayerSunrise => 'Sunrise';

  @override
  String prayerMarkPrayed(String prayer) {
    return 'Mark $prayer as prayed';
  }

  @override
  String prayerUnmarkPrayed(String prayer) {
    return 'Unmark $prayer';
  }

  @override
  String get prayerNotYetTime => 'Not yet time';

  @override
  String prayerLoggedCount(int count) {
    return '$count of 5 prayers logged today';
  }

  @override
  String get prayerCurrentLocation => 'Current location';

  @override
  String get prayerMadhabHanafi => 'Hanafi';

  @override
  String get prayerMadhabShafi => 'Shafi\'i, Maliki & Hanbali';

  @override
  String get prayerChangeSettings => 'Change';

  @override
  String get prayerMoreSettings => 'More settings in Profile';

  @override
  String qiblaTurnRight(int degrees) {
    return 'Turn $degrees° to the right';
  }

  @override
  String qiblaTurnLeft(int degrees) {
    return 'Turn $degrees° to the left';
  }

  @override
  String qiblaBearing(String degrees) {
    return 'Qibla bearing: $degrees°';
  }

  @override
  String qiblaDistance(String km) {
    return '$km km to Makkah';
  }

  @override
  String get qiblaWaitingForCompass => 'Waiting for the compass…';

  @override
  String qiblaVerseSource(String reference) {
    return 'Quran $reference · Sahih International';
  }

  @override
  String get qiblaDirN => 'N';

  @override
  String get qiblaDirNE => 'NE';

  @override
  String get qiblaDirE => 'E';

  @override
  String get qiblaDirSE => 'SE';

  @override
  String get qiblaDirS => 'S';

  @override
  String get qiblaDirSW => 'SW';

  @override
  String get qiblaDirW => 'W';

  @override
  String get qiblaDirNW => 'NW';

  @override
  String quranJuzAyah(int juz, int ayah) {
    return 'Juz $juz • Ayah $ayah';
  }

  @override
  String homeGreetingNamed(String name) {
    return 'Assalamu Alaikum, $name';
  }

  @override
  String get quranMenuTafseer => 'Tafseer';

  @override
  String get quranMenuTranslate => 'Translate';

  @override
  String get quranMenuListen => 'Listen to verses';

  @override
  String get quranMenuAddFavorite => 'Add to Favorites';

  @override
  String get quranMenuRemoveFavorite => 'Remove from Favorites';

  @override
  String get quranTafsirSourceName =>
      'Tafsir al-Muyassar — King Fahd Quran Complex';

  @override
  String get quranTafsirLoadError =>
      'We couldn\'t load the tafseer. Check your connection and try again.';

  @override
  String quranTranslationBy(String name) {
    return 'Translation: $name';
  }

  @override
  String get quranMushafDisplay => 'Mushaf display';

  @override
  String get quranDisplayHorizontal => 'Horizontal';

  @override
  String get quranDisplayVertical => 'Vertical';

  @override
  String get quranIndexTitle => 'The index';

  @override
  String get quranSearchTitle => 'Search';

  @override
  String get quranAudios => 'Audios';

  @override
  String get quranNightMode => 'Night mode';

  @override
  String get quranColorYourMushaf => 'Color your mushaf';

  @override
  String get quranReferenceMarks => 'Reference marks';

  @override
  String get quranFeaturesSection => 'Features';

  @override
  String get quranFavoriteSection => 'Favorite';

  @override
  String get quranColorSand => 'Sand';

  @override
  String get quranColorBlue => 'Blue';

  @override
  String get quranColorGreen => 'Green';

  @override
  String quranJuzLabel(int juz) {
    return 'Juz $juz';
  }

  @override
  String quranPageLabel(int page) {
    return 'Page $page';
  }

  @override
  String get quranQuickNavigation => 'Quick navigation';

  @override
  String get quranNextPage => 'Next page';

  @override
  String get quranPreviousPage => 'Previous page';

  @override
  String get quranReaderMenu => 'Mushaf menu';

  @override
  String get quranCoachMenu =>
      'Side menu: display, index, search, colours and more';

  @override
  String get quranCoachTapAyah =>
      'Tap any ayah for tafseer, translation, recitation and favorites';

  @override
  String get quranCoachPinch => 'Pinch with two fingers to resize the text';

  @override
  String get quranCoachQuickNav => 'Tap the page to show quick navigation';

  @override
  String get quranCoachGotIt => 'Got it';

  @override
  String get quranPageNotFound => 'This page could not be found.';

  @override
  String get quranClose => 'Close';
}
