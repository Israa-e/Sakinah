import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/app/app.dart';
import 'package:sakinah/core/storage/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('cold start with no onboarding lands on the Welcome step', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const SakinahApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sakīnah'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
