import 'package:flutter/material.dart';

import '../constants/app_radius.dart';

/// A slim, rounded linear progress bar (Quran/Journey progress, etc).
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    required this.value,
    super.key,
    this.height = 8,
    this.color,
    this.trackColor,
  });

  /// 0.0–1.0
  final double value;
  final double height;
  final Color? color;
  final Color? trackColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: AppRadius.pillAll,
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        minHeight: height,
        backgroundColor: trackColor ?? colorScheme.surfaceContainerHighest,
        valueColor: AlwaysStoppedAnimation(color ?? colorScheme.primary),
      ),
    );
  }
}

/// A circular progress ring with an optional centered label — used for the
/// tasbeeh counter, journey level, and garden progress.
class CircularProgress extends StatelessWidget {
  const CircularProgress({
    required this.value,
    super.key,
    this.size = 64,
    this.strokeWidth = 6,
    this.color,
    this.trackColor,
    this.child,
  });

  /// 0.0–1.0
  final double value;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? trackColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: value.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              strokeCap: StrokeCap.round,
              backgroundColor: trackColor ?? colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation(color ?? colorScheme.primary),
            ),
          ),
          ?child,
        ],
      ),
    );
  }
}
