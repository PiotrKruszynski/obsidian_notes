---
tags: [c, c08, koncepcja, preprocesor, pułapka]
powiązane: ["[[Makro]]", "[[Preprocesor to silnik wklejania tekstu]]"]
---

# Pułapka precedencji w makrach

> [!summary] W jednym zdaniu
> Bo makro to ślepa zamiana tekstu, brak nawisów wokół argumentu zmienia kolejność działań i daje cichą, błędną odpowiedź — dlatego owijasz **każdy** argument i całość w nawiasy.

Rozważ pozornie niewinne makro:
```c
#define SQUARE(x) x * x
```
Napiszesz `SQUARE(2 + 3)`. Preprocesor podstawia tekst `2 + 3` w miejsce każdego `x`, **dosłownie**:
```
SQUARE(2 + 3)   →   2 + 3 * 2 + 3
```
Teraz kompilator liczy z normalną precedencją (mnożenie przed dodawaniem): `2 + (3*2) + 3 = 11`. A chciałeś `(2+3)² = 25`. **Żadnego błędu, żadnego ostrzeżenia — po prostu zła liczba.** To koszmar do debugowania, bo kod wygląda poprawnie.

Lekarstwo — nawiasy wokół każdego `(x)` i wokół całego wyrażenia:
```c
#define SQUARE(x) ((x) * (x))
```
Teraz `SQUARE(2 + 3)` → `((2 + 3) * (2 + 3))` = `25`.

Dwa poziomy ochrony, każdy ma swój cel:
- nawias **wewnętrzny** `(x)` chroni przed precedencją *wewnątrz* argumentu (`2 + 3`),
- nawias **zewnętrzny** `(...)` chroni przed precedencją *na zewnątrz* (gdy ktoś napisze `SQUARE(3) + 1`).

> [!example] To samo w ex02
> ```c
> #define ABS(Value) ((Value) < 0 ? -(Value) : (Value))
> ```
> Wyobraź `ABS(a - b)`. Bez nawisów `-Value` stałoby się `-a - b` (czyli `-a` minus `b`) — błąd. Z nawiasami: `-(a - b)`. Poprawnie. Identyczna logika jak w `EVEN(nbr)` z ex01: bez nawiasów `argc - 1 % 2` policzyłoby `argc - (1 % 2)`, bo `%` ma wyższą precedencję niż `-`.

> [!tip] Reguła kciuka
> Pisząc makro z argumentem, owiń w nawiasy każde wystąpienie argumentu i całe wyrażenie. Zawsze. To tańsze niż godzina debugowania cichego błędu.

## Połączenia
- [[Makro]] — pojęcie nadrzędne
- [[ex02 ft_abs.h]] — gdzie stosujesz tę zasadę wprost
