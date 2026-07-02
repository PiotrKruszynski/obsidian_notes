---
tags: [c, koncepcja, stringi]
powiązane: ["[[Wskaźnik]]", "[[Arytmetyka ASCII]]", "[[malloc, void gwiazdka i size_t]]"]
sr_due: 2026-07-11
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# String i null terminator

- w C nie ma typu "string": to [[Wskaźnik|`char *`]] na pierwszy znak + **`\0`** (bajt 0) na końcu
- `"hi"` = 2 znaki widoczne, **3 bajty** w pamięci — dlatego kopia stringa to `malloc(len + 1)`
- idiom pętli: `while (str[i])` — działa, bo `\0` ma wartość 0, a 0 w C to fałsz

```
       ┌──────┬──────┬──────┐
       │ 'h'  │ 'i'  │ '\0' │
       └──────┴──────┴──────┘
        str[0] str[1] str[2]
```

> [!warning] Kopiując ręcznie, sam dopisz `dest[i] = '\0'` na końcu — bez tego każda funkcja czytająca `dest` poleci dalej w pamięć (śmieci albo segfault).

## Połączenia

- [[Wskaźnik]] — string to `char *`
- [[Arytmetyka ASCII]] — znaki jako liczby
- [[malloc, void gwiazdka i size_t]] — skąd `+1` przy alokacji
- [[Znacznik końca tablicy (sentinel)]] — `\0` to strażnik
