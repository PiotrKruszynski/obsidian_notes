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

> [!summary] W jednym zdaniu
> `typedef` tworzy **alias typu** — nową nazwę dla istniejącego typu, rozumianą przez kompilator (w przeciwieństwie do [[Makro|makra]], które jest tylko tekstem).

```c
typedef int t_bool;
```
Od teraz `t_bool` znaczy dokładnie tyle co `int`. Po co? Dla **intencji i czytelności**. Gdy widzisz `t_bool my_is_even(...)`, od razu wiesz, że funkcja zwraca prawda/fałsz, a nie dowolną liczbę. Kompilator i tak traktuje to jako `int` — ale człowiek czytający kod dostaje informację o przeznaczeniu.

Najczęstsze użycie to nazwanie struktury (patrz [[Struktura]]):
```c
typedef struct s_point
{
    int x;
    int y;
}	t_point;
```
Bez `typedef` musiałbyś wszędzie pisać `struct s_point p;`. Z `typedef` piszesz krótko `t_point p;`.

> [!tip] Dlaczego zostawiamy obie nazwy
> W zapisie wyżej są dwie nazwy: wewnętrzna `s_point` (od *struct*) i alias `t_point` (od *type*). Wewnętrzna nazwa bywa potrzebna, gdy struktura wskazuje na samą siebie (listy wiązane): w polu piszesz wtedy `struct s_point *next`. `t_` to alias do codziennego użytku.

> [!warning] typedef to nie makro
> `typedef int t_bool;` to **nie** `#define t_bool int`. typedef respektuje zasięg (scope) i bierze udział w kontroli typów; makro to ślepa zamiana tekstu bez żadnej kontroli. Do typów zawsze typedef.

## Połączenia
- [[Struktura]] — najczęstszy kontekst typedef
- [[Makro]] — z czym typedef bywa mylony i czemu są różne
