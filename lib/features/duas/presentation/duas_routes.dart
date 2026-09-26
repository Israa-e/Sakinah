import 'package:go_router/go_router.dart';

import '../../ask/presentation/screens/ask_screen.dart';
import '../domain/dua.dart';
import 'screens/dua_detail_screen.dart';
import 'screens/duas_library_screen.dart';

/// Du'as library and Ask Sakīnah — pushed on top of the shell (reached from
/// Home / Dhikr / Profile), not a tab of their own.
abstract final class DuasPaths {
  static const library = '/duas';
  static const ask = '/ask';

  /// Library showing only the user's saved du'as.
  static const saved = '/duas?saved=1';

  static String detail(String duaKey) => '/duas/$duaKey';

  /// Library pre-filtered to one category (`DuaCategory.name`).
  static String libraryCategory(String category) => '/duas?category=$category';
}

final List<RouteBase> duasRoutes = [
  GoRoute(
    path: DuasPaths.library,
    builder: (context, state) {
      final params = state.uri.queryParameters;
      final category = params['category'];
      return DuasLibraryScreen(
        initialCategory: category == null ? null : DuaCategory.tryParse(category),
        initialSavedOnly: params['saved'] == '1',
      );
    },
    routes: [
      GoRoute(
        path: ':key',
        builder: (context, state) => DuaDetailScreen(duaKey: state.pathParameters['key']!),
      ),
    ],
  ),
  GoRoute(
    path: DuasPaths.ask,
    builder: (context, state) => const AskScreen(),
  ),
];
