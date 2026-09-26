import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../../../prayer/data/drift_prayer_log_repository.dart';
import '../../../prayer/domain/prayer_models.dart';
import '../../../prayer/presentation/prayer_formatting.dart';
import '../../../prayer/presentation/prayer_name_x.dart';
import '../../../prayer/presentation/providers/prayer_providers.dart';

/// Next-prayer hero: name, time, live countdown, location, the day's five
/// prayers as a timeline (passed ones dimmed, with a check when logged;
/// long-press a begun prayer to log it) and the night's midpoint/last third.
/// Tapping opens the Prayer screen.
///
/// Rebuild budget: this widget only rebuilds when the *next prayer* or the
/// day's logs change. The countdown text (per minute) and pulse dot (per
/// second) are their own tiny consumers.
class HomePrayerCard extends ConsumerWidget {
  const HomePrayerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(prayerDayStateProvider);
    if (state == null) {
      final failed = ref.watch(todayPrayerScheduleProvider.select((s) => s.hasError));
      if (failed) {
        return SakinahCard(
          child: ErrorState(
            message: l10n.errorGeneric,
            retryLabel: l10n.retry,
            onRetry: () => ref.invalidate(todayPrayerScheduleProvider),
          ),
        );
      }
      return const SkeletonLoader(height: 220, borderRadius: AppRadius.xLargeAll);
    }

    final palette = context.palette;
    final locale = Localizations.localeOf(context).languageCode;
    final schedule = state.schedule;
    final next = state.next;
    final logged = ref.watch(prayerLogsForDayProvider(schedule.day)).valueOrNull ?? const {};
    final location = schedule.location;

    return Semantics(
      container: true,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: palette.hero,
          borderRadius: AppRadius.xLargeAll,
          boxShadow: palette.heroShadow,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => context.push(AppRoutes.prayer),
            child: Stack(
              children: [
                // Ambient arch aura.
                PositionedDirectional(
                  end: -40,
                  bottom: -40,
                  child: _Arc(size: 176, color: palette.heroAccent.withValues(alpha: 0.2)),
                ),
                PositionedDirectional(
                  end: -24,
                  bottom: -24,
                  child: _Arc(size: 128, color: palette.heroAccent.withValues(alpha: 0.15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const _PulseDot(),
                                    const SizedBox(width: 6),
                                    Flexible(
                                      child: Text(
                                        l10n.homeNextPrayer.toUpperCase(),
                                        style: context.textStyles.labelSmall?.copyWith(
                                          color: palette.heroAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.xxs),
                                Text(
                                  next.name.label(l10n),
                                  style: context.textStyles.headlineMedium?.copyWith(
                                    color: palette.onHero,
                                  ),
                                ),
                                const _CountdownText(),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                PrayerFormat.time(next.time, locale),
                                style: context.textStyles.displayMedium?.copyWith(
                                  color: palette.onHero,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.location_on, size: 12, color: palette.gold),
                                  const SizedBox(width: 2),
                                  Text(
                                    location == null
                                        ? l10n.homeLocationPending
                                        : PrayerFormat.coordinates(location, digits: 1),
                                    textDirection: location == null ? null : TextDirection.ltr,
                                    style: context.textStyles.labelSmall?.copyWith(
                                      color: palette.gold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Divider(height: 1, color: palette.onHeroMuted.withValues(alpha: 0.25)),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          for (final t in schedule.times) ...[
                            if (t.name != PrayerName.fajr) const SizedBox(width: AppSpacing.xxs),
                            Expanded(
                              child: _TimelineNode(
                                key: ValueKey('home-timeline-${t.name.name}'),
                                prayer: t,
                                isNext: state.isNext(t.name),
                                isPassed: state.isPassed(t.name),
                                isLogged: logged.contains(t.name),
                                onLongPress: state.isPassed(t.name)
                                    ? () {
                                        HapticFeedback.lightImpact();
                                        ref
                                            .read(prayerLogRepositoryProvider)
                                            .togglePrayed(schedule.day, t.name);
                                      }
                                    : null,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Divider(height: 1, color: palette.onHeroMuted.withValues(alpha: 0.25)),
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.xxs,
                        children: [
                          _NightTime(
                            label: l10n.homeMidnight,
                            time: PrayerFormat.time(schedule.midnight, locale),
                          ),
                          _NightTime(
                            label: l10n.homeLastThird,
                            time: PrayerFormat.time(schedule.lastThird, locale),
                          ),
                        ],
                      ),
                      if (schedule.isEstimated) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.prayerEstimatedNotice,
                          style: context.textStyles.labelSmall?.copyWith(
                            color: palette.onHeroMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Arc extends StatelessWidget {
  const _Arc({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color),
        ),
      ),
    );
  }
}

/// Gold dot that breathes once a second, driven by the shared clock tick
/// (finite implicit animations — no endlessly repeating controller).
class _PulseDot extends ConsumerWidget {
  const _PulseDot();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final even = ref.watch(clockTickProvider.select((t) => (t.valueOrNull?.second ?? 0).isEven));
    return AnimatedOpacity(
      opacity: reduceMotion || even ? 1 : 0.35,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: context.palette.heroAccent, shape: BoxShape.circle),
      ),
    );
  }
}

class _CountdownText extends ConsumerWidget {
  const _CountdownText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minutes = ref.watch(
      nextPrayerProvider.select((i) => i == null ? null : PrayerFormat.minutesLeft(i.remaining)),
    );
    if (minutes == null) return const SizedBox.shrink();
    return Text(
      context.l10n.prayerCountdown(PrayerFormat.countdown(minutes)),
      style: context.textStyles.bodySmall?.copyWith(color: context.palette.onHeroMuted),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  const _TimelineNode({
    required this.prayer,
    required this.isNext,
    required this.isPassed,
    required this.isLogged,
    required this.onLongPress,
    super.key,
  });

  final PrayerTime prayer;
  final bool isNext;
  final bool isPassed;
  final bool isLogged;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final locale = Localizations.localeOf(context).languageCode;
    final name = prayer.name.label(l10n);

    final Color bg;
    final Color labelColor;
    final Color timeColor;
    if (isNext) {
      bg = palette.onHero;
      labelColor = palette.hero;
      timeColor = palette.hero;
    } else if (isPassed) {
      bg = palette.onHero.withValues(alpha: 0.08);
      labelColor = palette.onHero.withValues(alpha: 0.7);
      timeColor = palette.onHero.withValues(alpha: 0.7);
    } else {
      bg = palette.onHero.withValues(alpha: 0.05);
      labelColor = palette.onHeroMuted;
      timeColor = palette.onHero.withValues(alpha: 0.9);
    }

    final node = AnimatedScale(
      scale: isNext ? 1.05 : 1,
      duration: const Duration(milliseconds: 250),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: AppRadius.mediumAll,
          border: isNext ? Border.all(color: palette.heroAccent.withValues(alpha: 0.4)) : null,
        ),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    style: context.textStyles.labelSmall?.copyWith(
                      color: labelColor,
                      fontWeight: isNext ? FontWeight.w700 : FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
                  if (isLogged) ...[
                    const SizedBox(width: 2),
                    Icon(Icons.check, size: 11, color: isNext ? palette.hero : palette.heroAccent),
                  ],
                ],
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                PrayerFormat.time(prayer.time, locale),
                maxLines: 1,
                style: context.textStyles.bodySmall?.copyWith(
                  color: timeColor,
                  fontWeight: isNext ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (onLongPress == null) return node;
    return Semantics(
      toggled: isLogged,
      onLongPressHint: isLogged ? l10n.prayerUnmarkPrayed(name) : l10n.prayerMarkPrayed(name),
      child: GestureDetector(onLongPress: onLongPress, child: node),
    );
  }
}

class _NightTime extends StatelessWidget {
  const _NightTime({required this.label, required this.time});

  final String label;
  final String time;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: context.textStyles.labelSmall?.copyWith(
            color: palette.onHeroMuted,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(width: 6),
        Text(time, style: context.textStyles.labelSmall?.copyWith(color: palette.onHero)),
      ],
    );
  }
}
