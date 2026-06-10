---
tags: ["sql"]
powiązane: ["[[Logiczna kolejność wykonania zapytania]]", "[[WHERE kontra HAVING]]", "[[NULL i logika trójwartościowa]]", "[[Window functions]]"]
---

# Agregacje i GROUP BY

> [!summary] W jednym zdaniu
> Funkcje agregujące (COUNT/SUM/AVG/MIN/MAX) zwijają wiele wierszy w jedną wartość, a `GROUP BY` robi to **osobno dla każdej grupy** — to podstawa raportów i częsty temat rozmów.

```sql
SELECT rating, COUNT(*) AS filmy, AVG(length) AS avg_length
FROM film
GROUP BY rating;
```
`GROUP BY rating` dzieli wiersze na grupy o tej samej wartości `rating`, a agregaty liczą się **w obrębie każdej grupy**. Wynik: jeden wiersz na rating (Sakila: G, PG, PG-13, R, NC-17).

Zasada, którą rozmówcy lubią sprawdzać: **każda kolumna w SELECT musi być albo w GROUP BY, albo wewnątrz agregatu.** Inaczej baza nie wie, którą wartość z grupy pokazać.

Pułapki COUNT (klasyk rozmów):
- `COUNT(*)` — liczy **wiersze**, łącznie z [[NULL i logika trójwartościowa|NULL]]-ami.
- `COUNT(col)` — liczy tylko wiersze, gdzie `col` jest **nie-NULL**.
- `COUNT(DISTINCT col)` — liczy unikalne nie-NULL wartości.

> [!tip] WHERE czy HAVING
> Filtr na pojedynczych wierszach **przed** grupowaniem → WHERE. Filtr na **wyniku agregatu** (np. `COUNT(*) > 5`) → HAVING. Wynika to wprost z [[Logiczna kolejność wykonania zapytania|kolejności wykonania]] — szczegóły w [[WHERE kontra HAVING]].

> [!warning] Agregat a NULL
> `AVG(col)` liczy średnią tylko z nie-NULL wartości — NULL-e są pomijane, nie liczone jako 0. To zmienia wynik i bywa pytane.

## Połączenia
- [[CASE WHEN]] — liczenie warunkowe (conditional aggregation)
- [[Logiczna kolejność wykonania zapytania]] — GROUP BY i HAVING w kolejności
- [[WHERE kontra HAVING]] — gdzie który filtr
- [[NULL i logika trójwartościowa]] — NULL a COUNT/AVG
- [[Window functions]] — agregacja BEZ zwijania wierszy
