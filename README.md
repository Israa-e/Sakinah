# Sakīnah — سَكينة

> A calmer way to live your faith. / طريق أهدأ للعيش مع إيمانك.

A modern, offline-first Muslim daily companion: Quran, Salah, Dhikr, Du'a, Qibla, Islamic learning, and personal spiritual habits — built to feel calm, premium, fast, and trustworthy.

This repository is being built **incrementally, phase by phase** (see [DEVELOPMENT ORDER](#development-order) below). What's implemented so far is real and runnable; everything else is scaffolded with a clear seam (a repository interface) so it can be filled in without touching the UI that depends on it.

## Status: Phases 1–3 (Foundation, Onboarding → Home, Prayer & Qibla)

Implemented:
- Full project foundation: architecture, state management, theming, localization, navigation, error handling, logging, local persistence.
- Design system: colors, typography, spacing, radii, and a starter component library.
- Onboarding flow: Welcome → Language → Location permission → Prayer preferences → Notifications permission → Goals.
- Home screen: greeting + Gregorian/Hijri date, live prayer countdown card, daily intention, Quran progress (empty + in-progress states), today's dhikr preview, daily deed with completion toggle, offline banner.
- **Prayer**: real Adhan-based calculation (`adhan_dart`) from device location + the calculation method/madhab chosen in onboarding (editable later from the Prayer screen), a full daily prayer-time list, and local notifications for each prayer (toggle in the Prayer screen). Falls back to a clearly-marked estimated schedule when location isn't available (denied permission, no fix, offline).
- **Qibla**: live compass screen (device heading + great-circle bearing to the Kaaba), with distinct states for permission denied, location unavailable, sensor unavailable, and "needs calibration."
- A fully navigable five-tab shell (Home / Quran / Dhikr / Journey / Profile) — the three not-yet-built tabs show a calm "coming soon" placeholder rather than a dead end; Prayer and Qibla are reached from the Home prayer card / Prayer screen rather than the tab bar, matching the spec's navigation list.

Not yet implemented (scaffolded via domain interfaces, ready to be filled in): Quran reader + audio, Dhikr sessions/tasbeeh, Journey/Garden, Reflection, Duas, Ramadan, Zakat, Hijri calendar screen, Ask Sakīnah, Profile/Settings screens.

## Screenshots

_Placeholder — add onboarding/home screenshots here once captured on a device or emulator._

| Welcome | Home | Prayer card |
|---|---|---|
| _tbd_ | _tbd_ | _tbd_ |

## Architecture

See **[ARCHITECTURE.md](ARCHITECTURE.md)** for the full write-up (state management choice and alternatives considered, layering rules, DI, storage, networking, navigation). In short:

- **State management / DI:** Riverpod (`flutter_riverpod` + `riverpod_generator`), used both for state and as the dependency-injection graph.
- **Layers:** Clean Architecture, feature-first (`lib/features/<feature>/{data,domain,presentation}`).
- **Local persistence:** Drift (SQLite) for relational/queryable data (Quran progress, daily deeds, and — as features land — bookmarks, dhikr sessions, journey stats); `shared_preferences` for small non-relational flags (locale, theme, onboarding state).
- **Navigation:** `go_router` with a `StatefulShellRoute` for the five-tab bottom navigation, and a redirect guard for onboarding.
- **Networking:** `Dio`, wrapped so every call returns a `Result<T>` (`Success`/`Failure`) — the UI never touches a raw exception.

## Project layout

```text
lib/
  app/            # App root widget, router, theme assembly, locale/theme-mode config
  core/            # Cross-cutting: constants, errors, network, storage, logging, extensions, shared widgets
  features/
    onboarding/    # data/ domain/ presentation/
    home/
    prayer/        # real Adhan-based calculation + notifications
    qibla/         # live compass + Qibla bearing
    quran/ dhikr/ journey/ dua/ reflection/ ramadan/ zakat/
    hijri_calendar/ ask_sakinah/ profile/   # not yet implemented
  l10n/            # ARB source strings + generated AppLocalizations
  main.dart
```

## Setup

Requires Flutter 3.44+ / Dart 3.12+.

```bash
flutter pub get
flutter gen-l10n                                   # regenerate AppLocalizations after editing lib/l10n/*.arb
dart run build_runner build --delete-conflicting-outputs   # regenerate Riverpod + Drift code after editing @riverpod/@DriftDatabase files
```

Fonts (IBM Plex Sans Arabic, Noto Naskh Arabic, Inter) are bundled under `assets/fonts/` for true offline-first typography — no runtime font fetching.

Location (prayer times/Qibla) and notification permissions are declared in `android/app/src/main/AndroidManifest.xml` and `ios/Runner/Info.plist` — real device/emulator testing of Prayer and Qibla needs a location fix (or the Android emulator's extended-controls location panel) and, on first launch, granting the permissions requested during onboarding.

## Development

```bash
flutter run -d <device>     # e.g. -d linux, -d chrome, -d <android-device-id>
flutter analyze              # must report no issues before merging
flutter test                 # unit + widget tests
```

Whenever you change a file containing `@riverpod`/`@Riverpod`/`@DriftDatabase`, re-run the `build_runner` command above (or `dart run build_runner watch` while developing).

## Testing

- `test/features/<feature>/` — unit tests for pure domain logic (e.g. `PrayerSchedule.nextFrom`, `QiblaReading.relativeAngle`/`needsCalibration`) and widget tests for screens, with fake repositories (`test/fakes/`) standing in for location/compass/network so tests stay fast and hermetic.
- `test/widget_test.dart` — cold-start smoke test verifying the onboarding Welcome step renders.
- Integration tests for full flows (Onboarding → Home, Home → Quran → Reader, ...) land once those flows exist end-to-end.

## Localization

Arabic and English are both first-class. Every user-facing string comes from `AppLocalizations` (generated from `lib/l10n/app_en.arb` / `app_ar.arb`) — never a hardcoded literal. RTL is exercised by default when the device/app locale is Arabic; `BuildContextX.isRtl` is available for the rare case a widget needs to branch on direction explicitly.

## Offline support

Everything implemented so far works fully offline: Drift (SQLite) backs Quran progress and daily deeds, `shared_preferences` backs onboarding/settings state, and the Home screen's offline banner is purely informational (nothing currently implemented requires a network round-trip to function). See [ARCHITECTURE.md](ARCHITECTURE.md) for how this extends as networked features (Ask Sakīnah, remote content sync) land.

## Development order

Phases follow the project spec: **1** Foundation → **2** Onboarding/Home/Profile/Settings → **3** Prayer/Qibla → **4** Quran → **5** Dhikr → **6** Journey/Garden/Reflection → **7** Duas/Ramadan/Hijri/Zakat → **8** Ask Sakīnah → **9** Testing & performance hardening. Each phase should land with `flutter analyze` clean, tests passing, RTL and dark mode checked, before the next one starts.
