import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../data/quran_text.dart';
import '../../domain/mushaf_page.dart';
import '../../domain/quran_models.dart';
import 'mushaf_ornaments.dart';
import 'mushaf_theme.dart';

typedef AyahTapCallback = void Function(Ayah ayah, Offset globalPosition);

/// Base Quran font size at text scale 1.0.
const double mushafBaseFontSize = 21;

/// One framed mushaf page.
///
/// With [expand] the page fills its parent (horizontal page-swipe mode) and
/// its text scrolls inside the frame if it doesn't fit; otherwise the page
/// takes its natural height (vertical continuous mode).
class MushafPage extends StatelessWidget {
  const MushafPage({
    required this.page,
    required this.theme,
    required this.child,
    super.key,
    this.expand = true,
    this.frameTop = 0,
    this.contentTop = mushafFrameBand + 14,
  });

  final int page;
  final MushafTheme theme;
  final Widget child;
  final bool expand;

  /// Where the frame's outer edge starts (leaves room for the top bar).
  final double frameTop;

  /// Where the text starts, measured from the top of this widget.
  final double contentTop;

  static const _medallionHeight = 28.0;
  static const _side = mushafFrameBand + 12;

  @override
  Widget build(BuildContext context) {
    final frame = CustomPaint(painter: MushafFramePainter(theme));
    const medallionOverlap = _medallionHeight / 2;
    final medallion = Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Center(
        child: PageNumberMedallion(page: page, theme: theme),
      ),
    );

    if (!expand) {
      return Stack(
        children: [
          Positioned.fill(top: frameTop, bottom: medallionOverlap, child: frame),
          Padding(
            padding: EdgeInsets.fromLTRB(
              _side,
              contentTop,
              _side,
              medallionOverlap + mushafFrameBand + 18,
            ),
            child: child,
          ),
          medallion,
        ],
      );
    }

    return Stack(
      children: [
        Positioned.fill(top: frameTop, bottom: medallionOverlap, child: frame),
        Positioned.fill(
          top: contentTop,
          left: _side - 4,
          right: _side - 4,
          bottom: medallionOverlap + mushafFrameBand + 6,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
            child: child,
          ),
        ),
        medallion,
      ],
    );
  }
}

/// The page's text: for each surah on the page an optional title box and
/// Bismillah, then continuous justified RTL text with one tappable span per
/// ayah followed by its number medallion.
class MushafPageText extends StatefulWidget {
  const MushafPageText({
    required this.content,
    required this.theme,
    required this.fontSize,
    required this.onAyahTap,
    super.key,
    this.selected,
    this.reciting,
    this.reveal,
  });

  final MushafPageContent content;
  final MushafTheme theme;
  final double fontSize;
  final AyahTapCallback onAyahTap;

  /// (surah, ayah) of the tapped ayah.
  final (int, int)? selected;

  /// (surah, ayah) currently being recited.
  final (int, int)? reciting;

  /// (surah, ayah) to scroll into view when it is on this page (the ayah
  /// opened via `?ayah=`, a jumped-to bookmark, or the recited ayah).
  final (int, int)? reveal;

  @override
  State<MushafPageText> createState() => _MushafPageTextState();
}

class _MushafPageTextState extends State<MushafPageText> {
  final _recognizers = <(int, int), TapGestureRecognizer>{};
  final _revealKey = GlobalKey();
  (int, int)? _revealed;

  @override
  void initState() {
    super.initState();
    _scheduleReveal();
  }

  @override
  void didUpdateWidget(MushafPageText oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleReveal();
  }

  void _scheduleReveal() {
    final target = widget.reveal;
    if (target == null || target == _revealed) return;
    if (widget.content.ayah(target.$1, target.$2) == null) return;
    _revealed = target;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _revealKey.currentContext;
      if (ctx == null || !ctx.mounted) return;
      Scrollable.ensureVisible(
        ctx,
        alignment: 0.5,
        duration: const Duration(milliseconds: 250),
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
      );
    });
  }

  @override
  void dispose() {
    for (final r in _recognizers.values) {
      r.dispose();
    }
    super.dispose();
  }

  TapGestureRecognizer _recognizerFor(Ayah ayah) {
    return _recognizers.putIfAbsent((
      ayah.surahNumber,
      ayah.numberInSurah,
    ), TapGestureRecognizer.new)..onTapUp = (d) => widget.onAyahTap(ayah, d.globalPosition);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final fontSize = widget.fontSize;
    final quran = context.sakinahTypography.quranText.copyWith(
      fontSize: fontSize,
      height: 2.05,
      color: theme.ink,
    );
    final children = <Widget>[];
    for (final segment in widget.content.segments) {
      if (segment.startsSurah) {
        children.add(
          Padding(
            padding: EdgeInsets.only(top: children.isEmpty ? 2 : 14, bottom: 4),
            child: SurahTitleBox(
              nameAr: segment.surah.nameAr,
              theme: theme,
              fontSize: fontSize * 0.95,
            ),
          ),
        );
        if (segment.surah.hasBismillahHeader) {
          children.add(
            Text(
              QuranText.bismillah,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: quran,
            ),
          );
        }
      }
      children.add(_paragraph(segment, quran));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }

  Widget _paragraph(MushafPageSegment segment, TextStyle style) {
    final theme = widget.theme;
    final markerSize = widget.fontSize * 1.25;
    final spans = <InlineSpan>[];
    for (final ayah in segment.ayahs) {
      final key = (ayah.surahNumber, ayah.numberInSurah);
      final highlighted = key == widget.selected || key == widget.reciting;
      final background = highlighted ? theme.highlight : null;
      spans
        ..add(
          TextSpan(
            text: '${ayah.textAr} ',
            recognizer: _recognizerFor(ayah),
            style: background == null ? null : TextStyle(backgroundColor: background),
          ),
        )
        ..add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              key: ValueKey('ayah-marker-${ayah.surahNumber}:${ayah.numberInSurah}'),
              onTapUp: (d) => widget.onAyahTap(ayah, d.globalPosition),
              child: Container(
                key: key == widget.reveal ? _revealKey : null,
                color: background,
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: AyahMarker(
                  number: ayah.numberInSurah,
                  theme: theme,
                  size: markerSize,
                  filled: key == widget.reciting,
                ),
              ),
            ),
          ),
        )
        ..add(const TextSpan(text: ' '));
    }
    return Text.rich(
      TextSpan(children: spans),
      textAlign: TextAlign.justify,
      textDirection: TextDirection.rtl,
      style: style,
    );
  }
}
