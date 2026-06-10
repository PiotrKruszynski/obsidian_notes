---
tags: ["sql"]
powiązane: ["[[Podzapytania (subqueries)]]", "[[NULL i logika trójwartościowa]]"]
---

# EXISTS kontra IN

> [!summary] W jednym zdaniu
> `IN` sprawdza przynależność do listy wartości, `EXISTS` sprawdza, czy podzapytanie zwraca cokolwiek — różnią się zachowaniem przy [[NULL i logika trójwartościowa|NULL]] i często wydajnością.

```sql
-- IN: czy customer_id jest w zbiorze wypożyczających
SELECT first_name, last_name FROM customer
WHERE customer_id IN (SELECT customer_id FROM rental);

-- EXISTS: czy istnieje pasujące wypożyczenie
SELECT first_name, last_name FROM customer c
WHERE EXISTS (SELECT 1 FROM rental r WHERE r.customer_id = c.customer_id);
```

> [!warning] Pułapka NOT IN z NULL (klasyk rozmów)
> Jeśli podzapytanie w `NOT IN (...)` zwróci choć **jeden NULL**, całe `NOT IN` może dać **zero wyników**. Bo `x NOT IN (a, NULL)` rozwija się do `x<>a AND x<>NULL`, a `x<>NULL` to UNKNOWN — więc nigdy nie TRUE. `NOT EXISTS` tej pułapki nie ma. Stąd reguła: **do negacji używaj `NOT EXISTS`, nie `NOT IN`**, gdy kolumna może być NULL.

> [!tip] Wydajność
> `EXISTS` często kończy pracę, gdy znajdzie pierwsze dopasowanie ("short-circuit"), więc dla "czy istnieje" bywa szybszy. `IN` z małą, stałą listą wartości jest natomiast czytelny i szybki. Na rozmowie: "EXISTS dla sprawdzenia istnienia i przy ryzyku NULL; IN dla małych list wartości".

## Połączenia
- [[Podzapytania (subqueries)]] — oba to formy podzapytań
- [[NULL i logika trójwartościowa]] — źródło pułapki NOT IN
