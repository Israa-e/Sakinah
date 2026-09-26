import '../domain/dhikr_item.dart';

// Content integrity
// -----------------
// Every Arabic text below was checked word-for-word against the Arabic hadith
// text of the cited narration (fawazahmed0/hadith-api editions, which use the
// standard sunnah.com / Fuad 'Abd al-Baqi numbering), and every count is the
// number stated in that narration. Do NOT add items here without the same
// check — a shorter honest list beats a padded one.
//
// Note on "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ": the research doc attributes it to
// Sahih Muslim 596, but 596 is the post-prayer 33/33/34 hadith (Ka'b ibn
// 'Ujrah). The narration for "SubhanAllahi wa bihamdihi, 100 times a day" is
// Sahih al-Bukhari 6405 / Sahih Muslim 2691, and for mornings and evenings
// Sahih Muslim 2692 — those are cited instead.

const _sayyidAlIstighfarArabic =
    'اللَّهُمَّ أَنْتَ رَبِّي، لَا إِلَٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، '
    'وَأَنَا عَلَىٰ عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، '
    'أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ لَكَ بِذَنْبِي، فَاغْفِرْ لِي، '
    'فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ';
const _sayyidAlIstighfarTranslit =
    "Allāhumma anta rabbī, lā ilāha illā anta, khalaqtanī wa ana 'abduk, "
    "wa ana 'alā 'ahdika wa wa'dika mastaṭa't, a'ūdhu bika min sharri mā ṣana't, "
    "abū'u laka bini'matika 'alayya, wa abū'u laka bidhanbī, faghfir lī, "
    'fa innahu lā yaghfirudh-dhunūba illā anta';
const _sayyidAlIstighfarTranslation =
    'O Allah, You are my Lord; none has the right to be worshipped but You. '
    'You created me and I am Your servant, and I hold to Your covenant and '
    'promise as much as I am able. I seek refuge in You from the evil of what '
    'I have done. I acknowledge Your favour upon me and I acknowledge my sin, '
    'so forgive me, for none forgives sins but You.';
const _sayyidAlIstighfarSource = 'Sahih al-Bukhari 6306';

const _bismillahArabic =
    'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ '
    'وَهُوَ السَّمِيعُ الْعَلِيمُ';
const _bismillahTranslit =
    "Bismillāhil-ladhī lā yaḍurru ma'asmihi shay'un fil-arḍi wa lā fis-samā', "
    "wa huwas-samī'ul-'alīm";
const _bismillahTranslation =
    'In the name of Allah, with whose name nothing on earth or in the heavens '
    'can cause harm, and He is the All-Hearing, the All-Knowing.';
const _bismillahSource = 'Sunan Abi Dawud 5088; Jami` at-Tirmidhi 3388';

const _subhanAllahiWaBihamdihiArabic = 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ';
const _subhanAllahiWaBihamdihiTranslit = 'SubḥānAllāhi wa biḥamdih';
const _subhanAllahiWaBihamdihiTranslation = 'Glory be to Allah, and praise be to Him.';

/// The bundled dhikr catalog, in display order.
const List<DhikrItem> dhikrCatalog = [
  // After every obligatory prayer — Sahih Muslim 596 (Ka'b ibn 'Ujrah):
  // 33 tasbihah, 33 tahmidah, 34 takbirah.
  DhikrItem(
    key: 'after_prayer_subhanallah',
    category: DhikrCategory.afterPrayer,
    arabic: 'سُبْحَانَ اللَّهِ',
    transliteration: 'SubḥānAllāh',
    translation: 'Glory be to Allah.',
    sourceReference: 'Sahih Muslim 596',
    targetCount: 33,
  ),
  DhikrItem(
    key: 'after_prayer_alhamdulillah',
    category: DhikrCategory.afterPrayer,
    arabic: 'الْحَمْدُ لِلَّهِ',
    transliteration: 'Al-ḥamdu lillāh',
    translation: 'All praise is due to Allah.',
    sourceReference: 'Sahih Muslim 596',
    targetCount: 33,
  ),
  DhikrItem(
    key: 'after_prayer_allahu_akbar',
    category: DhikrCategory.afterPrayer,
    arabic: 'اللَّهُ أَكْبَرُ',
    transliteration: 'Allāhu akbar',
    translation: 'Allah is the Greatest.',
    sourceReference: 'Sahih Muslim 596',
    targetCount: 34,
  ),

  // Morning.
  DhikrItem(
    key: 'morning_sayyid_al_istighfar',
    category: DhikrCategory.morning,
    arabic: _sayyidAlIstighfarArabic,
    transliteration: _sayyidAlIstighfarTranslit,
    translation: _sayyidAlIstighfarTranslation,
    sourceReference: _sayyidAlIstighfarSource,
    targetCount: 1,
  ),
  DhikrItem(
    key: 'morning_bismillah_protection',
    category: DhikrCategory.morning,
    arabic: _bismillahArabic,
    transliteration: _bismillahTranslit,
    translation: _bismillahTranslation,
    sourceReference: _bismillahSource,
    targetCount: 3,
  ),
  DhikrItem(
    key: 'morning_subhanallahi_wa_bihamdihi',
    category: DhikrCategory.morning,
    arabic: _subhanAllahiWaBihamdihiArabic,
    transliteration: _subhanAllahiWaBihamdihiTranslit,
    translation: _subhanAllahiWaBihamdihiTranslation,
    sourceReference: 'Sahih Muslim 2692',
    targetCount: 100,
  ),

  // Evening.
  DhikrItem(
    key: 'evening_sayyid_al_istighfar',
    category: DhikrCategory.evening,
    arabic: _sayyidAlIstighfarArabic,
    transliteration: _sayyidAlIstighfarTranslit,
    translation: _sayyidAlIstighfarTranslation,
    sourceReference: _sayyidAlIstighfarSource,
    targetCount: 1,
  ),
  DhikrItem(
    key: 'evening_bismillah_protection',
    category: DhikrCategory.evening,
    arabic: _bismillahArabic,
    transliteration: _bismillahTranslit,
    translation: _bismillahTranslation,
    sourceReference: _bismillahSource,
    targetCount: 3,
  ),
  DhikrItem(
    key: 'evening_subhanallahi_wa_bihamdihi',
    category: DhikrCategory.evening,
    arabic: _subhanAllahiWaBihamdihiArabic,
    transliteration: _subhanAllahiWaBihamdihiTranslit,
    translation: _subhanAllahiWaBihamdihiTranslation,
    sourceReference: 'Sahih Muslim 2692',
    targetCount: 100,
  ),

  // Anytime during the day.
  DhikrItem(
    key: 'astaghfirullah',
    category: DhikrCategory.anytime,
    arabic: 'أَسْتَغْفِرُ اللَّهَ',
    transliteration: 'Astaghfirullāh',
    translation: 'I seek the forgiveness of Allah.',
    // Bukhari 6307: "more than seventy times a day"; Muslim 2702: "a hundred
    // times a day" — hence the target of 100.
    sourceReference: 'Sahih al-Bukhari 6307; Sahih Muslim 2702',
    targetCount: 100,
  ),
  DhikrItem(
    key: 'subhanallahi_wa_bihamdihi',
    category: DhikrCategory.anytime,
    arabic: _subhanAllahiWaBihamdihiArabic,
    transliteration: _subhanAllahiWaBihamdihiTranslit,
    translation: _subhanAllahiWaBihamdihiTranslation,
    sourceReference: 'Sahih al-Bukhari 6405; Sahih Muslim 2691',
    targetCount: 100,
  ),
  DhikrItem(
    key: 'la_ilaha_illallah_wahdahu',
    category: DhikrCategory.anytime,
    arabic:
        'لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ '
        'وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
    transliteration:
        'Lā ilāha illallāhu waḥdahu lā sharīka lah, lahul-mulku wa lahul-ḥamd, '
        "wa huwa 'alā kulli shay'in qadīr",
    translation:
        'None has the right to be worshipped but Allah alone, without partner. '
        'His is the dominion and His is the praise, and He has power over all things.',
    sourceReference: 'Sahih al-Bukhari 6403; Sahih Muslim 2691',
    targetCount: 100,
  ),
];
