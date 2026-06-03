# Indeks — koszt i korzyść

> [!summary]
> Indeks przyspiesza odczyty kosztem wolniejszych zapisów. Każdy indeks to dodatkowa struktura, którą baza musi aktualizować przy każdym INSERT/UPDATE/DELETE.

## Co to jest indeks

Dodatkowa struktura danych (zwykle B-Tree) trzymana obok tabeli. Mapuje wartość kolumny → fizyczną lokalizację wiersza.

Bez indeksu: `SELECT * FROM users WHERE email = 'a@b.com'` → full table scan (wszystkie wiersze).
Z indeksem: → B-Tree lookup → O(log n) zamiast O(n).

## Trade-off

> [!warning]
> Indeks **zawsze** spowalnia zapisy. Przy `INSERT INTO users VALUES (...)` baza musi zaktualizować każdy indeks na tej tabeli. Tabela z 10 indeksami = 10x więcej pracy przy każdym wpisie.

To dlatego bazy nie indeksują wszystkiego automatycznie. **Ty musisz wybrać** które kolumny indeksować.

## Kiedy dodać indeks

Dobre kandydatury:
- kolumny w `WHERE` (filtrowanie)
- kolumny w `JOIN ON` (klucze obce)
- kolumny w `ORDER BY` (gdy sort jest często używany)

Złe kandydatury:
- kolumny z małą selektywnością (np. `gender` — tylko 2 wartości, full scan może być szybszy)
- tabele z dużą ilością zapisów i małą ilością odczytów

> [!example]
> Tabela `orders` z 10M wierszy. Zapytanie: `WHERE user_id = 42`.
> - Bez indeksu: skan 10M wierszy
> - Z indeksem na `user_id`: ~4 odczyty stron (B-Tree, 4 poziomy)
> 
> Ale każdy `INSERT` do `orders` → aktualizacja indeksu. Jeśli wstawiasz 100k zamówień/s — indeks to realne obciążenie.

## Primary Key vs Secondary Index

- **Primary key** — unikalny, wiersze fizycznie posortowane wg PK (clustered index w InnoDB). Odczyt po PK = bezpośredni dostęp.
- **Secondary index** — wskazuje na PK, potem druga operacja po PK. Dwie operacje zamiast jednej.

## Połączenia
- [[Indeks — jak działa i kiedy pomaga]] — praktyczne użycie i pułapki (co psuje indeks)

- [[B-Tree — jak SQL przechowuje dane]] — fizyczna implementacja indeksu
- [[SQL jako język deklaratywny]] — query optimizer wybiera kiedy użyć indeksu
- [[Normalizacja vs Denormalizacja]] — normalizacja wymaga więcej JOIN = więcej indeksów
