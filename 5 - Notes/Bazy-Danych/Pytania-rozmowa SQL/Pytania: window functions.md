---
tags: ["interview", "sql"]
status: draft
---

# Pytania: window functions

> [!abstract] Po co ten zestaw
> Odróżnia kandydata średniozaawansowanego od podstawowego. Baza: [[Window functions]].

## Q: Czym window function różni się od GROUP BY?
GROUP BY zwija grupę w jeden wiersz; funkcja okienkowa liczy to samo, ale zostawia wszystkie wiersze i dokłada kolumnę wyniku.

## Q: ROW_NUMBER vs RANK vs DENSE_RANK?
ROW_NUMBER: zawsze unikalny (1,2,3,4). RANK: remisy ten sam numer, potem dziura (1,2,2,4). DENSE_RANK: remisy ten sam numer, bez dziury (1,2,2,3).

## Q: Jak wybrać top 1 (np. najlepiej zarabiającego) w każdej grupie?
`ROW_NUMBER() OVER (PARTITION BY grupa ORDER BY wartość DESC)`, potem w [[CTE (WITH)|CTE]]/podzapytaniu filtr `WHERE rn = 1`. Filtr na zewnątrz, bo okna nie użyjesz w WHERE.

## Q: Czemu nie mogę dać funkcji okienkowej w WHERE?
Bo powstaje na etapie SELECT — po WHERE. Owiń zapytanie i filtruj po wyniku. → [[Logiczna kolejność wykonania zapytania]].

> [!tip] Zadanie praktyczne
> "Druga najwyższa pensja w dziale" — `DENSE_RANK() ... = 2` (albo ROW_NUMBER, zależnie czy remisy mają się liczyć). Rozmówca patrzy, czy świadomie wybierasz między RANK a DENSE_RANK.
