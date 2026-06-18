---
tags: [c, c08, koncepcja, pamięć, pułapka]
powiązane: ["[[malloc, void gwiazdka i size_t]]", "[[Stos kontra sterta]]"]
---

# free, leak i use-after-free

> [!summary] W jednym zdaniu
> `free(ptr)` oddaje stercie pamięć z [[malloc, void gwiazdka i size_t|malloc]]; każdy malloc wymaga dokładnie jednego free, a typowe błędy to wyciek (brak free) i użycie po zwolnieniu.

`free(ptr)` zwraca systemowi blok zaalokowany przez `malloc`. Po `free` ten obszar **już nie jest Twój**, choć wskaźnik wciąż trzyma stary adres.

Trzy klasyczne błędy:

**Memory leak (wyciek)** — zaalokowałeś i zgubiłeś wskaźnik bez `free`. Pamięć zostaje zajęta do końca programu, niedostępna. Każdy `malloc` to dług: dokładnie jeden `free` go spłaca.

**Use-after-free** — używasz wskaźnika po `free`. Pamięć mogła już trafić do kogoś innego — czytasz/piszesz cudze dane. Niezdefiniowane zachowanie.

**Double free** — `free` na tym samym wskaźniku dwa razy. Zwykle crash.

```c
char *str = malloc(10);
free(str);
str[0] = 'a';   // USE-AFTER-FREE — niezdefiniowane!
```

> [!tip] Higiena: zeruj wskaźnik po free
> ```c
> free(str);
> str = NULL;     // ewentualne free(NULL) jest bezpieczne (nic nie robi),
>                 // a użycie da czytelny segfault zamiast cichego chaosu
> ```

> [!example] Sprawdź wycieki narzędziem
> Na Linuksie: `valgrind ./program one two` — pokaże każdy zgubiony blok i miejsce alokacji. Na Macu zwykle używa się `leaks` albo Address Sanitizera (`cc -fsanitize=address`). W praktyce 42: jeśli alokujesz, dbaj o to, by każdy `malloc` miał parę.

> [!warning] Subtelność z ex04
> Jeśli któryś `malloc` kopii się nie uda i zwrócisz `NULL`, wcześniej zaalokowane bloki technicznie wyciekają. Moulinette w C08 zwykle nie testuje tego scenariusza, ale **sprawdzanie wyniku malloc jest obowiązkowe** — to nawyk, nie formalność.

## Połączenia
- [[malloc, void gwiazdka i size_t]] — druga strona pary alokacji
- [[Stos kontra sterta]] — free dotyczy tylko sterty
