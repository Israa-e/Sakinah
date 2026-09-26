import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/app/theme/app_theme.dart';
import 'package:sakinah/core/widgets/sakinah_bottom_navigation.dart';

void main() {
  testWidgets('sits at the bottom with its own height, not the whole screen', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(languageCode: 'en'),
        home: Scaffold(
          body: const SizedBox.expand(),
          bottomNavigationBar: SakinahBottomNavigation(
            currentIndex: 0,
            onTap: (_) {},
            items: const [
              SakinahNavItem(icon: Icons.mosque_outlined, selectedIcon: Icons.mosque, label: 'Home'),
              SakinahNavItem(icon: Icons.menu_book_outlined, selectedIcon: Icons.menu_book, label: 'Quran'),
            ],
          ),
        ),
      ),
    );

    final bar = tester.getRect(find.byType(SakinahBottomNavigation));
    expect(bar.height, lessThan(100));
    expect(bar.bottom, 844);
  });
}
