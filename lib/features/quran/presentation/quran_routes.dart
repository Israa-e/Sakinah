import 'package:go_router/go_router.dart';

import '../../../app/router/navigator_keys.dart';

import 'screens/quran_bookmarks_screen.dart';
import 'screens/quran_reader_screen.dart';
import 'screens/surah_index_screen.dart';

/// Quran tab: surah index (root) and the mushaf reader, opened either at a
/// surah/ayah (`/quran/surah/:number?ayah=`) or a page (`/quran/page/:page`).
abstract final class QuranPaths {
  static const root = '/quran';
  static const bookmarks = '/quran/bookmarks';

  /// Reader for [surah], optionally scrolled to [ayah].
  static String surah(int surah, {int? ayah}) =>
      ayah == null ? '/quran/surah/$surah' : '/quran/surah/$surah?ayah=$ayah';

  /// Mushaf page [page] (1–604).
  static String page(int page) => '/quran/page/$page';
}

/// Routes for this feature's shell branch. The first route is the tab root.
final List<RouteBase> quranRoutes = [
  GoRoute(
    path: QuranPaths.root,
    builder: (context, state) => const SurahIndexScreen(),
    routes: [
      GoRoute(
        // The mushaf reader is full screen, like a printed page — it covers
        // the tab bar instead of sitting inside the shell.
        parentNavigatorKey: rootNavigatorKey,
        path: 'surah/:number',
        builder: (context, state) => QuranReaderScreen(
          key: state.pageKey,
          surahNumber: int.tryParse(state.pathParameters['number'] ?? '') ?? 0,
          initialAyah: int.tryParse(state.uri.queryParameters['ayah'] ?? ''),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: 'page/:page',
        builder: (context, state) => QuranReaderScreen(
          key: state.pageKey,
          page: int.tryParse(state.pathParameters['page'] ?? '') ?? 0,
        ),
      ),
      GoRoute(path: 'bookmarks', builder: (context, state) => const QuranBookmarksScreen()),
    ],
  ),
];
