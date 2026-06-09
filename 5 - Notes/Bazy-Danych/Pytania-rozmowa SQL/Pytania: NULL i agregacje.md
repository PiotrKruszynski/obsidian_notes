---
tags: ["interview", "sql"]
status: draft
---

# Pytania: NULL i agregacje

> [!abstract] Po co ten zestaw
> NULL to ulubiona pułapka rozmówców, bo łamie intuicję z innych języków. Baza: [[NULL i logika trójwartościowa]] i [[Agregacje i GROUP BY]].

## Q: Czemu `WHERE col = NULL` nic nie zwraca?
Bo porównanie z NULL daje UNKNOWN, a WHERE przepuszcza tylko TRUE. Do NULL-i: `IS NULL` / `IS NOT NULL`.

## Q: Różnica COUNT(*) vs COUNT(col) vs COUNT(DISTINCT col)?
`COUNT(*)` liczy wiersze (z NULL-ami); `COUNT(col)` tylko nie-NULL; `COUNT(DISTINCT col)` unikalne nie-NULL.

## Q: Czemu AVG daje "dziwny" wynik przy NULL-ach?
Bo agregaty pomijają NULL — `AVG` liczy średnią z nie-NULL, nie traktuje NULL jako 0. Jeśli chcesz liczyć jak 0, użyj `AVG(COALESCE(col, 0))`.

## Q: Czemu `col NOT IN (podzapytanie)` nagle nie zwraca nic?
Bo podzapytanie zwróciło NULL — `NOT IN` z NULL-em daje UNKNOWN dla wszystkich. Używaj `NOT EXISTS`. → [[EXISTS kontra IN]].


## Q: Policz opłacone i oczekujące zamówienia w JEDNYM zapytaniu.
`SUM(CASE WHEN status='paid' THEN 1 ELSE 0 END)` i analogicznie dla 'pending' — conditional aggregation w jednym skanie. → [[CASE WHEN]].

## Q: Jak uniknąć dzielenia przez zero / pokazać 0 zamiast NULL?
`x / NULLIF(y, 0)` (dzielenie przez NULL daje NULL, nie błąd); `COALESCE(col, 0)` zamienia NULL na 0. → [[COALESCE i NULLIF]].

> [!warning] Pułapka <>
> `WHERE col <> 'A'` pominie wiersze, gdzie `col IS NULL`. Żeby je złapać: dodaj `OR col IS NULL`.
