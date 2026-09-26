import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:permission_handler/permission_handler.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../prayer/presentation/widgets/sanctuary_header.dart';
import '../../data/qibla_verse.dart';
import '../../domain/qibla_models.dart';
import '../providers/qibla_providers.dart';
import '../widgets/compass_dial.dart';

/// "Qibla" half of the Qibla & Prayer sanctuary (`/qibla`).
class QiblaScreen extends ConsumerWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final qiblaAsync = ref.watch(qiblaProvider);
    void retry() => ref.invalidate(qiblaProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SanctuaryTopBar(),
            const OfflineBanner(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                ),
                children: [
                  const SanctuarySegmentedControl(selected: SanctuaryTab.qibla),
                  const SizedBox(height: AppSpacing.lg),
                  qiblaAsync.when(
                    loading: () => const SizedBox(
                      height: 360,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (e, st) => _QiblaMessage(
                      icon: Icons.cloud_off_outlined,
                      message: l10n.errorGeneric,
                      onRetry: retry,
                    ),
                    data: (result) => result.when(
                      success: (reading) => _QiblaCompassCard(reading: reading),
                      failure: (failure) => _QiblaFailureView(failure: failure, onRetry: retry),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const _QiblaVerseCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QiblaFailureView extends StatelessWidget {
  const _QiblaFailureView({required this.failure, required this.onRetry});

  final AppFailure failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (icon, message) = switch (failure) {
      PermissionFailure() => (Icons.location_disabled_outlined, l10n.qiblaPermissionDenied),
      LocationFailure() => (Icons.location_off_outlined, l10n.qiblaLocationUnavailable),
      SensorFailure() => (Icons.explore_off_outlined, l10n.qiblaSensorUnavailable),
      _ => (Icons.cloud_off_outlined, l10n.errorGeneric),
    };
    return _QiblaMessage(
      icon: icon,
      message: message,
      onRetry: onRetry,
      onOpenSettings: failure is PermissionFailure ? openAppSettings : null,
    );
  }
}

class _QiblaMessage extends StatelessWidget {
  const _QiblaMessage({
    required this.icon,
    required this.message,
    required this.onRetry,
    this.onOpenSettings,
  });

  final IconData icon;
  final String message;
  final VoidCallback onRetry;
  final Future<bool> Function()? onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    return SakinahCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colors.secondaryContainer.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: colors.primary, size: 28),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.textStyles.bodyMedium?.copyWith(color: colors.onSurface),
          ),
          const SizedBox(height: AppSpacing.lg),
          SakinahOutlinedButton(label: l10n.retry, onPressed: onRetry, expand: false),
          if (onOpenSettings != null) ...[
            const SizedBox(height: AppSpacing.xs),
            TextButton(onPressed: onOpenSettings, child: Text(l10n.openSettings)),
          ],
        ],
      ),
    );
  }
}

class _QiblaCompassCard extends StatefulWidget {
  const _QiblaCompassCard({required this.reading});

  final QiblaReading reading;

  static const facingTolerance = 6.0;

  @override
  State<_QiblaCompassCard> createState() => _QiblaCompassCardState();
}

class _QiblaCompassCardState extends State<_QiblaCompassCard> {
  bool _isAligned(QiblaReading reading) {
    final relative = reading.relativeAngle;
    return relative != null &&
        (relative <= _QiblaCompassCard.facingTolerance ||
            relative >= 360 - _QiblaCompassCard.facingTolerance);
  }

  @override
  void didUpdateWidget(covariant _QiblaCompassCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isAligned(widget.reading) && !_isAligned(oldWidget.reading)) {
      HapticFeedback.mediumImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final locale = Localizations.localeOf(context).languageCode;
    final reading = widget.reading;
    final aligned = _isAligned(reading);
    final distance = reading.distanceToKaabaKm;
    final lat = reading.latitude;
    final lng = reading.longitude;

    return SakinahCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      borderRadius: AppRadius.xLargeAll,
      child: Column(
        children: [
          _StatusChip(reading: reading, aligned: aligned),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) => CompassDial(
              size: min(256, constraints.maxWidth),
              qiblaBearing: reading.qiblaBearing,
              heading: reading.deviceHeading,
              aligned: aligned,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (distance != null)
            Text(
              l10n.qiblaDistance(NumberFormat.decimalPattern(locale).format(distance.round())),
              textAlign: TextAlign.center,
              style: context.textStyles.bodyMedium?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            [
              if (lat != null && lng != null)
                '${lat.toStringAsFixed(4)}°, ${lng.toStringAsFixed(4)}°',
              l10n.qiblaBearing(reading.qiblaBearing.toStringAsFixed(1)),
            ].join(' • '),
            textAlign: TextAlign.center,
            style: context.textStyles.bodySmall?.copyWith(color: colors.secondary),
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(height: 1, color: colors.outlineVariant.withValues(alpha: 0.25)),
          const SizedBox(height: AppSpacing.sm),
          _CalibrationHint(prominent: reading.needsCalibration),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.reading, required this.aligned});

  final QiblaReading reading;
  final bool aligned;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final relative = reading.relativeAngle;

    final String text;
    if (aligned) {
      text = l10n.qiblaFacingIt;
    } else if (relative == null) {
      text = l10n.qiblaWaitingForCompass;
    } else if (relative <= 180) {
      text = l10n.qiblaTurnRight(relative.round());
    } else {
      text = l10n.qiblaTurnLeft((360 - relative).round());
    }

    return Semantics(
      liveRegion: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: aligned
              ? colors.secondaryContainer.withValues(alpha: 0.8)
              : colors.surfaceContainerHigh,
          borderRadius: AppRadius.pillAll,
          border: Border.all(
            color: aligned ? colors.secondary.withValues(alpha: 0.25) : Colors.transparent,
          ),
          boxShadow: aligned
              ? [
                  BoxShadow(
                    color: context.palette.hero.withValues(alpha: 0.12),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              aligned ? Icons.check_circle : Icons.explore_outlined,
              size: 16,
              color: colors.primary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                text,
                style: context.textStyles.labelMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalibrationHint extends StatelessWidget {
  const _CalibrationHint({required this.prominent});

  /// True when accuracy is poor/unknown — shown as a tinted banner rather
  /// than a quiet footnote.
  final bool prominent;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fg = prominent ? colors.onSecondaryContainer : colors.secondary;
    return Container(
      width: double.infinity,
      padding: prominent ? const EdgeInsets.all(AppSpacing.sm) : EdgeInsets.zero,
      decoration: prominent
          ? BoxDecoration(color: colors.secondaryContainer, borderRadius: AppRadius.mediumAll)
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.screen_rotation_alt, size: 16, color: fg),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              context.l10n.qiblaCalibrateHint,
              style: context.textStyles.labelSmall?.copyWith(color: fg),
            ),
          ),
        ],
      ),
    );
  }
}

class _QiblaVerseCard extends StatelessWidget {
  const _QiblaVerseCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: AppRadius.cardAll,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: colors.surfaceContainerLowest, shape: BoxShape.circle),
            child: Icon(Icons.auto_stories_outlined, size: 18, color: context.palette.gold),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            qiblaVerse.arabic,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: context.sakinahTypography.quranTextMedium.copyWith(color: colors.primary),
          ),
          if (!isArabic) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              '"${qiblaVerse.translation}"',
              textAlign: TextAlign.center,
              style: context.textStyles.bodySmall?.copyWith(
                color: colors.secondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xxs),
          Text(
            l10n.qiblaVerseSource(qiblaVerse.reference),
            textAlign: TextAlign.center,
            style: context.textStyles.labelSmall?.copyWith(color: colors.secondary),
          ),
        ],
      ),
    );
  }
}
