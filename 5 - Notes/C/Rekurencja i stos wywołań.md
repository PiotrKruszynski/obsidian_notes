---
tags: [c, koncepcja, rekurencja, pamięć]
powiązane: ["[[Stos kontra sterta]]", "[[Arytmetyka ASCII]]"]
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Rekurencja i stos wywołań

- każde wywołanie funkcji dostaje własną **ramkę** na stosie (argumenty + zmienne lokalne)
- ramki odkładają się i rozwijają w odwrotnej kolejności — stos naturalnie odwraca porządek
- klasyczne użycie: wypisywanie liczby — `% 10` daje cyfry od końca, więc najpierw rekurencja na `n / 10`, potem wypisz `n % 10`
- schemat: `if (n >= 10) putnbr(n / 10); wypisz(n % 10);`

```
putnbr(123) → putnbr(12) → putnbr(1): wypisz '1'
                       wróć: wypisz '2'
              wróć: wypisz '3'          → "123"
```

> [!warning] Rekurencja musi mieć warunek stopu — bez niego ramki rosną w nieskończoność → stack overflow.

## Połączenia

- [[Stos kontra sterta]] — gdzie żyją ramki
- [[Arytmetyka ASCII]] — cyfra staje się znakiem
