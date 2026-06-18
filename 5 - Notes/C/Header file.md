---
tags: [c, c08, koncepcja, preprocesor]
powiązane: ["[[Deklaracja kontra definicja]]", "[[Include guard]]", "[[Preprocesor to silnik wklejania tekstu]]"]
---

# Header file

> [!summary] W jednym zdaniu
> Header (`.h`) to plik pełen [[Deklaracja kontra definicja|deklaracji]], który wklejasz do plików `.c`, żeby kompilator znał funkcje i typy zdefiniowane gdzie indziej.

Problem: kompilator widzi każdy `.c` osobno (patrz [[Potok kompilacji w C]]). Żeby `main.c` mógł użyć `ft_putchar` z innego pliku, musi znać jej prototyp. Przepisywanie prototypów ręcznie w każdym `.c` byłoby koszmarem. Header to rozwiązanie: piszesz deklaracje raz, a `#include` wkleja je tam, gdzie trzeba.

Kluczowe: header **nie jest osobnym etapem ani osobno kompilowanym plikiem.** Nie istnieje `header.o`. `#include "ft.h"` powoduje, że [[Preprocesor to silnik wklejania tekstu|preprocesor]] **kopiuje całą treść `ft.h` w to miejsce** — header "jedzie na barana" wewnątrz `.c`, który go wklejył.

> [!example] Co widzi kompilator
> ```
> PRZED preprocesorem:         PO preprocesorze (jeden plik = translation unit):
>   main.c:                      ┌─────────────────────────┐
>   #include "ft.h"   ───►       │ void ft_putchar(char c); │ ← treść ft.h
>   int main(void){...}          │ ...                      │   wklejona tutaj
>                                │ int main(void){...}      │
>                                └─────────────────────────┘
> ```
> Sprawdź `cc -E main.c` — zobaczysz treść headera wklejoną w środku `main.c`.

> [!warning] Co wkładać do headera
> Tylko **deklaracje**: prototypy funkcji, `typedef`, makra, definicje struktur. **Nie** wkładaj definicji funkcji (ciał) — bo jeśli header wklei się do dwóch `.c`, dostaniesz dwie definicje i linker zaprotestuje. (Wyjątek w C08: ex01 ma `main`, który celowo definiuje funkcje w headerze — bo tam header jest dołączany tylko do jednego pliku.)

## Połączenia
- [[Deklaracja kontra definicja]] — co header zawiera
- [[Include guard]] — zabezpieczenie, które każdy header musi mieć
- [[Preprocesor to silnik wklejania tekstu]] — mechanizm `#include`
