---
tags: [c, koncepcja, preprocesor]
powiązane: ["[[Header file]]", "[[Preprocesor to silnik wklejania tekstu]]"]
sr_due: 2026-07-14
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Include guard

> [!summary] W jednym zdaniu
> Trójka `#ifndef / #define / #endif`, która gwarantuje, że treść headera trafi do kodu **dokładnie raz**, choćbyś wkleił go pośrednio wiele razy.

Skoro `#include` to dosłowne wklejanie ([[Preprocesor to silnik wklejania tekstu]]), pojawia się pułapka. Wyobraź sobie:

```
utils.h     zawiera:  typedef struct s_point t_point;
a.h      zawiera:  #include "utils.h"
b.h      zawiera:  #include "utils.h"
main.c   zawiera:  #include "a.h"
                   #include "b.h"
```

Preprocesor w `main.c` wkleja `a.h` (a w niej `utils.h`), potem `b.h` (a w niej **znowu** `utils.h`). Efekt: `typedef ...` pojawia się dwa razy → kompilator widzi podwójną definicję typu → błąd "redefinition".

Lekarstwo — owiń całą treść headera w guard:

```c
#ifndef UTILS_H
#define UTILS_H

typedef struct s_point t_point;

#endif
```

Prześledź mechanizm:
1. `#ifndef UTILS_H` — "jeśli `UTILS_H` **nie jest** jeszcze zdefiniowane, przetwarzaj dalej; inaczej skocz od razu do `#endif`".
2. `#define UTILS_H` — zdefiniuj `UTILS_H` (jego wartość bez znaczenia — liczy się, *że* istnieje).
3. treść headera.
4. `#endif` — koniec bloku.

Przy **drugim** wklejeniu `utils.h`: `UTILS_H` już istnieje (z kroku 2), więc preprocesor pomija wszystko do `#endif`. Treść trafia do kodu raz, niezależnie od liczby wklejeń.

> [!tip] Konwencja nazwy
> Nazwa pliku WIELKIMI literami, kropka → podkreślnik. `my_utils.h` → `MY_UTILS_H`. Musi być unikalna w projekcie (dwa różne headery z tym samym guardem skasowałyby się nawzajem).


## Połączenia
- [[Header file]] — guard jest obowiązkowym elementem każdego headera
- [[Preprocesor to silnik wklejania tekstu]] — `#ifndef` to dyrektywa preprocesora
