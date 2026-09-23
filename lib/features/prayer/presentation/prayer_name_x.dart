import '../../../l10n/app_localizations.dart';
import '../domain/prayer_models.dart';

extension PrayerNameLabel on PrayerName {
  String label(AppLocalizations l10n) => switch (this) {
        PrayerName.fajr => l10n.prayerFajr,
        PrayerName.dhuhr => l10n.prayerDhuhr,
        PrayerName.asr => l10n.prayerAsr,
        PrayerName.maghrib => l10n.prayerMaghrib,
        PrayerName.isha => l10n.prayerIsha,
      };
}
