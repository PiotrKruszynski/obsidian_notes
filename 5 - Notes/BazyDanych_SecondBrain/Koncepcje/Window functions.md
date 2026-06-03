---
tags: [sql, koncepcja, zaawansowany, kluczowe]
powiązane: ["[[Agregacje i GROUP BY]]", "[[CTE (WITH)]]", "[[Logiczna kolejność wykonania zapytania]]"]
---

# Window functions

> [!summary] W jednym zdaniu
> Funkcje okienkowe liczą wartość "po grupie" wierszy, ale — w przeciwieństwie do [[Agregacje i GROUP BY|GROUP BY]] — **nie zwijają** wierszy: każdy wiersz zostaje, a dochodzi dodatkowa kolumna wyniku.

To ulubiony temat rozmów na poziomie mid/senior, bo odróżnia "umiem SELECT" od "rozumiem SQL".

```sql
SELECT name, department, salary,
       AVG(salary) OVER (PARTITION BY department) AS avg_dept,
       RANK()      OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
FROM employees;
```
- `OVER (...)` zamienia funkcję w okienkową — definiuje "okno" wierszy, na którym liczy.
- `PARTITION BY department` — dziel na okna wg działu (jak GROUP BY, ale bez zwijania).
- `ORDER BY salary DESC` wewnątrz OVER — porządkuje wiersze w oknie (potrzebne do rankingów).

Najczęściej pytane funkcje rankingowe:
- `ROW_NUMBER()` — kolejny numer, zawsze unikalny (1,2,3,4).
- `RANK()` — remisy dostają ten sam numer, potem **dziura** (1,2,2,4).
- `DENSE_RANK()` — remisy ten sam numer, **bez dziury** (1,2,2,3).

> [!example] Klasyczne zadanie: "top 1 zarobek na dział"
> ```sql
> SELECT * FROM (
>   SELECT name, department, salary,
>          ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) rn
>   FROM employees
> ) t
> WHERE rn = 1;
> ```
> Okienko numeruje pracowników w dziale wg pensji; bierzesz `rn = 1`. Filtr po `rn` musi być na zewnątrz (w podzapytaniu/[[CTE (WITH)|CTE]]), bo funkcji okienkowej nie użyjesz w WHERE — powstaje na etapie SELECT ([[Logiczna kolejność wykonania zapytania]]).

> [!tip] Różnica od GROUP BY w jednym zdaniu
> "GROUP BY zwija grupę w jeden wiersz; window function liczy to samo, ale zostawia wszystkie wiersze i dokłada kolumnę." To zdanie często wystarcza na rozmowie.

## Połączenia
- [[Agregacje i GROUP BY]] — kontrast: zwijanie vs zachowanie wierszy
- [[CTE (WITH)]] — gdzie schować okno, by filtrować po jego wyniku
- [[Logiczna kolejność wykonania zapytania]] — czemu nie w WHERE
