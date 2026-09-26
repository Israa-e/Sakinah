# Sakīnah — Competitive Research & Design Decisions

_Compiled from the design session for the Sakīnah app (github.com/Israa-e/Sakinah). Covers competitor research, gap analysis, and every content/navigation decision made against the design canvas at:_
`https://claude.ai/artifact/VvXAXccxCA8zBUogRXFKGV`

---

## 1. Competitor Research

### 1.1 General Sunni prayer/companion apps (Muslim Pro, Athan Pro, Athan by IslamicFinder)

Reviewed to sanity-check Sakīnah's information architecture against what the market already expects.

| App | Publisher | Scale | Core features |
|---|---|---|---|
| Muslim Pro | Bitsmedia | 10M+ downloads | Verified prayer times, full Quran (audio + translations + memorization tools), Qibla finder, duas & dhikr, prayer/fasting tracker, "Ummah" social layer |
| Athan Pro | Quantic Apps | Large scale | Prayer times (MWL/ISNA/Egypt/Umm al-Qura + more), Qibla compass w/ live map + distance, Ramadan dashboard (Sehri/Iftar timings, fasting calendar) |
| Athan (IslamicFinder) | IslamicFinder | Large scale | Daily-goals gamification (log 5 prayers, Quran goal, Athkar goal, streaks), Hijri calendar, mosque finder |

**Takeaway:** Sakīnah's information architecture (prayer times → Quran → Dhikr → Journey/streaks → Qibla → Duas → Zakat → Hijri calendar) already covers the same ground these apps compete on. Nothing structurally missing.

### 1.2 Deen Buddy — دين بادي (Talking Tech, 500K+ downloads)

An AI-powered **"Quran Chat"** app:
- Ask any Quran-related question, get an answer sourced from "trusted sources" — meanings, tafsir, historical context.
- **Daily inspiring verse** — save and share your favorite verses easily.
- Available in English, German, Arabic.

**Relevance:** This is functionally the same concept as **Ask Sakīnah** (free-form question → sourced answer). Validates that our approach (answer + explicit Quran/hadith sources + "consult a scholar for rulings" disclaimer) is aligned with what a real, popular app in this space already does.

**Gap identified:** Deen Buddy has a **"daily verse" quick-save/share card** that Sakīnah's current design doesn't have as a standalone feature (Sakīnah's "Daily Intention" card is adjacent but not the same thing — no verse text, no save/share action).
→ *Open question, not yet decided: should Home gain a "Verse of the Day" card?*

### 1.3 AL Siraat — الصراط (Darwin Technology L.L.C, 1M+ downloads)

An **AI recitation-coaching** app ("Learn Quran & Qaida"):
- **Real-time AI mistake detection** while reciting — listens via microphone as you read.
- **Word-level, color-coded feedback**: 🟢 green = correct, 🟠 orange = needs improvement, 🔴 red = mistake.
- Tap a flagged word to **isolate and retry just that word** — no need to repeat the whole ayah.
- **Compare your recitation against renowned Qaris.**
- **Mistake log** — tracks errors over time to show improvement trends.
- Separate **Qaida module** for absolute beginners (Arabic letters, sounds, makharij) before Quran recitation itself.
- Bundled extras: prayer times, Qibla, Tasbeeh counter, Hijri calendar, daily duas.

**Relevance:** Directly comparable to Sakīnah's **Memorization Mode** screen.

**Gap identified — significant:** Sakīnah's current Memorization Mode is a simple **self-report loop** (hide ayah → user reads from memory → user taps "I remembered it" / "Try again"). There is **no actual voice input, no pronunciation analysis, no word-level feedback**. AL Siraat's core value proposition — AI listening to your actual recitation and grading it — is a different order of feature entirely (requires speech recognition + tajweed-rule analysis, not just a UI change).

---

## 2. Gap Analysis Summary

| Sakīnah feature | Comparable competitor feature | Status |
|---|---|---|
| Ask Sakīnah (Q&A + sources + scholar disclaimer) | Deen Buddy's AI Quran Chat | ✅ Already aligned |
| Home daily cards (intention, Quran progress, dhikr, good deed) | Deen Buddy's daily verse card | ⚠️ Adjacent but not equivalent — open question above |
| Memorization Mode (self-report hide/reveal) | AL Siraat's AI mistake detection (word-level, color-coded, voice-based) | ❌ Real gap — needs a product decision, not just a design tweak |
| Prayer times, Qibla, Tasbeeh, Hijri calendar, Duas | Present across all apps reviewed | ✅ Already covered |

---

## 3. Options for Closing the Memorization/Recitation Gap

Presented to the user; **decision pending** as of this document.

### Option A — New standalone screen: "Recitation Correction" (تصحيح التلاوة)
- A dedicated screen separate from Memorization Mode, modeled on AL Siraat's flow: mic input → live word-by-word color feedback → tap-to-retry a single word → session mistake log.
- **Pros:** Doesn't disturb the existing (working) Memorization Mode flow; framed as its own clear feature.
- **Cons:** Biggest scope — needs real speech-to-text + Arabic phoneme/tajweed-rule matching on the backend (not a client-only feature); a new bottom-sheet or full-screen mic UI to design.

### Option B — Extend Memorization Mode in place
- Keep the existing hide/reveal flow, but add word-level color-coded feedback as a secondary state once the user taps "I remembered it" (i.e., let them optionally recite aloud and see per-word feedback before confirming).
- **Pros:** Smaller design surface — one screen gets richer, nothing new to navigate to.
- **Cons:** Conflates two different mental models (self-report vs. AI-graded) in one screen; may feel cluttered.

### Option C — Defer
- Leave Memorization Mode as the simple self-report version for now; log this gap for a later phase once voice-recognition infrastructure exists.
- **Pros:** Zero additional design/backend work right now.
- **Cons:** Feature gap remains next to a 1M+-download competitor whose entire identity is built on this exact feature.

**No option has been chosen yet — needs a decision before design or backend work proceeds on this specific gap.**

---

## 4. Design & Content Decisions Made This Session

These **were** decided and **are already reflected** in the design canvas.

### 4.1 Bottom navigation: 5 tabs, not 4
- **Original spec said:** 4-tab bottom nav (Home / Quran / Dhikr / Journey), with Profile reachable only via a header icon on Home.
- **Discovered:** The real Flutter repo (`github.com/Israa-e/Sakinah`, README) already implements a **five-tab shell**: Home / Quran / Dhikr / Journey / **Profile**.
- **Decision:** Match the real code. Five tabs is now the source of truth.
- **Consequence:** Since Profile now has its own tab, the redundant Profile icon in Home's header was **replaced with a notifications bell icon** (having both a header shortcut and a tab pointing to the same screen was clutter, against the app's own "calm, minimal" brief).
- **Files updated:** `06-Home`, `08-Quran-Home`, `10-Surah-Details`, `13-Dhikr-Home`, `15-Journey-Garden`, `20-Profile` (now a proper tab root — back-chevron removed, nav bar added), `22-Home-Dark`, `23-Home-RTL-Arabic`, `25-Ramadan-Mode`, and the Design System reference sheet's nav example.

### 4.2 Religious content accuracy fixes
The original mockup content contained one outright error and several unverified placeholders. All were checked against real hadith/Quran sources and corrected:

| Location | Before | After (verified) |
|---|---|---|
| Dhikr Home, item 1 | "أعوذ بالله من الشيطان الرجيم" ×1 (not actually a countable dhikr — it's the Isti'adhah said before Quran recitation) | Replaced with **"أستغفر الله"** ×100 — the Prophet ﷺ sought forgiveness this way repeatedly each day (Sahih al-Bukhari 6307) |
| Dhikr Home, item 2 | "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ" — translation placeholder | "Glory be to Allah, and praise be to Him" — recited 33× after each prayer alongside Alhamdulillah (33×) and Allahu Akbar (34×) (Sahih Muslim 596) |
| Dhikr Home, item 3 | "لا إله إلا الله" (incomplete phrase) ×100 | Completed to the full authentic phrase: "لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ" with translation (Sahih al-Bukhari 6403 / Sahih Muslim 2691) |
| Quran Reader (2:143) | "[Translation placeholder]" | Sahih International translation, properly attributed |
| Du'a Detail (2:250, patience) | "[Translation placeholder — verified translation to be added]" | "Our Lord, pour upon us patience and plant firmly our feet and give us victory over the disbelieving people." — Sahih International; confirmed this is Talut's (Saul's) army's supplication before facing Goliath |

**Still unverified / left as honest placeholders** (not fabricated): the full text of Morning/Evening Adhkar sets, the Ask Sakīnah tafsir source chip, and most Du'a category entries beyond the one shown above. These need the same source-checking treatment before the app ships.

---

## 5. Open Items / Next Steps

1. **Decide** on Option A/B/C above for the recitation-correction gap.
2. **Decide** whether to add a "Verse of the Day" card to Home (Deen Buddy gap).
3. Continue verifying remaining placeholder religious content (full Adhkar sets, Du'a library) against Hisnul Muslim / named hadith collections before this ships to real users.
4. Backend prompt already drafted separately for: Ask Sakīnah's retrieval-constrained Q&A service, and optional cloud sync — see prior message in this conversation.