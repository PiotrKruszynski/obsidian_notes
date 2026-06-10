---
title: "Seria 3 — Podzapytania i CTE"
type: project
topic: bazy-danych
tags: ["sql", "sakila", "cwiczenia", "cte", "subquery"]
created: 2026-06-10
status: draft
źródło: "sesja LLM, Claude Fable 5"
---

# Seria 3 — Podzapytania i CTE

> [!summary]
> Siedem zadań: od podzapytania skalarnego, przez pułapkę NOT IN z NULL-em, po rekurencyjne CTE generujące kalendarz. Tu zaczyna się SQL „rozmówkowy".

## Zadania

### Z1. Dłuższe niż średnia ★★

Filmy dłuższe niż średnia długość wszystkich filmów: `title`, `length`, różnica od średniej.
Koncepcje: [[Podzapytania (subqueries)]]

### Z2. Klienci-duchy ★★★

Klienci, którzy nigdy niczego nie wypożyczyli. Rozwiąż DWA razy: przez `NOT EXISTS` i przez `NOT IN`. Sprawdź, czy wyniki są identyczne, i wyjaśnij, kiedy `NOT IN` potrafi zwrócić pusty wynik mimo istnienia takich klientów.
Koncepcje: [[EXISTS kontra IN]], [[NULL i logika trójwartościowa]]

### Z3. Drożsi od swojej kategorii ★★★

Filmy z `rental_rate` wyższym niż średnia ich własnej kategorii (podzapytanie skorelowane). Następnie zastanów się, czemu to wolne przy dużej tabeli.
Koncepcje: [[Podzapytania (subqueries)]]

### Z4. Klienci powyżej średniej ★★★

CTE `przychody` (klient → suma płatności), potem klienci z sumą powyżej średniej wszystkich sum. Kolumny: imię, nazwisko, suma.
Koncepcje: [[CTE (WITH)]], [[Agregacje i GROUP BY]]

### Z5. Hit każdego sklepu ★★★★

Dla każdego sklepu: kategoria generująca największy przychód. Użyj dwóch CTE (przychód per sklep+kategoria → maksimum per sklep).
Koncepcje: [[CTE (WITH)]], [[Podzapytania (subqueries)]]

### Z6. Refaktor czytelności ★★★

Weź swoje rozwiązanie Z3 (albo dowolne zagnieżdżone) i przepisz na CTE. Porównaj czytelność — które łatwiej debugować kawałek po kawałku?
Koncepcje: [[CTE (WITH)]]

### Z7. Kalendarz wypożyczeń ★★★★

`WITH RECURSIVE`: wygeneruj wszystkie daty z lipca 2005 i dla każdej policz liczbę wypożyczeń — łącznie z dniami, w których było ZERO (te dni nie istnieją w `rental`, więc zwykły GROUP BY ich nie pokaże!).
Koncepcje: [[CTE (WITH)]] (część rekurencyjna), [[JOIN — typy i co zwracają]] (LEFT JOIN do kalendarza)

## Moje rozwiązania i wnioski

_(Z2 i Z7 to najczęstsze „zagięcia" na rozmowach — wnioski stąd niemal na pewno zasługują na [!warning] w notatkach koncepcji)_

## Połączenia

- [[Seria 2 — Agregacje i GROUP BY]] — agregacje wracają tu wewnątrz CTE
- [[CTE (WITH)]] — główna koncepcja serii
- [[EXISTS kontra IN]] — Z2 to praktyczny dowód różnicy, którą ta notatka opisuje
