import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_app_bar.dart';
import '../../../../core/widgets/states.dart';
import '../../domain/qibla_models.dart';
import '../providers/qibla_providers.dart';
import '../widgets/compass_dial.dart';

class QiblaScreen extends ConsumerWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final qiblaAsync = ref.watch(qiblaProvider);

    return Scaffold(
      appBar: SakinahAppBar(title: l10n.qiblaTitle, showBackButton: true),
      body: SafeArea(
        child: qiblaAsync.when(
          loading: () => const LoadingState(),
          error: (e, st) => ErrorState(
            message: l10n.errorGeneric,
            retryLabel: l10n.retry,
            onRetry: () => ref.invalidate(qiblaProvider),
          ),
          data: (result) => result.when(
            success: (reading) => _QiblaCompass(reading: reading),
            failure: (failure) => _QiblaFailureView(
              failure: failure,
              onRetry: () => ref.invalidate(qiblaProvider),
            ),
          ),
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
    final message = switch (failure) {
      PermissionFailure() => l10n.qiblaPermissionDenied,
      LocationFailure() => l10n.qiblaLocationUnavailable,
      SensorFailure() => l10n.qiblaSensorUnavailable,
      _ => l10n.errorGeneric,
    };
    return ErrorState(message: message, retryLabel: l10n.retry, onRetry: onRetry);
  }
}

class _QiblaCompass extends StatelessWidget {
  const _QiblaCompass({required this.reading});

  final QiblaReading reading;

  static const _dialSize = 280.0;
  static const _facingTolerance = 6.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = context.colors;
    final relativeAngle = reading.relativeAngle;
    final isFacingQibla = relativeAngle != null &&
        (relativeAngle <= _facingTolerance || relativeAngle >= 360 - _facingTolerance);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          if (reading.needsCalibration) ...[
            _CalibrationBanner(message: l10n.qiblaCalibrateHint),
            const SizedBox(height: AppSpacing.lg),
          ],
          Expanded(
            child: Center(
              child: SizedBox(
                width: _dialSize,
                height: _dialSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CompassDial(size: _dialSize),
                    AnimatedRotation(
                      turns: (relativeAngle ?? 0) / 360,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.navigation,
                        size: 72,
                        color: isFacingQibla ? colorScheme.tertiary : colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isFacingQibla)
            Text(
              l10n.qiblaFacingIt,
              style: context.textStyles.headlineSmall?.copyWith(color: colorScheme.tertiary),
            )
          else if (relativeAngle != null)
            Text(
              '${relativeAngle.round()}°',
              style: context.textStyles.displayMedium,
            ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _CalibrationBanner extends StatelessWidget {
  const _CalibrationBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.explore_off_outlined, color: colorScheme.onSecondaryContainer),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: context.textStyles.bodySmall
                  ?.copyWith(color: colorScheme.onSecondaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
