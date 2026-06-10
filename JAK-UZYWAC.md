# JAK UŻYWAĆ — instrukcja LLM Wiki

## Setup (raz)

- Otwórz folder vaultu w **VS Code Insiders**.
- Odpal **Claude Code** w tym oknie (agent, nie zwykły czat) — wczyta `CLAUDE.md` automatycznie.
- Przed każdą sesją agenta upewnij się, że **synchronizacja chmury skończyła pracę** (inaczej konflikty plików).

## Dodawanie wiedzy

- Trwałe źródło (PDF, artykuł, transkrypt) → wrzuć do `2 - Source Materials/`.
- Luźny wniosek z sesji nauki → wrzuć do `1 - Raw Notes/`.
- Potem powiedz agentowi: **„zrób ingest [plik]"**.

## Utrzymanie

- Co jakiś czas: **„zrób lint vaultu"**.
- Przejrzyj raport (martwe linki, sieroty, duplikaty, sprzeczności, luki).
- Zdecyduj, co naprawić — agent nic nie zmienia bez Twojej zgody.

## Dwie role, te same pliki

- **Czytanie/myślenie** → Obsidian (graf, przeglądanie, linki).
- **Pisanie/utrzymanie** → Claude Code (ingest, lint, nowe notatki).

## Bezpieczeństwo

- Większe zmiany akceptuj **z diffa** — agent ma obowiązek go pokazać przed zapisem.
- Commituj po sensownych etapach („zrób commit"), żeby dało się cofnąć.
- Plugin Obsidian Git robi auto-backupy — w razie czego `git log` i powrót do dowolnego stanu.

## Hasła operacji (szczegóły w CLAUDE.md)

- `ingest [plik]` — rozłóż źródło/inbox na atomowe notatki, zaktualizuj istniejące, pokaż diff.
- `lint` — raport zdrowia vaultu, bez zmian.
- `nowa notatka [pojęcie]` — pojedyncza notatka wg zasad.
