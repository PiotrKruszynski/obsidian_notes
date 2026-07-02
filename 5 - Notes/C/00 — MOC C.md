---
tags: [moc, c]
typ: map-of-content
---

# 00 — MOC: Język C

> [!summary] Czym jest ta notatka
> To **Map of Content** — punkt wejścia do działu C. Nie czyta się jej liniowo: wchodzisz, klikasz w notatkę, której teraz potrzebujesz, i wracasz. Każda notatka jest atomowa i samodzielna, a linki `[[...]]` prowadzą do pojęć powiązanych.

## Fundament (przeczytaj najpierw, w tej kolejności)
- [[Potok kompilacji w C]] — co naprawdę robi `cc`
- [[Preprocesor to silnik wklejania tekstu]] — jak działają `#include` i `#define`
- [[Pamięć to taśma adresów]] — obraz, bez którego wskaźniki nie mają sensu
- [[Stos kontra sterta]] — gdzie żyją dane i jak długo

## Preprocesor i headery
- [[Deklaracja kontra definicja]]
- [[Header file]]
- [[Include guard]]
- [[Makro]]
- [[Pułapka precedencji w makrach]]
- [[typedef]]

## Wskaźniki i pamięć
- [[Wskaźnik]]
- [[pointers - c]] — praktyczne pułapki wskaźników
- [[Przekazywanie przez wartość kontra przez adres]]
- [[Podwójny wskaźnik char gwiazdka gwiazdka]]
- [[argc i argv]]
- [[main - c]] — argc/argv w praktyce, iteracja, sortowanie stringów
- [[malloc, void gwiazdka i size_t]]
- [[free, leak i use-after-free]]
- [[Znacznik końca tablicy (sentinel)]]
- [[array - c]] — tablice, tablice 2D, tablice jako pointery

## Struktury, stringi, wyjście
- [[Struktura]]
- [[Kropka kontra strzałka]]
- [[String i null terminator]]
- [[str - c]] — ściąga string.h, czytanie wejścia
- [[Arytmetyka ASCII]]
- [[write i deskryptory plików]]
- [[Rekurencja i stos wywołań]]

## Funkcje i operatory
- [[function C]] — anatomia funkcji, C vs Python
- [[bits operator - c]] — AND/OR/XOR/NOT, shifty, manipulacja bitami

> [!tip] Test zrozumienia
> Jeśli umiesz odpowiedzieć bez zaglądania, rozumiesz te podstawy naprawdę:
> 1. Dlaczego `#include` może wkleić ten sam header dwa razy i czemu to problem? → [[Include guard]]
> 2. Co preprocesor robi z `ABS(a - b)` *zanim* kompilator to zobaczy? → [[Pułapka precedencji w makrach]]
> 3. Czemu `my_swap` bierze `int *`, a nie `int`? → [[Przekazywanie przez wartość kontra przez adres]]
> 4. Czemu tablicy zwracanej z funkcji nie budujesz na stosie? → [[Stos kontra sterta]]
> 5. Skąd funkcja czytająca tablicę wie, gdzie ta się kończy? → [[Znacznik końca tablicy (sentinel)]]
