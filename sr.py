#!/usr/bin/env python3
"""
sr.py — codzienne powtórki notatek (SM-2) dla vaultu Obsidian.

Użycie (z folderu vaultu):
  python3 sr.py               # sesja powtórek: otwiera notatki w Obsidian, oceniasz 0-5
  python3 sr.py oop           # sesja tylko z pasującej ścieżki (np. Python/OOP); dowolny fragment
  python3 sr.py oop --all     # cały folder niezależnie od terminów (tryb przed egzaminem)
  python3 sr.py due [folder]  # pokaż, co dziś czeka (bez sesji)
  python3 sr.py stats         # raport skuteczności ("jak nieefektywny jestem")
  python3 sr.py add [ścieżka] [--stagger N]   # włącz notatki do systemu (domyślnie: 5 - Notes)
  python3 sr.py grade <plik> <0-5>            # pojedyncza ocena bez sesji

Opcje: --limit N (max notatek w sesji), --no-open (nie otwieraj Obsidiana)
W sesji: ocena 0-5 · s pomiń (wróci) · z zawieś na stałe (puste/śmieciowe) · o otwórz · q koniec

Skala ocen (SM-2):
  5 idealnie   4 dobrze, po wahaniu   3 ledwo, z trudem
  2 nie pamiętałem, ale znajome   1 coś świta   0 totalna pustka
Ocena <3 = wpadka (lapse): notatka wraca na jutro, licznik od zera.

Stan trzymany we frontmatter każdej notatki (pola sr_*), historia w .sr_log.csv.
"""
import csv
import random
import re
import subprocess
import sys
import urllib.parse
from datetime import date, timedelta
from pathlib import Path

VAULT = Path(__file__).resolve().parent
NOTES_DIR = VAULT / "5 - Notes"
LOG = VAULT / ".sr_log.csv"
VAULT_NAME = VAULT.name
SR_KEYS = ("sr_due", "sr_last", "sr_grade", "sr_interval", "sr_ease", "sr_reps", "sr_lapses")

# ---------- frontmatter ----------

def split_fm(text):
    """-> (fm_lines | None, body_text)"""
    lines = text.split("\n")
    if lines and lines[0].strip() == "---":
        for j in range(1, len(lines)):
            if lines[j].strip() == "---":
                return lines[1:j], "\n".join(lines[j + 1:])
    return None, text

def fm_get(fm_lines, key):
    for l in fm_lines or []:
        m = re.match(rf"^{key}:\s*(.*?)\s*$", l)
        if m:
            return m.group(1).strip('"')
    return None

def read_sr(path):
    fm, _ = split_fm(path.read_text(encoding="utf-8"))
    if fm is None or fm_get(fm, "sr_due") is None:
        return None
    def num(k, cast, default):
        v = fm_get(fm, k)
        try:
            return cast(v)
        except (TypeError, ValueError):
            return default
    return {
        "due": fm_get(fm, "sr_due"),
        "last": fm_get(fm, "sr_last"),
        "grade": fm_get(fm, "sr_grade"),
        "interval": num("sr_interval", int, 0),
        "ease": num("sr_ease", float, 2.5),
        "reps": num("sr_reps", int, 0),
        "lapses": num("sr_lapses", int, 0),
    }

def write_sr(path, sr):
    """Podmień/wstaw pola sr_* nie ruszając reszty pliku."""
    text = path.read_text(encoding="utf-8")
    fm, body = split_fm(text)
    sr_lines = [
        f"sr_due: {sr['due']}",
        f"sr_last: {sr['last']}",
        f"sr_grade: {sr['grade']}",
        f"sr_interval: {sr['interval']}",
        f"sr_ease: {round(sr['ease'], 2)}",
        f"sr_reps: {sr['reps']}",
        f"sr_lapses: {sr['lapses']}",
    ]
    if fm is None:
        new = "---\n" + "\n".join(sr_lines) + "\n---\n" + text
    else:
        kept = [l for l in fm if not re.match(r"^sr_\w+:", l)]
        new = "---\n" + "\n".join(kept + sr_lines) + "\n---" + ("\n" + body if body else "\n")
    path.write_text(new, encoding="utf-8")

# ---------- SM-2 ----------

def sm2(grade, interval, ease, reps, lapses):
    if grade >= 3:
        interval = 1 if reps == 0 else (6 if reps == 1 else round(interval * ease))
        reps += 1
    else:
        interval, reps, lapses = 1, 0, lapses + 1
    ease = max(1.3, ease + (0.1 - (5 - grade) * (0.08 + (5 - grade) * 0.02)))
    return interval, ease, reps, lapses

# ---------- vault ----------

def iter_notes():
    for p in sorted(NOTES_DIR.rglob("*.md")):
        if p.name.startswith("00 "):
            continue
        fm, _ = split_fm(p.read_text(encoding="utf-8"))
        if fm is not None and fm_get(fm, "type") == "moc":
            continue
        yield p

def due_notes(on=None, folder=None, ignore_due=False):
    on = on or date.today()
    out = []
    for p in iter_notes():
        if folder and folder.lower() not in str(p.relative_to(NOTES_DIR)).lower():
            continue
        sr = read_sr(p)
        if sr is None or sr["due"] == "9999-12-31":
            continue
        if ignore_due or (sr["due"] and sr["due"] <= on.isoformat()):
            out.append((p, sr))
    out.sort(key=lambda x: x[1]["due"])
    return out

def log_append(path, grade, interval, ease):
    new = not LOG.exists()
    with LOG.open("a", encoding="utf-8", newline="") as f:
        w = csv.writer(f)
        if new:
            w.writerow(["date", "file", "grade", "interval", "ease"])
        w.writerow([date.today().isoformat(), str(path.relative_to(VAULT)), grade, interval, round(ease, 2)])

def apply_grade(path, grade):
    sr = read_sr(path)
    if sr is None:
        sys.exit(f"'{path.name}' nie jest w systemie — najpierw: python3 sr.py add")
    interval, ease, reps, lapses = sm2(grade, sr["interval"], sr["ease"], sr["reps"], sr["lapses"])
    today = date.today()
    sr.update(due=(today + timedelta(days=interval)).isoformat(), last=today.isoformat(),
              grade=grade, interval=interval, ease=ease, reps=reps, lapses=lapses)
    write_sr(path, sr)
    log_append(path, grade, interval, ease)
    return interval

def open_in_obsidian(path):
    rel = urllib.parse.quote(str(path.relative_to(VAULT)))
    uri = f"obsidian://open?vault={urllib.parse.quote(VAULT_NAME)}&file={rel}"
    if sys.platform == "darwin":
        subprocess.Popen(["open", uri], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    else:
        print(f"   {uri}")

# ---------- komendy ----------

def cmd_add(target=None, stagger=21):
    root = VAULT / target if target else NOTES_DIR
    if not root.exists():
        sys.exit(f"Nie ma ścieżki: {root}")
    fresh = [p for p in iter_notes() if str(p).startswith(str(root)) and read_sr(p) is None]
    random.shuffle(fresh)
    today = date.today()
    for i, p in enumerate(fresh):
        due = today + timedelta(days=(i % stagger) if stagger > 0 else 0)
        write_sr(p, {"due": due.isoformat(), "last": "", "grade": "", "interval": 0,
                     "ease": 2.5, "reps": 0, "lapses": 0})
    print(f"Dodano {len(fresh)} notatek (starty rozłożone na {stagger} dni)." if stagger > 0
          else f"Dodano {len(fresh)} notatek (wszystkie od dziś).")

def cmd_due(folder=None):
    dues = due_notes(folder=folder)
    if not dues:
        print("Nic do powtórki. ✅")
        return
    print(f"Do powtórki: {len(dues)}")
    for p, sr in dues:
        days_over = (date.today() - date.fromisoformat(sr["due"])).days
        tag = f"  (zaległa {days_over} dn.)" if days_over > 0 else ""
        print(f"  {p.relative_to(NOTES_DIR)}{tag}")

def cmd_review(limit=None, no_open=False, folder=None, everything=False):
    dues = due_notes(folder=folder, ignore_due=everything)
    if not dues:
        print(f"Nic do powtórki{f' w ścieżce *{folder}*' if folder else ''}. ✅")
        return
    if limit:
        dues = dues[:limit]
    print(f"Sesja: {len(dues)} notatek. Skala: 5 idealnie · 4 z wahaniem · 3 ledwo · <3 nie pamiętam. [s]kip [z]awieś [o]twórz [q]uit\n")
    done, grades = 0, []
    for i, (p, sr) in enumerate(dues, 1):
        if not no_open:
            open_in_obsidian(p)
        while True:
            ans = input(f"[{i}/{len(dues)}] {p.stem}  → ocena 0-5: ").strip().lower()
            if ans == "q":
                break
            if ans == "s":
                break
            if ans == "z":
                sr["due"] = "9999-12-31"
                write_sr(p, sr)
                print("   → zawieszona (pusta/śmieciowa? uzupełnij treść albo skasuj plik)")
                break
            if ans == "o":
                open_in_obsidian(p)
                continue
            if ans in "012345" and ans != "":
                interval = apply_grade(p, int(ans))
                grades.append(int(ans))
                done += 1
                print(f"   → następna za {interval} dn.")
                break
            print("   0-5, s, o albo q")
        if ans == "q":
            break
    left = len(due_notes(folder=folder))
    avg = f", śr. ocena {sum(grades)/len(grades):.1f}" if grades else ""
    fails = sum(1 for g in grades if g < 3)
    print(f"\nZrobione: {done}{avg}, wpadki: {fails}. Na dziś zostało: {left}.")

def cmd_stats():
    today = date.today()
    in_sys, out_sys, overdue, due_today = [], 0, [], 0
    forecast = {}
    for p in iter_notes():
        sr = read_sr(p)
        if sr is None:
            out_sys += 1
            continue
        in_sys.append((p, sr))
        d = date.fromisoformat(sr["due"])
        if d < today:
            overdue.append((today - d).days)
        elif d == today:
            due_today += 1
        elif (d - today).days <= 7:
            forecast[d] = forecast.get(d, 0) + 1
    reps = sum(sr["reps"] for _, sr in in_sys)
    lapses = sum(sr["lapses"] for _, sr in in_sys)
    eases = [sr["ease"] for _, sr in in_sys if sr["reps"] > 0]

    rows = []
    if LOG.exists():
        with LOG.open(encoding="utf-8") as f:
            rows = [r for r in csv.DictReader(f)]
    last30 = [r for r in rows if r["date"] >= (today - timedelta(days=30)).isoformat()]
    fails30 = sum(1 for r in last30 if int(r["grade"]) < 3)
    days_logged = {r["date"] for r in rows}
    streak, d = 0, today
    if today.isoformat() not in days_logged:
        d = today - timedelta(days=1)
    while d.isoformat() in days_logged:
        streak += 1
        d -= timedelta(days=1)

    susp = sum(1 for _, sr in in_sys if sr["due"] == "9999-12-31")
    print("── Stan ────────────────────────────────")
    print(f"w systemie: {len(in_sys) - susp}   zawieszone: {susp}   poza systemem: {out_sys}")
    print(f"dziś: {due_today}   zaległe: {len(overdue)}" + (f" (najstarsza {max(overdue)} dn.)" if overdue else ""))
    print("── Skuteczność ─────────────────────────")
    if last30:
        print(f"oceny <3 (30 dni): {100*fails30/len(last30):.0f}%  ({fails30}/{len(last30)}) ← tyle razy NIE pamiętałeś")
    if reps:
        print(f"wpadki łącznie: {lapses}/{reps+lapses} powtórek ({100*lapses/(reps+lapses):.0f}%)")
    if eases:
        print(f"śr. ease: {sum(eases)/len(eases):.2f}  (start 2.5; niżej = materiał stawia opór)")
    print(f"streak: {streak} dni z rzędu z powtórką")
    hard = sorted((x for x in in_sys if x[1]["lapses"] > 0), key=lambda x: (x[1]["ease"], -x[1]["lapses"]))[:3]
    if hard:
        print("najtrudniejsze: " + "; ".join(f"{p.stem} ({sr['lapses']}× wpadka)" for p, sr in hard))
    if forecast:
        print("── Prognoza 7 dni ──────────────────────")
        print("  ".join(f"{d.strftime('%a %d')}: {n}" for d, n in sorted(forecast.items())))

def main():
    args = sys.argv[1:]
    no_open = "--no-open" in args
    everything = "--all" in args
    args = [a for a in args if a not in ("--no-open", "--all")]
    limit = stagger = None
    for flag in ("--limit", "--stagger"):
        if flag in args:
            i = args.index(flag)
            val = int(args[i + 1])
            args[i:i + 2] = []
            if flag == "--limit":
                limit = val
            else:
                stagger = val
    cmd = args[0] if args else "review"
    if cmd not in ("review", "due", "stats", "add", "grade", "-h", "--help"):
        cmd_review(limit=limit, no_open=no_open, folder=cmd, everything=everything)
    elif cmd == "review":
        cmd_review(limit=limit, no_open=no_open,
                   folder=args[1] if len(args) > 1 else None, everything=everything)
    elif cmd == "due":
        cmd_due(args[1] if len(args) > 1 else None)
    elif cmd == "stats":
        cmd_stats()
    elif cmd == "add":
        cmd_add(args[1] if len(args) > 1 else None, stagger=21 if stagger is None else stagger)
    elif cmd == "grade":
        p = Path(args[1])
        p = p if p.is_absolute() else VAULT / args[1]
        print(f"→ następna za {apply_grade(p, int(args[2]))} dn.")
    else:
        print(__doc__)

if __name__ == "__main__":
    main()
