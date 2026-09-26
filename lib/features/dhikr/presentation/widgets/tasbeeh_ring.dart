import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';

/// Large tappable tasbeeh ring: gold progress stroke over a 20% sage track,
/// the count in the centre. The whole ring is the tap target.
class TasbeehRing extends StatelessWidget {
  const TasbeehRing({
    required this.count,
    required this.target,
    required this.onTap,
    super.key,
    this.size = 240,
  });

  final int count;
  final int target;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final progress = target <= 0 ? 0.0 : (count / target).clamp(0.0, 1.0);
    final muted = context.colors.onSurfaceVariant;

    return Semantics(
      button: true,
      label: l10n.dhikrCounterSemantics(count, target),
      excludeSemantics: true,
      child: GestureDetector(
        key: const ValueKey('tasbeeh-ring'),
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox.square(
          dimension: size,
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: progress),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            builder: (context, value, child) => CustomPaint(
              painter: _RingPainter(
                progress: value,
                trackColor: context.colors.secondary.withValues(alpha: 0.2),
                progressColor: context.colors.tertiaryFixedDim,
                strokeWidth: size * 0.0375,
              ),
              child: child,
            ),
            child: Padding(
              padding: EdgeInsets.all(size * 0.09),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.surfaceContainerLowest,
                  boxShadow: palette.whisperShadow,
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$count',
                            style: context.sakinahTypography.counter.copyWith(
                              color: context.colors.primary,
                              fontSize: 56,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            '${l10n.dhikrGoal} / $target',
                            style: context.textStyles.labelMedium?.copyWith(color: palette.gold),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.touch_app_outlined, size: 14, color: muted),
                              const SizedBox(width: AppSpacing.xxs),
                              Text(
                                l10n.dhikrTapToCount,
                                style: context.textStyles.labelSmall?.copyWith(color: muted),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = trackColor;
    canvas.drawCircle(center, radius, track);
    if (progress <= 0) return;
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = progressColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.trackColor != trackColor ||
      old.progressColor != progressColor ||
      old.strokeWidth != strokeWidth;
}
