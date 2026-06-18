---
tags: [c, c08, koncepcja, preprocesor]
powiązane: ["[[Preprocesor to silnik wklejania tekstu]]", "[[Pułapka precedencji w makrach]]", "[[typedef]]"]
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

**Stałe-makra** używane w C, bo C (w wersji 42) nie ma wbudowanych typów logicznych:
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
- [[ex01 ft_boolean.h]], [[ex02 ft_abs.h]] — ćwiczenia oparte na makrach
