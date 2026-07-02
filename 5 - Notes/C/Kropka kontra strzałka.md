---
tags: [c, koncepcja, struktury, wskaźniki]
powiązane: ["[[Struktura]]", "[[Wskaźnik]]"]
sr_due: 2026-07-15
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Kropka kontra strzałka

- masz **strukturę** → kropka: `p.x = 42;`
- masz **wskaźnik** na strukturę → strzałka: `ptr->x = 42;`
- `ptr->x` to skrót za `(*ptr).x`: najpierw dereferencja, potem pole
- funkcja zmieniająca strukturę bierze wskaźnik (→ strzałka), wywołujący daje `&p` — logika z [[Przekazywanie przez wartość kontra przez adres]]

> [!tip] Strzałka "wskazuje" → dla wskaźnika; kropka jest "płaska" → dla struktury wprost.

## Połączenia

- [[Struktura]] — co zawiera pola
- [[Wskaźnik]] — kiedy `->`
