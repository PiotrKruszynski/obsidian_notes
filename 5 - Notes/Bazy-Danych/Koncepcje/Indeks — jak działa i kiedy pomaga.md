---
tags: ["sql"]
powiązane: ["[[Klucz główny i obcy]]", "[[SELECT i filtrowanie (WHERE)]]", "[[JOIN — typy i co zwracają]]"]
sr_due: 2026-07-09
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Indeks — jak działa i kiedy pomaga

> [!summary] W jednym zdaniu
> Indeks to dodatkowa struktura (zwykle B-drzewo), która pozwala bazie znaleźć wiersze bez skanowania całej tabeli — przyspiesza odczyt po danej kolumnie kosztem wolniejszych zapisów i miejsca.

Analogia: indeks w bazie działa jak skorowidz na końcu książki. Bez niego, żeby znaleźć wszystkie strony o "rekurencji", czytasz całą książkę (full table scan). Ze skorowidzem skaczesz prosto do właściwych stron.

Technicznie to najczęściej **B-drzewo** — struktura posortowana, w której wyszukiwanie, wstawianie i zakres działają w czasie logarytmicznym zamiast liniowego przeglądania wszystkich wierszy.

Kiedy indeks pomaga:
- `WHERE col = ...` / zakresy `BETWEEN` na kolumnie indeksowanej,
- `JOIN ... ON col` (łączenie po indeksowanej kolumnie),
- `ORDER BY col` (indeks bywa już posortowany).

Koszt, o którym trzeba wspomnieć na rozmowie:
- **Wolniejsze zapisy** — każdy INSERT/UPDATE/DELETE musi też zaktualizować indeksy.
- **Miejsce na dysku** — indeks to dodatkowe dane.
- Zbyt wiele indeksów szkodzi tabelom intensywnie zapisywanym.

> [!warning] Kiedy indeks bardziej szkodzi niż pomaga
> - Kolumna z niską selektywnością (np. `gender` — tylko 2 wartości) — full scan bywa szybszy, bo planner i tak odczyta większość tabeli.
> - Tabela intensywnie zapisywana z małą liczbą odczytów — każdy INSERT aktualizuje wszystkie indeksy.
> - MySQL `ALTER TABLE` na dużej tabeli = kopiowanie całości (może trwać godziny); PostgreSQL robi to lepiej.

> [!warning] Kiedy indeks NIE pomoże
> - Funkcja na kolumnie: `WHERE YEAR(created_at) = 2024` zwykle psuje użycie indeksu na `created_at` (chyba że jest indeks funkcyjny). Lepiej `WHERE created_at >= '2024-01-01' AND created_at < '2025-01-01'`.
> - `LIKE '%abc'` (wzorzec zaczynający się od `%`) — indeks nie pomoże, bo nie zna początku.
> - Bardzo mała tabela — pełny skan i tak jest tani.

> [!tip] Odpowiedź na "jak działa indeks"
> "Posortowana struktura (B-drzewo), która zamienia pełny skan na wyszukiwanie logarytmiczne; przyspiesza odczyt po kolumnie, ale spowalnia zapisy i zajmuje miejsce." Dorzuć przykład psucia indeksu funkcją — robi wrażenie.

## Połączenia
- [[B-Tree — jak SQL przechowuje dane]] — fizyczna struktura indeksu (DDIA)
- [[LSM-Tree vs B-Tree — porównanie]] — alternatywa write-heavy
- [[LSM-Tree vs B-Tree — porównanie]] — alternatywa dla obciążeń write-heavy
- [[Klucz główny i obcy]] — PK zwykle ma indeks automatycznie
- [[SELECT i filtrowanie (WHERE)]] — indeks działa na warunkach WHERE
- [[JOIN — typy i co zwracają]] — indeks na kolumnie łączenia
