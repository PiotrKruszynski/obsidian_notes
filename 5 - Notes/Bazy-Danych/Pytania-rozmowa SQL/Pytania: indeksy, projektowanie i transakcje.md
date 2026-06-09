---
tags: [sql, rozmowa, pytania]
status: do-powtórki
---

# Pytania: indeksy, projektowanie i transakcje

> [!abstract] Po co ten zestaw
> Pytania "systemowe", sprawdzające, czy rozumiesz koszty i projektowanie, nie tylko składnię. Bazy: [[Indeks — jak działa i kiedy pomaga]], [[Normalizacja (1NF, 2NF, 3NF)]], [[Transakcje i ACID]].

## Q: Jak działa indeks i co przyspiesza?
Posortowana struktura (zwykle B-drzewo) zamieniająca pełny skan na wyszukiwanie logarytmiczne; przyspiesza filtry/JOIN/ORDER BY po kolumnie. → [[Indeks — jak działa i kiedy pomaga]].

## Q: Jaki jest koszt indeksów?
Wolniejsze zapisy (każdy INSERT/UPDATE aktualizuje indeksy) i miejsce na dysku. Zbyt wiele indeksów szkodzi tabelom intensywnie zapisywanym.

## Q: Czemu mój indeks "nie działa"?
Funkcja na kolumnie (`WHERE YEAR(d)=2024`) lub `LIKE '%abc'` uniemożliwiają jego użycie. Przepisz na zakres dat / unikaj wiodącego `%`.

## Q: Rozwiń ACID.
Atomicity (wszystko albo nic), Consistency (poprawny → poprawny stan), Isolation (równoległe transakcje się nie widzą), Durability (po COMMIT przetrwa awarię). Zilustruj przelewem. → [[Transakcje i ACID]].

## Q: Normalizacja vs denormalizacja?
Normalizujesz, by nie powtarzać faktów i uniknąć anomalii; denormalizujesz celowo (analityka/hurtownie), by uniknąć kosztownych JOIN-ów. → [[Normalizacja (1NF, 2NF, 3NF)]].

## Q: DELETE vs TRUNCATE?
DELETE — wybrane wiersze, w transakcji, wolniejsze; TRUNCATE — cała tabela naraz, szybkie, zwykle bez ROLLBACK. → [[DELETE, TRUNCATE i DROP]].

> [!tip] Jak odpowiadać na "systemowe"
> Zawsze dorzuć **kompromis** (trade-off): indeks = szybszy odczyt kosztem zapisu; denormalizacja = szybszy odczyt kosztem powtórzeń. Rozmówcy szukają myślenia o kosztach, nie regułek.
