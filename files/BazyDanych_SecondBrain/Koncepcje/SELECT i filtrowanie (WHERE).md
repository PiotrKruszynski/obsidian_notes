---
tags: [sql, koncepcja, fundament]
powiązane: ["[[Logiczna kolejność wykonania zapytania]]", "[[NULL i logika trójwartościowa]]", "[[Agregacje i GROUP BY]]"]
---

# SELECT i filtrowanie (WHERE)

> [!summary] W jednym zdaniu
> `SELECT` wybiera kolumny, `FROM` źródło, `WHERE` odfiltrowuje wiersze po warunku — to szkielet każdego zapytania odczytującego dane.

```sql
SELECT name, email
FROM users
WHERE country = 'PL' AND active = TRUE;
```
- `SELECT` — które kolumny (lub wyrażenia) zwrócić. `SELECT *` bierze wszystkie.
- `FROM` — z jakiej tabeli (lub połączenia tabel).
- `WHERE` — warunek; wiersz wchodzi do wyniku tylko, gdy warunek jest **prawdą** (TRUE). To istotne przy [[NULL i logika trójwartościowa|NULL-ach]].

Operatory w `WHERE`: porównania (`=`, `<>`, `<`, `>=`), `BETWEEN a AND b`, `IN (...)`, `LIKE 'A%'` (wzorce: `%` = dowolny ciąg, `_` = jeden znak), `AND`/`OR`/`NOT`.

> [!warning] Pułapka NULL w WHERE
> `WHERE col = NULL` **nigdy** nie zwróci wierszy — porównanie z NULL daje UNKNOWN, nie TRUE. Do NULL-i służy `IS NULL` / `IS NOT NULL`. Szczegóły: [[NULL i logika trójwartościowa]].

> [!tip] Aliasy
> `SELECT price * qty AS total` nazywa wynik `total`. Ale aliasu nie użyjesz w `WHERE` (powstaje za późno) — patrz [[Logiczna kolejność wykonania zapytania]].

## Połączenia
- [[Logiczna kolejność wykonania zapytania]] — gdzie WHERE jest w kolejności
- [[NULL i logika trójwartościowa]] — czemu `= NULL` nie działa
- [[Agregacje i GROUP BY]] — następny krok po filtrowaniu
