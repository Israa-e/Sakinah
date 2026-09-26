import 'dua.dart';

/// Source of the du'a library and the user's saved du'as.
abstract interface class DuaRepository {
  /// The full bundled catalog, in display order.
  Future<List<Dua>> loadCatalog();

  /// Keys of saved du'as, newest first; re-emits on every change.
  Stream<List<String>> watchSavedKeys();

  Future<void> setSaved(String duaKey, {required bool saved});
}
