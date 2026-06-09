---
tags: ["sql"]
powiązane: ["[[SELECT i filtrowanie (WHERE)]]", "[[Agregacje i GROUP BY]]"]
---

# UNION, DISTINCT i czyszczenie wyniku

> [!summary] W jednym zdaniu
> `DISTINCT` usuwa duplikaty wierszy, `UNION` skleja wyniki dwóch zapytań **usuwając duplikaty**, a `UNION ALL` skleja **zachowując** duplikaty (i jest szybszy).

**DISTINCT** — odsiewa powtórzone wiersze wyniku:
```sql
SELECT DISTINCT country FROM users;   -- każdy kraj raz
```

**UNION vs UNION ALL** — częste pytanie z subtelną różnicą:
```sql
SELECT city FROM customers
UNION ALL                 -- albo UNION
SELECT city FROM suppliers;
```
- `UNION` — łączy i **usuwa duplikaty** (musi posortować/zahaszować → wolniej).
- `UNION ALL` — łączy i **zostawia wszystko** (szybciej, bo nie deduplikuje).

> [!tip] Co odpowiedzieć
> "UNION usuwa duplikaty i przez to robi dodatkową pracę; UNION ALL nie deduplikuje, więc jest szybszy — używaj ALL, jeśli wiesz, że duplikatów nie ma albo Cię nie przeszkadzają." Drobna uwaga, ale pokazuje świadomość kosztu.

> [!warning] Warunki UNION
> Oba zapytania muszą mieć **tę samą liczbę kolumn** i zgodne typy, w tej samej kolejności. Nazwy kolumn bierze się z pierwszego zapytania.

## Połączenia
- [[SELECT i filtrowanie (WHERE)]] — UNION łączy wyniki SELECT-ów
- [[Agregacje i GROUP BY]] — alternatywny sposób na deduplikację/zliczenia
