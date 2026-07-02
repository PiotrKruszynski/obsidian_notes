---
tags: [c, koncepcja, typy]
powiązane: ["[[Makro]]", "[[Struktura]]"]
sr_due: 2026-07-09
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# typedef

- tworzy **alias typu** rozumiany przez kompilator: `typedef int t_bool;` — odtąd `t_bool` = `int`
- cel: intencja i czytelność (`t_bool f(...)` mówi "zwracam prawdę/fałsz")
- najczęstsze użycie — krótka nazwa struktury:

```c
typedef struct s_point
{
    int x;
    int y;
}	t_point;      // t_point p; zamiast struct s_point p;
```

- wewnętrzna nazwa `s_point` bywa potrzebna, gdy struktura wskazuje na siebie (lista wiązana): `struct s_point *next`
- `typedef` ≠ makro: respektuje zasięg i kontrolę typów; `#define t_bool int` to goły tekst

## Połączenia

- [[Struktura]] — najczęstszy kontekst typedef
- [[Makro]] — z czym typedef bywa mylony
