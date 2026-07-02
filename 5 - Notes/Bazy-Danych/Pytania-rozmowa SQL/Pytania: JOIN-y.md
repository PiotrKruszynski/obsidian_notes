---
tags: ["interview", "sql"]
status: draft
sr_due: 2026-07-10
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Pytania: JOIN-y

> [!abstract] Po co ten zestaw
> JOIN-y padają niemal zawsze. Klucz to umieć powiedzieć, co dzieje się z wierszami **bez dopasowania**. Baza: [[JOIN — typy i co zwracają]].

## Q: Różnica INNER vs LEFT JOIN?
INNER zwraca tylko dopasowane pary; LEFT zwraca wszystkie wiersze z lewej tabeli, a brakujące prawe uzupełnia [[NULL i logika trójwartościowa|NULL]]-ami.

## Q: Jak znaleźć wiersze z lewej tabeli BEZ dopasowania po prawej?
LEFT JOIN + `WHERE prawa.klucz IS NULL` (tzw. anti-join). Albo `NOT EXISTS`.

## Q: Czemu mój LEFT JOIN nagle gubi wiersze?
Bo warunek na prawej tabeli trafił do WHERE (`WHERE o.amount > 100`) — NULL dla niedopasowanych daje UNKNOWN i wypada, więc LEFT zachowuje się jak INNER. Lekarstwo: warunek do `ON`. → [[JOIN — typy i co zwracają]].

## Q: Skąd biorą się duplikaty po JOIN?
Gdy jednemu wierszowi z jednej strony odpowiada wiele z drugiej (relacja jeden-do-wielu). To nie błąd JOIN-a, tylko natura danych.


## Q: Znajdź pracowników zarabiających więcej niż ich przełożony.
Self-join tabeli `employees` z samą sobą po `e.manager_id = m.id`, warunek `e.salary > m.salary`. → [[Self-join]].

> [!tip] Zadanie z białą tablicą
> Często proszą o naszkicowanie wyniku INNER vs LEFT na dwóch małych tabelach. Narysuj 3–4 wiersze i pokaż NULL-e — to przekonuje bardziej niż definicja.
