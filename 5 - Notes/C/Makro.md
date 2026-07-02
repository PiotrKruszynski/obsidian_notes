---
tags: [c, koncepcja, preprocesor]
powiązane: ["[[Preprocesor to silnik wklejania tekstu]]", "[[Pułapka precedencji w makrach]]", "[[typedef]]"]
sr_due: 2026-07-10
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Makro

> [!summary] W jednym zdaniu
> `#define` tworzy ślepą zamianę tekstu wykonywaną przez preprocesor — to **nie** stała ani funkcja, tylko znajdź-i-zamień na surowych znakach.

Gdy napiszesz `#define BUFFER 42`, preprocesor dostaje rozkaz: "wszędzie, gdzie zobaczysz słowo `BUFFER`, wpisz `42`". Nie wie, że 42 to liczba — dla niego to dwa znaki `4` i `2`. Zamiana dzieje się, **zanim** kompilator cokolwiek zobaczy (patrz [[Preprocesor to silnik wklejania tekstu]]).

**Makro z argumentem** wygląda jak funkcja, ale dalej jest tylko zamianą tekstu:
```c
#define EVEN(nbr) ((nbr) % 2 == 0)
```
`EVEN(argc - 1)` nie "wywołuje" niczego — preprocesor podstawia tekst `argc - 1` w miejsce `nbr`, dając `((argc - 1) % 2 == 0)`.

**Stałe-makra** — klasyczne C (przed C99 i `<stdbool.h>`) nie ma wbudowanego typu logicznego, stąd zwyczaj definiowania własnych:
```c
#define TRUE 1
#define FALSE 0
```
W C "prawda" to dowolna wartość różna od zera, "fałsz" to dokładnie zero — to wbudowana reguła języka. `if (5)` jest prawdą, `if (0)` fałszem. `TRUE`/`FALSE` to tylko czytelne nazwy dla 1 i 0.

> [!warning] Każda zamiana to potencjalna pułapka
> Bo to tekst, a nie wartość: zawsze owijaj argumenty w nawiasy. Pełne uzasadnienie → [[Pułapka precedencji w makrach]]. Druga pułapka: makro liczące argument dwa razy (np. `ABS`) wykona efekt uboczny dwukrotnie przy `ABS(x++)` — funkcja by tego nie zrobiła.

> [!tip] Makro kontra typedef
> Oba "nadają nazwę", ale: makro to tekst obrabiany przez preprocesor (zero kontroli typów), a [[typedef]] to alias typu rozumiany przez kompilator (z kontrolą typów). Do nazywania typów używaj `typedef`, nie `#define`.

## Połączenia
- [[Pułapka precedencji w makrach]] — najważniejsza zasada przy makrach z argumentem
- [[Preprocesor to silnik wklejania tekstu]] — kto i kiedy wykonuje zamianę
