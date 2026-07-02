---
tags: [c, koncepcja, pamięć, alokacja]
powiązane: ["[[Stos kontra sterta]]", "[[free, leak i use-after-free]]", "[[Wskaźnik]]"]
sr_due: 2026-07-02
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# malloc, void * i size_t

- `void *malloc(size_t size)` — rezerwuje `size` bajtów na [[Stos kontra sterta|stercie]], zwraca adres początku albo `NULL`
- `size_t` — całkowity **bez znaku**; typ rozmiarów i wyniku `sizeof`
- zwraca `void *` ("wskaźnik na cokolwiek") — w C przypisujesz bez rzutowania: `int *arr = malloc(...)`
- rozmiar zawsze przez `sizeof`: `malloc(10 * sizeof(int))`, nigdy `10 * 4` (rozmiar typu zależy od maszyny)

> [!warning] malloc może zwrócić NULL — zawsze sprawdzaj
> ```c
> ptr = malloc(...);
> if (!ptr)
>     return (NULL);
> ```
> Użycie `NULL` bez sprawdzenia → segfault.

## Połączenia

- [[Stos kontra sterta]] — po co alokować na stercie
- [[free, leak i use-after-free]] — każdy malloc to dług
