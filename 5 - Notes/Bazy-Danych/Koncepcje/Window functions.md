---
tags: ["sql"]
powiązane: ["[[Agregacje i GROUP BY]]", "[[CTE (WITH)]]", "[[Logiczna kolejność wykonania zapytania]]"]
---

# Window functions

> [!summary] W jednym zdaniu
> Funkcje okienkowe liczą wartość "po grupie" wierszy, ale — w przeciwieństwie do [[Agregacje i GROUP BY|GROUP BY]] — **nie zwijają** wierszy: każdy wiersz zostaje, a dochodzi dodatkowa kolumna wyniku.

To ulubiony temat rozmów na poziomie mid/senior, bo odróżnia "umiem SELECT" od "rozumiem SQL".

```sql
SELECT title, rating, rental_rate,
       AVG(rental_rate) OVER (PARTITION BY rating) AS avg_w_ratingu,
       RANK()           OVER (PARTITION BY rating ORDER BY rental_rate DESC) AS rnk
FROM film;
```
- `OVER (...)` zamienia funkcję w okienkową — definiuje "okno" wierszy, na którym liczy.
- `PARTITION BY rating` — dziel na okna wg ratingu (jak GROUP BY, ale bez zwijania).
- `ORDER BY rental_rate DESC` wewnątrz OVER — porządkuje wiersze w oknie (potrzebne do rankingów).

Najczęściej pytane funkcje rankingowe:
- `ROW_NUMBER()` — kolejny numer, zawsze unikalny (1,2,3,4).
- `RANK()` — remisy dostają ten sam numer, potem **dziura** (1,2,2,4).
- `DENSE_RANK()` — remisy ten sam numer, **bez dziury** (1,2,2,3).

> [!example] Klasyczne zadanie: "najdroższy film w każdym ratingu"
> ```sql
> SELECT * FROM (
>   SELECT title, rating, rental_rate,
>          ROW_NUMBER() OVER (PARTITION BY rating ORDER BY rental_rate DESC) rn
>   FROM film
> ) t
> WHERE rn = 1;
> ```
> Okienko numeruje filmy w ratingu wg stawki; bierzesz `rn = 1`. Filtr po `rn` musi być na zewnątrz (w podzapytaniu/[[CTE (WITH)|CTE]]), bo funkcji okienkowej nie użyjesz w WHERE — powstaje na etapie SELECT ([[Logiczna kolejność wykonania zapytania]]).

> [!tip] Różnica od GROUP BY w jednym zdaniu
> "GROUP BY zwija grupę w jeden wiersz; window function liczy to samo, ale zostawia wszystkie wiersze i dokłada kolumnę." To zdanie często wystarcza na rozmowie.

## Połączenia
- [[Agregacje i GROUP BY]] — kontrast: zwijanie vs zachowanie wierszy
- [[CTE (WITH)]] — gdzie schować okno, by filtrować po jego wyniku
- [[Logiczna kolejność wykonania zapytania]] — czemu nie w WHERE
