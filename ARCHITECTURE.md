# Sakīnah — Architecture

## State Management: Riverpod

**Chosen: `flutter_riverpod` + `riverpod_annotation`/`riverpod_generator`, paired with Clean Architecture and feature-first folders.**

### Why Riverpod

- **Is also the DI container.** Providers are read at compile time (no `BuildContext` needed, no service locator), so repositories, data sources, and use cases are wired the same way state is exposed. This removes the need for a second DI tool (e.g. `get_it`) and keeps one mental model for "how do I get X" everywhere in the app.
- **First-class async & caching.** `AsyncValue` models loading/data/error uniformly, which maps directly onto the offline-first requirement: a repository-backed provider can emit cached data immediately, then refresh in the background, without bespoke state machines per feature.
- **Granular rebuilds.** `select` and fine-grained provider scoping mean a widget watching "next prayer name" doesn't rebuild when "dhikr count" changes, without manual `Consumer` boilerplate — directly serves the performance requirement.
- **Testability.** `ProviderContainer` + overrides make it trivial to substitute fake repositories in unit/widget tests without a widget tree.
- **Compile-time safety.** `riverpod_generator` catches provider misuse (e.g. reading a disposed provider) at analysis time, and `riverpod_lint` enforces good patterns (no `ref.watch` in callbacks, correct disposal, etc.).
- **autoDispose + keepAlive** give explicit control over cache lifetime — e.g. `SurahListProvider` stays alive for the session, `AyahSearchProvider` disposes when the search screen closes.

### Alternatives considered

| Option | Verdict |
|---|---|
| **BLoC/Cubit** | Excellent discipline (explicit events/states) but doubles boilerplate for the many small, independent pieces of state this app needs (tasbeeh counter, per-ayah bookmark state, dhikr session, audio position...). BLoC's DI still needs `RepositoryProvider`/`get_it` on top — Riverpod covers both concerns in one library. Would be the right call for a team that wants maximal explicitness over every transition; not chosen here because it adds ceremony without a matching payoff for this app's shape. |
| **Provider** | Simpler, but lacks compile-time-safe scoping, has no built-in `AsyncValue` equivalent, and its `ChangeNotifier` root makes fine-grained rebuild control and cross-feature composition harder at this scale. Effectively superseded by Riverpod (same author, newer design). |
| **setState/InheritedWidget only** | Not viable past a trivial prototype — no cross-screen state sharing, no testable seams. |

### Dependency injection strategy

- Every repository/data source/use case is exposed via a generated `@riverpod` provider in its feature's `presentation` (for UI-facing state) or `data`/`domain` layer (for the repository itself).
- Providers depend on other providers via `ref.watch`/`ref.read` — never via constructors reaching into a global locator.
- Cross-cutting singletons (Dio client, Drift database, SharedPreferences, Logger) live in `core/` as providers, overridden once in `main.dart` (e.g. the `SharedPreferences` instance, which must be created with `await` before `runApp`).
- Tests override leaf providers (data sources) with fakes; everything above them (repositories, controllers) runs unmodified.

### State ownership rules

- **UI state** (form fields, toggles, transient screen state) is owned by a `Notifier`/`AsyncNotifier` local to that feature's `presentation` layer.
- **Domain state** (Quran progress, prayer settings, journey stats) is owned by the feature's repository and exposed as a `Stream`-backed provider so multiple screens reactively share one source of truth without duplicating fetch logic.
- Widgets never mutate state directly; they call a method on a Notifier, which is the only thing allowed to call repository/use-case methods.
- No provider reaches "up" into another feature's presentation layer — cross-feature reads only go through a domain-layer repository interface.

### Rebuild strategy

- Screens are decomposed so each `Consumer`/`ConsumerWidget` watches the narrowest provider (or `.select(...)`) it needs — e.g. the prayer countdown ticks a `Duration` provider without rebuilding the whole Home screen.
- Static/decorative subtrees are `const` wherever possible.
- Expensive derived values (e.g. formatted Hijri date, garden stage) are computed in a provider, not in `build()`, so they're memoized and shared.

---

## Layering: Clean Architecture, feature-first

```
lib/
  app/        # App root, router, theme wiring, environment config
  core/       # Cross-cutting: constants, errors, network, storage, logging, shared widgets
  features/
    <feature>/
      data/        # Data sources (remote/local), DTOs, repository implementations
      domain/      # Entities, repository interfaces, use cases
      presentation/ # Screens, widgets, Riverpod controllers/providers
```

- **domain** never imports `data` or `presentation` — it defines interfaces (`abstract class QuranRepository`) that `data` implements.
- **data** depends only on `domain` (to implement its interfaces) and `core` (network/storage primitives).
- **presentation** depends on `domain` (entities, repository interfaces) and talks to `data` only through the DI graph, never by importing a data class directly.
- Each feature is independently testable and — in principle — independently removable.

## Local persistence: Drift

**Chosen over Isar and Hive.**

Prayer/Quran/journey data is inherently relational (an `Ayah` belongs to a `Surah`; a `QuranBookmark` references an `Ayah`; a `DhikrSession` references a `Dhikr` item and rolls up into `JourneyProgress`). Drift:

- Compiles typed SQL at build time (catches query mistakes at compile time, not at runtime on a user's device).
- Gives real relational features: joins, indexes, foreign keys, and transactions — needed for e.g. "bookmarks with their surah name" or "atomically update dhikr count + journey stats."
- Supports schema migrations explicitly (`MigrationStrategy`), which a growing app will need repeatedly.
- Exposes **reactive queries** (`Stream<List<Row>>`) that plug directly into Riverpod `StreamProvider`s — a screen watching bookmarks updates itself the instant a bookmark is added, with no manual cache invalidation.
- Isar is fast and offers reactive queries too, but is object/NoSQL-shaped — relational joins across bookmarks/progress/journey would mean manual denormalization. Hive is a pure key-value store: adequate for simple flags (which is why `shared_preferences` is used for those instead of pulling in a second database), inadequate for querying "all bookmarks in Surah Al-Baqarah."

`shared_preferences` is used only for tiny, non-relational flags (onboarding completed, selected locale, theme mode) to avoid opening the database for trivial reads on app boot.

## Networking

- `Dio` with interceptors for logging (debug only), timeouts, and connectivity awareness (`connectivity_plus` gates requests instead of letting them hang).
- All repository methods that hit the network return a `Result<T>` (`core/errors/result.dart`): a sealed `Success<T>` / `Failure` type. UI never catches raw exceptions — it pattern-matches on `Result`.
- Failures are mapped to a closed `AppFailure` enum/sealed hierarchy (`network`, `timeout`, `server`, `cache`, `permission`, `location`, `unknown`) with a human-readable message resolved at the presentation layer (so messages can be localized).

## Navigation

`go_router`, using `StatefulShellRoute.indexedStack` for the bottom-navigation tier (Home/Quran/Dhikr/Journey/Profile) so each tab preserves its own navigation stack and scroll position. A top-level `redirect` guards the onboarding flow (see `app/router/app_router.dart`): unauthenticated/not-onboarded users are redirected to `/onboarding`, everyone else reaches the shell.

## Localization

Flutter's built-in `gen_l10n` (ARB files under `lib/l10n/`) + `flutter_localizations`. No hardcoded user-facing strings — every string is a getter on `AppLocalizations`. Arabic (`ar`) is treated as a first-class locale, not an afterthought: layout direction, icon mirroring, and font selection all key off `Directionality`/`Localizations.localeOf(context)`.

## Audio (planned, Phase 4)

`just_audio` + `just_audio_background` for Quran recitation: supports background playback, lock-screen controls, and lazy per-ayah/per-surah caching (never bulk-downloading the whole Quran). Deferred until the Quran feature phase — not part of the Phase 1 foundation dependency set.

## Security

No API keys ship in the Flutter binary. `Ask Sakīnah` and any other AI/network feature that needs a provider credential calls **our own backend**, which holds the secret server-side (see spec §34/§40). Client-side "secrets" (if any local secret is ever needed, e.g. a device-bound token) go through `flutter_secure_storage`, added when a feature actually needs it — not speculatively in Phase 1.
