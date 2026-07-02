---
tags: ["sql"]
powiązane: ["[[SELECT i filtrowanie (WHERE)]]", "[[Agregacje i GROUP BY]]"]
sr_due: 2026-07-02
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# CASE WHEN

> [!summary] W jednym zdaniu
> `CASE WHEN` to "if/else" wewnątrz zapytania — zwraca różne wartości zależnie od warunku; jego najmocniejsze rozmowowe zastosowanie to **liczenie warunkowe** (conditional aggregation).

Składnia (Sakila):
```sql
SELECT title,
       CASE
           WHEN length < 60  THEN 'krótki'
           WHEN length < 120 THEN 'normalny'
           ELSE 'długi'
       END AS kategoria
FROM film;
```
Każdy `WHEN` sprawdzany po kolei; pierwszy prawdziwy wygrywa; `ELSE` to wartość domyślna (bez `ELSE` niedopasowane dają [[NULL i logika trójwartościowa|NULL]]).

**Conditional aggregation — sztuczka, którą rozmówcy uwielbiają.** Łączysz `CASE` z [[Agregacje i GROUP BY|agregatem]], żeby policzyć podzbiory w jednym przejściu, bez wielu zapytań:
```sql
SELECT
  COUNT(*)                                                  AS wszystkie,
  SUM(CASE WHEN return_date IS NULL     THEN 1 ELSE 0 END) AS niezwrocone,
  SUM(CASE WHEN return_date IS NOT NULL THEN 1 ELSE 0 END) AS zwrocone
FROM rental;
```
To jeden skan tabeli zamiast trzech osobnych `COUNT ... WHERE`. Często pojawia się jako "policz X i Y w jednym zapytaniu" albo jako ręczny **pivot** (zamiana wierszy w kolumny).

> [!tip] Pytanie rozmowowe
> "Jak policzyć w jednym zapytaniu wypożyczenia zwrócone i niezwrócone?" → `SUM(CASE WHEN ... THEN 1 ELSE 0 END)` dla każdego stanu. Pokazanie tej sztuczki od razu sygnalizuje, że nie myślisz "jedno zapytanie = jeden warunek".

> [!warning] CASE zwraca jeden typ
> Wszystkie gałęzie `THEN`/`ELSE` powinny dawać zgodny typ. Mieszanie liczby i tekstu w gałęziach potrafi rzucić błąd albo wymusić niejawną konwersję.

## Połączenia
- [[SELECT i filtrowanie (WHERE)]] — CASE żyje w SELECT (i nie tylko)
- [[Agregacje i GROUP BY]] — conditional aggregation: CASE w środku agregatu
