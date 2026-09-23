import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Shortcuts so screens don't repeat `Theme.of(context)...` / `AppLocalizations.of(context)!`
/// everywhere. Keep this extension thin — it's a lookup convenience, not a place for logic.
extension BuildContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  ThemeData get theme => Theme.of(this);

  TextTheme get textStyles => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  Size get screenSize => MediaQuery.sizeOf(this);

  EdgeInsets get viewPadding => MediaQuery.paddingOf(this);
}
