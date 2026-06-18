# Dzień 05 — Rozdział 3 (2/2): OLTP vs OLAP i kolumnowe storage

**Książka:** Designing Data-Intensive Applications — Martin Kleppmann (2017)
**Fragment:** Rozdział 3, druga połowa — od sekcji „Transaction Processing or Analytics?" do końca
**Data:** 2026-06-18

---

## O czym jest ten fragment

Pierwsza połowa rozdziału 3 tłumaczyła, jak bazy danych przechowują i wyszukują dane dla typowych zastosowań transakcyjnych — hash-indexy, LSM-trees, B-drzewa. Druga połowa robi pivot i pyta: a co, jeśli chcemy nie pojedynczych rekordów, lecz agregatów z miliardów wierszy? Kleppmann pokazuje, że te dwa światy są tak różne, że wymagają fundamentalnie odmiennych silników.

**OLTP kontra OLAP.** OLTP (Online Transaction Processing) to klasyczny tryb pracy aplikacji: mała liczba rekordów na zapytanie, szybki zapis, dane dotyczą bieżącego stanu. OLAP (Online Analytic Processing) to tryb analityczny: jedno zapytanie skanuje miliony wierszy, czyta tylko kilka kolumn, liczy sumy i średnie, a dane reprezentują historię zdarzeń. Kleppmann zestawia oba modele w zwięzłej tabeli — i od razu widać, że nie chodzi tu o szczegóły konfiguracji, lecz o odmienną filozofię.

**Hurtownie danych.** Ponieważ analityczne zapytania na bazie OLTP szkodzą wydajności transakcji, firmy od końca lat 80. budują oddzielne hurtownie danych. Dane są pobierane z systemów OLTP procesem ETL (Extract–Transform–Load), oczyszczane i ładowane do hurtowni zoptymalizowanej pod kątem odczytu. Kleppmann wymienia komercyjnych gigantów (Teradata, Vertica, SAP HANA, Amazon Redshift) i otwarte projekty (Apache Hive, Spark SQL, Impala, Presto).

**Schematy gwiazdy i płatka śniegu.** Hurtownie danych mają charakterystyczną strukturę: centralną tabelę faktów (np. fact_sales — każdy wiersz to zdarzenie biznesowe) otoczoną tabelami wymiarów (dim_product, dim_date, dim_store...). To właśnie schemat gwiazdy. Odmiana — schemat płatka śniegu — normalizuje wymiary do subdimension-tablic, co jest czystsze, ale mniej wygodne dla analityków. Tabele faktów mogą mieć setki kolumn i dziesiątki petabajtów danych.

**Kolumnowe storage.** Tu zaczyna się prawdziwa innowacja drugiej połowy rozdziału. Tradycyjne bazy przechowują dane wierszami — wszystkie kolumny jednego rekordu sąsiadują ze sobą. Problem: analityczne zapytanie czyta tylko 4–5 kolumn z tabeli mającej 100, ale i tak musi załadować cały wiersz. Rozwiązanie: przechowuj nie wiersze, lecz kolumny osobno. Jeśli piszesz `SELECT date, product, SUM(quantity) FROM fact_sales`, silnik czyta tylko pliki kolumn `date`, `product` i `quantity` — pomijając resztę. Kluczowe: wszystkie pliki kolumn przechowują wiersze w tej samej kolejności, więc można zrekonstruować dowolny rekord biorąc k-ty element z każdego pliku.

**Kompresja kolumn.** Dane w jednej kolumnie są często repetytywne (np. kolumna kraju ma ~200 różnych wartości przy miliardach wierszy). Kleppmann opisuje bitmap encoding: dla każdej unikalnej wartości tworzymy bitmapę 0/1 (jeden bit na wiersz). Rzadkie bitmapy kompresujemy run-length encoding. Efekt: kolumna zajmuje ułamek oryginalnego rozmiaru, a operacje `WHERE product_sk IN (30, 68, 69)` sprowadzają się do bitwise OR na bitmapach — błyskawicznie.

**Porządek sortowania i wiele kolejności.** W column store można wybrać, po której kolumnie sortować dane — co działa jak indeks i dodatkowo poprawia kompresję (posortowana kolumna ma długie sekwencje tej samej wartości). Vertica poszła dalej: przechowuje te same dane posortowane na kilka różnych sposobów na różnych replikach — każde zapytanie trafia do repliki z najkorzystniejszym porządkiem.

**Zapis do column store.** Kolumnowy layout utrudnia zapis (wstawienie wiersza wymaga przepisania każdego pliku kolumny). Rozwiązanie znane z pierwszej połowy rozdziału: LSM-trees — nowe zapisy trafiają do in-memory store i są asynchronicznie mergowane do plików dyskowych. Tak właśnie działa Vertica.

**Zmaterializowane widoki i kostki OLAP.** Skoro te same agregaty pojawiają się w wielu zapytaniach, warto je zcacheować jako materialized views. Szczególnym przypadkiem jest data cube (kostka OLAP) — wielowymiarowa siatka precomputed agregatów. Umożliwia błyskawiczne odczyty, ale kosztem elastyczności: nie można zapytać o wymiar, który nie był wcześniej uwzględniony.

---

## Najważniejsze cytaty

> **"OLTP systems are typically user-facing, which means that they may see a huge volume of requests. In order to handle the load, applications usually only touch a small number of records in each query."**

Piotr, to jest definicja OLTP w jednym zdaniu. Mała liczba rekordów, ale ogromna liczba równoczesnych zapytań — stąd indeksy i optymalizacja pod kątem pojedynczego rekordu.

---

> **"The idea behind column-oriented storage is simple: don't store all the values from one row together, but store all the values from each column together instead."**

Jeden z najbardziej eleganckich pomysłów w tym rozdziale. Zmiana osi przechowywania danych — z wierszy na kolumny — to nie szczegół implementacyjny, lecz fundamentalna zmiana modelu.

---

> **"Often, the number of distinct values in a column is small compared to the number of rows [...] We can now take a column with n distinct values and turn it into n separate bitmaps."**

To wyjaśnienie bitmap encoding. Kluczowa obserwacja: kolumny mają niską kardynalność, a bitmapy pozwalają robić `AND`/`OR` na poziomie hardware — SIMD instructions działają na blokach bitów naraz.

---

> **"Different queries benefit from different sort orders, so why not store the same data sorted in several different ways? Data needs to be replicated to multiple machines anyway."**

Genialny pomysł z Vertici: skoro replikacja i tak istnieje, niech każda replika ma inne sortowanie. Zamiast kompromisu, masz optymalny layout dla każdego rodzaju zapytania.

---

> **"A data cube doesn't have the same flexibility as querying the raw data. For example, there is no way of calculating which proportion of sales comes from items that cost more than $100, because the price isn't one of the dimensions."**

Ostrzeżenie przed przedwczesną optymalizacją. Kostka OLAP jest szybka, ale zamraża strukturę zapytań. Dlatego hurtownie trzymają surowe dane i używają kostek tylko jako acceleration layer.

---

## Myśl dnia

Nie ma jednego „właściwego" silnika bazodanowego — jest wybór między dwiema fundamentalnymi filozofiami. OLTP optymalizuje pod kątem szybkiego dostępu do pojedynczych rekordów; OLAP pod kątem efektywnego skanowania miliardów wierszy. Kolumnowy storage, bitmap compression i sortowanie to techniki, które sprawiają, że analityka na petabajtach danych jest w ogóle możliwa — ale działają tylko dlatego, że zrezygnowały z optymalizacji transakcyjnych.

---

## Jutro (Dzień 06)

Jutro zaczynamy **Rozdział 4 — Encoding and Evolution** (pierwsza połowa). Temat: jak serializować dane (JSON, XML, Thrift, Protocol Buffers, Avro) i jak radzić sobie ze zmianami schematu w działającym systemie.
