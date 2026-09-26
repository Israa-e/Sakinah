import 'package:go_router/go_router.dart';

import 'screens/profile_screen.dart';
import 'screens/reflections_screen.dart';

/// Profile tab: settings and preferences.
abstract final class ProfilePaths {
  static const root = '/profile';
  static const reflections = '/profile/reflections';
}

/// Routes for this feature's shell branch. The first route is the tab root.
final List<RouteBase> profileRoutes = [
  GoRoute(
    path: ProfilePaths.root,
    builder: (context, state) => const ProfileScreen(),
    routes: [GoRoute(path: 'reflections', builder: (context, state) => const ReflectionsScreen())],
  ),
];
