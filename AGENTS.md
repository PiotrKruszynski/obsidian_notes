# AGENTS.md — konstytucja vaultu (LLM Wiki)

Ten vault to LLM Wiki w trzech warstwach (wzorzec Karpathy'ego):

1. **Źródła niemutowalne** — `2 - Source Materials/` (agent tylko czyta)
2. **Wiki utrzymywane przez agenta** — `5 - Notes/` (atomowe notatki, ciągle aktualizowane)
3. **Schema** — ten plik (konwencje, operacje, zasady)

Rola agenta: nie tylko tworzyć nowe notatki, ale **ciągle utrzymywać istniejące** — aktualizować, łapać sprzeczności, wykrywać braki i duplikaty, poprawiać cross-referencje. Wiki ma się starzeć w stronę spójności, nie entropii.

Język vaultu: **polski** (terminy techniczne po angielsku).

## Struktura vaultu

| Folder                  | Rola                                                                                                                                 |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `1 - Raw Notes/`        | **Inbox** — ulotne wnioski z sesji nauki, bałagan do rozłożenia przez `ingest`. Po przetworzeniu można czyścić.                      |
| `2 - Source Materials/` | **Raw / źródła niemutowalne** — PDF-y, artykuły, transkrypty, dumpy. TYLKO DO CZYTANIA: agent nie edytuje, nie kasuje, nie przenosi. |
| `3 - Indexes/`          | Indeksy / MOC-e przekrojowe.                                                                                                         |
| `4 - Templates/`        | Szablony notatek (Concept Note, AWS Service, MOC...).                                                                                |
| `5 - Notes/`            | **Wiki właściwe** — atomowe notatki w folderach modułów.                                                                             |
| `6 - Commands/`         | Cheatsheety komend.                                                                                                                  |
| `7 - Assets/`           | Załączniki, obrazy.                                                                                                                  |
| `8 - Daily/`            | Notatki dzienne.                                                                                                                     |
| `9 - Prompt template/`  | Szablony promptów.                                                                                                                   |

W `5 - Notes/` foldery modułów: `Python/`, `AWS/`, `Bazy-Danych/`, `Sieci/`, `Testy/`, `C/`, `Docker/`, `AI-ML/`, `Algorytmy/`, `FastAPI-vault/`, `Projekty/` (per projekt, np. `Projekty/fastapi-rekrutacja/`).

### Koncepcje — jedna koncepcja istnieje raz

Foldery `Koncepcje/` żyją **per moduł** (np. `Python/Koncepcje/`, `Bazy-Danych/Koncepcje/`). Konwencja:

- Koncepcja istnieje w **jednym miejscu** w całym vaulcie i jest reużywana przez linkowanie.
- Przed utworzeniem nowej notatki koncepcji agent MUSI przeszukać **wszystkie** foldery `Koncepcje/` (i całe `5 - Notes/`) pod kątem istniejącej notatki o tym pojęciu. Jeśli istnieje — linkuj `[[...]]`, nie duplikuj. Jeśli istnieje, ale jest niepełna — zaproponuj aktualizację (diff).
- Pojęcie ogólne (np. GIL, ACID) trafia do `Koncepcje/` modułu tematycznego; notatka specyficzna dla projektu — do folderu projektu, z linkami do koncepcji ogólnych.
- **Nazwy plików unikalne w całym vaulcie** (wikilinki Obsidian rozwiązują po nazwie pliku).

## Zasady atomowości (styl: krótkie notatki pod powtórki)

Cel notatki: dać się ponownie przeczytać w ~30 sekund przy codziennej powtórce.
Notatka, której nie da się tak przeczytać, nie będzie czytana wcale. Głębia
siedzi w grafie linków, nie w pojedynczym pliku.

- **Jedna notatka = jedna myśl.** Tytuł nazywa tę jedną myśl. Jeśli tytuł wymaga "i"/"oraz" łączącego dwa pojęcia — to dwie notatki.
- **Bullety, nie akapity.** Każdy punkt to jedna linia: hasło + rozwinięcie po myślniku, gdy samo hasło nie wystarcza. Zero prozy wykładowej.
- **Limit ~15 linii treści.** Wychodzi dłużej → podziel na dwie notatki i połącz linkiem.
- **Głębia przez linki.** Coś wymaga dłuższego tłumaczenia → osobna notatka `[[...]]`, nie dodatkowy akapit.
- **Duży temat → hub + atomy.** Temat kryjący wiele pojęć (np. AWS IAM) dostaje krótki hub (definicja 2–3 bullety + TL;DR + Połączenia) i osobne atomowe notatki podpojęć; pułapki/exam trapy jako `[!warning]` w notatce, której dotyczą.
- **Notatka samodzielna**: zrozumiała bez czytania innych. Kontekst dopowiadają linki, nie kolejność czytania.
- **Gęste linkowanie** `[[wikilinkami]]` w treści, wszędzie gdzie pada powiązane pojęcie.
- **Każda notatka kończy się sekcją `## Połączenia`** — lista linków, każdy z pół zdaniem wyjaśnienia, czemu pojęcia są powiązane. Sam link bez wyjaśnienia się nie liczy.

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

Nie zgaduj proweniencji wstecz. Przy uzupełnianiu starych notatek, dla których prawdziwe źródło nie jest znane, użyj wartości `"nieznane (sprzed LLM Wiki)"` zamiast przypisywać im fałszywe źródło. Fałszywa proweniencja jest gorsza niż brak.

Jeśli agent dopisuje do starej notatki nową treść od siebie (np. nowe bullety, callouty, `## Połączenia`, poprawki cross-linków), ta nowa treść też ma proweniencję. Dodaj albo uzupełnij pole:

```yaml
źródło_uzupełnień: ["sesja LLM, GPT-5 Codex, 2026-06-10"]
```

Nie mieszaj tego z pierwotnym `źródło`: `źródło` opisuje skąd pochodzi rdzeń notatki, a `źródło_uzupełnień` opisuje późniejsze dopiski agenta.

## Powtórki (SM-2) — pola sr_*

Vault ma system powtórek oparty o SM-2: skrypt `sr.py` w root (sesja: `python3 sr.py`,
raport: `python3 sr.py stats`), historia ocen w `.sr_log.csv`.

- Polami `sr_due / sr_last / sr_grade / sr_interval / sr_ease / sr_reps / sr_lapses`
  zarządza **wyłącznie skrypt** — przy edycji notatki zachowaj je bez zmian
  (nie przepisuj, nie kasuj, nie "poprawiaj" dat).
- Nowa notatka koncepcji dostaje inicjalizację: `sr_due:` data utworzenia,
  `sr_interval: 0`, `sr_ease: 2.5`, `sr_reps: 0`, `sr_lapses: 0` — dzięki temu
  od razu wchodzi do kolejki powtórek.
- MOC-e (`type: moc`) i pliki `00 — ...` nie podlegają powtórkom.

## Callouty Obsidian — opcjonalne, max 2 linie

- `> [!warning]` — **realna pułapka z konkretnym skutkiem** ("jeśli zrobisz X, stanie się Y"), nie ogólnikowe "uważaj".
- `> [!tip]` — sztuczka pamięciowa, skojarzenie, mnemonik.
- `> [!example]` — mini-przykład (1–2 linie).

Bez `> [!summary]` — krótka notatka sama jest swoim streszczeniem. Callout
wymagający akapitu tłumaczenia to materiał na osobną notatkę.

## Czego unikać

- **Notatek-katalogów**: ściana kodu/komend zamiast tłumaczenia. Kod ilustruje myśl, nie zastępuje jej.
- **Akapitów prozy i "wykładów"** — notatka to bullety.
- **Notatek ponad limit** — tnij na atomy zamiast rozwlekać.
- **Calloutów dłuższych niż 2 linie.**
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
- **notatki ponad limit** (~15 linii treści) albo z akapitami prozy — kandydaci
  do cięcia na atomy: raport z propozycją podziału, cięcie dopiero po akceptacji,
- dodatkowo: brakujący frontmatter / brak pola `źródło` / brak `## Połączenia`.

Resolver wikilinków MUSI działać jak Obsidian, nie jak prosty skaner `.md`:

- sprawdzaj cały vault, nie tylko notatki `.md`;
- uwzględnij `7 - Assets/` oraz inne załączniki;
- rozpoznawaj basename z rozszerzeniem (`![[obraz.png]]`), basename bez rozszerzenia (`[[Notatka]]`), ścieżki względne i ścieżki od root vaultu;
- link do istniejącego assetu nie jest luką koncepcyjną.

Zanim uznasz martwy wikilink za lukę do napisania, wykonaj mapowanie:

1. `martwy link → istniejąca podobna notatka/asset`;
2. oznacz wynik jako `do przelinkowania`, jeśli istnieje bliska notatka (np. `[[Typy baz danych]]` → `[[types of databases]]`, `[[Indeks — koszt i korzyść]]` → bliska notatka o indeksach);
3. dopiero linki bez sensownego istniejącego celu raportuj jako **luki**.

Nie twórz nowej notatki tylko dlatego, że wikilink jest martwy. Martwy link często oznacza rename, zmianę języka tytułu albo niekonsekwentny alias — i najpierw trzeba go naprawić przez przelinkowanie.

**Tylko raport — niczego nie zmieniaj bez wyraźnej zgody.** Po raporcie zaproponuj kolejność napraw.

### `nowa notatka [pojęcie]`

Pojedyncza notatka koncepcji/zadania wg tych samych zasad: sprawdzenie duplikatów → atomowość → frontmatter ze `źródło` → callouty → `## Połączenia` → aktualizacja notatek powiązanych → diff do akceptacji.

### `znajdź [pytanie]`

Wyszukiwanie wiedzy w vaulcie — operacja **tylko do odczytu**:

1. Szukaj odpowiedzi **wyłącznie w notatkach vaultu** (`5 - Notes/`, indeksy, ew. `2 - Source Materials/`) — NIE odpowiadaj z własnej wiedzy modelu.
2. Zawsze podawaj **ścieżki do plików** + jedno zdanie, co w którym jest.
3. Synteza z wielu notatek jest OK, ale tylko z ich treści i z listą plików źródłowych.
4. Jeśli odpowiedzi w vaulcie nie ma — powiedz wprost: **„brak notatki — to luka"** i zaproponuj `nowa notatka [pojęcie]`. Nie maskuj braku własną wiedzą.
5. Jeśli Twoja wiedza przeczy treści notatki — nie poprawiaj po cichu; zgłoś jako potencjalną sprzeczność do weryfikacji (z proweniencją notatki).

### `odpowiedz [pytanie]`

Merytoryczna odpowiedź na pytanie, której źródłem jest vault (nie wiedza modelu) — operacja **tylko do odczytu**:

1. Odpowiedz na pytanie treściwie, ale buduj odpowiedź **wyłącznie z treści notatek** (`5 - Notes/`, ew. `2 - Source Materials/`). Synteza z wielu notatek jest pożądana.
2. Nie dolewaj wiedzy modelu spoza notatek. Jeśli notatki pokrywają temat częściowo — odpowiedz tym, co jest, i powiedz wprost, czego w vaulcie brakuje.
3. Na końcu odpowiedzi sekcja **Źródła:** z listą ścieżek użytych notatek.
4. Jeśli vault nie pokrywa tematu wcale — nie odpowiadaj z głowy: zgłoś lukę i zaproponuj `nowa notatka [pojęcie]`.
5. Gdy Twoja wiedza przeczy treści notatki — odpowiedz wg notatki, ale jawnie zaznacz potencjalną sprzeczność do weryfikacji.

Różnica względem `znajdź`: `znajdź` mówi GDZIE wiedza leży, `odpowiedz` mówi CO z niej wynika. Pierwsze do nawigacji, drugie do powtórek i sprawdzania własnego zrozumienia.

### `ćwicz [temat]`

Praktyka, która zasila wiki (nie żyje obok niej):

1. Zadania buduj **wokół koncepcji istniejących w vaulcie** i linkuj je w treści zadania (`[[...]]`). Pojęcie potrzebne do zadań, ale bez notatki → zgłoś jako lukę, nie przemycaj po cichu.
2. Trudność stopniuj ★–★★★★. Zadania na realnej bazie (SQL: Sakila — setup i serie w `5 - Notes/Bazy-Danych/Cwiczenia-Sakila/`).
3. **Nie pokazuj rozwiązania, zanim użytkownik nie pokaże swojej próby.** Potem oceń: poprawność wyniku, pułapki (NULL-e, duplikaty, brakujące JOIN-y), czytelność, wydajność (EXPLAIN, gdy ma sens).
4. Po sesji zaproponuj domknięcie pętli: błąd użytkownika → `[!warning]` z realnym skutkiem do notatki koncepcji; zaskoczenie/trik → `[!tip]`; rozwiązania i wnioski → sekcja „Moje rozwiązania i wnioski" w notatce serii. Wszystko jako diff do akceptacji.
5. Nowa seria zadań = nowa notatka wg wzoru istniejących serii (frontmatter, `źródło`, zadania z linkami, sekcja wniosków, `## Połączenia`).

## Zasady bezpieczeństwa (zawsze)

- Zmiany w **istniejących** notatkach: najpierw diff, zapis po akceptacji.
- Niczego nie kasuj i nie nadpisuj bez pytania. `2 - Source Materials/` jest nietykalne.
- Nie zmieniaj uprawnień plików, nie rób operacji nieodwracalnych.
- Commituj po sensownych etapach pracy (git jest siatką bezpieczeństwa — vault ma auto-backupy pluginu Obsidian Git, nie nadpisuj jego konfiguracji).
