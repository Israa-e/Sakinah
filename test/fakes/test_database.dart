import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:sakinah/core/storage/app_database.dart';
// sqlite3 is a transitive dependency of drift; only used to locate the host
// library when running unit tests on Linux machines that ship just
// `libsqlite3.so.0` (no dev symlink).
// ignore: depend_on_referenced_packages
import 'package:sqlite3/open.dart';

AppDatabase openTestDatabase() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  if (Platform.isLinux) {
    open.overrideFor(OperatingSystem.linux, () {
      try {
        return DynamicLibrary.open('libsqlite3.so');
      } on ArgumentError {
        return DynamicLibrary.open('libsqlite3.so.0');
      }
    });
  }
  return AppDatabase.forTesting(NativeDatabase.memory());
}
