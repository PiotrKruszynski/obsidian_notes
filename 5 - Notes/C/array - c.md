---
title: "array - c"
type: concept
topic: c
tags: ["c"]
created: 2026-06-09
status: draft
sr_due: 2026-07-17
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# array - c

- tablica = zmienne **jednego typu** obok siebie w pamięci, indeksowane od 0: `int tab[5] = {10,20,30,40,50};`
- `tab[i]` ≡ `*(tab + i)` — tablica to adres pierwszego elementu
- do funkcji idzie **wskaźnik**, nie kopia — funkcja może zmienić oryginał ([[Przekazywanie przez wartość kontra przez adres]])
- C nie pamięta rozmiaru — przekazujesz go osobno albo używasz [[Znacznik końca tablicy (sentinel)|strażnika]]
- string = tablica `char` z `\0` ([[String i null terminator]])

## Tablice 2D

- tablica tablic, siatka wierszy × kolumn: `int t[2][3] = {{10,20,30},{40,50,60}};`
- dostęp `t[wiersz][kolumna]`; pętla w pętli (i po wierszach, j po kolumnach)
- w parametrze funkcji podajesz liczbę **kolumn**: `void f(int t[][3], int wiersze)`

> [!warning] Dostęp poza rozmiar (`tab[5]` przy 3 elementach) = crash albo losowe dane — C nie sprawdza granic. String literal potrzebuje miejsca na `\0`: `"Hello"` to 6 bajtów.

## Połączenia

- [[Wskaźnik]] — tablica a wskaźnik
- [[String i null terminator]] — tablica znaków
- [[Znacznik końca tablicy (sentinel)]] — koniec bez znanego rozmiaru
