import 'package:flutter/material.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';

/// Accent used for selected borders/checks: deep forest in light mode, the
/// lighter primary in dark mode so it keeps contrast on dark surfaces.
Color onboardingAccent(BuildContext context) =>
    context.isDark ? context.colors.primary : context.palette.hero;

/// Primary 54px pill CTA on `palette.hero` with a trailing directional arrow.
class OnboardingPillButton extends StatelessWidget {
  const OnboardingPillButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.leadingIcon,
    this.showArrow = true,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final bool showArrow;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.pillAll,
        boxShadow: onPressed == null ? null : palette.heroShadow,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: palette.hero,
            foregroundColor: palette.onHero,
            textStyle: context.textStyles.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          child: isLoading
              ? SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.5, color: palette.onHero),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (leadingIcon != null) ...[
                      Icon(leadingIcon, size: 20),
                      const SizedBox(width: AppSpacing.xs),
                    ],
                    Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    if (showArrow) ...[
                      const SizedBox(width: AppSpacing.xs),
                      const Icon(Icons.arrow_forward, size: 20),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}

/// Secondary, low-emphasis pill ("Maybe later", "Decide later").
class OnboardingSecondaryButton extends StatelessWidget {
  const OnboardingSecondaryButton({required this.label, required this.onPressed, super.key});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(44),
          foregroundColor: onboardingAccent(context),
          side: BorderSide(color: context.colors.secondary.withValues(alpha: 0.3)),
        ),
        child: Text(label),
      ),
    );
  }
}

/// Circular halo emblem at the top of each step (white disc, hairline ring,
/// thin gold inner ring, soft green aura).
class OnboardingEmblem extends StatelessWidget {
  const OnboardingEmblem({required this.icon, super.key, this.size = 64});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final palette = context.palette;
    return SizedBox.square(
      dimension: size + 24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.secondaryContainer.withValues(alpha: context.isDark ? 0.12 : 0.35),
            ),
          ),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.surfaceContainerLowest,
              border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4)),
              boxShadow: palette.whisperShadow,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxs),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: palette.gold.withValues(alpha: 0.35)),
                ),
                child: Icon(icon, size: size * 0.46, color: onboardingAccent(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small pill label with a gold dot ("LANGUAGE").
class OnboardingBadge extends StatelessWidget {
  const OnboardingBadge(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: AppRadius.pillAll,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: colors.tertiaryFixedDim, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text.toUpperCase(),
              style: context.textStyles.labelSmall?.copyWith(color: colors.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}

/// Centered hero heading block (emblem, optional badge, title, subtitle).
class OnboardingHeading extends StatelessWidget {
  const OnboardingHeading({
    required this.icon,
    required this.title,
    super.key,
    this.badge,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? badge;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnboardingEmblem(icon: icon),
        const SizedBox(height: AppSpacing.sm),
        if (badge != null) ...[OnboardingBadge(badge!), const SizedBox(height: AppSpacing.sm)],
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textStyles.headlineMedium?.copyWith(color: context.colors.primary),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: context.textStyles.bodyMedium?.copyWith(color: context.colors.secondary),
          ),
        ],
      ],
    );
  }
}

/// Round radio/checkbox indicator used on every selectable card.
class SelectionIndicator extends StatelessWidget {
  const SelectionIndicator({required this.selected, super.key});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final accent = onboardingAccent(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? accent : Colors.transparent,
        border: Border.all(
          color: selected ? accent : context.colors.outlineVariant,
          width: selected ? 0 : 2,
        ),
      ),
      child: selected
          ? Icon(
              Icons.check,
              size: 16,
              color: context.isDark ? context.colors.onPrimary : context.palette.onHero,
            )
          : null,
    );
  }
}

/// A selectable sanctuary card: 20px radius, 2px accent border when
/// selected, hairline otherwise; press-scale via [InkWell] + [AnimatedScale].
class SelectableOptionCard extends StatelessWidget {
  const SelectableOptionCard({
    required this.selected,
    required this.onTap,
    required this.title,
    super.key,
    this.leading,
    this.subtitle,
    this.titleTrailing,
    this.footer,
    this.isRadio = true,
  });

  final bool selected;
  final VoidCallback onTap;
  final String title;
  final Widget? leading;
  final String? subtitle;
  final Widget? titleTrailing;
  final Widget? footer;
  final bool isRadio;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = onboardingAccent(context);
    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: isRadio,
      checked: isRadio ? null : selected,
      button: true,
      child: Material(
        color: colors.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardAll,
          side: BorderSide(
            color: selected ? accent : colors.outlineVariant.withValues(alpha: 0.5),
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (leading != null) ...[leading!, const SizedBox(width: AppSpacing.sm)],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: AppSpacing.xs,
                            runSpacing: AppSpacing.xxs,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                title,
                                style: context.textStyles.titleMedium?.copyWith(
                                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                                  color: selected ? colors.onSurface : colors.onSurface,
                                ),
                              ),
                              ?titleTrailing,
                            ],
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              subtitle!,
                              style: context.textStyles.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    SelectionIndicator(selected: selected),
                  ],
                ),
                ?footer,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Rounded-square leading badge for option cards (e.g. "En", "ع", icons).
class OptionLeadingBadge extends StatelessWidget {
  const OptionLeadingBadge({required this.selected, required this.child, super.key});

  final bool selected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected
            ? colors.secondaryContainer.withValues(alpha: context.isDark ? 0.25 : 0.6)
            : colors.surfaceContainer,
        borderRadius: AppRadius.largeAll,
      ),
      child: IconTheme.merge(
        data: IconThemeData(
          color: selected ? onboardingAccent(context) : colors.onSurfaceVariant,
          size: 22,
        ),
        child: DefaultTextStyle.merge(
          style: context.textStyles.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: selected ? onboardingAccent(context) : colors.onSurfaceVariant,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Small pill tag inside a card title row ("Recommended").
class OnboardingTag extends StatelessWidget {
  const OnboardingTag(this.text, {super.key, this.strong = false});

  final String text;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
      decoration: BoxDecoration(
        color: strong ? palette.hero : colors.secondaryContainer.withValues(alpha: 0.6),
        borderRadius: AppRadius.pillAll,
      ),
      child: Text(
        text,
        style: context.textStyles.labelSmall?.copyWith(
          color: strong ? palette.onHero : colors.onSecondaryContainer,
        ),
      ),
    );
  }
}

/// Soft callout with a gold icon (tips, privacy notes, result states).
class OnboardingNote extends StatelessWidget {
  const OnboardingNote({
    required this.icon,
    required this.text,
    super.key,
    this.iconColor,
    this.action,
  });

  final IconData icon;
  final String text;
  final Color? iconColor;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: AppRadius.largeAll,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: iconColor ?? context.palette.gold),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: context.textStyles.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                ),
                ?action,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
