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

> [!summary] W jednym zdaniu
> Struktura grupuje kilka zmiennych w jedną całość leżącą obok siebie w [[Pamięć to taśma adresów|pamięci]] — jeden "pakiet" z nazwanymi polami.

```c
struct s_point
{
    int x;
    int y;
};
```
W pamięci to po prostu dwa `int` jeden za drugim:
```
adres:  2000        2004
       ┌───────────┬───────────┐
       │   x (int) │   y (int) │
       └───────────┴───────────┘
       └──── jedna struktura ───┘
```

Niemal zawsze łączysz strukturę z [[typedef]], żeby mieć krótki alias:
```c
typedef struct s_point
{
    int x;
    int y;
}	t_point;

t_point p;        // zamiast: struct s_point p;
```

Dostęp do pól zależy od tego, czy masz strukturę, czy [[Wskaźnik|wskaźnik]] na nią — patrz [[Kropka kontra strzałka]].

> [!example] Struktura łącząca trzy typy
> ```c
> typedef struct s_stock_str
> {
>     int   size;    // wartość (długość)
>     char  *str;    // wskaźnik na oryginalny napis
>     char  *copy;   // wskaźnik na świeżą kopię
> }	t_entry;
> ```
> Pole `size` to liczba; `str` i `copy` to [[Wskaźnik|wskaźniki]] — jeden wskazuje na cudzą pamięć, drugi na własną kopię. To częsty wzorzec przy kopiowaniu danych.

> [!tip] Inicjalizacja
> Na stosie: `t_point p; p.x = 42;`. Na stercie: `t_point *p = malloc(sizeof(t_point)); p->x = 42;`. `sizeof(t_point)` daje rozmiar całej struktury w bajtach — używaj go przy [[malloc, void gwiazdka i size_t|malloc]].

## Połączenia
- [[typedef]] — jak nadać strukturze krótki alias
- [[Kropka kontra strzałka]] — jak sięgać do pól
