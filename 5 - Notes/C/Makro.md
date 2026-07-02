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

- `#define X tekst` = ślepa zamiana tekstu przez preprocesor — **nie** stała, **nie** funkcja
- makro z argumentem też jest tekstem: `#define EVEN(n) ((n) % 2 == 0)` → `EVEN(x-1)` to podstawienie, nie wywołanie
- w C prawda = cokolwiek ≠ 0, fałsz = 0; stąd klasyczne `#define TRUE 1`, `#define FALSE 0` (przed C99 nie było `<stdbool.h>`)

> [!warning] Dwie pułapki
> Argument bez nawiasów psuje kolejność działań → [[Pułapka precedencji w makrach]]. Makro używające argumentu dwa razy (np. `ABS`) wykona `ABS(x++)` dwukrotnie — funkcja by tego nie zrobiła.

> [!tip] Do nazywania typów używaj [[typedef]] (kontrola typów), nie `#define` (goły tekst).

## Połączenia

- [[Pułapka precedencji w makrach]] — główna zasada makr z argumentem
- [[Preprocesor to silnik wklejania tekstu]] — kto wykonuje zamianę
