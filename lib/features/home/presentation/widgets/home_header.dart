import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/date_formatting.dart';
import '../../../profile/domain/display_name_provider.dart';
import '../../../profile/presentation/profile_routes.dart';

/// Sticky top bar: spa mark + wordmark, and a notifications bell (Profile
/// has its own tab, so the header carries the bell rather than a profile
/// icon — see the research doc, §IA). The bell opens Profile, where
/// notification preferences live.
class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.surface,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.xxs,
          AppSpacing.xs,
          AppSpacing.xxs,
        ),
        child: Row(
          children: [
            Icon(Icons.spa, color: colors.primary, size: 24),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                context.l10n.appName,
                style: context.textStyles.titleLarge?.copyWith(color: colors.primary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              tooltip: context.l10n.homeNotificationsTooltip,
              onPressed: () => context.go(ProfilePaths.root),
              icon: Icon(Icons.notifications_outlined, color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Assalamu Alaikum, {name} 🌿" plus today's Gregorian • Hijri date. The
/// name is the optional one set in onboarding/Profile; without it the
/// greeting stays nameless rather than inventing one.
class HomeGreeting extends ConsumerWidget {
  const HomeGreeting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(displayNameProvider);
    final locale = Localizations.localeOf(context).languageCode;
    final now = DateTime.now();
    final gregorian = DateFormat('EEEE, d MMM', locale).format(now);
    final hijri = AppDateFormat.hijriShort(now, locale);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name == null
              ? '${context.l10n.homeGreeting} 🌿'
              : '${context.l10n.homeGreetingNamed(name)} 🌿',
          style: context.textStyles.headlineMedium?.copyWith(color: context.colors.primary),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          '$gregorian • $hijri',
          style: context.textStyles.bodySmall?.copyWith(
            color: context.colors.secondary,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
