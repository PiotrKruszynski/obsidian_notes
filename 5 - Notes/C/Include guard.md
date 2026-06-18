---
tags: [c, c08, koncepcja, preprocesor]
powiązane: ["[[Header file]]", "[[Preprocesor to silnik wklejania tekstu]]"]
---

# Include guard

> [!summary] W jednym zdaniu
> Trójka `#ifndef / #define / #endif`, która gwarantuje, że treść headera trafi do kodu **dokładnie raz**, choćbyś wkleił go pośrednio wiele razy.

Skoro `#include` to dosłowne wklejanie ([[Preprocesor to silnik wklejania tekstu]]), pojawia się pułapka. Wyobraź sobie:

```
ft.h     zawiera:  typedef struct s_point t_point;
a.h      zawiera:  #include "ft.h"
b.h      zawiera:  #include "ft.h"
main.c   zawiera:  #include "a.h"
                   #include "b.h"
```

Preprocesor w `main.c` wkleja `a.h` (a w niej `ft.h`), potem `b.h` (a w niej **znowu** `ft.h`). Efekt: `typedef ...` pojawia się dwa razy → kompilator widzi podwójną definicję typu → błąd "redefinition".

Lekarstwo — owiń całą treść headera w guard:

```c
#ifndef FT_H
# define FT_H

typedef struct s_point t_point;

#endif
```

Prześledź mechanizm:
1. `#ifndef FT_H` — "jeśli `FT_H` **nie jest** jeszcze zdefiniowane, przetwarzaj dalej; inaczej skocz od razu do `#endif`".
2. `# define FT_H` — zdefiniuj `FT_H` (jego wartość bez znaczenia — liczy się, *że* istnieje).
3. treść headera.
4. `#endif` — koniec bloku.

Przy **drugim** wklejeniu `ft.h`: `FT_H` już istnieje (z kroku 2), więc preprocesor pomija wszystko do `#endif`. Treść trafia do kodu raz, niezależnie od liczby wklejeń.

> [!tip] Konwencja nazwy
> Nazwa pliku WIELKIMI literami, kropka → podkreślnik. `ft_boolean.h` → `FT_BOOLEAN_H`. Musi być unikalna w projekcie (dwa różne headery z tym samym guardem skasowałyby się nawzajem).

> [!warning] Norminette: wcięcie dyrektyw
> Wewnątrz bloku `#ifndef` dyrektywy są wcinane **spacją po `#`**: piszesz `# define`, `# include` (z odstępem), ale `#ifndef` i `#endif` na kolumnie 0 zostają bez odstępu. To wymóg Normy.

## Połączenia
- [[Header file]] — guard jest obowiązkowym elementem każdego headera
- [[Preprocesor to silnik wklejania tekstu]] — `#ifndef` to dyrektywa preprocesora
