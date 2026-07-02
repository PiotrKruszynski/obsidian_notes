---
title: "bits operator - c"
type: concept
topic: c
tags: ["c"]
created: 2026-06-09
status: draft
sr_due: 2026-07-14
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# bits operator - c

- liczby w pamięci to bity; operatory bitowe działają bit po bicie (przykłady dla `x=5` → `0101`, `y=3` → `0011`)

| Operator | Działanie | 5 op 3 |
| --- | --- | --- |
| `&` AND | 1 gdy oba 1 | `0001` = 1 |
| `\|` OR | 1 gdy którykolwiek 1 | `0111` = 7 |
| `^` XOR | 1 gdy różne | `0110` = 6 |
| `~` NOT | odwraca bity (uwaga: wynik ujemny, U2) | — |
| `<< n` | w lewo = ×2ⁿ | `5<<1` = 10 |
| `>> n` | w prawo = ÷2ⁿ | `5>>1` = 2 |

## Wzorce na bitach (maska `1 << n`)

- test bitu n: `x & (1 << n)`
- włącz: `x | (1 << n)`
- wyłącz: `x & ~(1 << n)`
- przełącz: `x ^ (1 << n)`
- parzystość: `x & 1` → 1 = nieparzysta

> [!warning] `&`/`|` (bitowe) ≠ `&&`/`||` (logiczne) — logiczne pytają "prawda czy fałsz?" o całe wartości, bitowe liczą na bitach. `5 & 3` = 1, ale `5 && 3` = 1 tylko dlatego, że oba ≠ 0.

## Połączenia

- [[Makro]] — flagi bitowe często siedzą w #define
- [[Arytmetyka ASCII]] — znaki też są liczbami
