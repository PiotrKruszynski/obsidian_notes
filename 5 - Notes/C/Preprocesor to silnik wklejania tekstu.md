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

> [!summary] W jednym zdaniu
> Preprocesor to "pracownik, który nie zna C" — umie tylko wklejać pliki i robić znajdź-zamień na tekście, i robi to, zanim kompilator cokolwiek zobaczy.

Wyobraź sobie, że przed kompilacją siada przy Twoim kodzie ktoś, kto **nie rozumie języka C**. Zna tylko polecenia zaczynające się od `#`. Trzy najważniejsze:

| Dyrektywa | Co robi (dosłownie) |
|-----------|---------------------|
| `#include "plik"` | "weź zawartość tego pliku i **wklej ją w to miejsce**, znak po znaku" |
| `#define NAZWA tekst` | "od teraz, gdy zobaczysz słowo `NAZWA`, **zamień je na `tekst`**" |
| `#ifndef / #endif` | "warunkowo włącz albo pomiń ten fragment tekstu" |

To **wszystko**, co robi preprocesor. Nie wie, czym jest funkcja ani zmienna. Nie liczy. Nie sprawdza typów. Tylko przepisuje tekst. Dopiero wynik jego pracy — czysty, rozwinięty tekst — trafia do kompilatora.

Zapamiętaj jedno zdanie, a połowa preprocesora stanie się oczywista: **`#include` to wklejanie, a `#define` to znajdź-i-zamień.**

> [!example] Co dokładnie się dzieje
> Ten kod:
> ```c
> #define ROZMIAR 42
> char buf[ROZMIAR];
> ```
> po przejściu przez preprocesor wygląda dla kompilatora tak:
> ```c
> char buf[42];
> ```
> Słowo `ROZMIAR` nigdy nie dociera do kompilatora — znika na etapie tekstu. Sprawdź to przez `cc -E`.

> [!warning] To jest źródło najpodstępniejszych błędów
> Skoro to ślepa zamiana tekstu, a nie wywołanie funkcji, łatwo o pułapkę precedencji — patrz [[Pułapka precedencji w makrach]]. Preprocesor nie "rozumie" Twojej intencji; on tylko podstawia znaki.

## Połączenia
- [[Potok kompilacji w C]] — preprocesor to etap (1)
- [[Header file]] — `#include` w akcji
- [[Makro]] — `#define` w akcji
- [[Include guard]] — `#ifndef` w akcji
