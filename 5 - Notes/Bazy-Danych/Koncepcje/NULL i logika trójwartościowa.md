---
tags: ["sql"]
powiązane: ["[[SELECT i filtrowanie (WHERE)]]", "[[Agregacje i GROUP BY]]", "[[EXISTS kontra IN]]"]
---

# NULL i logika trójwartościowa

> [!summary] W jednym zdaniu
> NULL znaczy "brak wartości / nieznane", a nie zero ani pusty string — i wciąga SQL w logikę **trójwartościową** (TRUE/FALSE/UNKNOWN), co jest źródłem najczęstszych pułapek rozmowowych.

W większości języków logika jest dwuwartościowa: prawda albo fałsz. W SQL dochodzi trzecia wartość: **UNKNOWN**, bo porównanie czegokolwiek z NULL daje "nie wiadomo".

Konsekwencje, które padają na rozmowach:

- **`NULL = NULL` to UNKNOWN, nie TRUE.** Dwa nieznane nie są "równe". Dlatego do NULL-i używasz `IS NULL` / `IS NOT NULL`, nie `=`.
- **WHERE przepuszcza tylko TRUE.** Wiersz, dla którego warunek daje UNKNOWN, wypada — tak jakby był FALSE. Stąd `WHERE col = NULL` nie zwraca nic.
- **Agregaty pomijają NULL.** `COUNT(col)`, `SUM`, `AVG` ignorują NULL-e. `COUNT(*)` liczy wiersze (z NULL-ami), `COUNT(col)` liczy tylko nie-NULL — patrz [[Agregacje i GROUP BY]].
- **`NOT IN` z NULL-em jest zdradliwe.** Jeśli podzapytanie w `NOT IN` zwróci choć jeden NULL, całość może dać zero wyników — dlatego na rozmowach poleca się `NOT EXISTS` zamiast `NOT IN` ([[EXISTS kontra IN]]).

> [!example] Klasyczny "gotcha"
> ```sql
> SELECT * FROM t WHERE col <> 'A';
> ```
> Wiersze, gdzie `col IS NULL`, **nie** wejdą do wyniku — choć intuicyjnie "nie jest A". Bo `NULL <> 'A'` to UNKNOWN, nie TRUE. Żeby je złapać: `WHERE col <> 'A' OR col IS NULL`.

> [!tip] Co odpowiedzieć
> "NULL to nieznane, nie zero; porównania z NULL dają UNKNOWN; WHERE przepuszcza tylko TRUE; do NULL-i służą IS NULL / IS NOT NULL; agregaty pomijają NULL." Ta jedna odpowiedź pokrywa większość pytań o NULL.

## Połączenia
- [[COALESCE i NULLIF]] — jak zastępować NULL i unikać dzielenia przez zero
- [[SELECT i filtrowanie (WHERE)]] — czemu `= NULL` nie działa
- [[Agregacje i GROUP BY]] — NULL a COUNT/SUM/AVG
- [[EXISTS kontra IN]] — pułapka NOT IN z NULL
