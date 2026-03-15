#db 

baza danych to nic innego jak zbiór danych

rodzaje DB

rel db - MySQL, PostgresSQL, SQLServer, DB2 opieraja sie na tabelach i relacji miedzy tabelami. jeden do jeden i jeden do wielu. dlaczego nie wiele do wielu? redundancja danych!  mam tabele imie i tabele adres . jeden uzytkownik wiele akresow i wiele adresow wiele uzytkowikow dopisuje w tabelkach i duplikuje wpisy. duza duplikacja danych. to daje redundancje. jak zrobie tabele pośrednia to tez mam redundancje ale w nowej robie foreign key i dlatego jej sie nei uzywa

documnet db - MongoDB, - json key value , hierarchiczne rekordy, value moze byc bardziej zlozonym typem danych np json. czym sie rozni json od słownika? boolin data json trzyma timestampy. najwazniejsza super wazna roznica!! w sjon wszystkie klucze muszą być w cudzysłowach, nie moze byc railing comma. SA oparte o dokumenty



key-value db - Redis (do catch, in-memory wiec ultraszybka) - po prostu jest klucz do ktorej jest przypisana wartosc. 
wada to bardzo ubogi zbiór danych

wide column 
table db - 

graph db - oparta o dane hierarchiczne. wszystkie słowa świta każdy węzeł to tylko listera. nie musi przeszukiwać wszystkich słów tylko takie wycinki i wagi i dlatego tak niewiarygodnie działa
us army logistyka
obiegi dokumentów w CISCO z zbliżonym podpowiadaniem





Vectondi - istnieja listy z numerkami [1,0,1,0] . ta nauka nazywa się [[NLP]] i jest Vectorizer który robi robote. 
w tym jest też RAG, bazy RAGowe


# Rodzaje baz danych
## 1. Relacyjne DB (SQL)

**Przykłady:** MySQL, PostgreSQL, SQL Server, DB2
Opierają się na **tabelach** i **relacjach między tabelami**.
### Typy relacji
- **1 do 1** — jeden rekord w tabeli A odpowiada dokładnie jednemu rekordowi w tabeli B
- **1 do wielu** — jeden rekord w A odpowiada wielu rekordom w B (np. jeden użytkownik → wiele adresów)
### Dlaczego nie wiele do wielu?
Relacja wiele-do-wielu tworzy **redundancję danych** — wpisy się duplikują między tabelami. Zamiast tego stosuje się **tabelę pośrednią** z kluczami obcymi (Foreign Key), co kontroluje duplikację i zapewnia spójność danych.

```
users          user_addresses     addresses
------         --------------     ---------
id             user_id → FK       id
name           address_id → FK    street, city
```

---

## 2. Document DB (NoSQL)

**Przykłady:** MongoDB
Przechowuje dane jako **dokumenty JSON** — klucz może mieć wartość prostą lub złożoną (zagnieżdżony obiekt/tablica).
### JSON vs słownik w Pythonie

|Cecha|JSON|Python dict|
|---|---|---|
|Klucze|tylko string (w cudzysłowach)|dowolny typ|
|Wartości logiczne|`true` / `false`|`True` / `False`|
|Trailing comma|**niedozwolona**|dozwolona|
|Timestampy|tak (jako string lub liczba)|tak|

> **Najważniejsza różnica:** w JSON **wszystkie klucze muszą być w cudzysłowach** i **nie może być przecinka po ostatnim elemencie** (brak trailing comma).

---

## 3. Key-Value DB

**Przykłady:** Redis

Najprostsza struktura — **klucz → wartość**. Nic więcej.

- Działa **in-memory** (dane w RAM) → ultraszybka
- Idealna do **cachowania**
- Dane znikają po restarcie (chyba że skonfigurowana persistencja)

```
"sesja:abc123" → { user_id: 42, expires: 1710000000 }
"rate_limit:user:7" → 15
```

---

## 4. Wide Column DB

**Przykłady:** Apache Cassandra, HBase

Dane przechowywane **kolumnami zamiast wierszami**. Szybkie zapytania analityczne na ogromnych zbiorach danych.

---

## 5. Graph DB

**Przykłady:** Neo4j

Oparta o **dane hierarchiczne i sieciowe**. Każdy węzeł to encja (np. litera, użytkownik, miejsce), krawędzie to relacje z wagami.

Dlatego tak dobrze działa przy:

- wyszukiwaniu w grafach słów (każdy węzeł = litera, nie trzeba przeszukiwać wszystkiego — tylko wycinki grafu)
- sieciach społecznościowych
- mapach i nawigacji

```
(A) --[waga: 5]--> (B) --[waga: 2]--> (C)
```

---

## 6. Vector DB

**Przykłady:** Pinecone, Weaviate, Qdrant

Przechowuje dane jako **wektory** — listy liczb reprezentujące znaczenie tekstu lub obrazu.

### Jak to działa?

1. Tekst wchodzi do **Vectorizera** (NLP — Natural Language Processing)
2. Vectorizer zamienia słowa na liczby: `"kot" → [1, 0, 1, 0, 0.8, ...]`
3. Podobne znaczenia = **blisko w przestrzeni wektorowej**
4. Baza szuka najbliższych sąsiadów (nie dokładnych dopasowań)

### Po co?

- Wyszukiwanie semantyczne (nie po słowie kluczowym, ale po sensie)
- Pamięć dla modeli AI (LLM + RAG)
- Systemy rekomendacji



# db SQL
_schema_
jak jest schema to jest szybsza niż NoSQL

„data is organized into relations (called tables in SQL), where each relation is an unordered collection
of tuples (rows in SQL).”


# db NoSQL
_schemaless_
powstały w 2000+ . Internet generuje dużo danych ale każdy zestaw jest inny. Byłoby dużo null.
Czemu w SQL `NULL` są problematyczne? Bo bardzo spowolniają DB. 

Kiedyś używało się dysków HDD (największa wada że używa talerzy, które muszą się kręcić, jak się nie przekręci w odpowiednie miejsce to nie odczytasz) teraz SSD(mają sektory).

Relacyjne bazy danych (PostgreSQL, MySQL, Oracle) powstały w epoce HDD. Cały system był zoptymalizowany pod `HDD latency`

_SSD_ usunęło największy problem.
_Amazon Dynamo_ w 2007 było systemem, który zapoczątkował ruch NoSQL w nowoczesnej formie i była odpalana właśnie na dyskach _SSD_.

Amazon zbudował Dynamo, żeby obsłużyć **ogromny ruch w koszyku zakupów Amazon.com**. Klasyczne bazy SQL nie dawały:
- wystarczającej **skalowalności**
- **odporności na awarie**
- bardzo **niskich opóźnień**

Dlatego Dynamo wprowadziło kilka idei, które później przejęła większość NoSQL:

| **koncepcja**                  | **sens**                           |
| ------------------------------ | ---------------------------------- |
| **key-value store**            | prosty model danych                |
| **eventual consistency**       | szybkość zamiast ścisłej spójności |
| **partitioning + replication** | skalowanie na setki maszyn         |
| **consistent hashing**         | równomierne rozłożenie danych      |




spójnośc danych
skalowalność pozioma jest trudniejsza w SQL
system fail over
replikacja failing

twierdzenie CAP
spójność - dostepność do danych ten sam niezależnie od serwera
dostępność - dane zawsze dostępne
odporność na partycjonowanie - awaria pojedyńczego wezła nie wpłynie na działanie całego systemu

zamieniamy na płąską strukturę
trudno zrobic wiele punktów zapisu
constain - badają relacje miedzy 

operacja seek , jak miedzy serwerami to jeszcze gorzej
join pomiedzy serwerami jest bardzo kosztowny, w niektórych wręcz nie można ciąć po relacji

odczytywanie fragmentów danych

![[Pasted image 20260315152833.png]]

allegro na nosql szybszy bo kategorie zmieniaja sie zadziej a mamy przyspieszenie na odczycie
nosql skaluja sie lepiej niz sql

![[Pasted image 20260315153116.png]]



NoSQL wtedy kiedyd model jest idealnie, albo zaczyna nam brakować w SQL
