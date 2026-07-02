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

- `int main(int argc, char **argv)` — argumenty wiersza poleceń
- `argc` liczy wszystkie tokeny **łącznie z nazwą programu**; realne argumenty = `argc - 1`
- `argv[0]` = nazwa programu; `argv[1..argc-1]` = argumenty; `argv[argc]` = `NULL` (gwarantowany strażnik)
- `argv` to [[Podwójny wskaźnik char gwiazdka gwiazdka|tablica stringów]]

> [!warning] `./prog` bez argumentów → `argc == 1`, nie 0. Iterację po argumentach użytkownika zaczynaj od `i = 1`.

## Połączenia

- [[Podwójny wskaźnik char gwiazdka gwiazdka]] — typ `argv`
- [[Znacznik końca tablicy (sentinel)]] — `NULL` na końcu `argv`
