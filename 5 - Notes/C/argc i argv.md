---
tags: [c, c08, koncepcja, podstawy]
powiązane: ["[[Podwójny wskaźnik char gwiazdka gwiazdka]]", "[[ex01 ft_boolean.h]]", "[[ex04 ft_strs_to_tab]]"]
---

# argc i argv

> [!summary] W jednym zdaniu
> To argumenty wiersza poleceń: `argc` liczy wszystkie tokeny (łącznie z nazwą programu), `argv` to [[Podwójny wskaźnik char gwiazdka gwiazdka|tablica stringów]] z ich treścią.

```c
int main(int argc, char **argv)
```

Dla wywołania `./program one two`:
- `argc == 3` — bo liczy **też nazwę programu**: `./program`, `one`, `two`.
- `argv[0]` → `"./program"` (nazwa programu).
- `argv[1]` → `"one"`.
- `argv[2]` → `"two"`.
- `argv[3]` → `NULL` (standard gwarantuje `NULL` na końcu — wartowniczy znacznik, patrz [[Znacznik końca tablicy (sentinel)]]).

> [!warning] Klasyczna pomyłka: argc liczy nazwę programu
> Liczba **prawdziwych** argumentów to `argc - 1`. Dlatego w ex01 `main` woła `ft_is_even(argc - 1)` — sprawdza parzystość liczby argumentów *bez* nazwy programu. `./prog` (zero argumentów) → `argc - 1 == 0` → parzyste.

> [!example] Związek z ex04
> `ft_strs_to_tab(int ac, char **av)` to po prostu te same `argc`/`argv` przekazane dalej pod innymi nazwami. `av` jest typu `char **`, więc przetwarzasz je tak jak w [[Podwójny wskaźnik char gwiazdka gwiazdka]].

## Połączenia
- [[Podwójny wskaźnik char gwiazdka gwiazdka]] — typ `argv`
- [[ex01 ft_boolean.h]] — używa `argc - 1`
- [[ex04 ft_strs_to_tab]] — przetwarza `argv` jako `av`
