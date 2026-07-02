---
tags: ["sql"]
powiązane: ["[[Logiczna kolejność wykonania zapytania]]", "[[NULL i logika trójwartościowa]]", "[[Agregacje i GROUP BY]]"]
sr_due: 2026-07-16
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# SELECT i filtrowanie (WHERE)

> [!summary] W jednym zdaniu
> `SELECT` wybiera kolumny, `FROM` źródło, `WHERE` odfiltrowuje wiersze po warunku — to szkielet każdego zapytania odczytującego dane.

```sql
SELECT first_name, email
FROM customer
WHERE store_id = 1 AND active = 1;
```
- `SELECT` — które kolumny (lub wyrażenia) zwrócić. `SELECT *` bierze wszystkie.
- `FROM` — z jakiej tabeli (lub połączenia tabel).
- `WHERE` — warunek; wiersz wchodzi do wyniku tylko, gdy warunek jest **prawdą** (TRUE). To istotne przy [[NULL i logika trójwartościowa|NULL-ach]].

Operatory w `WHERE`: porównania (`=`, `<>`, `<`, `>=`), `BETWEEN a AND b`, `IN (...)`, `LIKE 'A%'` (wzorce: `%` = dowolny ciąg, `_` = jeden znak), `AND`/`OR`/`NOT`.

> [!warning] Pułapka NULL w WHERE
> `WHERE col = NULL` **nigdy** nie zwróci wierszy — porównanie z NULL daje UNKNOWN, nie TRUE. Do NULL-i służy `IS NULL` / `IS NOT NULL`. Szczegóły: [[NULL i logika trójwartościowa]].

> [!tip] Aliasy
> `SELECT rental_rate * rental_duration AS koszt FROM film` nazywa wynik `koszt`. Ale aliasu nie użyjesz w `WHERE` (powstaje za późno) — patrz [[Logiczna kolejność wykonania zapytania]].

## Połączenia
- [[Logiczna kolejność wykonania zapytania]] — gdzie WHERE jest w kolejności
- [[NULL i logika trójwartościowa]] — czemu `= NULL` nie działa
- [[Agregacje i GROUP BY]] — następny krok po filtrowaniu
