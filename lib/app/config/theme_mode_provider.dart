import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/storage/preferences_service.dart';

part 'theme_mode_provider.g.dart';

@Riverpod(keepAlive: true)
class AppThemeModeController extends _$AppThemeModeController {
  @override
  AppThemeMode build() => ref.watch(preferencesServiceProvider).themeMode;

  Future<void> setThemeMode(AppThemeMode mode) async {
    await ref.read(preferencesServiceProvider).setThemeMode(mode);
    state = mode;
  }
}

extension AppThemeModeX on AppThemeMode {
  ThemeMode get toFlutter => switch (this) {
        AppThemeMode.system => ThemeMode.system,
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      };
}
