// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'سَكينة';

  @override
  String get appTagline => 'طريق أهدأ للعيش مع إيمانك.';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get back => 'رجوع';

  @override
  String get skip => 'تخطي';

  @override
  String get maybeLater => 'ربما لاحقًا';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get onboardingLanguageTitle => 'اختر لغتك';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get onboardingLocationTitle =>
      'اسمح بالوصول إلى الموقع لحساب مواقيت الصلاة واتجاه القبلة بدقة.';

  @override
  String get allowLocation => 'السماح بالموقع';

  @override
  String get onboardingPrayerPrefsTitle => 'تفضيلات الصلاة';

  @override
  String get calculationMethodLabel => 'طريقة الحساب';

  @override
  String get madhabLabel => 'المذهب';

  @override
  String get onboardingNotificationsTitle =>
      'ابقَ على تواصل هادئ مع صلواتك وأذكارك اليومية.';

  @override
  String get allowNotifications => 'السماح بالإشعارات';

  @override
  String get onboardingGoalsTitle => 'على ماذا تودّ أن تركّز؟';

  @override
  String get onboardingGoalsSubtitle =>
      'اختر ما تشاء، ويمكنك تغيير ذلك لاحقًا.';

  @override
  String get goalQuran => 'القرآن';

  @override
  String get goalPrayer => 'الصلاة';

  @override
  String get goalDhikr => 'الذكر';

  @override
  String get goalDua => 'الدعاء';

  @override
  String get goalMemorization => 'الحفظ';

  @override
  String get goalConsistency => 'الاستمرارية';

  @override
  String get beginJourney => 'ابدأ';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navQuran => 'القرآن';

  @override
  String get navDhikr => 'الذكر';

  @override
  String get navJourney => 'المسيرة';

  @override
  String get navProfile => 'أنا';

  @override
  String get homeGreeting => 'السلام عليكم';

  @override
  String get dailyIntentionTitle => 'نية اليوم';

  @override
  String get dailyIntentionText => 'خذ بضع دقائق اليوم لتجديد صلتك بالله.';

  @override
  String get begin => 'ابدأ';

  @override
  String get yourQuran => 'قرآنك';

  @override
  String get continueReading => 'متابعة القراءة';

  @override
  String ayahLabel(int number) {
    return 'الآية $number';
  }

  @override
  String get todaysDhikr => 'ذكر اليوم';

  @override
  String get start => 'ابدأ';

  @override
  String get dailyDeedTitle => 'عمل خير صغير';

  @override
  String get markAsDone => 'تمّ الإنجاز';

  @override
  String get markedAsDone => 'أُنجز اليوم';

  @override
  String prayerCountdown(String time) {
    return 'بعد $time';
  }

  @override
  String get prayerEstimatedNotice => 'تقديريّ — سيتزامن مع موقعك قريبًا';

  @override
  String get prayerFajr => 'الفجر';

  @override
  String get prayerDhuhr => 'الظهر';

  @override
  String get prayerAsr => 'العصر';

  @override
  String get prayerMaghrib => 'المغرب';

  @override
  String get prayerIsha => 'العشاء';

  @override
  String get offlineNotice =>
      'أنت غير متصل بالإنترنت — تُعرض بياناتك المحفوظة.';

  @override
  String get errorGeneric => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get comingSoonTitle => 'قريبًا';

  @override
  String get comingSoonBody => 'هذا الجزء من سَكينة ما زال قيد الإعداد بعناية.';

  @override
  String get prayerScreenTitle => 'الصلاة';

  @override
  String get prayerSettingsTitle => 'تفضيلات الصلاة';

  @override
  String get prayerNotificationsLabel => 'إشعارات الصلاة';

  @override
  String get prayerNotificationsSubtitle =>
      'احصل على تذكير هادئ عند دخول وقت كل صلاة.';

  @override
  String get qiblaButton => 'اتجاه القبلة';

  @override
  String get qiblaTitle => 'القبلة';

  @override
  String get qiblaFacingIt => 'أنت متجه نحو القبلة';

  @override
  String get qiblaCalibrateHint =>
      'حرّك هاتفك على شكل رقم ثمانية لمعايرة البوصلة';

  @override
  String get qiblaPermissionDenied =>
      'يلزم الوصول إلى الموقع لتحديد اتجاه القبلة.';

  @override
  String get qiblaLocationUnavailable =>
      'تعذّر تحديد موقعك. تحقق من الاتصال وحاول مرة أخرى.';

  @override
  String get qiblaSensorUnavailable => 'هذا الجهاز لا يحتوي على حساس بوصلة.';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get quranTitle => 'القرآن الكريم';

  @override
  String get quranSearchHint => 'ابحث عن سورة بالاسم أو الرقم';

  @override
  String quranNoSearchResults(String query) {
    return 'لا توجد سورة تطابق «$query»';
  }

  @override
  String get quranSurahsHeader => 'السور';

  @override
  String get quranStartReadingTitle => 'ابدأ قراءتك';

  @override
  String get quranStartReadingBody => 'افتح سورة الفاتحة وسنحفظ موضعك هنا.';

  @override
  String quranProgressAyahOf(int ayah, int total) {
    return 'الآية $ayah من $total';
  }

  @override
  String quranAyahCount(int count) {
    return '$count آية';
  }

  @override
  String get quranMeccan => 'مكية';

  @override
  String get quranMedinan => 'مدنية';

  @override
  String get quranBookmarksTitle => 'المحفوظات';

  @override
  String quranBookmarksCount(int count) {
    return '$count آيات محفوظة';
  }

  @override
  String get quranBookmarksEmptyTitle => 'لا توجد محفوظات بعد';

  @override
  String get quranBookmarksEmptyBody =>
      'اضغط على علامة الحفظ في أي آية لتجدها هنا.';

  @override
  String get quranRemoveBookmark => 'إزالة';

  @override
  String quranJuzAyahRange(int juz, int from, int to) {
    return 'الجزء $juz • الآية $from–$to';
  }

  @override
  String get quranModeRead => 'قراءة';

  @override
  String get quranModeTranslation => 'الترجمة';

  @override
  String get quranModeTafsir => 'التفسير';

  @override
  String get quranTafsirUnavailableTitle => 'التفسير غير متاح بعد';

  @override
  String get quranTafsirUnavailableBody =>
      'نعرض التفسير فقط من مصدر مرخّص ومنسوب بوضوح. إلى أن يُضاف، اقرأ الترجمة أو استشر عالمًا موثوقًا.';

  @override
  String quranAyahSelected(int number) {
    return 'الآية $number • محددة';
  }

  @override
  String quranSurahCitation(String name, String reference) {
    return 'سورة $name $reference';
  }

  @override
  String get quranReflectionPromptTitle => 'لحظة تدبّر';

  @override
  String get quranReflectionPromptBody =>
      'توقّف مع هذه الآية قليلًا. إلامَ تدعوك أن تنتبه اليوم؟';

  @override
  String get quranActionListen => 'استماع';

  @override
  String get quranActionBookmark => 'حفظ';

  @override
  String get quranActionBookmarked => 'محفوظة';

  @override
  String get quranActionReflect => 'تدبّر';

  @override
  String get quranActionShare => 'مشاركة';

  @override
  String get quranActionCopy => 'نسخ';

  @override
  String get quranCopied => 'تم نسخ الآية';

  @override
  String get quranShareCopied => 'تم نسخ الآية — الصقها حيث تريد لمشاركتها';

  @override
  String get quranBookmarkAdded => 'تم حفظ الآية';

  @override
  String get quranBookmarkRemoved => 'تمت إزالة الحفظ';

  @override
  String get quranReciterName => 'مشاري راشد العفاسي';

  @override
  String get quranAudioUnavailable => 'تعذّر تشغيل التلاوة الآن';

  @override
  String get quranPlayRecitation => 'تشغيل التلاوة';

  @override
  String get quranPause => 'إيقاف مؤقت';

  @override
  String get quranPlay => 'تشغيل';

  @override
  String get quranPreviousAyah => 'الآية السابقة';

  @override
  String get quranNextAyah => 'الآية التالية';

  @override
  String get quranStopRecitation => 'إيقاف التلاوة';

  @override
  String get quranTextSize => 'حجم الخط';

  @override
  String get quranTextSizeReset => 'إعادة ضبط';

  @override
  String get quranReflectTitle => 'تدبّر هذه الآية';

  @override
  String get quranReflectHint => 'اكتب ما تثيره هذه الآية في قلبك…';

  @override
  String get quranReflectSave => 'حفظ التدبّر';

  @override
  String get quranReflectionSaved => 'تم حفظ التدبّر';

  @override
  String get quranLoadError => 'تعذّر تحميل هذه السورة. حاول مرة أخرى.';

  @override
  String get quranOfflineNotCached =>
      'أنت غير متصل وهذه السورة غير محفوظة بعد. اتصل مرة واحدة وستُحفظ للقراءة دون اتصال.';

  @override
  String get quranSurahNotFound => 'تعذّر العثور على هذه السورة.';

  @override
  String get quranTranslatorLabel => 'صحيح إنترناشيونال';

  @override
  String get journeyEyebrow => 'ملاذك الروحي';

  @override
  String get journeyTitle => 'رحلتك';

  @override
  String get journeyGardenName => 'بُسْتَانُ السَّكِينَةِ';

  @override
  String journeyLevel(int level) {
    return 'المستوى $level';
  }

  @override
  String journeyXpProgress(int current, int target) {
    return '$current / $target نقطة';
  }

  @override
  String get journeyLevelCaption => 'تنمو بالمداومة';

  @override
  String journeyStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count يوم من المداومة',
      many: '$count يومًا من المداومة',
      few: '$count أيام من المداومة',
      two: 'يومان من المداومة',
      one: 'يوم واحد من المداومة',
      zero: 'بستانك في انتظارك',
    );
    return '$_temp0';
  }

  @override
  String get journeyStageSeed => 'بذرة';

  @override
  String get journeyStageSprout => 'برعم';

  @override
  String get journeyStageSapling => 'شتلة';

  @override
  String get journeyStageBlooming => 'مزهرة';

  @override
  String get journeyStageFlourishing => 'شجرة وارفة';

  @override
  String get journeyStageMessageSeed =>
      'كل بستان يبدأ ببذرة واحدة. عمل صغير اليوم يزرع بذرتك.';

  @override
  String get journeyStageMessageSprout =>
      'بدأت جذورك الأولى تثبت. الخطوات الهادئة المستمرة تصل بعيدًا.';

  @override
  String get journeyStageMessageSapling =>
      'نموٌّ ثابت. لحظاتك اليومية الصغيرة تتراكم.';

  @override
  String get journeyStageMessageBlooming =>
      'بستانك يزهر. واصل العناية به، يومًا هادئًا بعد يوم.';

  @override
  String get journeyStageMessageFlourishing =>
      'شجرة وارفة جذورها أيام ثابتة. استرح في ظلها وواصل العناية بها.';

  @override
  String journeyStageProgress(String current, String next) {
    return '$current ← $next';
  }

  @override
  String journeyNextInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'التالي بعد $count يوم',
      many: 'التالي بعد $count يومًا',
      few: 'التالي بعد $count أيام',
      two: 'التالي بعد يومين',
      one: 'التالي بعد يوم',
    );
    return '$_temp0';
  }

  @override
  String get journeyStageMax => 'اكتمل النمو';

  @override
  String get journeyStreakTitle => 'السلسلة الحالية';

  @override
  String journeyDaysUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'يوم',
      many: 'يومًا',
      few: 'أيام',
      two: 'يومان',
      one: 'يوم',
      zero: 'يوم',
    );
    return '$_temp0';
  }

  @override
  String journeyBestStreak(int count) {
    return 'الأفضل: $count';
  }

  @override
  String get journeyStreakOpenToday =>
      'اليوم ما زال مفتوحًا — أي عمل صغير يحافظ على سلسلتك.';

  @override
  String get journeyStreakTendedToday => 'اعتنيت ببستانك اليوم. أحسنت.';

  @override
  String get journeyStreakStart => 'ابدأ اليوم — صلاة أو آية أو ذكر يكفي.';

  @override
  String get journeyLevelCardTitle => 'مستوى النمو';

  @override
  String journeyXpToNext(int xp) {
    return '$xp نقطة للمستوى التالي';
  }

  @override
  String get journeyXpNote =>
      'النقاط مجرد مرآة لطيفة لمداومتك، وليست مقياسًا للأجر.';

  @override
  String get journeyWeekTitle => 'آخر ٧ أيام';

  @override
  String journeyActiveDays(int count) {
    return '$count / 7 أيام نشطة';
  }

  @override
  String journeyDeedsThisWeek(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عمل يومي أُنجز',
      many: '$count عملًا يوميًا أُنجز',
      few: '$count أعمال يومية أُنجزت',
      two: 'عملان يوميان أُنجزا',
      one: 'عمل يومي واحد أُنجز',
      zero: 'لم تُنجز أعمال يومية بعد',
    );
    return '$_temp0';
  }

  @override
  String get journeyHabitsTitle => 'عادات الأسبوع';

  @override
  String get journeyHabitReflection => 'التأمل';

  @override
  String journeyHabitDays(int count) {
    return '$count / 7 أيام';
  }

  @override
  String journeyAyahsTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count آية',
      many: '$count آية',
      few: '$count آيات',
      two: 'آيتان',
      one: 'آية واحدة',
    );
    return '$_temp0';
  }

  @override
  String journeyPrayersTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count صلاة',
      many: '$count صلاة',
      few: '$count صلوات',
      two: 'صلاتان',
      one: 'صلاة واحدة',
    );
    return '$_temp0';
  }

  @override
  String journeyDhikrTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ذكر',
      many: '$count ذكرًا',
      few: '$count أذكار',
      two: 'ذكران',
      one: 'ذكر واحد',
    );
    return '$_temp0';
  }

  @override
  String journeyReflectionsTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count خاطرة',
      many: '$count خاطرة',
      few: '$count خواطر',
      two: 'خاطرتان',
      one: 'خاطرة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get journeyGoalsTitle => 'نواياك';

  @override
  String get journeyGoalsDefaultHint =>
      'لم تختر مجالات تركيز بعد — إليك بدايات لطيفة.';

  @override
  String journeyGoalPrayerProgress(int count) {
    return '$count / 5 صلوات اليوم';
  }

  @override
  String journeyGoalQuranProgress(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'قرأت $count آية اليوم',
      many: 'قرأت $count آية اليوم',
      few: 'قرأت $count آيات اليوم',
      two: 'قرأت آيتين اليوم',
      one: 'قرأت آية واحدة اليوم',
      zero: 'لم تقرأ آيات اليوم بعد',
    );
    return '$_temp0';
  }

  @override
  String journeyGoalDhikrProgress(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ذكر اليوم',
      many: '$count ذكرًا اليوم',
      few: '$count أذكار اليوم',
      two: 'ذكران اليوم',
      one: 'ذكر واحد اليوم',
      zero: 'لا أذكار اليوم بعد',
    );
    return '$_temp0';
  }

  @override
  String journeyGoalConsistencyProgress(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'سلسلة $count يوم',
      many: 'سلسلة $count يومًا',
      few: 'سلسلة $count أيام',
      two: 'سلسلة يومين',
      one: 'سلسلة يوم واحد',
      zero: 'ابدأ سلسلتك اليوم',
    );
    return '$_temp0';
  }

  @override
  String get journeyGoalDuaHint => 'استكشف أدعية اليوم';

  @override
  String get journeyGoalMemorizationHint => 'تابع في المصحف';

  @override
  String get journeyGoalDoneToday => 'أُنجز اليوم';

  @override
  String get journeyMilestonesTitle => 'المحطات';

  @override
  String journeyMilestonesCount(int done, int total) {
    return '$done من $total';
  }

  @override
  String get journeyMilestoneFirstStep => 'الخطوة الأولى';

  @override
  String get journeyMilestoneFirstReflection => 'أول خاطرة';

  @override
  String get journeyMilestoneFivePrayers => 'الصلوات الخمس في يوم';

  @override
  String get journeyMilestoneAyahs100 => 'قراءة ١٠٠ آية';

  @override
  String get journeyMilestoneStreak7 => 'سلسلة ٧ أيام';

  @override
  String get journeyMilestoneStreak30 => 'سلسلة ٣٠ يومًا';

  @override
  String get journeyMilestoneLevel5 => 'بلوغ المستوى ٥';

  @override
  String get journeyMilestoneLocked => 'لم تتحقق بعد';

  @override
  String get journeyStartTitle => 'ازرع بذرتك الأولى';

  @override
  String get journeyStartBody =>
      'ينمو بستانك من لحظات صغيرة ثابتة. اختر واحدة لتبدأ.';

  @override
  String get journeyActionLogPrayer => 'سجّل صلاة';

  @override
  String get journeyActionRead => 'اقرأ القرآن';

  @override
  String get journeyActionDhikr => 'ابدأ الذكر';

  @override
  String get journeyActionReflect => 'اكتب خاطرة اليوم';

  @override
  String get journeyError => 'تعذّر تحميل رحلتك.';

  @override
  String get dhikrBrandSubtitle => 'طمأنينة القلب';

  @override
  String get dhikrProfileTooltip => 'الملف الشخصي';

  @override
  String get dhikrEyebrow => 'ذكرٌ بحضور القلب';

  @override
  String get dhikrTitle => 'الأذكار والسكينة';

  @override
  String get dhikrTitleArabic => 'Dhikr & Sanctuary';

  @override
  String get dhikrTabCounter => 'عدّاد التسبيح';

  @override
  String get dhikrTabGarden => 'رحلة الحديقة';

  @override
  String get dhikrCategoryAll => 'الكل';

  @override
  String get dhikrCategoryAfterPrayer => 'أذكار بعد الصلاة';

  @override
  String get dhikrCategoryMorning => 'أذكار الصباح';

  @override
  String get dhikrCategoryEvening => 'أذكار المساء';

  @override
  String get dhikrCategoryAnytime => 'أذكار مطلقة';

  @override
  String dhikrCompletedOf(int completed, int total) {
    return '$completed من $total مكتملة';
  }

  @override
  String get dhikrCurrentCycle => 'الورد الحالي';

  @override
  String get dhikrAllDoneToday => 'اكتملت كلها اليوم — تقبّل الله';

  @override
  String dhikrTimes(int count) {
    return '$count مرة';
  }

  @override
  String dhikrTodayProgress(int count, int target) {
    return 'اليوم $count / $target';
  }

  @override
  String dhikrSource(String source) {
    return 'المصدر: $source';
  }

  @override
  String get dhikrSectionTitle => 'رياض الأذكار';

  @override
  String get dhikrAuthenticBadge => 'من السنة الثابتة';

  @override
  String get dhikrDone => 'تمّ';

  @override
  String get dhikrGoal => 'الهدف';

  @override
  String get dhikrTapToCount => 'انقر للعدّ';

  @override
  String dhikrCounterSemantics(int count, int target) {
    return 'انقر للعدّ. $count من $target';
  }

  @override
  String get dhikrReset => 'إعادة';

  @override
  String get dhikrResetConfirmTitle => 'إعادة عدّاد اليوم؟';

  @override
  String get dhikrResetConfirmBody => 'سيعود عدد هذا الذكر لليوم إلى الصفر.';

  @override
  String get dhikrCancel => 'إلغاء';

  @override
  String get dhikrUndo => 'تراجع';

  @override
  String get dhikrHapticsOn => 'اهتزاز';

  @override
  String get dhikrHapticsOff => 'صامت';

  @override
  String get dhikrHapticsTooltip => 'الاهتزاز عند العدّ';

  @override
  String get dhikrTargetTooltip => 'تغيير الهدف';

  @override
  String get dhikrTargetReached => 'بلغتَ الهدف — تقبّل الله. يمكنك المتابعة.';

  @override
  String dhikrNext(String name) {
    return 'التالي: $name';
  }

  @override
  String get dhikrSetComplete => 'اكتملت المجموعة — تقبّل الله';

  @override
  String get dhikrBackToList => 'العودة إلى الأذكار';

  @override
  String get dhikrNotFound => 'تعذّر العثور على هذا الذكر.';

  @override
  String get dhikrGardenEyebrow => 'ذكرُ اليوم';

  @override
  String get dhikrGardenTitle => 'تنمو حديقتك مع كل ذكر';

  @override
  String get dhikrTodayCountLabel => 'أذكار اليوم';

  @override
  String get dhikrCompletedLabel => 'مكتملة';

  @override
  String get dhikrWeekTitle => 'هذا الأسبوع';

  @override
  String dhikrDaysActive(int count) {
    return '$count من 7 أيام';
  }

  @override
  String get dhikrOpenGarden => 'افتح حديقتك';

  @override
  String get duasLibraryTitle => 'مكتبة الأدعية';

  @override
  String get duasLibrarySubtitle => 'أدعية جامعة من القرآن الكريم';

  @override
  String get duasSearchHint => 'ابحث عن دعاء، شعور، أو حاجة';

  @override
  String get duasClearSearch => 'مسح البحث';

  @override
  String get duasCategoryAll => 'الكل';

  @override
  String get duasCategoryForgiveness => 'الاستغفار والتوبة';

  @override
  String get duasCategoryPatience => 'الصبر والثبات';

  @override
  String get duasCategoryGuidance => 'طلب الهداية';

  @override
  String get duasCategoryFamily => 'الوالدين والذرية';

  @override
  String get duasCategoryKnowledge => 'طلب العلم';

  @override
  String get duasCategoryHardship => 'تفريج الكرب';

  @override
  String get duasCategoryGratitude => 'الشكر';

  @override
  String get duasShowSaved => 'عرض الأدعية المحفوظة';

  @override
  String get duasShowAll => 'عرض كل الأدعية';

  @override
  String get duasSavedTitle => 'الأدعية المحفوظة';

  @override
  String get duasFeaturedLabel => 'دعاء اليوم المختار';

  @override
  String get duasQuranSectionTitle => 'أدعية من القرآن الكريم';

  @override
  String get duasQuranSectionSubtitle => 'أدعية الأنبياء والمؤمنين';

  @override
  String duasCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دعاء',
      few: '$count أدعية',
      two: 'دعاءان',
      one: 'دعاء واحد',
    );
    return '$_temp0';
  }

  @override
  String get duasNoResultsTitle => 'لا توجد أدعية مطابقة';

  @override
  String get duasNoResultsMessage => 'جرّب كلمة أو تصنيفًا آخر.';

  @override
  String get duasNoSavedTitle => 'لا توجد أدعية محفوظة بعد';

  @override
  String get duasNoSavedMessage => 'اضغط على علامة الحفظ في أي دعاء ليظهر هنا.';

  @override
  String get duasSave => 'حفظ';

  @override
  String get duasSaved => 'محفوظ';

  @override
  String get duasSaveTooltip => 'حفظ الدعاء';

  @override
  String get duasUnsaveTooltip => 'إزالة من المحفوظات';

  @override
  String get duasCopy => 'نسخ';

  @override
  String get duasCopied => 'تم نسخ الدعاء';

  @override
  String duasTranslationBy(String translator) {
    return 'الترجمة: $translator';
  }

  @override
  String duasQuranReference(String verse) {
    return 'القرآن الكريم $verse';
  }

  @override
  String get duasOpenInQuran => 'افتح في المصحف';

  @override
  String get duasReciteTitle => 'ردّد الدعاء';

  @override
  String get duasReciteHint => 'اضغط لعدّ مرات الترديد';

  @override
  String duasReciteCountSemantics(int count) {
    return 'رُدّد $count مرة';
  }

  @override
  String get duasReciteReset => 'إعادة';

  @override
  String get duasLoadError => 'تعذّر تحميل مكتبة الأدعية.';

  @override
  String get duasNotFound => 'لم يتم العثور على هذا الدعاء.';

  @override
  String get duasDhikrCardEyebrow => 'جلسة سكينة وتضرّع';

  @override
  String get duasDhikrCardTitle => 'تسبيح واستغفار هادئ';

  @override
  String get duasDhikrCardBody =>
      'خصص دقائق من وقتك لذكر الله وسكينة القلب بتدبّر.';

  @override
  String get duasDhikrCardAction => 'ابدأ الذكر';

  @override
  String get askTitle => 'اسأل سكينة';

  @override
  String get askSubtitle => 'رفيق يستند إلى مصادر موثّقة';

  @override
  String get askTopBarSubtitle => 'رفيق موثّق وملاذ هادئ';

  @override
  String get askKnowledgeEyebrow => 'رحاب المعرفة';

  @override
  String get askVerifiedSources => 'مصادر موثّقة';

  @override
  String get askInputHint => 'اسأل عن القرآن والأدعية والعبادات…';

  @override
  String get askSend => 'إرسال السؤال';

  @override
  String get askSuggestedTitle => 'أسئلة مقترحة';

  @override
  String get askSuggestionAnxiety => 'دعاء للقلق وطمأنينة القلب';

  @override
  String get askSuggestionAyah => 'ما معنى الآية ٢:١٤٣؟';

  @override
  String get askSuggestionFasting => 'آداب الصيام';

  @override
  String get askDisclaimer =>
      'لأغراض التعلّم. للأحكام الشرعية الشخصية، استشر عالمًا مؤهلًا.';

  @override
  String get askYou => 'أنت';

  @override
  String get askAnswerTitle => 'إجابة سكينة';

  @override
  String get askAnswerSubtitle => 'مستندة إلى المصادر أدناه';

  @override
  String get askSourcesTitle => 'المصادر';

  @override
  String askSourceQuran(String reference) {
    return 'القرآن الكريم $reference';
  }

  @override
  String askSourceHadith(String reference) {
    return 'حديث · $reference';
  }

  @override
  String get askNoSources =>
      'لم تُرفق مصادر بهذه الإجابة — يُرجى التعامل معها بحذر.';

  @override
  String get askThinking => 'جارٍ البحث في المصادر الموثّقة…';

  @override
  String get askUnavailableTitle => 'خدمة «اسأل سكينة» غير متاحة بعد';

  @override
  String get askUnavailableMessage =>
      'نُعدّ خدمة تجيب فقط من مصادر موثّقة من القرآن والحديث. إلى أن تجهز، يمكنك تصفّح مكتبة الأدعية.';

  @override
  String get askBrowseDuas => 'تصفّح الأدعية';

  @override
  String get askErrorOffline => 'أنت غير متصل. اتصل بالإنترنت وحاول مجددًا.';

  @override
  String get askErrorTimeout => 'استغرقت الإجابة وقتًا طويلًا. حاول مجددًا.';

  @override
  String get askErrorServer => 'حدث خطأ من جهتنا. حاول مجددًا.';

  @override
  String get askErrorGeneric => 'تعذّر الحصول على إجابة. حاول مجددًا.';

  @override
  String get askExploreDuasTitle => 'استكشف الأدعية';

  @override
  String askCollections(int count) {
    return '$count تصنيفات';
  }

  @override
  String get askFeaturedDuaLabel => 'دعاء اليوم المختار';

  @override
  String get askViewLibrary => 'عرض المكتبة';

  @override
  String get onboardingWelcomeBadge => 'ملاذ السكينة';

  @override
  String get onboardingWelcomeWordmark => 'سَكِينَة';

  @override
  String get onboardingWelcomeFootnote => 'يستغرق الإعداد دقيقة تقريبًا';

  @override
  String onboardingStepOf(int current, int total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get onboardingSkipSetup => 'تخطي الإعداد';

  @override
  String get onboardingLanguageBadge => 'اللغة';

  @override
  String get onboardingLanguageSubtitle =>
      'اختر لغتك المفضلة. يمكنك تغييرها في أي وقت من ملفك الشخصي.';

  @override
  String get onboardingLanguageEnglishDesc => 'واجهة وترجمات باللغة الإنجليزية';

  @override
  String get onboardingLanguageArabicDesc =>
      'واجهة عربية كاملة من اليمين إلى اليسار';

  @override
  String get onboardingLanguageNote =>
      'تُعرض آيات القرآن دائمًا بالرسم العربي الأصلي مهما كانت اللغة التي تختارها.';

  @override
  String get onboardingLocationHeadline => 'مواقيت دقيقة واتجاه القبلة';

  @override
  String get onboardingLocationAutoTitle => 'دقة تلقائية';

  @override
  String get onboardingLocationAutoBody =>
      'يستخدم موقعك لحساب مواقيت الصلاة المحلية واتجاه القبلة.';

  @override
  String get onboardingRecommended => 'مستحسن';

  @override
  String get onboardingLocationPrivacy =>
      'الخصوصية أولًا: تبقى إحداثياتك على جهازك ولا تُشارك أبدًا.';

  @override
  String get onboardingLocationGranted =>
      'تم تفعيل الموقع — ستتبع مواقيت الصلاة مكانك.';

  @override
  String get onboardingLocationDenied =>
      'الموقع غير مفعّل. ستكون المواقيت تقريبية حتى تسمح به من إعدادات النظام.';

  @override
  String get onboardingSettingsHint =>
      'يمكنك تغيير ذلك في أي وقت من ملفك الشخصي.';

  @override
  String get onboardingPrayerPrefsSubtitle =>
      'اختر الطريقة التي يتبعها مسجدك المحلي. إن لم تكن متأكدًا، فالخيار الافتراضي مناسب لمعظم المناطق.';

  @override
  String get onboardingCalcAuthority => 'جهة الحساب';

  @override
  String onboardingMethodAngles(String fajr, String isha) {
    return 'الفجر $fajr°، العشاء $isha°';
  }

  @override
  String onboardingMethodAnglesInterval(String fajr, int minutes) {
    return 'الفجر $fajr°، العشاء بعد المغرب بـ $minutes دقيقة';
  }

  @override
  String get onboardingMethodMwl => 'رابطة العالم الإسلامي';

  @override
  String get onboardingMethodEgyptian => 'الهيئة المصرية العامة للمساحة';

  @override
  String get onboardingMethodKarachi => 'جامعة العلوم الإسلامية، كراتشي';

  @override
  String get onboardingMethodUmmAlQura => 'جامعة أم القرى، مكة المكرمة';

  @override
  String get onboardingMethodIsna => 'الجمعية الإسلامية لأمريكا الشمالية';

  @override
  String get onboardingMethodGulf => 'منطقة الخليج';

  @override
  String get onboardingMethodSingapore => 'سنغافورة';

  @override
  String get onboardingMethodTurkiye => 'تركيا (رئاسة الشؤون الدينية)';

  @override
  String get onboardingMethodMoonsighting => 'لجنة رؤية الهلال';

  @override
  String get onboardingMadhabSection => 'حساب العصر (المذهب)';

  @override
  String get onboardingMadhabStandard => 'الجمهور';

  @override
  String get onboardingMadhabStandardSchools => 'الشافعي، المالكي، الحنبلي';

  @override
  String get onboardingMadhabStandardDesc =>
      'يبدأ العصر عندما يساوي الظل طول الشيء';

  @override
  String get onboardingMadhabHanafi => 'الحنفي';

  @override
  String get onboardingMadhabHanafiSchools => 'عصر متأخر';

  @override
  String get onboardingMadhabHanafiDesc =>
      'يبدأ العصر عندما يبلغ الظل ضعف طول الشيء';

  @override
  String get onboardingConfirmContinue => 'تأكيد ومتابعة';

  @override
  String get onboardingNotificationsHeadline => 'تنبيهات هادئة';

  @override
  String get onboardingNotifPrayerTitle => 'تنبيهات مواقيت الصلاة';

  @override
  String get onboardingNotifPrayerBody =>
      'إشعار هادئ عند دخول وقت كل صلاة من الصلوات الخمس.';

  @override
  String get onboardingNotifReassurance =>
      'لا رسائل مزعجة ولا إعلانات — مواقيت الصلاة فقط.';

  @override
  String get onboardingNotifEnable => 'تفعيل التنبيهات';

  @override
  String get onboardingDecideLater => 'ليس الآن';

  @override
  String get onboardingNotifGranted => 'التنبيهات مفعّلة.';

  @override
  String get onboardingNotifDenied =>
      'الإشعارات محظورة. يمكنك السماح بها لاحقًا من إعدادات النظام.';

  @override
  String get onboardingGoalQuranTitle => 'تلاوة القرآن يوميًا';

  @override
  String get onboardingGoalPrayerTitle => 'المحافظة على الصلاة في وقتها';

  @override
  String get onboardingGoalDhikrTitle => 'أذكار الصباح والمساء';

  @override
  String get onboardingGoalDuaTitle => 'الخواطر والدعاء';

  @override
  String get onboardingGoalConsistencyTitle => 'بستان العادات الروحية';

  @override
  String get onboardingGoalMemorizationTitle => 'حفظ القرآن';

  @override
  String get onboardingNameLabel => 'بماذا نناديك؟';

  @override
  String get onboardingNameHint => 'اسمك (اختياري)';

  @override
  String get onboardingGoalsTip =>
      'اختياراتك تساعد فقط في تخصيص الاقتراحات — لا شيء نهائي.';

  @override
  String get onboardingComplete => 'إتمام الإعداد';

  @override
  String get profileHeaderSubtitle => 'إعدادات ملاذك';

  @override
  String get profileAddName => 'أضف اسمك';

  @override
  String get profileEditName => 'تعديل الاسم';

  @override
  String get profileNameDialogTitle => 'اسمك';

  @override
  String get profileSave => 'حفظ';

  @override
  String get profileCancel => 'إلغاء';

  @override
  String get profileDelete => 'حذف';

  @override
  String get profileSectionPrayer => 'الصلاة';

  @override
  String get profileNotifications => 'تنبيهات الصلاة';

  @override
  String get profileNotificationsBody => 'نبّهني عند دخول وقت كل صلاة';

  @override
  String get profileNotificationsDenied =>
      'الإشعارات محظورة في إعدادات النظام.';

  @override
  String get profileRefreshLocation => 'تحديث الموقع';

  @override
  String get profileRefreshLocationBody => 'حدّث المواقيت حسب مكانك الحالي';

  @override
  String get profileLocationUpdated => 'تم تحديث الموقع والمواقيت.';

  @override
  String get profileLocationDenied => 'إذن الموقع غير مفعّل.';

  @override
  String get profileLocationFailed =>
      'تعذّر تحديد موقعك. تأكد من تفعيل خدمات الموقع وحاول مجددًا.';

  @override
  String get profileSectionAppearance => 'المظهر';

  @override
  String get profileTheme => 'السمة';

  @override
  String get profileThemeSystem => 'النظام';

  @override
  String get profileThemeLight => 'فاتح';

  @override
  String get profileThemeDark => 'داكن';

  @override
  String get profileLanguage => 'اللغة';

  @override
  String get profileSectionQuran => 'القرآن';

  @override
  String get profileTranslation => 'الترجمة الإنجليزية';

  @override
  String get profileTranslationValue => 'صحيح إنترناشيونال';

  @override
  String get profileSectionContent => 'المحتوى والمصادر';

  @override
  String get profileSources => 'مصادر المحتوى';

  @override
  String get profileSourcesBody =>
      'جميع نصوص القرآن (بالرسم العثماني) وترجمتها الإنجليزية (صحيح إنترناشيونال) مأخوذة من api.alquran.cloud. يُعرض كل دعاء وذكر مع مصدره — آية قرآنية أو كتاب حديث محدد ورقمه. لا يُعاد صياغة أي نص ديني ولا يُولَّد.';

  @override
  String get profileSectionExplore => 'استكشف';

  @override
  String get profileDuasLibrary => 'مكتبة الأدعية';

  @override
  String get profileAskSakinah => 'اسأل سكينة';

  @override
  String get profileReflections => 'خواطري';

  @override
  String get profileSectionAbout => 'حول';

  @override
  String get profileAbout => 'حول سكينة';

  @override
  String profileVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get profileResetOnboarding => 'إعادة الإعداد الأولي';

  @override
  String get profileResetOnboardingBody =>
      'أعد خطوات الترحيب مجددًا. تبقى بياناتك كما هي.';

  @override
  String get profileResetConfirmTitle => 'إعادة الإعداد الأولي؟';

  @override
  String get profileResetConfirmBody =>
      'ستمر بخطوات الترحيب مرة أخرى. تبقى خواطرك وتقدمك والعناصر المحفوظة.';

  @override
  String get profileResetConfirm => 'إعادة';

  @override
  String get profileReflectionsEmptyTitle => 'لا توجد خواطر بعد';

  @override
  String get profileReflectionsEmptyBody =>
      'ستظهر هنا الخواطر التي تكتبها أثناء قراءة القرآن.';

  @override
  String profileReflectionAyahRef(int surah, int ayah) {
    return 'القرآن $surah:$ayah';
  }

  @override
  String profileReflectionSurahRef(int surah) {
    return 'سورة $surah';
  }

  @override
  String get profileReflectionDeleteTitle => 'حذف هذه الخاطرة؟';

  @override
  String get profileReflectionDeleteBody => 'لا يمكن التراجع عن ذلك.';

  @override
  String get profileReflectionDeleted => 'تم حذف الخاطرة';

  @override
  String get homeNotificationsTooltip => 'الإشعارات';

  @override
  String get homeNextPrayer => 'الصلاة القادمة';

  @override
  String get homeMidnight => 'منتصف الليل';

  @override
  String get homeLastThird => 'الثلث الأخير';

  @override
  String get homeLocationPending => 'بانتظار الموقع';

  @override
  String get homeTimelineHint => 'اضغط مطولًا على صلاة حان وقتها لتسجيلها.';

  @override
  String get homeQuickQibla => 'القبلة';

  @override
  String get homeQuickDuas => 'الأدعية';

  @override
  String get homeQuickAsk => 'اسأل سكينة';

  @override
  String homeDhikrTarget(int count) {
    return 'الهدف: $count';
  }

  @override
  String homeDhikrProgress(int count, int target) {
    return '$count من $target';
  }

  @override
  String homeQuranSurahName(String name) {
    return 'سورة $name';
  }

  @override
  String homeQuranAyahJuz(int ayah, int juz) {
    return 'الآية $ayah • الجزء $juz';
  }

  @override
  String get homeQuranCompletion => 'إتمام السورة';

  @override
  String homeQuranPercent(int percent) {
    return '$percent٪';
  }

  @override
  String get homeQuranEmptyTitle => 'ابدأ بسورة الفاتحة';

  @override
  String get homeQuranEmptyBody => 'سيظهر تقدّمك في القراءة هنا بمجرد أن تبدأ.';

  @override
  String get homeQuranStartReading => 'ابدأ القراءة';

  @override
  String homeVerseSource(String reference) {
    return 'القرآن الكريم $reference';
  }

  @override
  String get prayerQiblaTitle => 'القبلة والصلاة';

  @override
  String get prayerTabTimes => 'مواقيت الصلاة';

  @override
  String get prayerTabQibla => 'القبلة';

  @override
  String get prayerNextPrayer => 'الصلاة القادمة';

  @override
  String get prayerTodaysSchedule => 'مواقيت اليوم';

  @override
  String get prayerSunrise => 'الشروق';

  @override
  String prayerMarkPrayed(String prayer) {
    return 'تسجيل صلاة $prayer';
  }

  @override
  String prayerUnmarkPrayed(String prayer) {
    return 'إلغاء تسجيل $prayer';
  }

  @override
  String get prayerNotYetTime => 'لم يحن وقتها';

  @override
  String prayerLoggedCount(int count) {
    return 'سُجّلت $count من 5 صلوات اليوم';
  }

  @override
  String get prayerCurrentLocation => 'الموقع الحالي';

  @override
  String get prayerMadhabHanafi => 'الحنفي';

  @override
  String get prayerMadhabShafi => 'الشافعي والمالكي والحنبلي';

  @override
  String get prayerChangeSettings => 'تغيير';

  @override
  String get prayerMoreSettings => 'مزيد من الإعدادات في الملف الشخصي';

  @override
  String qiblaTurnRight(int degrees) {
    return 'استدر $degrees° إلى اليمين';
  }

  @override
  String qiblaTurnLeft(int degrees) {
    return 'استدر $degrees° إلى اليسار';
  }

  @override
  String qiblaBearing(String degrees) {
    return 'اتجاه القبلة: $degrees°';
  }

  @override
  String qiblaDistance(String km) {
    return '$km كم إلى مكة المكرمة';
  }

  @override
  String get qiblaWaitingForCompass => 'بانتظار البوصلة…';

  @override
  String qiblaVerseSource(String reference) {
    return 'القرآن الكريم $reference';
  }

  @override
  String get qiblaDirN => 'ش';

  @override
  String get qiblaDirNE => 'ش ق';

  @override
  String get qiblaDirE => 'ق';

  @override
  String get qiblaDirSE => 'ج ق';

  @override
  String get qiblaDirS => 'ج';

  @override
  String get qiblaDirSW => 'ج غ';

  @override
  String get qiblaDirW => 'غ';

  @override
  String get qiblaDirNW => 'ش غ';

  @override
  String quranJuzAyah(int juz, int ayah) {
    return 'الجزء $juz • الآية $ayah';
  }

  @override
  String homeGreetingNamed(String name) {
    return 'السلام عليكم يا $name';
  }

  @override
  String get quranMenuTafseer => 'التفسير';

  @override
  String get quranMenuTranslate => 'الترجمة';

  @override
  String get quranMenuListen => 'الاستماع للآيات';

  @override
  String get quranMenuAddFavorite => 'إضافة إلى المفضلة';

  @override
  String get quranMenuRemoveFavorite => 'إزالة من المفضلة';

  @override
  String get quranTafsirSourceName => 'التفسير الميسر — مجمع الملك فهد';

  @override
  String get quranTafsirLoadError =>
      'تعذّر تحميل التفسير. تحقّق من اتصالك وحاول مرة أخرى.';

  @override
  String quranTranslationBy(String name) {
    return 'الترجمة الإنجليزية: $name';
  }

  @override
  String get quranMushafDisplay => 'عرض المصحف';

  @override
  String get quranDisplayHorizontal => 'أفقي';

  @override
  String get quranDisplayVertical => 'عمودي';

  @override
  String get quranIndexTitle => 'الفهرس';

  @override
  String get quranSearchTitle => 'البحث';

  @override
  String get quranAudios => 'التلاوات';

  @override
  String get quranNightMode => 'الوضع الليلي';

  @override
  String get quranColorYourMushaf => 'لوّن مصحفك';

  @override
  String get quranReferenceMarks => 'العلامات المرجعية';

  @override
  String get quranFeaturesSection => 'المميزات';

  @override
  String get quranFavoriteSection => 'المفضلة';

  @override
  String get quranColorSand => 'رملي';

  @override
  String get quranColorBlue => 'أزرق';

  @override
  String get quranColorGreen => 'أخضر';

  @override
  String quranJuzLabel(int juz) {
    return 'الجزء $juz';
  }

  @override
  String quranPageLabel(int page) {
    return 'صفحة $page';
  }

  @override
  String get quranQuickNavigation => 'التنقل السريع';

  @override
  String get quranNextPage => 'الصفحة التالية';

  @override
  String get quranPreviousPage => 'الصفحة السابقة';

  @override
  String get quranReaderMenu => 'قائمة المصحف';

  @override
  String get quranCoachMenu =>
      'القائمة الجانبية: طريقة العرض والفهرس والبحث والألوان والمزيد';

  @override
  String get quranCoachTapAyah =>
      'اضغط على أي آية للتفسير والترجمة والاستماع والمفضلة';

  @override
  String get quranCoachPinch => 'باعد أو قرّب إصبعيك لتكبير الخط أو تصغيره';

  @override
  String get quranCoachQuickNav => 'اضغط على الصفحة لإظهار التنقل السريع';

  @override
  String get quranCoachGotIt => 'حسنًا';

  @override
  String get quranPageNotFound => 'تعذّر العثور على هذه الصفحة.';

  @override
  String get quranClose => 'إغلاق';
}
