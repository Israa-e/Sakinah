import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import 'mushaf_ornaments.dart';
import 'mushaf_theme.dart';

/// Rounded square icon tile used in the reader's top bar.
class MushafIconTile extends StatelessWidget {
  const MushafIconTile({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.theme,
    super.key,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final MushafTheme theme;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: theme.plaque,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: theme.frameSoft, width: 1.4),
        ),
        elevation: 1.5,
        shadowColor: Colors.black26,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: SizedBox.square(
            dimension: 42,
            child: Icon(icon, color: theme.isNight ? theme.ink : const Color(0xFF1D2340), size: 24),
          ),
        ),
      ),
    );
  }
}

/// Top bar laid over the frame: back, surah plaque, juz plaque, menu.
class MushafTopBar extends StatelessWidget {
  const MushafTopBar({
    required this.surahNameAr,
    required this.juz,
    required this.theme,
    required this.onBack,
    required this.onMenu,
    super.key,
  });

  static const height = 48.0;

  final String surahNameAr;
  final int juz;
  final MushafTheme theme;
  final VoidCallback onBack;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final plaqueText = TextStyle(color: theme.ink, fontSize: 13, height: 1.2);
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            MushafIconTile(icon: Icons.arrow_back, tooltip: l10n.back, onTap: onBack, theme: theme),
            const SizedBox(width: 4),
            Expanded(
              flex: 5,
              child: MushafPlaque(
                theme: theme,
                child: Text(
                  surahNameAr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                  textScaler: TextScaler.noScaling,
                  style: context.sakinahTypography.quranTextMedium.copyWith(
                    fontSize: 15,
                    height: 1.2,
                    color: theme.ink,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              flex: 4,
              child: MushafPlaque(
                theme: theme,
                child: Text(
                  l10n.quranJuzLabel(juz),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaler: TextScaler.noScaling,
                  style: context.textStyles.labelMedium?.merge(plaqueText) ?? plaqueText,
                ),
              ),
            ),
            const SizedBox(width: 4),
            MushafIconTile(
              icon: Icons.menu_rounded,
              tooltip: l10n.quranReaderMenu,
              onTap: onMenu,
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom "Quick navigation" bar: juz • page • surah, a page slider laid out
/// right-to-left like the mushaf, and previous/next page buttons.
class MushafQuickNav extends StatefulWidget {
  const MushafQuickNav({
    required this.page,
    required this.lastPage,
    required this.juzOf,
    required this.surahNameOf,
    required this.theme,
    required this.onJump,
    super.key,
  });

  final int page;
  final int lastPage;
  final int Function(int page) juzOf;
  final String Function(int page) surahNameOf;
  final MushafTheme theme;
  final ValueChanged<int> onJump;

  @override
  State<MushafQuickNav> createState() => _MushafQuickNavState();
}

class _MushafQuickNavState extends State<MushafQuickNav> {
  double? _dragging;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = widget.theme;
    final shown = _dragging?.round() ?? widget.page;
    final info = context.textStyles.labelMedium?.copyWith(
      color: theme.ink,
      fontWeight: FontWeight.w600,
    );
    Widget arrow(IconData icon, String tooltip, int target) => IconButton(
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      onPressed: target < 1 || target > widget.lastPage ? null : () => widget.onJump(target),
      // Explicit LTR so the arrow always points the way the page moves.
      icon: Icon(icon, color: theme.frame, textDirection: TextDirection.ltr),
    );

    return Material(
      color: theme.plaque.withValues(alpha: 0.97),
      elevation: 6,
      shadowColor: Colors.black38,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: theme.frameSoft, width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.quranQuickNavigation,
              style: context.textStyles.labelSmall?.copyWith(color: theme.frame),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.quranJuzLabel(widget.juzOf(shown)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: info,
                  ),
                ),
                Text(l10n.quranPageLabel(shown), style: info),
                Expanded(
                  child: Text(
                    widget.surahNameOf(shown),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: context.sakinahTypography.arabicUi.copyWith(
                      fontSize: 13,
                      height: 1.3,
                      color: theme.ink,
                    ),
                  ),
                ),
              ],
            ),
            // Page 1 sits on the right, as in a printed mushaf.
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  arrow(Icons.keyboard_double_arrow_right, l10n.quranPreviousPage, widget.page - 1),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: theme.frame,
                        inactiveTrackColor: theme.frameSoft.withValues(alpha: 0.5),
                        thumbColor: theme.frame,
                        overlayColor: theme.frame.withValues(alpha: 0.12),
                        valueIndicatorColor: theme.frame,
                        trackHeight: 3,
                      ),
                      child: Slider(
                        key: const ValueKey('quran-quick-nav-slider'),
                        value: (_dragging ?? widget.page.toDouble()).clamp(
                          1,
                          widget.lastPage.toDouble(),
                        ),
                        min: 1,
                        max: widget.lastPage.toDouble(),
                        divisions: widget.lastPage - 1,
                        label: '$shown',
                        onChanged: (v) => setState(() => _dragging = v),
                        onChangeEnd: (v) {
                          setState(() => _dragging = null);
                          widget.onJump(v.round());
                        },
                      ),
                    ),
                  ),
                  arrow(Icons.keyboard_double_arrow_left, l10n.quranNextPage, widget.page + 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating action menu for a tapped ayah.
class AyahPopupMenu extends StatelessWidget {
  const AyahPopupMenu({
    required this.theme,
    required this.bookmarked,
    required this.onTafseer,
    required this.onTranslate,
    required this.onListen,
    required this.onFavorite,
    required this.onReflect,
    required this.onShare,
    super.key,
  });

  static const width = 236.0;
  static const itemHeight = 46.0;
  static const itemCount = 6;
  static const height = itemHeight * itemCount + 16;

  final MushafTheme theme;
  final bool bookmarked;
  final VoidCallback onTafseer;
  final VoidCallback onTranslate;
  final VoidCallback onListen;
  final VoidCallback onFavorite;
  final VoidCallback onReflect;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = [
      (Icons.menu_book_outlined, l10n.quranMenuTafseer, onTafseer),
      (Icons.translate, l10n.quranMenuTranslate, onTranslate),
      (Icons.play_circle_outline, l10n.quranMenuListen, onListen),
      (
        bookmarked ? Icons.bookmark_remove_outlined : Icons.bookmark_add_outlined,
        bookmarked ? l10n.quranMenuRemoveFavorite : l10n.quranMenuAddFavorite,
        onFavorite,
      ),
      (Icons.edit_note, l10n.quranActionReflect, onReflect),
      (Icons.ios_share, l10n.quranActionShare, onShare),
    ];
    final labelColor = theme.isNight ? theme.ink : const Color(0xFF1D2340);
    return Material(
      color: theme.paper,
      elevation: 10,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: theme.frameSoft, width: 3),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < items.length; i++)
                InkWell(
                  onTap: items[i].$3,
                  child: Container(
                    height: itemHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: i == items.length - 1
                          ? null
                          : Border(
                              bottom: BorderSide(color: theme.frameSoft.withValues(alpha: 0.55)),
                            ),
                    ),
                    child: Row(
                      children: [
                        Icon(items[i].$1, color: theme.frame, size: 22),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            items[i].$2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textStyles.titleSmall?.copyWith(color: labelColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// First-run hints: side menu, tap an ayah, pinch to zoom, quick navigation.
class MushafCoachMarks extends StatelessWidget {
  const MushafCoachMarks({required this.onDismiss, super.key});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = context.textStyles.titleMedium?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      shadows: const [Shadow(blurRadius: 6)],
    );
    Widget hint(IconData icon, String label) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Icon(icon, size: 34, color: const Color(0xFF1F5E96)),
        ),
        const SizedBox(height: 10),
        Text(label, textAlign: TextAlign.center, style: text),
      ],
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onDismiss,
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.72),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: SizedBox(
                        width: 220,
                        child: hint(Icons.menu_rounded, l10n.quranCoachMenu),
                      ),
                    ),
                    const SizedBox(height: 28),
                    hint(Icons.touch_app_outlined, l10n.quranCoachTapAyah),
                    const SizedBox(height: 28),
                    hint(Icons.pinch_outlined, l10n.quranCoachPinch),
                    const SizedBox(height: 28),
                    hint(Icons.linear_scale, l10n.quranCoachQuickNav),
                    const SizedBox(height: 28),
                    FilledButton(onPressed: onDismiss, child: Text(l10n.quranCoachGotIt)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
