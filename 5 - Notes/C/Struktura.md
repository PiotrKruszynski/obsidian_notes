---
tags: [c, koncepcja, struktury]
powiązane: ["[[typedef]]", "[[Kropka kontra strzałka]]"]
sr_due: 2026-07-02
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Struktura

- grupuje kilka zmiennych (pól) w jedną całość leżącą obok siebie w [[Pamięć to taśma adresów|pamięci]]
- pola mogą być różnych typów: liczby, [[Wskaźnik|wskaźniki]], inne struktury
- niemal zawsze z [[typedef]], żeby pisać `t_point p;` zamiast `struct s_point p;`
- rozmiar całości daje `sizeof(t_point)` — używaj przy [[malloc, void gwiazdka i size_t|malloc]]

```
struct s_point { int x; int y; };

adres:  2000        2004
       ┌───────────┬───────────┐
       │   x (int) │   y (int) │
       └───────────┴───────────┘
```

- inicjalizacja: stos → `t_point p; p.x = 42;` · sterta → `t_point *p = malloc(sizeof(t_point)); p->x = 42;`

## Połączenia

- [[typedef]] — krótki alias dla struktury
- [[Kropka kontra strzałka]] — dostęp do pól
