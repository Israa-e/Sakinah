import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../domain/mushaf_page.dart';
import 'mushaf_theme.dart';

/// The reader's side menu (display mode, navigation, features, colours,
/// reference marks). Every action closes the panel first.
class MushafSidePanel extends StatelessWidget {
  const MushafSidePanel({
    required this.theme,
    required this.displayMode,
    required this.night,
    required this.onDisplayMode,
    required this.onIndex,
    required this.onSearch,
    required this.onTafseer,
    required this.onAudios,
    required this.onTranslate,
    required this.onTextSize,
    required this.onNight,
    required this.onColor,
    required this.onReferenceMarks,
    super.key,
  });

  final MushafTheme theme;
  final MushafDisplayMode displayMode;
  final bool night;
  final ValueChanged<MushafDisplayMode> onDisplayMode;
  final VoidCallback onIndex;
  final VoidCallback onSearch;
  final VoidCallback onTafseer;
  final VoidCallback onAudios;
  final VoidCallback onTranslate;
  final VoidCallback onTextSize;
  final ValueChanged<bool> onNight;
  final ValueChanged<MushafColor> onColor;
  final VoidCallback onReferenceMarks;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ink = theme.ink;
    VoidCallback closeThen(VoidCallback action) => () {
      Navigator.of(context).pop();
      action();
    };

    Widget tile(IconData icon, String label, VoidCallback onTap, {Widget? trailing}) => ListTile(
      leading: Icon(icon, color: theme.frame, size: 26),
      title: Text(label, style: context.textStyles.titleSmall?.copyWith(color: ink)),
      trailing: trailing,
      onTap: onTap,
      dense: true,
      visualDensity: const VisualDensity(vertical: 1),
    );

    Widget section(String label) => Container(
      width: double.infinity,
      color: theme.plaque,
      padding: const EdgeInsetsDirectional.fromSTEB(20, 6, 20, 6),
      child: Text(label, style: context.textStyles.labelMedium?.copyWith(color: ink)),
    );

    final colorNames = {
      MushafColor.sand: l10n.quranColorSand,
      MushafColor.blue: l10n.quranColorBlue,
      MushafColor.green: l10n.quranColorGreen,
    };

    return Drawer(
      backgroundColor: theme.paper,
      width: 300,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.horizontal(start: Radius.circular(24)),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                l10n.quranMushafDisplay,
                textAlign: TextAlign.center,
                style: context.textStyles.titleMedium?.copyWith(color: ink),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SegmentedButton<MushafDisplayMode>(
                showSelectedIcon: false,
                style: SegmentedButton.styleFrom(
                  selectedBackgroundColor: theme.frame,
                  selectedForegroundColor: theme.paper,
                  foregroundColor: ink,
                  side: BorderSide(color: theme.frame),
                ),
                segments: [
                  ButtonSegment(
                    value: MushafDisplayMode.horizontal,
                    icon: const Icon(Icons.auto_stories_outlined),
                    label: Text(l10n.quranDisplayHorizontal),
                  ),
                  ButtonSegment(
                    value: MushafDisplayMode.vertical,
                    icon: const Icon(Icons.view_day_outlined),
                    label: Text(l10n.quranDisplayVertical),
                  ),
                ],
                selected: {displayMode},
                onSelectionChanged: (s) => onDisplayMode(s.first),
              ),
            ),
            const SizedBox(height: 8),
            tile(Icons.format_list_numbered, l10n.quranIndexTitle, closeThen(onIndex)),
            tile(Icons.search, l10n.quranSearchTitle, closeThen(onSearch)),
            section(l10n.quranFeaturesSection),
            tile(Icons.menu_book_outlined, l10n.quranMenuTafseer, closeThen(onTafseer)),
            tile(Icons.headphones_outlined, l10n.quranAudios, closeThen(onAudios)),
            tile(Icons.translate, l10n.quranMenuTranslate, closeThen(onTranslate)),
            tile(Icons.text_fields, l10n.quranTextSize, closeThen(onTextSize)),
            tile(
              Icons.dark_mode_outlined,
              l10n.quranNightMode,
              () => onNight(!night),
              trailing: Switch(value: night, onChanged: onNight),
            ),
            tile(Icons.palette_outlined, l10n.quranColorYourMushaf, () {}),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Wrap(
                spacing: 14,
                children: [
                  for (final c in MushafColor.values)
                    Semantics(
                      selected: c == theme.color,
                      button: true,
                      label: colorNames[c],
                      child: Tooltip(
                        message: colorNames[c],
                        child: InkResponse(
                          onTap: () => onColor(c),
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: c == theme.color ? theme.frame : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MushafTheme.base(c).swatch,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            section(l10n.quranFavoriteSection),
            tile(Icons.bookmarks_outlined, l10n.quranReferenceMarks, closeThen(onReferenceMarks)),
          ],
        ),
      ),
    );
  }
}
