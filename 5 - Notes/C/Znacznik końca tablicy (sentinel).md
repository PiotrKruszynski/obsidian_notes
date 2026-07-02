---
tags: [c, koncepcja, wzorzec]
powiązane: ["[[String i null terminator]]", "[[argc i argv]]"]
sr_due: 2026-07-20
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Znacznik końca tablicy (sentinel)

- gdy funkcja nie zna długości tablicy, na końcu stoi umówiona wartość-strażnik — czytający jedzie, aż na nią trafi
- trzy postacie tego samego wzorca: `\0` kończy string · `NULL` kończy `argv` · element z umówionym polem (np. `str == 0`) kończy tablicę struktur
- producent alokuje **+1 miejsca** i ustawia strażnika; konsument zatrzymuje się na nim
- alternatywa: przekazywanie rozmiaru osobnym argumentem

> [!warning] Obie strony muszą trzymać się tej samej umowy — brak strażnika u producenta = pętla konsumenta leci w cudzą pamięć → segfault.

## Połączenia

- [[String i null terminator]] — ten sam wzorzec dla znaków
- [[argc i argv]] — `NULL` jako strażnik `argv`
