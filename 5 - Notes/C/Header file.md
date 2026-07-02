---
tags: [c, koncepcja, preprocesor]
powiązane: ["[[Deklaracja kontra definicja]]", "[[Include guard]]", "[[Preprocesor to silnik wklejania tekstu]]"]
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Header file

> [!summary] W jednym zdaniu
> Header (`.h`) to plik pełen [[Deklaracja kontra definicja|deklaracji]], który wklejasz do plików `.c`, żeby kompilator znał funkcje i typy zdefiniowane gdzie indziej.

Problem: kompilator widzi każdy `.c` osobno (patrz [[Potok kompilacji w C]]). Żeby `main.c` mógł użyć `my_putchar` z innego pliku, musi znać jej prototyp. Przepisywanie prototypów ręcznie w każdym `.c` byłoby koszmarem. Header to rozwiązanie: piszesz deklaracje raz, a `#include` wkleja je tam, gdzie trzeba.

Kluczowe: header **nie jest osobnym etapem ani osobno kompilowanym plikiem.** Nie istnieje `header.o`. `#include "utils.h"` powoduje, że [[Preprocesor to silnik wklejania tekstu|preprocesor]] **kopiuje całą treść `utils.h` w to miejsce** — header "jedzie na barana" wewnątrz `.c`, który go wklejył.

> [!example] Co widzi kompilator
> ```
> PRZED preprocesorem:         PO preprocesorze (jeden plik = translation unit):
>   main.c:                      ┌─────────────────────────┐
>   #include "utils.h"   ───►       │ void my_putchar(char c); │ ← treść utils.h
>   int main(void){...}          │ ...                      │   wklejona tutaj
>                                │ int main(void){...}      │
>                                └─────────────────────────┘
> ```
> Sprawdź `cc -E main.c` — zobaczysz treść headera wklejoną w środku `main.c`.

> [!warning] Co wkładać do headera
> Tylko **deklaracje**: prototypy funkcji, `typedef`, makra, definicje struktur. **Nie** wkładaj definicji funkcji (ciał) — bo jeśli header wklei się do dwóch `.c`, dostaniesz dwie definicje i linker zaprotestuje.

## Połączenia
- [[Deklaracja kontra definicja]] — co header zawiera
- [[Include guard]] — zabezpieczenie, które każdy header musi mieć
- [[Preprocesor to silnik wklejania tekstu]] — mechanizm `#include`
