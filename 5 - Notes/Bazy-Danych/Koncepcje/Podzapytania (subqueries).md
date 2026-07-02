---
tags: ["sql"]
powiązane: ["[[EXISTS kontra IN]]", "[[CTE (WITH)]]", "[[Agregacje i GROUP BY]]"]
sr_due: 2026-07-21
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Podzapytania (subqueries)

> [!summary] W jednym zdaniu
> Podzapytanie to zapytanie w zapytaniu; bywa **skalarne** (zwraca jedną wartość), **wielowierszowe** (do IN/EXISTS) albo **skorelowane** (odwołuje się do wiersza z zapytania zewnętrznego i wykonuje się dla każdego z nich).

**Skalarne** — zwraca jedną wartość, użyjesz jak liczby:
```sql
SELECT title FROM film
WHERE length > (SELECT AVG(length) FROM film);
```

**Wielowierszowe** — zwraca kolumnę wartości, do `IN` / `ANY` / `EXISTS`:
```sql
SELECT first_name, last_name FROM customer
WHERE customer_id IN (SELECT customer_id FROM rental);
```

**Skorelowane** — podzapytanie zależy od wiersza zewnętrznego, więc wykonuje się **raz na każdy** taki wiersz:
```sql
SELECT c.first_name FROM customer c
WHERE EXISTS (SELECT 1 FROM rental r WHERE r.customer_id = c.customer_id);
```
`r.customer_id = c.customer_id` odwołuje się do `c` z zewnątrz — to czyni je skorelowanym.

> [!warning] Wydajność skorelowanych
> Skorelowane podzapytanie potrafi działać dla każdego wiersza zewnętrznego — przy dużych tabelach drogo. Często da się je zamienić na [[JOIN — typy i co zwracają|JOIN]] albo [[CTE (WITH)|CTE]] dla czytelności i szybkości. To dobry temat na rozmowie ("jak byś to zoptymalizował").

> [!tip] IN vs EXISTS
> Dla "czy istnieje powiązany wiersz" zwykle lepszy `EXISTS` niż `IN` — zwłaszcza przy NULL-ach. Patrz [[EXISTS kontra IN]].

## Połączenia
- [[EXISTS kontra IN]] — który wybrać i pułapka NULL
- [[CTE (WITH)]] — czytelniejsza alternatywa dla zagnieżdżeń
- [[Agregacje i GROUP BY]] — podzapytania często liczą agregaty
