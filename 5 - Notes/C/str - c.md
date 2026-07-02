---
title: "str - c"
type: concept
topic: c
tags: ["c"]
created: 2026-06-09
status: draft
sr_due: 2026-07-08
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# str - c

- string = tablica `char` + `\0`; teoria → [[String i null terminator]]
- deklaracje: `char s[] = "tekst"` (tablica, można pisać) · `char *s = "tekst"` (literal, **read-only** — zapis = segfault)

## string.h — ściąga

```c
strlen(s)             // długość bez \0
strcpy(dest, src)     // kopiuj (NIEBEZPIECZNE: brak limitu)
strncpy(dest, src, n) // kopiuj max n znaków
strcat(s1, s2)        // dołącz s2 do s1
strcmp(s1, s2)        // 0 równe · <0 s1<s2 · >0 s1>s2
strchr(s, c)          // pierwszy znak c (albo NULL)
strstr(s1, s2)        // podstring (albo NULL)
```

## Czytanie wejścia

- `scanf("%s", buf)` — do spacji, brak limitu = niebezpieczne; `scanf("%49s", buf)` lepiej
- `fgets(buf, 50, stdin)` — cała linia z limitem, **najbezpieczniejsze** (zostawia `\n`)

> [!warning] Bufor za mały to buffer overflow: `char s[5]; strcpy(s, "hello");` — "hello" potrzebuje 6 bajtów (z `\0`).

## Połączenia

- [[String i null terminator]] — czym jest string
- [[Arytmetyka ASCII]] — porządek w strcmp
- [[array - c]] — string to tablica znaków
