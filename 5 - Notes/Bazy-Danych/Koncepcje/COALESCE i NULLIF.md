---
tags: ["sql"]
powiązane: ["[[NULL i logika trójwartościowa]]", "[[CASE WHEN]]"]
---

# COALESCE i NULLIF

> [!summary] W jednym zdaniu
> `COALESCE` zwraca pierwszą nie-[[NULL i logika trójwartościowa|NULL]] wartość z listy (zastępuje NULL czymś sensownym), a `NULLIF` zamienia konkretną wartość z powrotem w NULL — to standardowe narzędzia do okiełznania NULL-i.

**COALESCE** — "weź pierwsze, co nie jest NULL":
```sql
SELECT name, COALESCE(phone, email, 'brak kontaktu') AS kontakt
FROM users;
```
Sprawdza argumenty po kolei, zwraca pierwszy nie-NULL. Klasyczne użycie: domyślna wartość zamiast NULL, np. `COALESCE(discount, 0)` żeby liczyć NULL jako zero (bo [[Agregacje i GROUP BY|agregaty]] i arytmetyka traktują NULL specjalnie).

**NULLIF** — "jeśli równe, zrób NULL":
```sql
SELECT amount / NULLIF(quantity, 0) AS cena_jedn
FROM orders;
```
`NULLIF(quantity, 0)` zwraca NULL, gdy `quantity = 0` — dzięki temu unikasz **dzielenia przez zero** (dzielenie przez NULL daje NULL, nie błąd). To jego najczęstsze zastosowanie.

> [!tip] Para na rozmowie
> "Jak uniknąć dzielenia przez zero?" → `x / NULLIF(y, 0)`. "Jak pokazać 0 zamiast NULL w wyniku?" → `COALESCE(col, 0)`. Obie sztuczki padają przy zadaniach z arytmetyką i raportami.

> [!warning] COALESCE vs ISNULL/IFNULL
> `COALESCE` jest standardem SQL i przyjmuje wiele argumentów. `ISNULL` (SQL Server) i `IFNULL` (MySQL) to dialektowe warianty na dwa argumenty. Na rozmowie używaj `COALESCE` — działa wszędzie.

## Połączenia
- [[NULL i logika trójwartościowa]] — problem, który te funkcje rozwiązują
- [[CASE WHEN]] — COALESCE to w istocie skrócony CASE na NULL
