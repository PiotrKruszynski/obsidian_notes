---
tags: [c, koncepcja, pamięć, pułapka]
powiązane: ["[[malloc, void gwiazdka i size_t]]", "[[Stos kontra sterta]]"]
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# free, leak i use-after-free

- `free(ptr)` oddaje stercie blok z [[malloc, void gwiazdka i size_t|malloc]]; po `free` obszar już nie jest Twój
- **leak** — zgubiłeś wskaźnik bez `free`; pamięć zajęta do końca programu
- **use-after-free** — użycie wskaźnika po `free`; niezdefiniowane zachowanie
- **double free** — `free` dwa razy na tym samym adresie; zwykle crash
- zasada: każdy `malloc` ma dokładnie jedną parę `free`

> [!tip] Po `free(str)` ustaw `str = NULL` — `free(NULL)` jest bezpieczne, a użycie da czytelny segfault zamiast cichego chaosu.

> [!warning] Częściowa awaria alokacji
> Gdy w serii alokacji któryś `malloc` zwróci `NULL`, zwolnij wcześniejsze bloki przed `return` — inaczej wyciekają.

Wycieki sprawdzasz narzędziem: `valgrind` (Linux), `leaks` / `cc -fsanitize=address` (Mac).

## Połączenia

- [[malloc, void gwiazdka i size_t]] — druga strona pary
- [[Stos kontra sterta]] — free dotyczy tylko sterty
