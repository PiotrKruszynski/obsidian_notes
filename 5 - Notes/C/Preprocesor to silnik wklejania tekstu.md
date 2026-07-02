---
tags: [c, koncepcja, fundament, preprocesor]
powiązane: ["[[Potok kompilacji w C]]", "[[Makro]]", "[[Header file]]", "[[Include guard]]"]
sr_due: 2026-07-03
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Preprocesor to silnik wklejania tekstu

- pracownik, który **nie zna C** — umie tylko przepisywać tekst, zanim kompilator cokolwiek zobaczy
- `#include "plik"` — wklej zawartość pliku w to miejsce, znak po znaku
- `#define NAZWA tekst` — odtąd zamieniaj słowo `NAZWA` na `tekst` (znajdź-i-zamień)
- `#ifndef / #endif` — warunkowo włącz albo pomiń fragment tekstu
- nie liczy, nie sprawdza typów, nie zna funkcji — **tylko podstawia znaki**

Jedno zdanie do zapamiętania: **`#include` to wklejanie, `#define` to znajdź-i-zamień.**

> [!warning] Ślepa zamiana tekstu = źródło podstępnych błędów — patrz [[Pułapka precedencji w makrach]].

## Połączenia

- [[Potok kompilacji w C]] — preprocesor to etap (1)
- [[Header file]] — `#include` w akcji
- [[Makro]] — `#define` w akcji
- [[Include guard]] — `#ifndef` w akcji
