import 'package:flutter/material.dart';

import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';

/// Base surface for every card-shaped component in the app (PrayerCard,
/// QuranCard, DhikrCard, ...). Those compose this rather than each rebuilding
/// their own `Container` + `BoxDecoration`.
class SakinahCard extends StatelessWidget {
  const SakinahCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
    this.color,
    this.border,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? theme.cardColor,
        borderRadius: AppRadius.largeAll,
        border: border,
      ),
      child: child,
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.largeAll,
        child: content,
      ),
    );
  }
}
