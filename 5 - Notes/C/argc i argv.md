---
tags: [c, koncepcja, podstawy]
powiązane: ["[[Podwójny wskaźnik char gwiazdka gwiazdka]]"]
sr_due: 2026-07-08
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
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
> Liczba **prawdziwych** argumentów to `argc - 1` — licz je *bez* nazwy programu. `./prog` (zero argumentów) → `argc - 1 == 0`.

> [!example] Przekazywanie dalej
> Funkcja `f(int ac, char **av)` dostaje te same `argc`/`argv` pod innymi nazwami. `av` jest typu `char **`, więc przetwarzasz je tak jak w [[Podwójny wskaźnik char gwiazdka gwiazdka]].

## Połączenia
- [[Podwójny wskaźnik char gwiazdka gwiazdka]] — typ `argv`
