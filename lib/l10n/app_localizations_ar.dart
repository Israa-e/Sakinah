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
  String get navProfile => 'الملف الشخصي';

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
}
