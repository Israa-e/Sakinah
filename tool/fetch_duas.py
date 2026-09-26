#!/usr/bin/env python3
"""Build assets/data/duas.json from api.alquran.cloud.

Every du'a in the library is a whole Quranic ayah. Arabic text (quran-uthmani)
and translation (Sahih International, en.sahih) are fetched verbatim from the
API — nothing here is typed by hand except the category and the descriptive
titles. Re-run to refresh:  python3 tool/fetch_duas.py
"""
import json
import time
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / 'assets' / 'data' / 'duas.json'
API = 'https://api.alquran.cloud/v1/ayah/{s}:{a}/editions/quran-uthmani,en.sahih'

# (key, surah, ayah, category, titleEn, titleAr)
DUAS = [
    ('good-both-worlds', 2, 201, 'guidance', 'Good in this world and the next', 'دعاء خيري الدنيا والآخرة'),
    ('patience-talut', 2, 250, 'patience', "Talut's army: a du'a for patience", 'دعاء جيش طالوت بالصبر'),
    ('closing-al-baqarah', 2, 286, 'hardship', "Closing du'a of Al-Baqarah", 'دعاء خواتيم سورة البقرة'),
    ('steadfast-hearts', 3, 8, 'guidance', 'Hearts kept firm on guidance', 'دعاء ثبات القلوب على الهداية'),
    ('forgiveness-fire', 3, 16, 'forgiveness', 'Forgiveness and protection from the Fire', 'دعاء المغفرة والوقاية من النار'),
    ('steadfast-believers', 3, 147, 'patience', "Du'a of the steadfast believers", 'دعاء الربيين الصابرين'),
    ('adam-hawwa', 7, 23, 'forgiveness', "Du'a of Adam and Hawwa", 'دعاء آدم وحواء عليهما السلام'),
    ('ibrahim-prayer', 14, 40, 'family', "Ibrahim's du'a for prayer and descendants", 'دعاء إبراهيم عليه السلام لإقامة الصلاة'),
    ('ibrahim-parents', 14, 41, 'family', "Ibrahim's du'a for parents and believers", 'دعاء إبراهيم عليه السلام للوالدين والمؤمنين'),
    ('mercy-parents', 17, 24, 'family', 'Mercy for parents', 'دعاء الرحمة للوالدين'),
    ('musa-chest', 20, 25, 'hardship', "Musa's du'a for an expanded chest", 'دعاء موسى عليه السلام بشرح الصدر'),
    ('musa-ease', 20, 26, 'hardship', "Musa's du'a for ease", 'دعاء موسى عليه السلام بتيسير الأمر'),
    ('increase-knowledge', 20, 114, 'knowledge', 'Increase in knowledge', 'دعاء طلب الزيادة في العلم'),
    ('ayyub-adversity', 21, 83, 'hardship', "Ayyub's du'a in adversity", 'دعاء أيوب عليه السلام'),
    ('yunus-dhun-nun', 21, 87, 'hardship', "Du'a of Yunus (Dhun-Nun)", 'دعاء ذي النون (يونس عليه السلام)'),
    ('forgive-have-mercy', 23, 118, 'forgiveness', 'Forgiveness and mercy', 'دعاء المغفرة والرحمة'),
    ('comfort-of-eyes', 25, 74, 'family', 'Comfort of the eyes in family', 'دعاء قرة العين في الأزواج والذرية'),
    ('musa-in-need', 28, 24, 'hardship', "Musa's du'a in need", 'دعاء موسى عليه السلام في الحاجة'),
    ('gratitude-offspring', 46, 15, 'gratitude', 'Gratitude and righteous offspring', 'دعاء الشكر وصلاح الذرية'),
    ('forgive-brothers', 59, 10, 'forgiveness', 'Forgiveness for our brothers in faith', 'دعاء المغفرة للإخوة في الإيمان'),
    ('perfect-our-light', 66, 8, 'forgiveness', 'Perfect our light', 'دعاء إتمام النور'),
]


def fetch(s, a):
    url = API.format(s=s, a=a)
    with urllib.request.urlopen(url, timeout=30) as r:
        body = json.load(r)
    if body.get('code') != 200:
        raise SystemExit(f'API error for {s}:{a}: {body}')
    ar, en = body['data']
    assert ar['edition']['identifier'] == 'quran-uthmani', ar['edition']
    assert en['edition']['identifier'] == 'en.sahih', en['edition']
    assert ar['numberInSurah'] == a and ar['surah']['number'] == s
    return url, ar, en


def main():
    items = []
    for key, s, a, cat, title_en, title_ar in DUAS:
        url, ar, en = fetch(s, a)
        items.append({
            'key': key,
            'category': cat,
            'titleEn': title_en,
            'titleAr': title_ar,
            'arabic': ar['text'].strip(),
            'translation': en['text'].strip(),
            'translator': 'Sahih International',
            'reference': f'Quran {s}:{a}',
            'surah': s,
            'ayah': a,
            'surahNameEn': ar['surah']['englishName'],
            'surahNameAr': ar['surah']['name'],
            'sourceUrl': url,
        })
        time.sleep(0.2)
    OUT.write_text(json.dumps({
        'source': 'api.alquran.cloud (quran-uthmani, en.sahih)',
        'duas': items,
    }, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(f'Wrote {len(items)} du\'as to {OUT}')


if __name__ == '__main__':
    main()
