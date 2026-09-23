# Sakīnah — Performance Notes

Practical rules this codebase follows, and how to verify them as features land.

## Rebuild strategy

- Screens are decomposed into small `Consumer`/`ConsumerWidget`s that each watch the narrowest provider they need, instead of one widget watching a big combined state object. Example: `HomePrayerCard` watches `nextPrayerProvider` only; the countdown ticks via a separate `clockTickProvider` so the rest of Home never rebuilds once a second (see `features/prayer/presentation/providers/prayer_providers.dart`).
- Static/decorative subtrees are `const` wherever possible (enforced by the `prefer_const_constructors`/`prefer_const_declarations` lints in `analysis_options.yaml`).
- Derived values that would otherwise be recomputed per rebuild (formatted Hijri date, Quran progress ratio) are computed once in a provider or a model getter, not inline in `build()`.
- Lists (once Quran/Dhikr/Journey screens land) must use `ListView.builder`/`SliverList` — never materialize an unbounded widget list.

## Caching & data flow

- Drift's reactive queries (`Stream<List<Row>>` / `.watchSingle...`) feed Riverpod `StreamProvider`s directly — a write anywhere (e.g. marking the daily deed done) is reflected everywhere it's watched with no manual cache invalidation.
- `keepAlive: true` is used deliberately for app-wide singletons (Dio client, Drift database, preferences, router) so they aren't rebuilt/reconnected on every navigation. Screen-scoped or search-like providers should use the default `autoDispose` once they exist, so their cache doesn't outlive the screen.
- The Qibla compass stream (`qiblaProvider`) is deliberately plain `@riverpod` (autoDispose), not `keepAlive` — the magnetometer stops being read the moment the user leaves the Qibla screen, instead of running for the lifetime of the app.
- The prayer schedule/clock providers are `autoDispose` too, but are kept alive indirectly for as long as the app runs because `PrayerNotificationScheduler` (a `keepAlive` provider watched once from `SakinahApp`) holds a subscription — one intentional exception, not a general pattern to copy elsewhere.
- No network or database call happens inside `build()` — repositories are read through providers that resolve before the widget tree needs the value, and loading states (`AsyncValue.loading`) render a `SkeletonLoader` sized like the eventual content so nothing jumps.

## Database

- Drift (SQLite) tables are indexed by their natural access pattern (e.g. `QuranProgressEntries` ordered by `updatedAt` for "most recent"). As the Quran feature's full schema (surahs/ayahs/bookmarks) lands, add explicit indexes for the actual query shapes used (surah lookup, bookmark-by-ayah) rather than guessing upfront.
- Writes are done via `insertOnConflictUpdate`/targeted `update()..where()` rather than read-modify-write in Dart, so partial updates (e.g. toggling `completed`) don't require re-reading the source of truth first.
- `NativeDatabase.createInBackground` keeps SQLite I/O off the UI isolate.

## Startup

- `main()` only awaits the one thing that must be ready before `runApp` — `SharedPreferences.getInstance()`. Everything else (Drift database, network client) is created lazily behind a `keepAlive` provider the first time something actually reads it.
- Fonts are bundled as local assets (`assets/fonts/`), not fetched at runtime — no first-launch network dependency for correct typography.

## Audio (Phase 4)

Deferred until the Quran feature lands. Planned approach (see ARCHITECTURE.md): `just_audio` + `just_audio_background`, with per-ayah/per-surah lazy caching — never a bulk Quran download — and explicit handling of interruptions/headphone events so playback doesn't fight the OS.

## Profiling process

For each phase, before moving to the next:

1. `flutter analyze` — must be clean (see `analysis_options.yaml`; generated `*.g.dart` files are excluded from analysis, not from correctness — they're regenerated from source you do lint).
2. `flutter test` — unit + widget tests green.
3. Run the affected screen in profile mode (`flutter run --profile`) and open DevTools' **Performance** view while interacting with it; watch for dropped frames (target: no jank at 60 FPS on the timeline) and the **Memory** view for leaks across repeated navigation (open/close the screen several times and confirm memory returns to baseline).
4. Check the **Widget rebuild** overlay (`Highlight repaints` / `Track widget rebuilds` in DevTools) on any screen with a ticking or streamed value to confirm only the intended widget subtree rebuilds.
5. Only then move to the next phase.
