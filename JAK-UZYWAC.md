# JAK UŻYWAĆ — instrukcja LLM Wiki

## Setup (raz)

- Otwórz folder vaultu w **VS Code Insiders**.
- Odpal agenta w tym oknie (**Codex**, Claude Code, Copilot — agent, nie zwykły czat) — każdy wczyta `AGENTS.md` automatycznie.
- Przed każdą sesją agenta upewnij się, że **synchronizacja chmury skończyła pracę** (inaczej konflikty plików).

## Dodawanie wiedzy

- Trwałe źródło (PDF, artykuł, transkrypt) → wrzuć do `2 - Source Materials/`.
- Luźny wniosek z sesji nauki → wrzuć do `1 - Raw Notes/`.
- Najszybciej z LLM: skopiuj odpowiedź (Cmd+C) i w terminalu `raw nazwa-pliku [model]` — funkcja zapisuje schowek do `1 - Raw Notes/` z datą i źródłem (instalacja: `6 - Commands/raw — schowek do inboxu`).
- Potem powiedz agentowi: **„zrób ingest [plik]"**.

## Codzienna powtórka (SM-2)

- W terminalu vaultu: `python3 sr.py` — otwiera po kolei zaległe notatki w Obsidian; czytasz (~30 s) i wpisujesz ocenę 0–5.
- Skala: **5** idealnie · **4** z wahaniem · **3** ledwo · **2–0** nie pamiętam (notatka wraca na jutro).
- Trafiła się pusta/śmieciowa notatka → **`z`** zawiesza ją na stałe (potem uzupełnij treść albo skasuj plik). `s` tylko odkłada na jutro.
- Po przerwie (dzień, tydzień): nic nie przepada — zaległe czekają w kolejce od najstarszych. Nadrabiaj porcjami: `python3 sr.py --limit 30`.
- Terminy liczy SM-2 (krzywa zapominania): dobre oceny wydłużają odstęp (1 → 6 → ~2× dni), wpadka zeruje licznik.
- Powtórka z konkretnego działu: `python3 sr.py oop` (dowolny fragment ścieżki, np. `python`, `bazy`); z `--all` przelatujesz cały dział niezależnie od terminów — tryb przed egzaminem/rozmową.
- `python3 sr.py stats` — zaległości, % wpadek, streak, prognoza tygodnia (czyli: jak nieefektywny jesteś).
- `python3 sr.py add` — włącza do powtórek notatki dodane do vaultu ręcznie (agent inicjalizuje pola `sr_*` sam).
- Ściąga: `sr.py` sesja · `sr.py oop` dział · `sr.py oop --all` dział bez terminów · `sr.py due [dział]` podgląd · `sr.py stats` raport · `sr.py add` nowe · `--limit N` porcja. W sesji: `0–5` ocena · `s` jutro · `z` zawieś · `o` otwórz · `q` koniec.

## Utrzymanie

- Co jakiś czas: **„zrób lint vaultu"**.
- Przejrzyj raport (martwe linki, sieroty, duplikaty, sprzeczności, luki).
- Zdecyduj, co naprawić — agent nic nie zmienia bez Twojej zgody.

## Dwie role, te same pliki

- **Czytanie/myślenie** → Obsidian (graf, przeglądanie, linki).
- **Pisanie/utrzymanie** → agent w VS Code, np. Codex (ingest, lint, nowe notatki).

## Szukanie wiedzy

- Pamiętasz **gdzie** → Obsidian, klikasz.
- Pamiętasz **słowo** → Obsidian: `Cmd+O` (nazwa notatki) lub `Cmd+Shift+F` (pełnotekstowo).
- Pamiętasz tylko **sens** albo pytanie jest przekrojowe → agent: **„znajdź [pytanie]"** — odpowiada wyłącznie z notatek, podaje ścieżki; brak notatki zgłasza jako lukę.

## Bezpieczeństwo

- Większe zmiany akceptuj **z diffa** — agent ma obowiązek go pokazać przed zapisem.
- Commituj po sensownych etapach („zrób commit"), żeby dało się cofnąć.
- Plugin Obsidian Git robi auto-backupy — w razie czego `git log` i powrót do dowolnego stanu.

## Hasła operacji (szczegóły w AGENTS.md)

- `ingest [plik]` — rozłóż źródło/inbox na atomowe notatki, zaktualizuj istniejące, pokaż diff.
- `lint` — raport zdrowia vaultu, bez zmian.
- `nowa notatka [pojęcie]` — pojedyncza notatka wg zasad.
- `znajdź [pytanie]` — szukanie tylko w notatkach, ze ścieżkami; brak = luka.
- `odpowiedz [pytanie]` — merytoryczna odpowiedź zbudowana wyłącznie z notatek, ze źródłami na końcu; braki wskazane wprost.
- `ćwicz [temat]` — zadania praktyczne z koncepcji, które masz; błędy wracają do notatek jako [!warning]. SQL: baza Sakila w `Bazy-Danych/Cwiczenia-Sakila/`.
