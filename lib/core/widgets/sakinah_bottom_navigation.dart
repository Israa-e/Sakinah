import 'package:flutter/material.dart';

class SakinahNavItem {
  const SakinahNavItem({required this.icon, required this.selectedIcon, required this.label});

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// The five-tab shell navigation (Home/Quran/Dhikr/Journey/Profile). A thin
/// wrapper over [NavigationBar] so the app shell doesn't hand-roll styling.
class SakinahBottomNavigation extends StatelessWidget {
  const SakinahBottomNavigation({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<SakinahNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        for (final item in items)
          NavigationDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon),
            label: item.label,
          ),
      ],
    );
  }
}
