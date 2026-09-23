import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

/// Gregorian + Hijri date formatting for the given [languageCode] ('en'/'ar').
/// Kept in one place so every screen that shows "today's date" (Home,
/// Ramadan, Hijri calendar) formats it identically.
abstract final class AppDateFormat {
  static String gregorianLong(DateTime date, String languageCode) {
    return DateFormat.yMMMMEEEEd(languageCode).format(date);
  }

  static String hijriShort(DateTime date, String languageCode) {
    HijriCalendar.setLocal(languageCode == 'ar' ? 'ar' : 'en');
    final hijri = HijriCalendar.fromDate(date);
    return '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear}';
  }
}
