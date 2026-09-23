import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/extensions/build_context_extensions.dart';
import '../../core/widgets/sakinah_bottom_navigation.dart';

/// Hosts the five-tab bottom navigation. Each branch keeps its own
/// navigation stack and scroll position via [StatefulNavigationShell].
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: SakinahBottomNavigation(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: [
          SakinahNavItem(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
            label: l10n.navHome,
          ),
          SakinahNavItem(
            icon: Icons.menu_book_outlined,
            selectedIcon: Icons.menu_book,
            label: l10n.navQuran,
          ),
          SakinahNavItem(
            icon: Icons.self_improvement_outlined,
            selectedIcon: Icons.self_improvement,
            label: l10n.navDhikr,
          ),
          SakinahNavItem(
            icon: Icons.eco_outlined,
            selectedIcon: Icons.eco,
            label: l10n.navJourney,
          ),
          SakinahNavItem(
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}
