import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/date_formatting.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/drift_prayer_log_repository.dart';
import '../../domain/prayer_models.dart';
import '../../domain/prayer_notifications_provider.dart';
import '../prayer_formatting.dart';
import '../prayer_name_x.dart';
import '../providers/prayer_providers.dart';
import 'next_prayer_hero.dart';

/// Icon shown for a prayer that hasn't begun yet.
IconData prayerIcon(PrayerName name) => switch (name) {
  PrayerName.fajr => Icons.wb_twilight,
  PrayerName.dhuhr => Icons.light_mode_outlined,
  PrayerName.asr => Icons.wb_sunny_outlined,
  PrayerName.maghrib => Icons.wb_twilight,
  PrayerName.isha => Icons.dark_mode_outlined,
};

/// "Today's schedule": all five prayers (plus sunrise), the next one
/// highlighted with a live countdown, and — for every prayer whose time has
/// begun — a tap target to mark it as prayed (persisted in `PrayerLogs`).
class PrayerScheduleCard extends ConsumerWidget {
  const PrayerScheduleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(prayerDayStateProvider);
    if (state == null) return const SizedBox(height: 320);

    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final schedule = state.schedule;
    final logged = ref.watch(prayerLogsForDayProvider(schedule.day)).valueOrNull ?? const {};
    final notificationsOn = ref.watch(prayerNotificationsEnabledProvider);
    // Arabic prayer names shown under the English ones (skipped in Arabic UI).
    final arabic = locale == 'ar' ? null : lookupAppLocalizations(const Locale('ar'));

    Widget rowFor(PrayerTime t) => _PrayerRow(
      key: ValueKey('prayer-row-${t.name.name}'),
      prayer: t,
      arabicLabel: arabic == null ? null : t.name.label(arabic),
      isNext: state.isNext(t.name),
      hasBegun: state.isPassed(t.name),
      isLogged: logged.contains(t.name),
      notificationsOn: notificationsOn,
      onToggle: () {
        HapticFeedback.lightImpact();
        ref.read(prayerLogRepositoryProvider).togglePrayed(schedule.day, t.name);
      },
    );

    final sunrise = schedule.sunrise;
    return SakinahCard(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.xs,
            children: [
              Text(
                l10n.prayerTodaysSchedule,
                style: context.textStyles.titleMedium?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                AppDateFormat.hijriShort(schedule.day, locale),
                style: context.textStyles.labelSmall?.copyWith(color: context.colors.secondary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          for (final t in schedule.times) ...[
            rowFor(t),
            if (t.name == PrayerName.fajr && sunrise != null)
              _SunriseRow(time: sunrise, arabicLabel: arabic?.prayerSunrise),
          ],
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.prayerLoggedCount(logged.length),
            textAlign: TextAlign.center,
            style: context.textStyles.bodySmall?.copyWith(color: context.colors.secondary),
          ),
        ],
      ),
    );
  }
}

class _PrayerRow extends StatelessWidget {
  const _PrayerRow({
    required this.prayer,
    required this.arabicLabel,
    required this.isNext,
    required this.hasBegun,
    required this.isLogged,
    required this.notificationsOn,
    required this.onToggle,
    super.key,
  });

  final PrayerTime prayer;
  final String? arabicLabel;
  final bool isNext;
  final bool hasBegun;
  final bool isLogged;
  final bool notificationsOn;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final locale = Localizations.localeOf(context).languageCode;
    final name = prayer.name.label(l10n);

    final Widget leading;
    if (isNext) {
      leading = _Circle(
        background: colors.primary,
        child: Icon(Icons.schedule, size: 15, color: colors.onPrimary),
      );
    } else if (hasBegun) {
      leading = AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isLogged
            ? _Circle(
                key: const ValueKey('logged'),
                background: colors.secondaryContainer,
                child: Icon(Icons.check, size: 16, color: colors.primary),
              )
            : _Circle(
                key: const ValueKey('unlogged'),
                background: Colors.transparent,
                border: colors.outline,
                child: const SizedBox.shrink(),
              ),
      );
    } else {
      leading = _Circle(
        background: colors.surfaceContainerHigh,
        child: Icon(prayerIcon(prayer.name), size: 15, color: colors.secondary),
      );
    }

    final titleStyle = context.textStyles.titleMedium?.copyWith(
      color: isNext ? colors.primary : colors.onSurface,
      fontWeight: isNext ? FontWeight.w700 : FontWeight.w500,
      decoration: isLogged ? TextDecoration.lineThrough : null,
      decorationColor: colors.secondary.withValues(alpha: 0.5),
    );

    final bell = !notificationsOn
        ? Icons.notifications_none
        : (isNext ? Icons.notifications_active : Icons.notifications_outlined);

    final row = Container(
      padding: EdgeInsets.symmetric(
        horizontal: isNext ? AppSpacing.sm : 0,
        vertical: AppSpacing.sm,
      ),
      margin: EdgeInsets.symmetric(vertical: isNext ? AppSpacing.xxs : 0),
      decoration: isNext
          ? BoxDecoration(
              color: colors.secondaryContainer.withValues(alpha: 0.4),
              borderRadius: AppRadius.mediumAll,
              border: Border.all(color: colors.secondary.withValues(alpha: 0.2)),
            )
          : null,
      child: Row(
        children: [
          leading,
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xxs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(name, style: titleStyle),
                    if (isNext) const NextPrayerCountdownBadge(onHero: false),
                  ],
                ),
                if (arabicLabel != null)
                  Text(
                    arabicLabel!,
                    textDirection: TextDirection.rtl,
                    style: context.sakinahTypography.arabicUi.copyWith(
                      fontSize: 12,
                      height: 1.4,
                      color: colors.secondary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            PrayerFormat.time(prayer.time, locale),
            style: (isNext ? context.textStyles.titleMedium : context.textStyles.bodyMedium)
                ?.copyWith(
                  color: isNext ? colors.primary : colors.secondary,
                  fontWeight: isNext ? FontWeight.w700 : FontWeight.w400,
                ),
          ),
          const SizedBox(width: AppSpacing.sm),
          ExcludeSemantics(
            child: Icon(
              bell,
              size: isNext ? 20 : 18,
              color: isNext && notificationsOn
                  ? context.palette.gold
                  : colors.secondary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );

    if (!hasBegun) {
      return Semantics(hint: isNext ? null : l10n.prayerNotYetTime, child: row);
    }

    return Semantics(
      button: true,
      toggled: isLogged,
      label: isLogged ? l10n.prayerUnmarkPrayed(name) : l10n.prayerMarkPrayed(name),
      child: InkWell(
        onTap: onToggle,
        borderRadius: AppRadius.mediumAll,
        child: Tooltip(
          message: isLogged ? l10n.prayerUnmarkPrayed(name) : l10n.prayerMarkPrayed(name),
          excludeFromSemantics: true,
          child: row,
        ),
      ),
    );
  }
}

class _SunriseRow extends StatelessWidget {
  const _SunriseRow({required this.time, required this.arabicLabel});

  final DateTime time;
  final String? arabicLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final locale = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          _Circle(
            background: colors.surfaceContainerHigh,
            child: Icon(Icons.wb_sunny, size: 14, color: colors.secondary),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.prayerSunrise,
                  style: context.textStyles.titleMedium?.copyWith(color: colors.secondary),
                ),
                if (arabicLabel != null)
                  Text(
                    arabicLabel!,
                    textDirection: TextDirection.rtl,
                    style: context.sakinahTypography.arabicUi.copyWith(
                      fontSize: 12,
                      height: 1.4,
                      color: colors.secondary,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            PrayerFormat.time(time, locale),
            style: context.textStyles.bodyMedium?.copyWith(color: colors.secondary),
          ),
          // Keeps the time column aligned with the prayer rows' bell icon.
          const SizedBox(width: AppSpacing.sm + 18),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.background, required this.child, super.key, this.border});

  final Color background;
  final Color? border;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border == null ? null : Border.all(color: border!, width: 1.5),
      ),
      child: child,
    );
  }
}
