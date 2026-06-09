---
tags: ["sql"]
powiązane: ["[[SELECT i filtrowanie (WHERE)]]", "[[Agregacje i GROUP BY]]"]
---

# CASE WHEN

> [!summary] W jednym zdaniu
> `CASE WHEN` to "if/else" wewnątrz zapytania — zwraca różne wartości zależnie od warunku; jego najmocniejsze rozmowowe zastosowanie to **liczenie warunkowe** (conditional aggregation).

Składnia:
```sql
SELECT name,
       CASE
           WHEN age < 18 THEN 'niepełnoletni'
           WHEN age < 65 THEN 'dorosły'
           ELSE 'senior'
       END AS kategoria
FROM users;
```
Każdy `WHEN` sprawdzany po kolei; pierwszy prawdziwy wygrywa; `ELSE` to wartość domyślna (bez `ELSE` niedopasowane dają [[NULL i logika trójwartościowa|NULL]]).

**Conditional aggregation — sztuczka, którą rozmówcy uwielbiają.** Łączysz `CASE` z [[Agregacje i GROUP BY|agregatem]], żeby policzyć podzbiory w jednym przejściu, bez wielu zapytań:
```sql
SELECT
  COUNT(*)                                        AS wszyscy,
  SUM(CASE WHEN status = 'paid'    THEN 1 ELSE 0 END) AS oplaceni,
  SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) AS oczekujacy
FROM orders;
```
To jeden skan tabeli zamiast trzech osobnych `COUNT ... WHERE`. Często pojawia się jako "policz X i Y w jednym zapytaniu" albo jako ręczny **pivot** (zamiana wierszy w kolumny).

> [!tip] Pytanie rozmowowe
> "Jak policzyć w jednym zapytaniu liczbę zamówień opłaconych i oczekujących?" → `SUM(CASE WHEN ... THEN 1 ELSE 0 END)` dla każdego statusu. Pokazanie tej sztuczki od razu sygnalizuje, że nie myślisz "jedno zapytanie = jeden warunek".

> [!warning] CASE zwraca jeden typ
> Wszystkie gałęzie `THEN`/`ELSE` powinny dawać zgodny typ. Mieszanie liczby i tekstu w gałęziach potrafi rzucić błąd albo wymusić niejawną konwersję.

## Połączenia
- [[SELECT i filtrowanie (WHERE)]] — CASE żyje w SELECT (i nie tylko)
- [[Agregacje i GROUP BY]] — conditional aggregation: CASE w środku agregatu
