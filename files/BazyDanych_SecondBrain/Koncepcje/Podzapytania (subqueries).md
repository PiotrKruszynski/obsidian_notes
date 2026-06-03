---
tags: [sql, koncepcja, średni]
powiązane: ["[[EXISTS kontra IN]]", "[[CTE (WITH)]]", "[[Agregacje i GROUP BY]]"]
---

# Podzapytania (subqueries)

> [!summary] W jednym zdaniu
> Podzapytanie to zapytanie w zapytaniu; bywa **skalarne** (zwraca jedną wartość), **wielowierszowe** (do IN/EXISTS) albo **skorelowane** (odwołuje się do wiersza z zapytania zewnętrznego i wykonuje się dla każdego z nich).

**Skalarne** — zwraca jedną wartość, użyjesz jak liczby:
```sql
SELECT name FROM users
WHERE age > (SELECT AVG(age) FROM users);
```

**Wielowierszowe** — zwraca kolumnę wartości, do `IN` / `ANY` / `EXISTS`:
```sql
SELECT name FROM users
WHERE id IN (SELECT user_id FROM orders);
```

**Skorelowane** — podzapytanie zależy od wiersza zewnętrznego, więc wykonuje się **raz na każdy** taki wiersz:
```sql
SELECT u.name FROM users u
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id);
```
`o.user_id = u.id` odwołuje się do `u` z zewnątrz — to czyni je skorelowanym.

> [!warning] Wydajność skorelowanych
> Skorelowane podzapytanie potrafi działać dla każdego wiersza zewnętrznego — przy dużych tabelach drogo. Często da się je zamienić na [[JOIN — typy i co zwracają|JOIN]] albo [[CTE (WITH)|CTE]] dla czytelności i szybkości. To dobry temat na rozmowie ("jak byś to zoptymalizował").

> [!tip] IN vs EXISTS
> Dla "czy istnieje powiązany wiersz" zwykle lepszy `EXISTS` niż `IN` — zwłaszcza przy NULL-ach. Patrz [[EXISTS kontra IN]].

## Połączenia
- [[EXISTS kontra IN]] — który wybrać i pułapka NULL
- [[CTE (WITH)]] — czytelniejsza alternatywa dla zagnieżdżeń
- [[Agregacje i GROUP BY]] — podzapytania często liczą agregaty
