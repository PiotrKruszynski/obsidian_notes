---
title: "function C"
type: concept
topic: c
tags: ["c"]
created: 2026-06-09
status: draft
sr_due: 2026-07-03
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# function C

- funkcja = zbiór instrukcji pod identyfikatorem; cel: reużywalność
- anatomia: `typ_zwracany nazwa(parametry) { ciało; return wartość; }`
- `void` = nic nie zwraca / brak parametrów: `void f(void)`
- deklaracja (prototyp) przed użyciem, definicja raz — [[Deklaracja kontra definicja]]

## C vs Python

| Cecha | Python | C |
| --- | --- | --- |
| Typowanie | dynamiczne | statyczne, jawne |
| Argumenty domyślne/nazwane | tak | nie |
| Wiele wartości zwracanych | tak (krotka) | nie (struktura albo wskaźniki) |
| Przeciążanie | nie (`*args`) | nie (różne nazwy) |

## Połączenia

- [[Deklaracja kontra definicja]] — prototyp vs ciało
- [[Przekazywanie przez wartość kontra przez adres]] — jak funkcja dostaje argumenty
- [[write i deskryptory plików]] — najprostsze funkcje wyjścia
