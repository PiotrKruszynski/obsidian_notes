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

- `char` — znak · `char *` — string (adres 1. znaku) · `char **` — **tablica stringów** (adres 1. wskaźnika)
- `av[i]` → i-ty string (`char *`); `av[i][j]` → j-ty znak i-tego stringa (`char`)
- czytanie typu: każde `*` albo `[]` zdejmuje jeden poziom
- tak wygląda `argv` z `main` — patrz [[argc i argv]]

```
av (char **)
   │
   ▼
┌────────┬────────┬────────┬────────┐
│ av[0]  │ av[1]  │ av[2]  │  NULL  │   ← tablica wskaźników (char *)
└───┼────┴───┼────┴───┼────┴────────┘
    ▼        ▼        ▼
  "prog"   "one"    "two"            ← napisy w pamięci
```

## Połączenia

- [[Wskaźnik]] — pojęcie bazowe
- [[argc i argv]] — skąd `char **` bierze się w `main`
- [[String i null terminator]] — czym jest pojedynczy `char *`
