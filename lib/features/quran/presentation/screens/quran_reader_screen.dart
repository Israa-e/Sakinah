import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/states.dart';
import '../../data/drift_quran_repository.dart';
import '../../data/quran_page_index_loader.dart';
import '../../domain/mushaf_page.dart';
import '../../domain/quran_models.dart';
import '../../domain/quran_page_index.dart';
import '../../domain/quran_repository.dart';
import '../providers/quran_audio_controller.dart';
import '../providers/quran_providers.dart';
import '../quran_routes.dart';
import '../widgets/mushaf_chrome.dart';
import '../widgets/mushaf_page_view.dart';
import '../widgets/mushaf_sheets.dart';
import '../widgets/mushaf_side_panel.dart';
import '../widgets/mushaf_theme.dart';
import '../widgets/reader_chrome.dart';
import '../widgets/reader_sheets.dart';

/// Mushaf-style page reader over the 604-page Madani layout.
///
/// Opens at [page], or at the page holding [surahNumber]:[initialAyah]
/// (which is then highlighted). Pages swipe right-to-left (horizontal) or
/// scroll continuously (vertical); tapping an ayah opens its action menu.
class QuranReaderScreen extends ConsumerStatefulWidget {
  const QuranReaderScreen({super.key, this.page, this.surahNumber, this.initialAyah})
    : assert(page != null || surahNumber != null);

  final int? page;
  final int? surahNumber;
  final int? initialAyah;

  @override
  ConsumerState<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

const double _maxPageWidth = 600;

class _QuranReaderScreenState extends ConsumerState<QuranReaderScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _stackKey = GlobalKey();
  final _verticalKey = GlobalKey();
  final _pageKeys = <int, GlobalKey>{};
  final _vController = ScrollController();
  PageController? _pageController;
  MushafDisplayMode? _mode;

  late final QuranRepository _repo;

  int? _page;
  int _anchorPage = 1;
  (int, int)? _selected;
  (int, int)? _reveal;
  Offset? _menuAt;
  bool _chrome = false;
  bool? _showCoach;

  /// Ayahs (surah * 1000 + ayah) already added to today's reading log in
  /// this session, so revisiting a page never inflates the total.
  final _counted = <int>{};
  int? _recordedPage;
  Timer? _progressDebounce;
  (Surah, int)? _pendingProgress;

  // Pinch-to-zoom (raw pointers so it never fights the page swipe).
  final _pointers = <int, Offset>{};
  bool _pinching = false;
  double _pinchStartDistance = 0;
  double _pinchStartScale = 1;
  double? _pinchScale;

  @override
  void initState() {
    super.initState();
    _repo = ref.read(quranRepositoryProvider);
  }

  @override
  void dispose() {
    _progressDebounce?.cancel();
    final pending = _pendingProgress;
    if (pending != null) unawaited(_repo.saveProgress(pending.$1, pending.$2));
    _pageController?.dispose();
    _vController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------- helpers

  QuranPageIndex? get _index => ref.read(quranPageIndexProvider).valueOrNull;

  Surah? _surah(int number) =>
      ref.read(surahListProvider).valueOrNull?.where((s) => s.number == number).firstOrNull;

  MushafPageContent? _contentFor(int surah, int ayah) {
    final index = _index;
    if (index == null) return null;
    return ref.read(mushafPageProvider(index.pageOf(surah, ayah))).valueOrNull;
  }

  Ayah? _selectedAyah() {
    final sel = _selected;
    if (sel == null) return null;
    return _contentFor(sel.$1, sel.$2)?.ayah(sel.$1, sel.$2);
  }

  /// The selected ayah, else the first ayah of the current page.
  Ayah? _targetAyah() {
    final page = _page;
    return _selectedAyah() ??
        (page == null ? null : ref.read(mushafPageProvider(page)).valueOrNull?.firstAyah);
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  // ------------------------------------------------------ progress / logs

  void _saveProgress(Surah surah, int ayah) {
    _progressDebounce?.cancel();
    _pendingProgress = (surah, ayah);
    _progressDebounce = Timer(const Duration(milliseconds: 400), () {
      _pendingProgress = null;
      unawaited(_repo.saveProgress(surah, ayah));
    });
  }

  void _recordPage(MushafPageContent content) {
    if (_recordedPage == content.page) return;
    _recordedPage = content.page;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final fresh = content.ayahs
          .where((a) => _counted.add(a.surahNumber * 1000 + a.numberInSurah))
          .length;
      if (fresh > 0) unawaited(_repo.logAyahsRead(fresh));
      final sel = _selected;
      final onPage = sel != null && content.ayah(sel.$1, sel.$2) != null;
      final first = content.firstAyah;
      if (onPage) {
        _saveProgress(content.surahOf(sel.$1)!, sel.$2);
      } else if (first != null) {
        _saveProgress(content.surah, first.numberInSurah);
      }
    });
  }

  // ---------------------------------------------------------- navigation

  void _goToPage(int target, {bool animate = false}) {
    final index = _index;
    final current = _page;
    if (index == null || current == null) return;
    final p = index.clampPage(target);
    setState(() => _menuAt = null);
    if (_mode == MushafDisplayMode.vertical) {
      setState(() {
        _anchorPage = p;
        _page = p;
      });
      return;
    }
    final controller = _pageController;
    if (controller == null || !controller.hasClients) {
      setState(() => _page = p);
      return;
    }
    if (animate && (p - current).abs() <= 2) {
      unawaited(
        controller.animateToPage(
          p - 1,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        ),
      );
    } else {
      controller.jumpToPage(p - 1);
    }
  }

  void _onPageChanged(int page) {
    if (page == _page) return;
    setState(() {
      _page = page;
      _menuAt = null;
    });
  }

  bool _onVerticalScroll(ScrollNotification n) {
    if (n is! ScrollUpdateNotification && n is! ScrollEndNotification) return false;
    final viewport = _verticalKey.currentContext?.findRenderObject();
    if (viewport is! RenderBox || !viewport.hasSize) return false;
    final probe = viewport.size.height * 0.3;
    for (final entry in _pageKeys.entries) {
      final box = entry.value.currentContext?.findRenderObject();
      if (box is! RenderBox || !box.attached || !box.hasSize) continue;
      final top = box.localToGlobal(Offset.zero, ancestor: viewport).dy;
      if (top <= probe && top + box.size.height > probe) {
        if (entry.key != _page) {
          setState(() {
            _page = entry.key;
            if (n is ScrollUpdateNotification) _menuAt = null;
          });
        }
        break;
      }
    }
    return false;
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(QuranPaths.root);
    }
  }

  // --------------------------------------------------------------- taps

  void _onAyahTap(Ayah ayah, Offset global) {
    final box = _stackKey.currentContext?.findRenderObject();
    if (box is! RenderBox) return;
    setState(() {
      _selected = (ayah.surahNumber, ayah.numberInSurah);
      _menuAt = box.globalToLocal(global);
    });
    final surah = _surah(ayah.surahNumber);
    if (surah != null) _saveProgress(surah, ayah.numberInSurah);
  }

  void _onBackgroundTap() {
    setState(() {
      if (_menuAt != null || _selected != null) {
        _menuAt = null;
        _selected = null;
      } else {
        _chrome = !_chrome;
      }
    });
  }

  // ------------------------------------------------------------ actions

  MushafTheme get _theme {
    final night = ref.read(mushafNightModeProvider) ?? context.isDark;
    return MushafTheme.of(ref.read(mushafColorProvider), night: night);
  }

  void _closeMenu() => setState(() => _menuAt = null);

  Future<void> _tafseer(Ayah ayah) async {
    final surah = _surah(ayah.surahNumber);
    if (surah == null) return;
    _closeMenu();
    await showTafsirSheet(context, surah: surah, ayah: ayah, theme: _theme);
  }

  Future<void> _translate(Ayah ayah) async {
    final content = _contentFor(ayah.surahNumber, ayah.numberInSurah);
    if (content == null) return;
    _closeMenu();
    await showTranslationSheet(
      context,
      content: content,
      theme: _theme,
      focus: (ayah.surahNumber, ayah.numberInSurah),
    );
  }

  Future<void> _listen(Ayah ayah) async {
    _closeMenu();
    final ayahs = await ref.read(surahAyahsProvider(ayah.surahNumber).future);
    await ref.read(quranAudioControllerProvider.notifier).playFrom(ayahs, ayah.numberInSurah);
  }

  Future<void> _favorite(Ayah ayah) async {
    final l10n = context.l10n;
    _closeMenu();
    final now = await _repo.toggleBookmark(ayah.surahNumber, ayah.numberInSurah);
    if (mounted) _snack(now ? l10n.quranBookmarkAdded : l10n.quranBookmarkRemoved);
  }

  Future<void> _reflect(Ayah ayah) async {
    final surah = _surah(ayah.surahNumber);
    if (surah == null) return;
    final l10n = context.l10n;
    _closeMenu();
    final saved = await showReflectSheet(context, surah: surah, ayah: ayah);
    if ((saved ?? false) && mounted) _snack(l10n.quranReflectionSaved);
  }

  Future<void> _share(Ayah ayah) async {
    final l10n = context.l10n;
    _closeMenu();
    final text =
        '${ayah.textAr}\n\n${ayah.translation} — '
        'Quran ${ayah.reference} (${ayah.translatorName})';
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) _snack(l10n.quranShareCopied);
  }

  Future<void> _openIndex({required bool search}) async {
    final index = _index;
    if (index == null) return;
    final page = await showSurahJumpSheet(context, theme: _theme, index: index, search: search);
    if (page != null && mounted) _goToPage(page);
  }

  Future<void> _openReferenceMarks() async {
    final index = _index;
    if (index == null) return;
    final target = await showReferenceMarksSheet(context, theme: _theme, index: index);
    if (target == null || !mounted) return;
    setState(() => _selected = _reveal = target);
    _goToPage(index.pageOf(target.$1, target.$2));
  }

  void _setMode(MushafDisplayMode mode) {
    unawaited(ref.read(mushafDisplayModeProvider.notifier).set(mode));
  }

  // --------------------------------------------------------------- pinch

  double _pointerDistance() {
    final points = _pointers.values.take(2).toList();
    return (points[0] - points[1]).distance;
  }

  void _pointerDown(PointerDownEvent e) {
    _pointers[e.pointer] = e.position;
    if (_pointers.length == 2) {
      _pinchStartDistance = _pointerDistance();
      _pinchStartScale = ref.read(quranTextScaleProvider);
      setState(() {
        _pinching = true;
        _menuAt = null;
      });
    }
  }

  void _pointerMove(PointerMoveEvent e) {
    if (!_pointers.containsKey(e.pointer)) return;
    _pointers[e.pointer] = e.position;
    if (!_pinching || _pointers.length < 2 || _pinchStartDistance <= 0) return;
    final scale = (_pinchStartScale * _pointerDistance() / _pinchStartDistance)
        .clamp(QuranTextScale.min, QuranTextScale.max)
        .toDouble();
    if ((scale - (_pinchScale ?? -1)).abs() >= 0.02) setState(() => _pinchScale = scale);
  }

  void _pointerEnd(PointerEvent e) {
    _pointers.remove(e.pointer);
    if (_pinching && _pointers.length < 2) {
      final scale = _pinchScale;
      if (scale != null) unawaited(ref.read(quranTextScaleProvider.notifier).set(scale));
      setState(() {
        _pinching = false;
        _pinchScale = null;
      });
    }
  }

  // --------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final indexAsync = ref.watch(quranPageIndexProvider);
    final surahsAsync = ref.watch(surahListProvider);
    final night = ref.watch(mushafNightModeProvider) ?? context.isDark;
    final theme = MushafTheme.of(ref.watch(mushafColorProvider), night: night);
    final mode = ref.watch(mushafDisplayModeProvider);
    final audio = ref.watch(quranAudioControllerProvider);

    ref.listen(quranAudioControllerProvider, (prev, next) {
      if (next.errorCount > (prev?.errorCount ?? 0)) _snack(l10n.quranAudioUnavailable);
      final current = next.current;
      final index = _index;
      if (current != null && index != null && current != prev?.current) {
        final page = index.pageOf(current.surahNumber, current.numberInSurah);
        if (page != _page) _goToPage(page, animate: true);
      }
    });

    Widget scaffold(Widget body) => Scaffold(
      backgroundColor: theme.paper,
      body: SafeArea(child: body),
    );

    final index = indexAsync.valueOrNull;
    final surahs = surahsAsync.valueOrNull;
    if (indexAsync.hasError || surahsAsync.hasError) {
      return scaffold(ErrorState(message: l10n.errorGeneric));
    }
    if (index == null || surahs == null) return scaffold(const LoadingState());

    if (_page == null) {
      final requestedPage = widget.page;
      final surahNumber = widget.surahNumber;
      if (requestedPage != null) {
        if (requestedPage < 1 || requestedPage > index.lastPage) {
          return scaffold(ErrorState(message: l10n.quranPageNotFound));
        }
        _page = requestedPage;
      } else if (surahNumber != null) {
        if (surahNumber < 1 || surahNumber > index.surahCount) {
          return scaffold(ErrorState(message: l10n.quranSurahNotFound));
        }
        final ayah = widget.initialAyah?.clamp(1, index.ayahCount(surahNumber));
        _page = index.pageOf(surahNumber, ayah ?? 1);
        if (ayah != null) _selected = _reveal = (surahNumber, ayah);
      }
      _anchorPage = _page!;
    }
    final page = _page!;

    if (_mode != mode) {
      if (mode == MushafDisplayMode.vertical) {
        _pageController?.dispose();
        _pageController = null;
        _anchorPage = page;
      }
      _mode = mode;
    }
    if (mode == MushafDisplayMode.horizontal) {
      _pageController ??= PageController(initialPage: page - 1);
    }

    if (_showCoach == null) {
      _showCoach = !ref.read(quranCoachMarksSeenProvider);
      if (_showCoach!) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) unawaited(ref.read(quranCoachMarksSeenProvider.notifier).markSeen());
        });
      }
    }

    final current = ref.watch(mushafPageProvider(page)).valueOrNull;
    if (current != null) _recordPage(current);

    final double storedScale = ref.watch(quranTextScaleProvider);
    final scale = _pinchScale ?? storedScale;
    final fontSize = mushafBaseFontSize * scale;
    final reciting = audio.current == null
        ? null
        : (audio.current!.surahNumber, audio.current!.numberInSurah);
    final pageSurah = surahs.where((s) => s.number == index.surahOfPage(page)).firstOrNull;

    Widget pageItem(int p, {required bool expand}) {
      return Consumer(
        builder: (context, ref, _) {
          final async = ref.watch(mushafPageProvider(p));
          final Widget child;
          if (async.valueOrNull case final content?) {
            child = MushafPageText(
              content: content,
              theme: theme,
              fontSize: fontSize,
              selected: _selected,
              reciting: reciting,
              reveal: reciting ?? _reveal,
              onAyahTap: _onAyahTap,
            );
          } else if (async.hasError) {
            child = ErrorState(
              message: pageLoadErrorMessage(context, async.error),
              retryLabel: l10n.retry,
              onRetry: () {
                for (final r in index.rangesForPage(p)) {
                  ref.invalidate(surahAyahsProvider(r.surah));
                }
              },
            );
          } else {
            child = SizedBox(
              height: 320,
              child: Center(child: CircularProgressIndicator(color: theme.frame)),
            );
          }
          final framed = MushafPage(
            page: p,
            theme: theme,
            expand: expand,
            frameTop: expand ? MushafTopBar.height / 2 - 3 : 0,
            contentTop: expand ? MushafTopBar.height + 8 : 30,
            child: child,
          );
          // Keep a phone-like page proportion on wide windows.
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxPageWidth),
              child: expand ? SizedBox.expand(child: framed) : framed,
            ),
          );
        },
      );
    }

    final Widget pages;
    if (mode == MushafDisplayMode.horizontal) {
      pages = PageView.builder(
        key: const ValueKey('mushaf-pager'),
        controller: _pageController,
        // Page 1 on the right; the next page comes in from the left.
        reverse: Directionality.of(context) == TextDirection.ltr,
        allowImplicitScrolling: true,
        physics: _pinching ? const NeverScrollableScrollPhysics() : null,
        itemCount: index.lastPage,
        onPageChanged: (i) => _onPageChanged(i + 1),
        itemBuilder: (context, i) => pageItem(i + 1, expand: true),
      );
    } else {
      final centerKey = ValueKey('mushaf-center-$_anchorPage');
      Widget item(int p) => Padding(
        key: _pageKeys.putIfAbsent(p, GlobalKey.new),
        padding: const EdgeInsets.fromLTRB(2, 6, 2, 6),
        child: pageItem(p, expand: false),
      );
      pages = Padding(
        padding: const EdgeInsets.only(top: MushafTopBar.height),
        child: NotificationListener<ScrollNotification>(
          onNotification: _onVerticalScroll,
          child: CustomScrollView(
            key: ValueKey('mushaf-vertical-$_anchorPage'),
            controller: _vController,
            center: centerKey,
            physics: _pinching ? const NeverScrollableScrollPhysics() : null,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => item(_anchorPage - 1 - i),
                  childCount: _anchorPage - 1,
                ),
              ),
              SliverList(
                key: centerKey,
                delegate: SliverChildBuilderDelegate(
                  (context, i) => item(_anchorPage + i),
                  childCount: index.lastPage - _anchorPage + 1,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final selectedAyah = _selectedAyah();
    final bookmarked =
        selectedAyah != null &&
        (ref.watch(bookmarkedAyahsProvider(selectedAyah.surahNumber)).valueOrNull ?? const <int>{})
            .contains(selectedAyah.numberInSurah);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.paper,
      endDrawer: MushafSidePanel(
        theme: theme,
        displayMode: mode,
        night: night,
        onDisplayMode: _setMode,
        onIndex: () => _openIndex(search: false),
        onSearch: () => _openIndex(search: true),
        onTafseer: () {
          final a = _targetAyah();
          if (a != null) unawaited(_tafseer(a));
        },
        onAudios: () {
          final a = _targetAyah();
          if (a != null) unawaited(_listen(a));
        },
        onTranslate: () {
          final a = _targetAyah();
          if (a != null) unawaited(_translate(a));
        },
        onTextSize: () => showQuranTextSizeSheet(context),
        onNight: (v) => ref.read(mushafNightModeProvider.notifier).set(night: v),
        onColor: (c) => ref.read(mushafColorProvider.notifier).set(c),
        onReferenceMarks: _openReferenceMarks,
      ),
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final menuAt = _menuAt;
            return Stack(
              key: _stackKey,
              children: [
                Positioned.fill(
                  child: Listener(
                    onPointerDown: _pointerDown,
                    onPointerMove: _pointerMove,
                    onPointerUp: _pointerEnd,
                    onPointerCancel: _pointerEnd,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _onBackgroundTap,
                      child: pages,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ColoredBox(
                    color: mode == MushafDisplayMode.vertical ? theme.paper : Colors.transparent,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: _maxPageWidth),
                        child: MushafTopBar(
                          surahNameAr: pageSurah?.nameAr ?? '',
                          juz: index.juzOfPage(page),
                          theme: theme,
                          onBack: _back,
                          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
                        ),
                      ),
                    ),
                  ),
                ),
                if (menuAt != null && selectedAyah != null)
                  _positionedMenu(
                    menuAt,
                    constraints.biggest,
                    AyahPopupMenu(
                      theme: theme,
                      bookmarked: bookmarked,
                      onTafseer: () => _tafseer(selectedAyah),
                      onTranslate: () => _translate(selectedAyah),
                      onListen: () => _listen(selectedAyah),
                      onFavorite: () => _favorite(selectedAyah),
                      onReflect: () => _reflect(selectedAyah),
                      onShare: () => _share(selectedAyah),
                    ),
                  ),
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 8,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _maxPageWidth),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_chrome)
                            MushafQuickNav(
                              page: page,
                              lastPage: index.lastPage,
                              juzOf: index.juzOfPage,
                              surahNameOf: (p) =>
                                  surahs
                                      .where((s) => s.number == index.surahOfPage(p))
                                      .firstOrNull
                                      ?.nameAr ??
                                  '',
                              theme: theme,
                              onJump: _goToPage,
                            ),
                          if (_chrome && audio.isActive) const SizedBox(height: 6),
                          if (audio.isActive)
                            QuranMiniPlayer(
                              state: audio,
                              onToggle: () =>
                                  ref.read(quranAudioControllerProvider.notifier).togglePlayPause(),
                              onPrevious: () =>
                                  ref.read(quranAudioControllerProvider.notifier).previous(),
                              onNext: () => ref.read(quranAudioControllerProvider.notifier).next(),
                              onClose: () => ref.read(quranAudioControllerProvider.notifier).stop(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_showCoach ?? false)
                  Positioned.fill(
                    child: MushafCoachMarks(onDismiss: () => setState(() => _showCoach = false)),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _positionedMenu(Offset at, Size area, Widget menu) {
    const w = AyahPopupMenu.width;
    const h = AyahPopupMenu.height;
    final left = (at.dx - w / 2).clamp(8.0, math.max(8.0, area.width - w - 8)).toDouble();
    final below = at.dy + 22;
    final top = below + h <= area.height - 8 ? below : math.max(8.0, at.dy - 22 - h);
    return Positioned(left: left, top: top, child: menu);
  }
}
