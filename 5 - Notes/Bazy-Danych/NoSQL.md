---
title: "NoSQL"
type: concept
topic: databases
tags: ["databases"]
created: 2026-06-09
status: draft
sr_due: 2026-07-08
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# NoSQL — systemy rozproszone i architektura

> [!summary] Zakres tej notatki
> Teoria distributed systems: dlaczego NoSQL powstał, CAP, BASE, eventual consistency, replikacja, sharding, quorum R/W/N. Porównanie typów → [[types of databases|Typy baz danych]].

# Dlaczego NoSQL istnieje?

Relacyjne bazy danych były projektowane:
- dla struktury,
- spójności,
- transakcji,
- pojedynczych lub małych klastrów.


Nie były projektowane pod:

- Internet-scale,
- miliony requestów,
- globalne klastry,
- dynamiczne dane,
- ogromny write throughput.

# Problemy klasycznych RDBMS

## 1. Skalowanie poziome

SQL dobrze skaluje się pionowo:

- więcej RAM,
- szybszy CPU,
- większy storage.

Ale Internet wymusił:

  

- dziesiątki,
- setki,
- tysiące maszyn.

  

Problem:

- JOIN między serwerami jest bardzo kosztowny,
- distributed transactions są trudne,
- locki i synchronizacja spowalniają system.

## 2. Dynamiczne dane

W Web 2.0 dane stały się:

- heterogeniczne,
- szybko zmienne,
- częściowo nieustrukturyzowane.

  

Przykład:
- każdy użytkownik może mieć inne pola profilu,
- różne dokumenty mają różną strukturę.

W SQL prowadzi to do:
- ogromnej liczby NULL,
- szerokich tabel,
- kosztownych migracji schematu.

## 3. HDD vs SSD
Relacyjne DB były projektowane pod HDD.

HDD:
- mają talerze,
- wymagają seek operation,
- random access jest bardzo kosztowny.

JOINy generują:
- dużo seeków,
- dużo skakania po danych.

SSD usunęły ten problem:
- brak ruchomych części,
- szybki random access,
- dużo niższe latency.

To umożliwiło rozwój nowoczesnych systemów NoSQL.
# Big Data
## Charakterystyka Big Data
Big Data to dane:
- zbyt duże dla jednej maszyny,
- szybko rosnące,
- pochodzące z wielu źródeł,
- wymagające rozproszonego przetwarzania.
## Wymagania Big Data
- wysoka dostępność,
- szybki odczyt i zapis,
- regionalna replikacja,
- odporność na awarie,
- brak single point of failure,
- skalowanie horyzontalne.
# Shared Nothing Architecture
Większość NoSQL opiera się o:
- shared nothing.

Każdy node:
- jest niezależny,
- ma własny storage,
- własny RAM,
- własny CPU.

Nie istnieje centralny serwer zarządzający.

Zalety:
- łatwe skalowanie,
- brak bottlenecku,
- brak single point of failure.
# Fundamentalne techniki NoSQL
## 1. Replikacja
Te same dane są kopiowane na wiele node’ów.

Cel:
- odporność na awarie,
- większa dostępność,
- szybszy odczyt lokalny.
## 2. Partycjonowanie (Sharding)
Dane są dzielone na partycje między serwery.
Przykład:
```text

Node A -> users 1-1M
Node B -> users 1M-2M
Node C -> users 2M-3M
```

Pozwala:
- rozłożyć ruch,
- zwiększać throughput liniowo.
# CAP Theorem
W systemie rozproszonym nie można jednocześnie zapewnić:

| skrót | znaczenie           |
| ----- | ------------------- |
| C     | Consistency         |
| A     | Availability        |
| P     | Partition Tolerance |
## Definicje
### Consistency
Każdy odczyt widzi najnowszy zapis lub błąd.
### Availability
Każde żądanie dostaje odpowiedź.
Nie ma gwarancji:
- że dane są najnowsze.
### Partition Tolerance
System działa mimo:
- utraty połączeń,
- awarii części klastra,
- problemów sieciowych.
# Najważniejszy wniosek CAP
  W systemie rozproszonym:
- P jest obowiązkowe.
Sieć zawsze może się podzielić.

Więc realny wybór to:
- CP
- albo AP.
# CP vs AP

| Typ | Charakterystyka | Przykłady |
|---|---|---|
| CP | spójność ważniejsza niż dostępność | MongoDB, HBase, ZooKeeper |
| AP | dostępność ważniejsza niż ścisła spójność | Cassandra, DynamoDB, CouchDB |
# PACELC
CAP jest uproszczeniem.
PACELC mówi:
- jeśli jest partition → wybierasz A lub C,
- jeśli nie ma partition → wybierasz latency lub consistency.

Nowoczesne systemy często optymalizują:
- latency,
- throughput,
- availability.
# Yield i Harvest
Lepszy praktyczny model niż CAP.
## Yield
```text
yield = odpowiedziane requesty / wszystkie requesty
```
Mierzy:
- dostępność z perspektywy klienta.
## Harvest
```text
harvest = zwrócone dane / wszystkie dane
```

Mierzy:
- kompletność odpowiedzi.
## Przykład
Wyszukiwarka:
- jeden shard niedostępny.

Opcja 1:
- zwróć error,
- harvest = 100%,
- yield niski.

Opcja 2:
- zwróć częściowe wyniki,
- yield = 100%,
- harvest niższy.

Google zwykle wybiera:
- wysoki yield,
- częściowe odpowiedzi.
# ACID vs BASE

## ACID
Relacyjne podejście.

| Litera | Znaczenie |
|---|---|
| A | Atomicity |
| C | Consistency |
| I | Isolation |
| D | Durability |
## BASE
NoSQL podejście.

| Litera | Znaczenie |
|---|---|
| B | Basically Available |
| S | Soft State |
| E | Eventually Consistent |

# Różnice ACID vs BASE

| ACID           | BASE                   |
| -------------- | ---------------------- |
| silna spójność | eventual consistency   |
| izolacja       | optimistic concurrency |
| transakcje     | availability           |
| constraints    | elastyczność           |
| schema         | schemaless             |

---

# Eventual Consistency

Dane propagują się asynchronicznie.
Przez chwilę:
- różne node’y mogą mieć różne wersje danych.
System finalnie osiąga spójność.

# Rozwiązywanie konfliktów
## Last Write Wins (LWW)
Wygrywa rekord:
- z najwyższym timestamp.
Problem:
- zegary nie są idealnie zsynchronizowane.
Cassandra domyślnie używa LWW.

## Vector Clocks
Każdy node trzyma historię wersji.
Pozwala:
- wykryć konflikt,
- ale nie rozwiązuje go automatycznie.

## CRDT
Struktury matematyczne:
- zaprojektowane do bezkonfliktowego merge.

Merge zawsze daje:
- deterministyczny wynik.

---

## Paxos / Raft

Consensus algorithms.
Zapewniają:
- silną spójność,
- kosztem latency.
# Parametry R, W, N
## N
Liczba replik danych.
## R
Ile replik musi odpowiedzieć przy odczycie.
## W
Ile replik musi potwierdzić zapis.
# Reguła spójności
Spójność zachodzi gdy:
R \+ W \> N

---

# Charakterystyczne przypadki
## Bardzo szybki odczyt
$begin:math:display$

R \= 1\,\\ W \= N

$end:math:display$
- odczyt z jednej repliki,
- zapis musi trafić wszędzie.

---

## Bardzo szybki zapis


R \= N\,\\ W \= 1


- zapis szybki,
- odczyt kosztowny.

---

## Maksymalna wydajność

$R \= 1\,\\ W \= 1$

- bardzo szybki system,
- niska spójność.
# Indeksy w NoSQL

| Typ | Indeksy |
|---|---|
| Key-Value | tylko po kluczu |
| Document | secondary indexes |
| Wide-Column | głównie primary key |
| Graph | indeksy węzłów i relacji |
| Time-Series | tag-based indexes |
| Search | inverted indexes |
