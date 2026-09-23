import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/prayer/presentation/providers/prayer_notification_scheduler.dart';
import '../l10n/app_localizations.dart';
import 'config/locale_provider.dart';
import 'config/theme_mode_provider.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class SakinahApp extends ConsumerWidget {
  const SakinahApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(appLocaleProvider);
    final themeMode = ref.watch(appThemeModeControllerProvider);
    // Keeps prayer-time reminders scheduled for as long as the app is alive,
    // independent of whichever screen is currently shown.
    ref.watch(prayerNotificationSchedulerProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      themeMode: themeMode.toFlutter,
      theme: AppTheme.light(languageCode: locale.languageCode),
      darkTheme: AppTheme.dark(languageCode: locale.languageCode),
    );
  }
}
