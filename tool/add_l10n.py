#!/usr/bin/env python3
"""Add/replace localized strings in both ARB files, then regenerate.

Usage: python3 tool/add_l10n.py strings.json
where strings.json is {"keyName": {"en": "...", "ar": "...", "placeholders": {...}?}, ...}

Safe to run concurrently: an exclusive file lock serializes the
read-modify-write of the ARB files and the `flutter gen-l10n` run.
"""
import fcntl, json, subprocess, sys
from pathlib import Path

root = Path(__file__).resolve().parent.parent
arb = {lang: root / 'lib' / 'l10n' / f'app_{lang}.arb' for lang in ('en', 'ar')}
new = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))

with open(root / 'tool' / '.l10n.lock', 'w') as lock:
    fcntl.flock(lock, fcntl.LOCK_EX)
    for lang, path in arb.items():
        data = json.loads(path.read_text(encoding='utf-8'))
        for key, entry in new.items():
            data[key] = entry[lang]
            if lang == 'en' and entry.get('placeholders'):
                data['@' + key] = {'placeholders': entry['placeholders']}
        path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    r = subprocess.run(['flutter', 'gen-l10n'], cwd=root, capture_output=True, text=True)
    print(r.stdout[-2000:], r.stderr[-2000:])
    sys.exit(r.returncode)
