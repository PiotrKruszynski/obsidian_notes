---
tags: [c, koncepcja, wskaźniki]
powiązane: ["[[Pamięć to taśma adresów]]", "[[Przekazywanie przez wartość kontra przez adres]]", "[[Podwójny wskaźnik char gwiazdka gwiazdka]]"]
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Wskaźnik

- zmienna, która zamiast wartości trzyma **adres** innej komórki [[Pamięć to taśma adresów|pamięci]]
- `&x` — weź adres; `*p` — idź pod adres (odczyt/zapis wartości)
- typ wskaźnika (`int *`, `char *`) mówi kompilatorowi, ile bajtów i jak interpretować pod adresem
- `char *str` "jest stringiem", bo wskazuje pierwszy znak — czytasz do [[String i null terminator|`\0`]]

```c
int x = 42;
int *p = &x;   // p = adres x
*p = 100;      // zmiana przez adres → x == 100
```

> [!warning] Dereferencja `NULL` = segfault — po [[malloc, void gwiazdka i size_t|malloc]] zawsze `if (!p)`.

## Połączenia

- [[Pamięć to taśma adresów]] — skąd biorą się adresy
- [[Przekazywanie przez wartość kontra przez adres]] — po co dawać funkcji adres
- [[Podwójny wskaźnik char gwiazdka gwiazdka]] — wskaźnik na wskaźnik
- [[Kropka kontra strzałka]] — pola struktury przez wskaźnik
