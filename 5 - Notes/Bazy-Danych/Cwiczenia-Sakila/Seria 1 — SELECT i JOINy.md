---
title: "Seria 1 — SELECT i JOINy"
type: project
topic: bazy-danych
tags: ["sql", "sakila", "cwiczenia", "join"]
created: 2026-06-10
status: draft
źródło: "sesja LLM, Claude Fable 5"
sr_due: 2026-07-03
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Seria 1 — SELECT i JOINy

> [!summary]
> Osiem zadań od prostego filtrowania do łańcuchów 4 JOIN-ów i LEFT JOIN z NULL-em. Najpierw rozwiąż sam w kontenerze ([[00 — Setup Sakila (Docker)]]), potem daj agentowi do sprawdzenia (`ćwicz`).

## Zadania

### Z1. Długie filmy dla nastolatków ★

Wypisz filmy z ratingiem `PG-13` dłuższe niż 120 minut. Kolumny: `title`, `length`, `rating`. Posortuj od najdłuższego.
Koncepcje: [[SELECT i filtrowanie (WHERE)]]

### Z2. Najtańsze wypożyczenia ★

10 filmów o najniższej stawce `rental_rate`, z nazwą języka zamiast `language_id`. Kolumny: `title`, `rental_rate`, nazwa języka.
Koncepcje: [[JOIN — typy i co zwracają]]

### Z3. Obsada jednego filmu ★★

Imiona i nazwiska wszystkich aktorów grających w filmie `ALIEN CENTER`.
Koncepcje: [[JOIN — typy i co zwracają]] (tabela łącząca M:N)

### Z4. Klienci z Kanady ★★

Imię, nazwisko i miasto klientów mieszkających w Kanadzie. Łańcuch: `customer → address → city → country`.
Koncepcje: [[JOIN — typy i co zwracają]], [[Klucz główny i obcy]]

### Z5. Filmy-widmo ★★

Filmy, których NIE ma w żadnym magazynie (brak wiersza w `inventory`). Powinno wyjść kilkadziesiąt tytułów.
Koncepcje: [[JOIN — typy i co zwracają]] (LEFT JOIN + IS NULL), [[NULL i logika trójwartościowa]]

### Z6. Imiennicy ★★★

Pary różnych aktorów o tym samym nazwisku. Każda para raz (nie A-B i B-A, nie A-A).
Koncepcje: [[Self-join]]

### Z7. Niezwrócone filmy ★★★

Wypożyczenia bez daty zwrotu: imię i nazwisko klienta + tytuł filmu + data wypożyczenia. Pamiętaj o trasie `rental → inventory → film`.
Koncepcje: [[JOIN — typy i co zwracają]], [[NULL i logika trójwartościowa]]

### Z8. Horrory w sklepie 1 ★★★

Unikalne tytuły kategorii `Horror` dostępne (mające kopię) w sklepie nr 1. Dlaczego bez `DISTINCT` wychodzi więcej wierszy?
Koncepcje: [[UNION, DISTINCT i czyszczenie wyniku]], [[JOIN — typy i co zwracają]]

## Moje rozwiązania i wnioski

_(tu wklejaj swoje zapytania i notuj, co Cię zaskoczyło — agent przy `ćwicz` zaproponuje, które wnioski przenieść do notatek koncepcji)_

## Połączenia

- [[00 — Setup Sakila (Docker)]] — jak postawić bazę do tej serii
- [[JOIN — typy i co zwracają]] — główna koncepcja ćwiczona w tej serii
- [[Logiczna kolejność wykonania zapytania]] — gdy nie rozumiesz, czemu alias nie działa w WHERE
