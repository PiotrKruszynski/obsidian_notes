---
tags: [c, c08, koncepcja, wzorzec]
powiązane: ["[[String i null terminator]]", "[[argc i argv]]", "[[ex04 ft_strs_to_tab]]", "[[ex05 ft_show_tab]]"]
---

# Znacznik końca tablicy (sentinel)

> [!summary] W jednym zdaniu
> Gdy funkcja nie zna z góry długości tablicy, umawiasz się na specjalną wartość-strażnika na końcu — czytający jedzie, dopóki na nią nie trafi. To ten sam pomysł co `\0` w stringu.

To wzorzec, który widziałeś już trzy razy, choć pod różnymi postaciami:
- [[String i null terminator|`\0`]] kończy string,
- `NULL` kończy `argv` (patrz [[argc i argv]]),
- a w ex04/ex05 **struktura z `str == 0`** kończy tablicę struktur.

Idea jest zawsze ta sama: zamiast przekazywać długość osobno, wstawiasz na końcu wartość, która "normalnie nie wystąpi", i traktujesz ją jako "tu koniec".

> [!example] Dwie strony umowy: ex04 ustawia, ex05 czyta
> ex04 alokuje o jeden element więcej i oznacza ostatni:
> ```c
> tab = malloc(sizeof(t_stock_str) * (ac + 1));  // +1 na strażnika
> ...
> tab[ac].str = 0;                               // znacznik końca
> ```
> ex05 jedzie, dopóki nie trafi na strażnika:
> ```c
> while (par[i].str != 0)   // zatrzymaj się na znaczniku
> { ... i++; }
> ```
> Gdyby ex04 nie ustawił `str = 0`, pętla w ex05 czytałaby pamięć w nieskończoność → segfault. To dlatego obie funkcje muszą trzymać się **tej samej umowy**.

> [!tip] Czemu w ogóle ten wzorzec
> `ft_show_tab` dostaje tylko wskaźnik na początek tablicy — nie dostaje jej długości. Strażnik to jedyny sposób, by funkcja wiedziała, gdzie przestać. Alternatywą byłoby przekazywanie rozmiaru osobnym argumentem, ale PDF wymaga wariantu ze strażnikiem.

## Połączenia
- [[String i null terminator]] — ten sam wzorzec dla znaków
- [[argc i argv]] — `NULL` jako strażnik `argv`
- [[ex04 ft_strs_to_tab]] — ustawia strażnika
- [[ex05 ft_show_tab]] — reaguje na strażnika
