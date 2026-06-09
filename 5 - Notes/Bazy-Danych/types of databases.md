---
title: "types of databases"
type: concept
topic: databases
tags: []
created: 2026-06-09
status: draft
---

main:  #db #cap #sql #nosql
Status: #pending 

Created: 2026-05-25  12:05
___
# Rodzaje baz danych
## 1. Relacyjne bazy danych (SQL)
**Przykłady:** PostgreSQL, MySQL, SQL Server, Oracle, DB2

Relacyjne bazy danych przechowują dane w postaci:
- tabel,
- wierszy (rows / tuples),
- kolumn,
- relacji między tabelami.
Model relacyjny został zaprojektowany wokół:
- spójności danych,
- integralności relacji,
- transakcji ACID,
- normalizacji danych.

> „Data is organized into relations (called tables in SQL), where each relation is an unordered collection of tuples.”
## Schema vs Schemaless

### SQL → schema-based

W SQL struktura danych jest definiowana wcześniej:

```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name TEXT,
    age INT
);
```

Każdy rekord musi spełniać ten schemat.
#### Zalety:
- walidacja danych,
- constraints,
- foreign keys,
- przewidywalność,
- optymalizacja zapytań.
Dzięki temu SQL często działa szybciej dla:
- złożonych relacji,
- JOINów,
- transakcji,
- raportowania.
## Relacje
- 1 do 1
- 1 do wielu
- Wiele do wielu
	- Nie implementuje się bezpośrednio.

Powód:
- redundancja danych,
- problemy ze spójnością,
- trudne aktualizacje.

Stosuje się tabelę pośrednią:

```text
users              user_addresses           addresses
------             ----------------         ---------
id                 user_id  -> FK           id
name               address_id -> FK         street
```

To:
- eliminuje duplikację,
- utrzymuje spójność,
- umożliwia skalowanie relacji.
## Constraints
SQL mocno opiera się o constraints:
- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- CHECK
- NOT NULL

Constraints wymuszają poprawność danych na poziomie bazy.

To ogromna przewaga SQL przy:
- systemach finansowych,
- ERP,
- bankowości,
- transakcjach.
# Problemy SQL przy dużej skali

Relacyjne DB były projektowane w epoce HDD.
## HDD problem
Dysk HDD:
- ma talerze,
- głowica musi fizycznie wykonać seek,
- random access jest bardzo kosztowny.
JOINy oznaczały:
- dużo seek operations,
- dużo skakania po danych,
- wysokie latency.
Szczególnie problematyczne były:
- JOINy między wieloma tabelami,
- JOINy między wieloma serwerami,
- wiele punktów zapisu.
## Skalowanie poziome SQL
SQL dobrze skaluje się pionowo:
- mocniejszy CPU,
- więcej RAM,
- szybszy storage.
Ale trudniej skaluje się poziomo:
- wiele nodów,
- rozproszony zapis,
- replikacja,
- failover,
- distributed transactions.
JOIN między serwerami jest bardzo kosztowny.
W wielu systemach rozproszonych:
- nie robi się JOINów,
- dane są denormalizowane,
- model zmienia się na „flat structure”.
# NULL w SQL
Przy bardzo dużych zbiorach danych:
- wiele opcjonalnych kolumn,
- dużo `NULL`,
- sparse data.
To powoduje:
- większy storage overhead,
- gorszą lokalność danych,
- bardziej skomplikowane indeksy,
- wolniejsze skany.
Problem szczególnie widoczny przy dynamicznych danych internetowych.
# 2. NoSQL
## Schemaless
NoSQL powstał głównie po 2000 roku.

Internet zaczął generować:
- ogromne ilości danych,
- dynamiczne struktury,
- nieregularne rekordy.

Wymuszanie jednego schematu stawało się problemem.

NoSQL pozwala:
- przechowywać różne struktury,
- łatwo dodawać pola,
- unikać ogromnej liczby `NULL`.
# SSD a NoSQL
Pojawienie się SSD zmieniło architekturę baz danych.

SSD:
- nie mają talerzy,
- nie mają kosztownego seek time,
- random access jest znacznie szybszy.

To usunęło największy problem klasycznych systemów HDD.
# Amazon Dynamo (2007)

System, który mocno wpłynął na nowoczesny NoSQL.
Amazon stworzył Dynamo dla:
- koszyka zakupów Amazon.com,
- ogromnego ruchu,
- wysokiej dostępności,
- niskich opóźnień.

Klasyczne SQL nie zapewniały:
- odpowiedniej skalowalności,
- odporności na awarie,
- szybkiego distributed write.
## Idee Dynamo

| koncepcja | sens |
|---|---|
| key-value store | prosty model danych |
| eventual consistency | szybkość zamiast ścisłej spójności |
| partitioning | podział danych między nody |
| replication | kopie danych dla odporności |
| consistent hashing | równomierne rozłożenie danych |

# CAP Theorem

W systemach rozproszonych nie da się jednocześnie w pełni zapewnić:

| element | znaczenie |
|---|---|
| Consistency | każdy node widzi te same dane |
| Availability | system zawsze odpowiada |
| Partition tolerance | system działa mimo awarii sieci/node |

Przy partycjonowaniu sieci trzeba wybrać kompromis:
- spójność,
- albo dostępność.

NoSQL często wybiera:
- wysoką dostępność,
- eventual consistency.

SQL częściej wybiera:
- silną spójność.
# 3. Document DB

**Przykłady:** MongoDB

Dane są przechowywane jako dokumenty JSON/BSON.

Przykład:

```json
{
  "name": "Piotr",
  "addresses": [
    {
      "city": "Warsaw"
    }
  ]
}
```

Nie trzeba robić JOINów:
- dane mogą być zagnieżdżone,
- odczyt jest szybszy,
- model bardziej odpowiada strukturze aplikacji.

---

## JSON vs Python dict

| cecha | JSON | Python dict |
|---|---|---|
| klucze | tylko string | dowolny typ |
| bool | true/false | True/False |
| trailing comma | niedozwolona | dozwolona |
| cudzysłowy | wymagane | opcjonalne |

Najważniejsze:
- JSON wymaga `"kluczy"` w cudzysłowach,
- brak trailing comma.

---

# 4. Key-Value DB

**Przykłady:** Redis, DynamoDB

Najprostszy model:
- klucz → wartość.

```text
"session:abc123" -> { user_id: 42 }
```

Cechy:
- bardzo szybkie,
- często in-memory,
- idealne do cache,
- proste skalowanie.

Redis:
- działa głównie w RAM,
- jest ekstremalnie szybki,
- często używany do:
  - cache,
  - rate limiting,
  - sesji,
  - kolejek.
# 5. Wide Column DB

**Przykłady:** Cassandra, HBase

Model zaprojektowany pod:
- ogromne ilości danych,
- wysoką dostępność,
- rozproszenie.

Dane są organizowane kolumnowo.

To daje:
- szybkie odczyty wybranych kolumn,
- dobrą kompresję,
- wysoką skalowalność.

Cassandra:
- bardzo dobrze skaluje się poziomo,
- nie ma single point of failure,
- opiera się o partitioning i replication.
# 6. Graph DB

**Przykłady:** Neo4j

Model oparty o:
- nodes,
- edges,
- relacje.

```text
(A) --[waga: 5]--> (B)
```

Idealny dla:
- social networks,
- rekomendacji,
- map,
- hierarchii,
- dependency graphs.

Graph DB jest szybki tam, gdzie relacje są ważniejsze niż same rekordy.

Zamiast przeszukiwać wszystko:
- traversuje graf,
- odwiedza tylko powiązane węzły.
# 7. Vector DB

**Przykłady:** Pinecone, Weaviate, Qdrant

Przechowuje embeddingi:
- wektory reprezentujące znaczenie danych.

Przykład:

```text
"kot" -> [0.12, 0.91, -0.33, ...]
```

Podobne znaczenia:
- są blisko siebie w przestrzeni wektorowej.
## Jak działa

1. Tekst trafia do modelu embeddingowego
2. Model generuje wektor
3. DB indeksuje wektory
4. Wyszukiwanie działa przez similarity search

Nie szuka:
- dokładnego słowa,
- tylko podobnego znaczenia.
## Zastosowania

- semantic search,
- RAG,
- pamięć dla LLM,
- recommendation systems,
- image similarity,
- AI assistants.
# Kiedy SQL, a kiedy NoSQL?

## SQL wybiera się gdy:
- dane są mocno relacyjne,
- ważna jest spójność,
- potrzebne są transakcje,
- jest dużo JOINów,
- model danych jest stabilny.
## NoSQL wybiera się gdy:
- dane są dynamiczne,
- potrzeba ogromnej skali,
- liczy się szybkość,
- schema często się zmienia,
- system jest rozproszony,
- można zaakceptować eventual consistency.

## Wybór bazy — decision tree

```
Potrzebujesz joinów i transakcji ACID?
├── TAK → PostgreSQL / MySQL / NewSQL
└── NIE
    ├── Dane to relacje między encjami? → Neo4j / Neptune
    ├── Time-series / metryki? → TimescaleDB / InfluxDB / Prometheus
    ├── Full-text search? → Elasticsearch / Typesense
    ├── Proste klucz-wartość / cache? → Redis
    ├── Dokumenty JSON z query? → MongoDB / Firestore
    └── High-write, time-series, multi-DC? → Cassandra / ScyllaDB
```

# Praktyka

W praktyce większość dużych systemów używa wielu baz jednocześnie:

| problem | baza |
|---|---|
| transakcje | PostgreSQL |
| cache | Redis |
| analityka | Cassandra |
| wyszukiwanie AI | Vector DB |
| relacje społeczne | Neo4j |

To podejście nazywa się:
- polyglot persistence.

Notes:

![[Pasted image 20260315152833.png]]

allegro na nosql szybszy bo kategorie zmieniaja sie zadziej a mamy przyspieszenie na odczycie
nosql skaluja sie lepiej niz sql

![[Pasted image 20260315153116.png]]

NoSQL wtedy kiedyd model jest idealnie, albo zaczyna nam brakować w SQL
