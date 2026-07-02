---
tags: [c, koncepcja, wskaźniki, kluczowe]
powiązane: ["[[Wskaźnik]]", "[[argc i argv]]", "[[String i null terminator]]"]
sr_due: 2026-07-10
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Podwójny wskaźnik (char **)

> [!summary] W jednym zdaniu
> `char **` to wskaźnik na wskaźnik — w praktyce **tablica stringów**: każdy element to `char *` (jeden napis), a `char **` wskazuje na początek tej tablicy.

Rozłóżmy to pojęcie warstwami:

- `char` — jeden znak.
- `char *` — adres pierwszego znaku, czyli jeden **string** ([[String i null terminator]]).
- `char **` — adres pierwszego `char *`, czyli początek **tablicy stringów**.

```
av (char **)
   │
   ▼
┌────────┬────────┬────────┬────────┐
│ av[0]  │ av[1]  │ av[2]  │  NULL  │   ← tablica wskaźników (char *)
└───┼────┴───┼────┴───┼────┴────────┘
    ▼        ▼        ▼
  "prog"   "one"    "two"            ← faktyczne napisy w pamięci
```

Dwa poziomy indeksowania:
- `av[i]` → i-ty **string** (typ `char *`).
- `av[i][j]` → j-ty **znak** i-tego stringa (typ `char`).

Tak właśnie wygląda `argv` z `main` (patrz [[argc i argv]]) — i tak samo `av` w `my_strs_to_tab(int ac, char **av)`.

> [!example] Przejście po wszystkich znakach
> ```c
> int i = 0;
> while (i < ac)             // po stringach
> {
>     int j = 0;
>     while (av[i][j])       // po znakach i-tego stringa, do '\0'
>     {
>         // av[i][j] to pojedynczy znak
>         j++;
>     }
>     i++;
> }
> ```

> [!tip] Jak to czytać
> Czytaj typ "od zmiennej w lewo": `av` jest `**`, czyli "wskaźnik na (wskaźnik na char)". Każde `*` albo `[]` zdejmuje jeden poziom: `av[i]` to już `char *`, `av[i][j]` to `char`.

## Połączenia
- [[Wskaźnik]] — pojęcie bazowe
- [[argc i argv]] — skąd `char **` bierze się w `main`
