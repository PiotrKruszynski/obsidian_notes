---
tags: [c, koncepcja, preprocesor, pułapka]
powiązane: ["[[Makro]]", "[[Preprocesor to silnik wklejania tekstu]]"]
sr_due: 2026-07-17
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Pułapka precedencji w makrach

- `#define SQUARE(x) x * x` + `SQUARE(2 + 3)` → dosłowne podstawienie: `2 + 3 * 2 + 3` = **11**, nie 25
- zero błędów i ostrzeżeń — po prostu zła liczba; kod wygląda poprawnie
- lekarstwo: `#define SQUARE(x) ((x) * (x))`
- nawias **wewnętrzny** `(x)` chroni przed precedencją wewnątrz argumentu; **zewnętrzny** — na zewnątrz (`SQUARE(3) + 1`)

> [!tip] Reguła: w makrze z argumentem owijaj w nawiasy każde wystąpienie argumentu i całe wyrażenie. Zawsze.

## Połączenia

- [[Makro]] — pojęcie nadrzędne
