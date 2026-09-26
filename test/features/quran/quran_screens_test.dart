import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakinah/app/theme/app_theme.dart';
import 'package:sakinah/core/errors/app_failure.dart';
import 'package:sakinah/core/storage/preferences_service.dart';
import 'package:sakinah/features/quran/data/drift_quran_repository.dart';
import 'package:sakinah/features/quran/data/quran_page_index_loader.dart';
import 'package:sakinah/features/quran/data/tafsir_remote_data_source.dart';
import 'package:sakinah/features/quran/presentation/providers/quran_audio_controller.dart';
import 'package:sakinah/features/quran/presentation/screens/quran_bookmarks_screen.dart';
import 'package:sakinah/features/quran/presentation/screens/quran_reader_screen.dart';
import 'package:sakinah/features/quran/presentation/screens/surah_index_screen.dart';
import 'package:sakinah/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'quran_fakes.dart';

void main() {
  late FakeQuranRepository repo;
  late FakeAudioEngine audio;
  late FakeTafsirRemote tafsir;
  late SharedPreferences prefs;

  Future<void> pump(
    WidgetTester tester,
    Widget home, {
    FakeQuranRepository? repository,
    FakeAudioEngine? engine,
    FakeTafsirRemote? tafsirRemote,
    Map<String, Object> prefValues = const {'quran.coachMarksSeen': true},
    Size size = const Size(390, 844),
    Locale locale = const Locale('en'),
    ThemeData? theme,
    double textScale = 1.0,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues(prefValues);
    prefs = await SharedPreferences.getInstance();
    repo = repository ?? FakeQuranRepository();
    audio = engine ?? FakeAudioEngine();
    tafsir = tafsirRemote ?? FakeTafsirRemote();
    final index = await tester.runAsync(loadTestPageIndex);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          quranRepositoryProvider.overrideWithValue(repo),
          quranAudioEngineProvider.overrideWithValue(audio),
          tafsirRemoteDataSourceProvider.overrideWithValue(tafsir),
          quranPageIndexProvider.overrideWith((ref) async => index!),
        ],
        child: MaterialApp(
          theme: theme,
          locale: locale,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: home,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Flush the debounced progress write so no timers are left pending.
  Future<void> settle(WidgetTester tester) => tester.pump(const Duration(seconds: 1));

  Finder marker(int surah, int ayah) => find.byKey(ValueKey('ayah-marker-$surah:$ayah'));

  Future<void> tapAyah(WidgetTester tester, int surah, int ayah) async {
    await tester.tap(marker(surah, ayah));
    await tester.pumpAndSettle();
  }

  group('SurahIndexScreen', () {
    testWidgets('lists surahs with start pages and filters them', (tester) async {
      await pump(tester, const SurahIndexScreen());

      expect(find.text('Al-Faatiha'), findsOneWidget);
      expect(find.text('Al-Baqara'), findsOneWidget);
      expect(find.text('Begin your reading'), findsOneWidget);
      expect(find.textContaining('Page 2 • 286 ayahs'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'baqarah');
      await tester.pumpAndSettle();
      expect(find.text('Al-Baqara'), findsOneWidget);
      expect(find.text('Al-Faatiha'), findsNothing);

      await tester.enterText(find.byType(TextField), '3');
      await tester.pumpAndSettle();
      expect(find.text('Aal-i-Imraan'), findsOneWidget);
      expect(find.textContaining('Page 50'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'البقرة');
      await tester.pumpAndSettle();
      expect(find.text('Al-Baqara'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'zzz');
      await tester.pumpAndSettle();
      expect(find.textContaining('No surah matches'), findsOneWidget);
    });
  });

  group('QuranReaderScreen', () {
    testWidgets('renders a page with its surah title, text and ayah markers', (tester) async {
      await pump(tester, const QuranReaderScreen(page: 2));

      expect(find.textContaining('نص-2-1'), findsOneWidget);
      expect(find.textContaining('نص-2-5'), findsOneWidget);
      expect(find.textContaining('نص-2-6'), findsNothing);
      for (var a = 1; a <= 5; a++) {
        expect(marker(2, a), findsOneWidget);
      }
      expect(find.text('٥'), findsWidgets);
      expect(find.text('Juz 1'), findsOneWidget);
      // Title box (and top-bar plaque) + Bismillah for Al-Baqarah.
      expect(find.text('سُورَةُ البَقَرَةِ'), findsNWidgets(2));
      expect(find.textContaining('بِسْمِ'), findsOneWidget);

      // Viewing the page logs its ayahs once and saves the position.
      await settle(tester);
      expect(repo.ayahsLogged, 5);
      expect(repo.progress.last, (2, 1));
    });

    testWidgets('?ayah= opens the page holding that ayah and highlights it', (tester) async {
      await pump(tester, const QuranReaderScreen(surahNumber: 2, initialAyah: 6));
      expect(marker(2, 6), findsOneWidget);
      expect(marker(2, 5), findsNothing);
      await settle(tester);
      expect(repo.progress.last, (2, 6));
    });

    testWidgets('tapping an ayah shows the menu; favorite goes through the repository', (
      tester,
    ) async {
      await pump(tester, const QuranReaderScreen(page: 2));

      await tester.tapOnText(find.textRange.ofSubstring('نص-2-3'));
      await tester.pumpAndSettle();
      for (final label in [
        'Tafseer',
        'Translate',
        'Listen to verses',
        'Add to Favorites',
        'Share',
      ]) {
        expect(find.text(label), findsOneWidget);
      }

      await tester.tap(find.text('Add to Favorites'));
      await tester.pumpAndSettle();
      expect(repo.toggled, [(2, 3)]);
      expect(find.text('Ayah bookmarked'), findsOneWidget);
      expect(find.text('Tafseer'), findsNothing);

      await tapAyah(tester, 2, 3);
      expect(find.text('Remove from Favorites'), findsOneWidget);

      // Tapping elsewhere dismisses the menu.
      await tester.tapAt(const Offset(200, 700));
      await tester.pumpAndSettle();
      expect(find.text('Tafseer'), findsNothing);
      await settle(tester);
    });

    testWidgets('translate sheet lists the page ayahs with the translator', (tester) async {
      await pump(tester, const QuranReaderScreen(page: 2));
      await tapAyah(tester, 2, 4);
      await tester.tap(find.text('Translate'));
      await tester.pumpAndSettle();

      expect(find.text('Translation: Sahih International'), findsOneWidget);
      expect(find.text('translation 2:1 (1)'), findsOneWidget);
      expect(find.text('translation 2:4 (4)'), findsOneWidget);
      expect(find.text('translation 2:5 (5)', skipOffstage: false), findsOneWidget);
      expect(find.textContaining('translation 2:6', skipOffstage: false), findsNothing);
      await settle(tester);
    });

    testWidgets('tafseer sheet shows the Muyassar text with attribution', (tester) async {
      await pump(tester, const QuranReaderScreen(page: 2));
      await tapAyah(tester, 2, 2);
      await tester.tap(find.text('Tafseer'));
      await tester.pumpAndSettle();

      expect(tafsir.requested, [(2, 2)]);
      expect(find.text('tafsir-placeholder 2:2'), findsOneWidget);
      expect(find.text('Tafsir al-Muyassar — King Fahd Quran Complex'), findsOneWidget);
      await settle(tester);
    });

    testWidgets('tafseer offline shows a retryable error', (tester) async {
      await pump(
        tester,
        const QuranReaderScreen(page: 2),
        tafsirRemote: FakeTafsirRemote(failure: const NetworkFailure()),
      );
      await tapAyah(tester, 2, 2);
      await tester.tap(find.text('Tafseer'));
      await tester.pumpAndSettle();
      expect(find.textContaining("couldn't load the tafseer"), findsOneWidget);
      expect(find.text('Tafsir al-Muyassar — King Fahd Quran Complex'), findsOneWidget);

      tafsir.failure = null;
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(find.text('tafsir-placeholder 2:2'), findsOneWidget);
      await settle(tester);
    });

    testWidgets('quick navigation jumps by slider and by next page', (tester) async {
      await pump(tester, const QuranReaderScreen(page: 2));
      // Tap the page (not an ayah) to reveal the quick navigation bar.
      await tester.tapAt(const Offset(200, 700));
      await tester.pumpAndSettle();
      expect(find.text('Quick navigation'), findsOneWidget);
      expect(find.text('Page 2'), findsOneWidget);

      await tester.tap(find.byTooltip('Next page'));
      await tester.pumpAndSettle();
      expect(marker(2, 6), findsOneWidget);
      expect(find.text('Page 3'), findsOneWidget);

      final slider = tester.widget<Slider>(find.byKey(const ValueKey('quran-quick-nav-slider')));
      slider.onChangeEnd!(22);
      await tester.pumpAndSettle();
      expect(marker(2, 142), findsOneWidget);
      expect(find.text('Juz 2'), findsWidgets);
      await settle(tester);
      // Pages 2, 3 and 22 were each logged once.
      expect(repo.ayahsLogged, greaterThan(5));
    });

    testWidgets('display mode toggle persists and vertical mode renders pages', (tester) async {
      await pump(tester, const QuranReaderScreen(page: 2));
      await tester.tap(find.byTooltip('Mushaf menu'));
      await tester.pumpAndSettle();
      expect(find.text('Mushaf display'), findsOneWidget);
      await tester.tap(find.text('Vertical'));
      await tester.pumpAndSettle();
      expect(prefs.getString('quran.displayMode'), 'vertical');

      await tester.tap(find.byTooltip('Blue'));
      await tester.pumpAndSettle();
      expect(prefs.getString('quran.mushafColor'), 'blue');
      await tester.tap(find.text('Night mode'));
      await tester.pumpAndSettle();
      expect(prefs.getBool('quran.nightMode'), isTrue);

      Navigator.of(tester.element(find.text('Mushaf display'))).pop();
      await tester.pumpAndSettle();
      expect(marker(2, 1), findsOneWidget);
      expect(find.byKey(const ValueKey('mushaf-pager')), findsNothing);
      await settle(tester);
    });

    testWidgets('offline and not cached shows a retryable error', (tester) async {
      await pump(
        tester,
        const QuranReaderScreen(page: 2),
        repository: FakeQuranRepository(ayahFailure: const NetworkFailure()),
      );
      expect(find.textContaining("You're offline"), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('listen recites from the tapped ayah and advances', (tester) async {
      await pump(tester, const QuranReaderScreen(page: 1));
      await tapAyah(tester, 1, 3);
      await tester.tap(find.text('Listen to verses'));
      await tester.pumpAndSettle();
      expect(audio.loaded.single, endsWith('/ar.alafasy/1003.mp3'));
      expect(find.text('Mishary Rashid Alafasy'), findsOneWidget);

      audio.complete();
      await tester.pumpAndSettle();
      expect(audio.loaded.last, endsWith('/ar.alafasy/1004.mp3'));
      await settle(tester);
    });

    testWidgets('audio backend failure is contained', (tester) async {
      await pump(tester, const QuranReaderScreen(page: 1), engine: FakeAudioEngine(failLoad: true));
      await tapAyah(tester, 1, 1);
      await tester.tap(find.text('Listen to verses'));
      await tester.pumpAndSettle();
      expect(find.text("Recitation couldn't be played right now"), findsOneWidget);
      await settle(tester);
    });

    testWidgets('reflect saves a reflection tied to the ayah', (tester) async {
      await pump(tester, const QuranReaderScreen(page: 1));
      await tapAyah(tester, 1, 2);
      await tester.tap(find.text('Reflect'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'A quiet thought');
      await tester.pump();
      await tester.tap(find.text('Save reflection'));
      await tester.pumpAndSettle();
      expect(repo.reflections.single, ('A quiet thought', 1, 2));
      expect(find.text('Reflection saved'), findsOneWidget);
      await settle(tester);
    });

    testWidgets('coach marks show on first run only', (tester) async {
      await pump(tester, const QuranReaderScreen(page: 1), prefValues: const {});
      expect(find.text('Got it'), findsOneWidget);
      expect(prefs.getBool('quran.coachMarksSeen'), isTrue);
      await tester.tap(find.text('Got it'));
      await tester.pumpAndSettle();
      expect(find.text('Got it'), findsNothing);
      await settle(tester);
    });
  });

  group('QuranBookmarksScreen', () {
    testWidgets('shows empty state, then saved ayahs', (tester) async {
      final repository = FakeQuranRepository();
      await pump(tester, const QuranBookmarksScreen(), repository: repository);
      expect(find.text('No bookmarks yet'), findsOneWidget);

      await repository.toggleBookmark(2, 255);
      await tester.pumpAndSettle();
      expect(find.text('Surah Al-Baqara 2:255'), findsOneWidget);

      await tester.tap(find.byTooltip('Remove'));
      await tester.pumpAndSettle();
      expect(find.text('No bookmarks yet'), findsOneWidget);
    });
  });

  group('layout', () {
    testWidgets('index and reader fit 360px, Arabic RTL, dark, text scale 1.3', (tester) async {
      final dark = AppTheme.dark(languageCode: 'ar');
      await pump(
        tester,
        const SurahIndexScreen(),
        size: const Size(360, 780),
        locale: const Locale('ar'),
        theme: dark,
        textScale: 1.3,
      );
      expect(tester.takeException(), isNull);

      await pump(
        tester,
        const QuranReaderScreen(surahNumber: 2, initialAyah: 7),
        size: const Size(360, 780),
        locale: const Locale('ar'),
        theme: dark,
        textScale: 1.3,
        prefValues: const {},
      );
      expect(tester.takeException(), isNull);
      expect(find.text('حسنًا'), findsOneWidget);
      await tester.tapAt(const Offset(180, 300)); // any tap dismisses the hints
      await tester.pumpAndSettle();
      await tapAyah(tester, 2, 7);
      expect(find.text('إضافة إلى المفضلة'), findsOneWidget);
      await tester.tap(find.text('الاستماع للآيات'));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(180, 400));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.byTooltip('قائمة المصحف'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await settle(tester);
    });
  });
}
