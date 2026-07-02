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

> [!summary] W jednym zdaniu
> Gdy funkcja nie zna z góry długości tablicy, umawiasz się na specjalną wartość-strażnika na końcu — czytający jedzie, dopóki na nią nie trafi. To ten sam pomysł co `\0` w stringu.

To wzorzec, który widziałeś już trzy razy, choć pod różnymi postaciami:
- [[String i null terminator|`\0`]] kończy string,
- `NULL` kończy `argv` (patrz [[argc i argv]]),
- **element-strażnik** (np. struktura z polem `str == 0`) kończy tablicę struktur.

Idea jest zawsze ta sama: zamiast przekazywać długość osobno, wstawiasz na końcu wartość, która "normalnie nie wystąpi", i traktujesz ją jako "tu koniec".

> [!example] Dwie strony umowy: producent ustawia, konsument czyta
> Funkcja budująca tablicę alokuje o jeden element więcej i oznacza ostatni:
> ```c
> tab = malloc(sizeof(t_item) * (n + 1));  // +1 na strażnika
> ...
> tab[n].str = 0;                          // znacznik końca
> ```
> Funkcja czytająca jedzie, dopóki nie trafi na strażnika:
> ```c
> while (par[i].str != 0)   // zatrzymaj się na znaczniku
> { ... i++; }
> ```
> Gdyby producent nie ustawił `str = 0`, pętla konsumenta czytałaby pamięć w nieskończoność → segfault. Obie strony muszą trzymać się **tej samej umowy**.

> [!tip] Czemu w ogóle ten wzorzec
> Funkcja dostająca sam wskaźnik na początek tablicy nie zna jej długości. Strażnik mówi jej, gdzie przestać; alternatywą jest przekazywanie rozmiaru osobnym argumentem.

## Połączenia
- [[String i null terminator]] — ten sam wzorzec dla znaków
- [[argc i argv]] — `NULL` jako strażnik `argv`
