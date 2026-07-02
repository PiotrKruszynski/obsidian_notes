---
title: "main - c"
type: concept
topic: c
tags: ["c"]
created: 2026-06-09
status: draft
sr_due: 2026-07-02
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# main - c

- `int main(int argc, char **argv)` — punkt wejścia programu CLI; szczegóły typów → [[argc i argv]]
- iteracja po argumentach: od `i = 1` (pomija nazwę programu), warunek `i < argc`
- iteracja wsteczna: od `i = argc - 1`, warunek `i > 0`
- porównywanie argumentów: **zawsze** funkcją typu `strcmp`; wynik `<0 / 0 / >0` = kolejność wg kodów ASCII (`'0'..'9' < 'A'..'Z' < 'a'..'z'`)
- sortowanie `argv`: przestawiasz **wskaźniki** `char *`, nie kopiujesz tekstu:

```c
tmp = argv[i];
argv[i] = argv[j];
argv[j] = tmp;
```

> [!warning] Typowe błędy
> `argv[i] > argv[j]` porównuje **adresy**, nie tekst — używaj `strcmp`. Start od `i = 0` wypisuje nazwę programu. `argv` to tablica, `argv[i]` string, `argv[i][j]` znak.

## Połączenia

- [[argc i argv]] — czym są argumenty
- [[Podwójny wskaźnik char gwiazdka gwiazdka]] — typ `argv` i dwa poziomy indeksowania
- [[Arytmetyka ASCII]] — skąd bierze się porządek sortowania
- [[write i deskryptory plików]] — wypisywanie wyników
