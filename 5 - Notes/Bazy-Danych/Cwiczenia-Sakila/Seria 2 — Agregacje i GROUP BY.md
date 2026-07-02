---
title: "Seria 2 — Agregacje i GROUP BY"
type: project
topic: bazy-danych
tags: ["sql", "sakila", "cwiczenia", "group-by"]
created: 2026-06-10
status: draft
źródło: "sesja LLM, Claude Fable 5"
sr_due: 2026-07-17
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Seria 2 — Agregacje i GROUP BY

> [!summary]
> Osiem zadań na GROUP BY, HAVING i pułapki COUNT-a z NULL-ami. Warunek wejścia: Seria 1 zrobiona — tu JOIN-y są narzędziem, nie tematem.

## Zadania

### Z1. Filmy per rating ★

Ile filmów ma każdy rating? Kolumny: `rating`, liczba. Posortuj malejąco.
Koncepcje: [[Agregacje i GROUP BY]]

### Z2. Średnia długość per kategoria ★

Średnia długość filmu w każdej kategorii, zaokrąglona do 1 miejsca, malejąco.
Koncepcje: [[Agregacje i GROUP BY]]

### Z3. Przychód per sklep ★★

Suma wszystkich płatności w rozbiciu na sklep. Trasa: `payment → rental → inventory → store` (albo krótsza — uzasadnij wybór).
Koncepcje: [[Agregacje i GROUP BY]], [[JOIN — typy i co zwracają]]

### Z4. Top 10 klientów ★★

Dziesięciu klientów z największą sumą płatności: imię, nazwisko, suma, liczba płatności.
Koncepcje: [[Agregacje i GROUP BY]]

### Z5. Tylko długie kategorie ★★

Kategorie, w których ŚREDNIA długość filmu przekracza 120 minut. Czemu warunek nie może być w WHERE?
Koncepcje: [[WHERE kontra HAVING]], [[Logiczna kolejność wykonania zapytania]]

### Z6. Przychód miesięczny ★★

Suma płatności per rok-miesiąc (np. `2005-07`). Posortuj chronologicznie.
Koncepcje: [[Agregacje i GROUP BY]]

### Z7. Pracowici aktorzy ★★★

Aktorzy, którzy zagrali w więcej niż 30 filmach: imię, nazwisko, liczba filmów, malejąco.
Koncepcje: [[Agregacje i GROUP BY]], [[WHERE kontra HAVING]]

### Z8. Pułapka COUNT ★★★

Na tabeli `rental` policz w JEDNYM zapytaniu: `COUNT(*)`, `COUNT(return_date)` i ich różnicę. Co oznacza wynik i dlaczego te liczby się różnią?
Koncepcje: [[NULL i logika trójwartościowa]], [[Agregacje i GROUP BY]]

## Moje rozwiązania i wnioski

_(wklejaj zapytania + wnioski; różnica COUNT(*) vs COUNT(kolumna) to klasyk rozmów rekrutacyjnych)_

## Połączenia

- [[Seria 1 — SELECT i JOINy]] — poprzednia seria, JOIN-y używane tutaj jako narzędzie
- [[Agregacje i GROUP BY]] — główna koncepcja serii
- [[WHERE kontra HAVING]] — Z5 i Z7 ćwiczą dokładnie tę różnicę
