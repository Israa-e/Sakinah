import 'package:flutter/material.dart';

/// Thin wrapper over [AppBar] so screens don't each re-decide elevation/
/// centering/back-button style — that's owned by [AppTheme.appBarTheme].
class SakinahAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SakinahAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.showBackButton = false,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      leading: leading,
      title: title != null ? Text(title!) : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
