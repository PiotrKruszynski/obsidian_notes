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

> [!summary] W jednym zdaniu
> `malloc(n)` rezerwuje `n` bajtów na [[Stos kontra sterta|stercie]] i zwraca [[Wskaźnik|wskaźnik]] na ich początek (albo `NULL` przy porażce) — a rozmiar liczysz przez `sizeof`, nie na sztywno.

```c
void *malloc(size_t size);
```

Rozbiór sygnatury — trzy rzeczy, które warto rozumieć:

**`size_t size`** — `size_t` to specjalny typ całkowity **bez znaku** (nieujemny), używany do rozmiarów i liczników w pamięci. Rozmiar nie może być ujemny, więc nie marnuje bitu na znak. `sizeof` też zwraca `size_t`.

**zwraca `void *`** — `void *` to "wskaźnik na coś, typu jeszcze nieokreślonego". `malloc` nie wie, na co przeznaczysz pamięć, więc oddaje neutralny adres. W C przypisanie `void *` do dowolnego wskaźnika jest automatyczne — **nie rzutujesz** (rzutowanie wyniku `malloc` w C jest zbędne):
```c
int *arr = malloc(10 * sizeof(int));   // void* → int* samo
```

**liczenie rozmiaru przez `sizeof`** — nigdy nie wpisuj rozmiaru typu na sztywno:
```c
int *arr = malloc(10 * 4);            // ŹLE: zakładasz, że int = 4 bajty
int *arr = malloc(10 * sizeof(int));  // DOBRZE: poprawne na każdej maszynie
```

> [!warning] malloc może zwrócić NULL — zawsze sprawdzaj
> Gdy zabraknie pamięci, `malloc` daje `NULL`. Użycie `NULL` bez sprawdzenia → segfault. Wzorzec obowiązkowy:
> ```c
> ptr = malloc(...);
> if (!ptr)              // to samo co (ptr == NULL)
>     return (NULL);     // obsłuż błąd
> ```

> [!example] Alokacja tablicy struktur
> ```c
> tab = malloc(sizeof(t_entry) * (n + 1));
> ```
> `sizeof(t_entry)` to rozmiar jednej struktury; `(n + 1)` to liczba struktur (z jednym dodatkowym miejscem na [[Znacznik końca tablicy (sentinel)|znacznik końca]]).

## Połączenia
- [[Stos kontra sterta]] — dlaczego w ogóle alokujesz na stercie
- [[free, leak i use-after-free]] — każdy malloc to dług do spłacenia
