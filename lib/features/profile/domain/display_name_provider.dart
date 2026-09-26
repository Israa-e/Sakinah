import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences_service.dart';

part 'display_name_provider.g.dart';

/// The name the user asked to be greeted by, or `null` when they skipped it.
/// Set during onboarding (Goals step) and editable from the Profile header.
@Riverpod(keepAlive: true)
class DisplayName extends _$DisplayName {
  static const storageKey = 'profile.display_name';

  @override
  String? build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(storageKey)?.trim();
    return (raw == null || raw.isEmpty) ? null : raw;
  }

  Future<void> setName(String? name) async {
    final prefs = ref.read(sharedPreferencesProvider);
    final trimmed = name?.trim() ?? '';
    if (trimmed.isEmpty) {
      await prefs.remove(storageKey);
      state = null;
    } else {
      await prefs.setString(storageKey, trimmed);
      state = trimmed;
    }
  }
}
