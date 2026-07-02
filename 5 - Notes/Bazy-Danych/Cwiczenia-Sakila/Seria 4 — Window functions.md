---
title: "Seria 4 — Window functions"
type: project
topic: bazy-danych
tags: ["sql", "sakila", "cwiczenia", "window-functions"]
created: 2026-06-10
status: draft
źródło: "sesja LLM, Claude Fable 5"
sr_due: 2026-07-10
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Seria 4 — Window functions

> [!summary]
> Siedem zadań na funkcje okienkowe: rankingi, running total, LAG i udziały procentowe. Kluczowa lekcja serii: okno NIE zwija wierszy (w przeciwieństwie do GROUP BY) i nie działa w WHERE.

## Zadania

### Z1. Top 3 najdroższe per kategoria ★★★

Dla każdej kategorii trzy filmy o najwyższym `rental_rate`. `ROW_NUMBER()` + CTE, filtr po numerze na zewnątrz. Dlaczego filtr nie może być w WHERE tego samego SELECT-a?
Koncepcje: [[Window functions]], [[CTE (WITH)]], [[Logiczna kolejność wykonania zapytania]]

### Z2. RANK kontra DENSE_RANK ★★

Zrankuj filmy po `length` malejąco trzema funkcjami obok siebie: `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`. Znajdź pierwszy remis i opisz, jak każda funkcja go potraktowała.
Koncepcje: [[Window functions]]

### Z3. Konto klienta rośnie ★★★

Dla klienta o id 1: każda płatność + suma narastająca (running total) po dacie płatności.
Koncepcje: [[Window functions]] (SUM OVER z ORDER BY)

### Z4. Dni między wypożyczeniami ★★★

Dla klienta o id 1: każde wypożyczenie + ile dni minęło od poprzedniego (`LAG`). Pierwszy wiersz powinien mieć NULL — dlaczego?
Koncepcje: [[Window functions]], [[NULL i logika trójwartościowa]]

### Z5. Płatność na tle średniej ★★★

Każda płatność klienta obok jego ŚREDNIEJ płatności (AVG OVER PARTITION BY) + różnica. Zauważ: wszystkie wiersze zostają — GROUP BY by je zwinął.
Koncepcje: [[Window functions]], [[Agregacje i GROUP BY]] (kontrast!)

### Z6. Udział kategorii w torcie ★★★★

Przychód każdej kategorii + jej procentowy udział w całkowitym przychodzie (`SUM(...) OVER ()` bez PARTITION). Jedno zapytanie, bez podzapytań skalarnych.
Koncepcje: [[Window functions]], [[CTE (WITH)]]

### Z7. Kwartyle długości ★★★★

Podziel filmy na 4 kwartyle po długości (`NTILE(4)`), potem policz min/max/avg długości w każdym kwartylu.
Koncepcje: [[Window functions]], [[Agregacje i GROUP BY]]

## Moje rozwiązania i wnioski

_(kontrast „okno vs GROUP BY" z Z5 to gotowy materiał na [!tip] w [[Window functions]])_

## Połączenia

- [[Seria 3 — Podzapytania i CTE]] — CTE wraca tu jako opakowanie dla okien
- [[Window functions]] — główna koncepcja serii
- [[Logiczna kolejność wykonania zapytania]] — wyjaśnia, czemu okna nie działają w WHERE (Z1)
