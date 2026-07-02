---
tags: [c, koncepcja, wskaźniki]
powiązane: ["[[Wskaźnik]]"]
sr_due: 2026-07-06
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Przekazywanie przez wartość kontra przez adres

- w C argument idzie do funkcji **przez wartość** — funkcja pracuje na kopii, oryginał nietknięty
- żeby funkcja zmieniła zmienną wywołującego, przekaż jej **adres**: `f(&x)`, parametr `int *`
- dlatego `swap` musi brać `int *a, int *b` i pracować na `*a`, `*b` — zamiana kopii nic nie daje
- `*a = *b` zmienia wartość pod adresem; `a = b` przestawia tylko lokalny wskaźnik

> [!tip] Ten sam mechanizm co `scanf("%d", &n)` — dajesz adres, żeby funkcja miała gdzie wpisać wynik.

## Połączenia

- [[Wskaźnik]] — narzędzie, które to umożliwia
