import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/storage/preferences_service.dart';

part 'locale_provider.g.dart';

const supportedLocales = [Locale('en'), Locale('ar')];

/// The active app locale. Defaults to the device locale when it's one Sakīnah
/// supports, otherwise English — never a locale that has no ARB file.
@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale build() {
    final saved = ref.watch(preferencesServiceProvider).locale;
    if (saved != null) {
      return supportedLocales.firstWhere(
        (l) => l.languageCode == saved,
        orElse: () => const Locale('en'),
      );
    }
    final device = PlatformDispatcher.instance.locale;
    return supportedLocales.firstWhere(
      (l) => l.languageCode == device.languageCode,
      orElse: () => const Locale('en'),
    );
  }

  Future<void> setLocale(Locale locale) async {
    await ref.read(preferencesServiceProvider).setLocale(locale.languageCode);
    state = locale;
  }
}
