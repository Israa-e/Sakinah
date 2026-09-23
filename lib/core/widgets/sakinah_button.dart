import 'package:flutter/material.dart';

/// Primary filled call-to-action button. Wraps [ElevatedButton] purely so the
/// rest of the app depends on one Sakīnah-specific widget rather than on
/// Material directly — styling itself comes from [AppTheme].
class SakinahButton extends StatelessWidget {
  const SakinahButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(label),
            ],
          );

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: child,
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Secondary, lower-emphasis action button.
class SakinahOutlinedButton extends StatelessWidget {
  const SakinahOutlinedButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Text(label),
        ],
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// A calm, circular icon-only affordance (e.g. profile, back, more).
class SakinahIconButton extends StatelessWidget {
  const SakinahIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.semanticLabel,
    this.filled = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: onPressed,
      tooltip: semanticLabel,
      icon: Icon(icon),
      style: filled
          ? IconButton.styleFrom(
              backgroundColor: colorScheme.surfaceContainerHighest,
              foregroundColor: colorScheme.onSurface,
              shape: const CircleBorder(),
            )
          : null,
    );
  }
}
