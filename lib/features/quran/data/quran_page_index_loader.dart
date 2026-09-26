import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/quran_page_index.dart';
import 'drift_quran_repository.dart';

part 'quran_page_index_loader.g.dart';

const quranPagesAssetPath = 'assets/data/quran_pages.json';

/// Builds the [QuranPageIndex] from the bundled page/juz starts and the
/// bundled surah metadata (ayah counts). Both assets ship with the app, so
/// this never needs the network.
Future<QuranPageIndex> loadQuranPageIndex({
  required Future<String> Function(String path) loadString,
}) async {
  final pages = jsonDecode(await loadString(quranPagesAssetPath)) as Map<String, dynamic>;
  final surahs = jsonDecode(await loadString(surahsAssetPath)) as Map<String, dynamic>;
  final counts = [
    for (final s in (surahs['surahs'] as List).cast<Map<String, dynamic>>()) s['ayahCount'] as int,
  ];
  return QuranPageIndex.fromJson(pages, counts);
}

@Riverpod(keepAlive: true)
Future<QuranPageIndex> quranPageIndex(Ref ref) {
  return loadQuranPageIndex(loadString: rootBundle.loadString);
}
