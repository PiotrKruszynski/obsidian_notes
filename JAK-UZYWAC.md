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
