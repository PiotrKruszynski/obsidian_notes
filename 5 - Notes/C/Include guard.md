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

- problem: `#include` to dosłowne wklejanie — gdy `a.h` i `b.h` obie wklejają `utils.h`, jego treść trafia do `.c` **dwa razy** → "redefinition"
- lekarstwo: cała treść headera w bloku `#ifndef`

```c
#ifndef UTILS_H
#define UTILS_H

/* treść headera */

#endif
```

- pierwsze wklejenie definiuje `UTILS_H`; przy każdym kolejnym `#ifndef` jest fałszywe i preprocesor pomija wszystko do `#endif`
- konwencja nazwy: nazwa pliku wielkimi, kropka → `_` (`my_utils.h` → `MY_UTILS_H`); musi być unikalna w projekcie

## Połączenia

- [[Header file]] — co guard chroni
- [[Preprocesor to silnik wklejania tekstu]] — `#ifndef` to dyrektywa tekstowa
