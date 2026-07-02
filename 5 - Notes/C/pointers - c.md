---
title: "pointers - c"
type: concept
topic: c
tags: ["c"]
created: 2026-06-09
status: draft
sr_due: 2026-07-21
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# pointers - c

Praktyczne pułapki przy pisaniu — teoria w [[Wskaźnik]] i [[Przekazywanie przez wartość kontra przez adres]].

- **niezainicjalizowany wskaźnik**: `int *p; *p = 5;` → crash (p trzyma losowy adres); zawsze `int *p = &x;`
- **gwiazdka przy przypisaniu adresu**: `*p = &x` to błąd — adres przypisujesz do `p`, nie `*p`
- **wskaźnik vs wartość**: `a = b` przestawia wskaźnik; `*a = *b` zmienia wartość pod adresem — to różne operacje
- pointer na pointer: tyle gwiazdek, ile skoków — `**p2` = dwa skoki ([[Podwójny wskaźnik char gwiazdka gwiazdka]])

## Połączenia

- [[Wskaźnik]] — podstawy `&` i `*`
- [[Przekazywanie przez wartość kontra przez adres]] — po co funkcji adres
- [[Podwójny wskaźnik char gwiazdka gwiazdka]] — poziomy dereferencji
