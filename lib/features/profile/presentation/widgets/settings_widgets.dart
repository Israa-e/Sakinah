import 'package:flutter/material.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_card.dart';

/// Gold eyebrow + a sanctuary card holding a group of rows separated by
/// hairline dividers.
class SettingsSection extends StatelessWidget {
  const SettingsSection({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: AppSpacing.xxs, bottom: AppSpacing.xs),
            child: CardEyebrow(title),
          ),
          SakinahCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < children.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: AppSpacing.md + 40 + AppSpacing.sm,
                      color: context.colors.outlineVariant.withValues(alpha: 0.35),
                    ),
                  children[i],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RowIcon extends StatelessWidget {
  const _RowIcon(this.icon, {this.destructive = false});

  final IconData icon;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: destructive
            ? colors.errorContainer.withValues(alpha: context.isDark ? 0.25 : 0.6)
            : colors.secondaryContainer.withValues(alpha: context.isDark ? 0.2 : 0.55),
        borderRadius: AppRadius.mediumAll,
      ),
      child: Icon(
        icon,
        size: 20,
        color: destructive
            ? colors.error
            : (context.isDark ? colors.primary : context.palette.hero),
      ),
    );
  }
}

/// A single settings row: tinted icon tile, title, optional subtitle and
/// trailing (value text, switch, chevron). Tappable only when [onTap] is set;
/// informational rows get no chevron and no ink.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    required this.icon,
    required this.title,
    super.key,
    this.subtitle,
    this.value,
    this.trailing,
    this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        children: [
          _RowIcon(icon, destructive: destructive),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textStyles.titleMedium?.copyWith(
                    color: destructive ? colors.error : colors.onSurface,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: context.textStyles.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ],
                if (value != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    value!,
                    style: context.textStyles.bodySmall?.copyWith(
                      color: context.palette.gold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.xs),
            trailing!,
          ] else if (onTap != null) ...[
            const SizedBox(width: AppSpacing.xs),
            Icon(Icons.chevron_right, color: colors.outline),
          ],
        ],
      ),
    );
    if (onTap == null) return content;
    return InkWell(onTap: onTap, borderRadius: AppRadius.cardAll, child: content);
  }
}

/// Row with a full-width segmented choice underneath the title — keeps the
/// options readable at 360px / 1.3× text instead of squeezing them trailing.
class SettingsChoiceRow<T> extends StatelessWidget {
  const SettingsChoiceRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.options,
    required this.onChanged,
    super.key,
  });

  final IconData icon;
  final String title;
  final T value;
  final List<(T, String)> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _RowIcon(icon),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(title, style: context.textStyles.titleMedium)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<T>(
            showSelectedIcon: false,
            segments: [
              for (final (v, label) in options)
                ButtonSegment<T>(
                  value: v,
                  label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
            ],
            selected: {value},
            onSelectionChanged: (s) => onChanged(s.first),
          ),
        ],
      ),
    );
  }
}
