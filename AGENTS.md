# AGENTS.md — konstytucja vaultu (LLM Wiki)

> Plik w otwartym standardzie [AGENTS.md](https://agents.md) — czytany automatycznie przez Codex CLI, GitHub Copilot, Cursor, Gemini CLI i inne; Claude Code używa go jako fallbacku, gdy brak CLAUDE.md.

Ten vault to LLM Wiki w trzech warstwach (wzorzec Karpathy'ego):

1. **Źródła niemutowalne** — `2 - Source Materials/` (agent tylko czyta)
2. **Wiki utrzymywane przez agenta** — `5 - Notes/` (atomowe notatki, ciągle aktualizowane)
3. **Schema** — ten plik (konwencje, operacje, zasady)

Rola agenta: nie tylko tworzyć nowe notatki, ale **ciągle utrzymywać istniejące** — aktualizować, łapać sprzeczności, wykrywać braki i duplikaty, poprawiać cross-referencje. Wiki ma się starzeć w stronę spójności, nie entropii.

Język vaultu: **polski** (terminy techniczne mogą zostać po angielsku).

## Struktura vaultu

| Folder | Rola |
|---|---|
| `1 - Raw Notes/` | **Inbox** — ulotne wnioski z sesji nauki, bałagan do rozłożenia przez `ingest`. Po przetworzeniu można czyścić. |
| `2 - Source Materials/` | **Raw / źródła niemutowalne** — PDF-y, artykuły, transkrypty, dumpy. TYLKO DO CZYTANIA: agent nie edytuje, nie kasuje, nie przenosi. |
| `3 - Indexes/` | Indeksy / MOC-e przekrojowe. |
| `4 - Templates/` | Szablony notatek (Concept Note, AWS Service, MOC...). |
| `5 - Notes/` | **Wiki właściwe** — atomowe notatki w folderach modułów. |
| `6 - Commands/` | Cheatsheety komend. |
| `7 - Assets/` | Załączniki, obrazy. |
| `8 - Daily/` | Notatki dzienne. |
| `9 - Prompt template/` | Szablony promptów. |

W `5 - Notes/` foldery modułów: `Python/`, `AWS/`, `Bazy-Danych/`, `Sieci/`, `Testy/`, `C/`, `Docker/`, `AI-ML/`, `Algorytmy/`, `FastAPI-vault/`, `Projekty/` (per projekt, np. `Projekty/fastapi-rekrutacja/`).

### Koncepcje — jedna koncepcja istnieje raz

Foldery `Koncepcje/` żyją **per moduł** (np. `Python/Koncepcje/`, `Bazy-Danych/Koncepcje/`). Konwencja:

- Koncepcja istnieje w **jednym miejscu** w całym vaulcie i jest reużywana przez linkowanie.
- Przed utworzeniem nowej notatki koncepcji agent MUSI przeszukać **wszystkie** foldery `Koncepcje/` (i całe `5 - Notes/`) pod kątem istniejącej notatki o tym pojęciu. Jeśli istnieje — linkuj `[[...]]`, nie duplikuj. Jeśli istnieje, ale jest niepełna — zaproponuj aktualizację (diff).
- Pojęcie ogólne (np. GIL, ACID) trafia do `Koncepcje/` modułu tematycznego; notatka specyficzna dla projektu — do folderu projektu, z linkami do koncepcji ogólnych.
- **Nazwy plików unikalne w całym vaulcie** (wikilinki Obsidian rozwiązują po nazwie pliku).

## Zasady atomowości

- **Jedna notatka = jedna myśl.** Tytuł nazywa tę jedną myśl. Jeśli tytuł wymaga "i"/"oraz" łączącego dwa pojęcia — to dwie notatki.
- **Notatka samodzielna**: zrozumiała bez czytania innych. Kontekst dopowiadają linki, nie kolejność czytania.
- **Model mentalny / analogia przed kodem.** Najpierw obraz w głowie, potem składnia.
- **Tłumacz DLACZEGO, nie tylko CO.** Definicja bez przyczyny to katalog, nie wiedza.
- **Gęste linkowanie** `[[wikilinkami]]` w treści, wszędzie gdzie pada powiązane pojęcie.
- **Każda notatka kończy się sekcją `## Połączenia`** — lista linków, każdy z jednym zdaniem WYJAŚNIENIA, czemu pojęcia są powiązane. Sam link bez wyjaśnienia się nie liczy.

## Frontmatter i proweniencja

Każda notatka dostaje frontmatter wg istniejącej konwencji vaultu + pole `źródło`:

```yaml
---
title: "Nazwa notatki"
type: concept        # concept | service | moc | project | question
topic: python        # moduł tematyczny
tags: ["python"]
created: 2026-06-10
status: draft        # draft | done
źródło: "2 - Source Materials/nazwa-pliku.pdf"
---
```

Pole `źródło` jest **obowiązkowe** — mówi, skąd pochodzi twierdzenie, żeby dało się je później zweryfikować. Możliwe wartości:

- `"2 - Source Materials/plik.pdf"` — notatka z ingestu źródła (ścieżka do pliku!)
- `"1 - Raw Notes/plik.md"` — notatka z ingestu inboxu
- `"sesja LLM, <model>"` — wiedza z rozmowy z LLM, np. `"sesja LLM, GPT-5 Codex"`, `"sesja LLM, Claude Fable 5"` (zawsze podaj model!)
- `"dokumentacja python.org"`, `"wykład 42"` itp.

To ważne: część wiedzy pochodzi z rozmów z LLM, które bywają błędne. Bez proweniencji nie da się odróżnić twierdzenia z dokumentacji od halucynacji.

## Callouty Obsidian — do tłumaczenia, nie ozdoby

- `> [!summary]` — **sedno w jednym zdaniu, zawsze na górze notatki** (zaraz pod tytułem).
- `> [!example]` — przykład **krok po kroku**, z danymi, nie abstrakcyjny.
- `> [!warning]` — **realna pułapka z przykładem skutku** ("jeśli zrobisz X, stanie się Y"), nie ogólnikowe "uważaj".
- `> [!tip]` — sztuczka pamięciowa, skojarzenie, mnemonik.

Callout bez treści tłumaczącej to szum — lepiej go nie dawać.

## Czego unikać

- **Notatek-katalogów**: ściana kodu/komend zamiast tłumaczenia. Kod ilustruje myśl, nie zastępuje jej.
- **Duplikowania pojęć** między modułami zamiast linkowania do jednej notatki.
- **Tytułów łączących dwie myśli** ("X i Y") — rozbij na dwie notatki.
- **Pomijania sekcji `## Połączenia`** albo linków bez wyjaśnienia związku.

## Operacje (wywoływane hasłem)

### `ingest [plik]`

Przeczytaj wskazane źródło z `2 - Source Materials/` lub plik z `1 - Raw Notes/`, następnie:

1. Rozłóż treść na **atomowe notatki** wg zasad powyżej.
2. Dla każdego pojęcia sprawdź, czy koncepcja **już istnieje** gdziekolwiek w `5 - Notes/` (wszystkie `Koncepcje/` i moduły). Jeśli tak — linkuj, nie duplikuj; jeśli wymaga uzupełnienia — zaproponuj zmianę.
3. **Zaktualizuj powiązane istniejące notatki** (dopisz linki, skoryguj treść, dodaj do `## Połączenia`).
4. Popraw cross-referencje w obu kierunkach.
5. W frontmatter każdej nowej notatki: `źródło` ze ścieżką do pliku źródłowego.
6. Na końcu pokaż **diff do akceptacji** (nowe pliki + każda zmiana w istniejących). Zapis dopiero po zgodzie.

Plików w `2 - Source Materials/` nie wolno modyfikować. Plik z `1 - Raw Notes/` po zaakceptowanym ingestcie można oznaczyć/usunąć — tylko za zgodą.

### `lint`

Przejdź cały vault (`5 - Notes/` + indeksy) i wypisz raport:

- **martwe wikilinki** — `[[linki]]` do nieistniejących plików,
- **notatki-sieroty** — bez żadnych linków przychodzących,
- **zduplikowane koncepcje** między modułami (to samo pojęcie w dwóch miejscach),
- **sprzeczności** między notatkami (twierdzenia, które się wykluczają — podaj obie lokalizacje i cytaty),
- **luki** — pojęcia często linkowane, dla których nie istnieje notatka,
- dodatkowo: brakujący frontmatter / brak pola `źródło` / brak `## Połączenia`.

**Tylko raport — niczego nie zmieniaj bez wyraźnej zgody.** Po raporcie zaproponuj kolejność napraw.

### `nowa notatka [pojęcie]`

Pojedyncza notatka koncepcji/zadania wg tych samych zasad: sprawdzenie duplikatów → atomowość → frontmatter ze `źródło` → callouty → `## Połączenia` → aktualizacja notatek powiązanych → diff do akceptacji.

## Zasady bezpieczeństwa (zawsze)

- Zmiany w **istniejących** notatkach: najpierw diff, zapis po akceptacji.
- Niczego nie kasuj i nie nadpisuj bez pytania. `2 - Source Materials/` jest nietykalne.
- Nie zmieniaj uprawnień plików, nie rób operacji nieodwracalnych.
- Commituj po sensownych etapach pracy (git jest siatką bezpieczeństwa — vault ma auto-backupy pluginu Obsidian Git, nie nadpisuj jego konfiguracji).
