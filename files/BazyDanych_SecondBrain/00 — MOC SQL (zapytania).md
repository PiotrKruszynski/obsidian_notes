---
tags: [moc, sql, rozmowa]
typ: map-of-content
---

# 00 — MOC: SQL (pod rozmowę kwalifikacyjną)

> [!summary] Czym jest ta notatka
> Punkt wejścia do vaultu SQL pod **rozmowę kwalifikacyjną**. Zakres przekrojowy: fundament → średni → kluczowe zaawansowane (window functions, CTE, indeksy), z naciskiem na pułapki, które rozmówcy najczęściej testują. Dialekt: standardowy SQL; różnice PostgreSQL/MySQL zaznaczone tam, gdzie istotne.

## Jak używać
Koncepcje (`Koncepcje/`) tłumaczą "dlaczego". Zestawy pytań (`Pytania-rozmowa SQL/`) to symulacja rozmowy — każde pytanie linkuje do koncepcji z odpowiedzią. Na powtórkę: czytaj pytania, przy każdym sprawdzaj, czy umiesz odpowiedzieć bez zaglądania.

## Fundament (przeczytaj najpierw)
- [[Model relacyjny]] — tabele, wiersze, kolumny
- [[Klucz główny i obcy]] — PK/FK, jak tabele się wiążą
- [[Logiczna kolejność wykonania zapytania]] — **klucz do połowy pytań**
- [[SELECT i filtrowanie (WHERE)]] — szkielet zapytania
- [[NULL i logika trójwartościowa]] — najczęstsza pułapka
- [[COALESCE i NULLIF]] — okiełznanie NULL-i

## Łączenie i agregacja
- [[JOIN — typy i co zwracają]]
- [[Agregacje i GROUP BY]]
- [[WHERE kontra HAVING]]
- [[CASE WHEN]] — warunkowa logika i conditional aggregation
- [[Self-join]] — JOIN tabeli ze sobą

## Średni / zaawansowany
- [[Podzapytania (subqueries)]]
- [[EXISTS kontra IN]]
- [[Window functions]]
- [[CTE (WITH)]]

## Wydajność i projektowanie
- [[Indeks — jak działa i kiedy pomaga]]
- [[Normalizacja (1NF, 2NF, 3NF)]]
- [[Transakcje i ACID]]
- [[UNION, DISTINCT i czyszczenie wyniku]]
- [[DELETE, TRUNCATE i DROP]]

## Zestawy pytań (symulacja rozmowy)
- [[Pytania: kolejność wykonania i WHERE vs HAVING]]
- [[Pytania: JOIN-y]]
- [[Pytania: NULL i agregacje]]
- [[Pytania: window functions]]
- [[Pytania: indeksy, projektowanie i transakcje]]

> [!tip] Test gotowości (przed rozmową)
> Umiesz odpowiedzieć bez zaglądania?
> 1. Kolejność wykonania klauzul i co z niej wynika? → [[Logiczna kolejność wykonania zapytania]]
> 2. INNER vs LEFT i czemu LEFT bywa gubi wiersze? → [[JOIN — typy i co zwracają]]
> 3. Czemu `= NULL` nie działa i czemu `NOT IN` z NULL zwraca pustkę? → [[NULL i logika trójwartościowa]], [[EXISTS kontra IN]]
> 4. ROW_NUMBER vs RANK vs DENSE_RANK + top-1-na-grupę? → [[Window functions]]
> 5. Jak działa indeks i jaki ma koszt? → [[Indeks — jak działa i kiedy pomaga]]
> 6. Rozwiń ACID; DELETE vs TRUNCATE? → [[Transakcje i ACID]], [[DELETE, TRUNCATE i DROP]]

> [!warning] Dialekt
> Notatki używają standardowego SQL. Główne różnice do pamiętania: limit wyników (`LIMIT` w PostgreSQL/MySQL vs `TOP`/`FETCH FIRST` w SQL Server), auto-increment (`SERIAL`/`IDENTITY` vs `AUTO_INCREMENT`), składnia dat. Jeśli rozmowa dotyczy konkretnej bazy, doprecyzuj — dostroję notatki.
