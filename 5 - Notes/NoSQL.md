main:  #database #nosql #distributed #architecture

Status: #pending 

Created: 2026-05-24  18:03
___
# Dlaczego NoSQL istnieje

Relacyjne bazy danych zostały zaprojektowane dla spójności i struktury — nie dla skali i elastyczności. NoSQL to **zbiór kompromisów**, nie jedna technologia. Każdy typ rozwiązuje inny problem kosztem czegoś innego.

**Główne motywacje:**

- Horyzontalna skalowalność (sharding bez bólu)
- _Schemaless_ — dane heterogeniczne lub ewoluujące szybko
- Specjalizacja pod konkretny access pattern (grafowe, time-series, wyszukiwanie)
- Latencja — brak joinów, dane denormalizowane

---

## CAP Theorem — fundament

Dystrybuowany system może mieć jednocześnie tylko **2 z 3**:

```
C — Consistency      (każdy odczyt widzi ostatni zapis)
A — Availability     (każde zapytanie dostaje odpowiedź)
P — Partition Tol.   (system działa mimo utraty połączeń między węzłami)
```

**P jest obowiązkowe** w systemach rozproszonych — sieć zawsze może się podzielić. Więc wybór to **CP vs AP**.

|Typ|Przykłady|Wybór|
|---|---|---|
|CP|MongoDB, HBase, Zookeeper|Spójność ważniejsza niż dostępność|
|AP|Cassandra, CouchDB, DynamoDB|Dostępność ważniejsza niż ścisła spójność|

CAP jest uproszczeniem — patrz też **PACELC** (trade-off latency vs consistency nawet bez partition).

---

## PACELC — rozszerzenie CAP

```
If Partition → (A vs C)
Else (normalnie) → (L vs C)
                    Latency vs Consistency
```

DynamoDB: AP/EL — wysoka dostępność przy partycji, niski latency kosztem consistency normalnie.  
Spanner (Google): CP/EC — spójność zawsze, latency wyższa.

---

## Rodzaje NoSQL

### 1. Key-Value

**Struktura:** `klucz → wartość` (opaque blob lub typ prosty)  
**Dostęp:** tylko po kluczu, zero query language  
**Skalowalność:** trywialna — hash(key) → węzeł

**Przykłady:** Redis, DynamoDB (w uproszczeniu), Riak  
**Use case:** sesje, cache, feature flags, rate limiting, distributed locks

**Redis extras:** struktury danych (list, set, sorted set, hash, stream), Lua scripts, pub/sub, persistence opcjonalna (RDB/AOF)

**Pułapka:** brak możliwości query po wartości. Jeśli potrzebujesz `WHERE value.field = X` — to nie key-value.

---

### 2. Document

**Struktura:** `klucz → dokument` (JSON/BSON, zagnieżdżony)  
**Dostęp:** po kluczu + query po polach dokumentu + indeksy  
**Schemaless:** dokumenty w jednej kolekcji mogą mieć różną strukturę

**Przykłady:** MongoDB, CouchDB, Firestore, DocumentDB  
**Use case:** CMS, katalogi produktów, profile użytkowników, dane heterogeniczne

**MongoDB write path:**

```
Write → Journal (WAL) → Memory (WiredTiger cache) → Disk
```

**Replikacja MongoDB:** Replica Set (1 primary + N secondary). Primary przyjmuje zapisy, secondary replikują async. Przy awarii primary: automatyczna elekcja przez Raft-like protokół.

**Sharding MongoDB:**

```
mongos (router) → config servers → shard (replica set)
```

Shard key determinuje rozkład danych — analogia do partition key w Cassandzie. Błędny shard key → hot shard.

**Pułapki:**

- `$lookup` (join) przez shard key = cross-shard query = wolno
- Brak transakcji multi-document poniżej v4.0 (teraz są, ale kosztowne)
- Indeksy zajmują RAM — za dużo indeksów → eviction → degradacja

---

### 3. Wide-Column

**Struktura:** tabela z dynamicznymi kolumnami per wiersz, klucz złożony  
**Dostęp:** po kluczu + range scan po clustering columns  
**Model:** bliżej relacyjnego niż document, ale bez joinów

**Przykłady:** Cassandra, HBase, ScyllaDB  
**Use case:** time-series, IoT, logi, dane z naturalnym kluczem złożonym

→ Szczegóły w notatce `cassandra-architektura.md`

**HBase vs Cassandra:**

||HBase|Cassandra|
|---|---|---|
|Architektura|Master-slave (HDFS)|Peer-to-peer|
|Spójność|Strong (CP)|Tunable (AP domyślnie)|
|Dostępność|SPOF (master)|Brak SPOF|
|Ekosystem|Hadoop/HDFS|Standalone|

---

### 4. Graph

**Struktura:** węzły (nodes) + krawędzie (edges) + właściwości  
**Dostęp:** traversal — przechodzenie relacji  
**Siła:** zapytania po relacjach są O(1) per hop, nie O(N) jak JOIN

**Przykłady:** Neo4j, Amazon Neptune, JanusGraph, Memgraph  
**Use case:** social graph, rekomendacje, fraud detection, knowledge graph, network topology

**Cypher (Neo4j) przykład:**

```cypher
-- Znajdź znajomych znajomych usera X, którzy lubią Python
MATCH (u:User {id: 'X'})-[:FRIEND]->(f)-[:FRIEND]->(fof)
WHERE (fof)-[:LIKES]->(:Tag {name: 'Python'})
  AND fof <> u
RETURN fof.name, COUNT(*) AS mutual_friends
ORDER BY mutual_friends DESC
LIMIT 10;
```

To samo w SQL → 3 JOIN-y + subquery + wolne na dużym grafie.

**Pułapka:** grafy nie skalują horyzontalnie tak łatwo jak inne typy — krawędź między węzłami może przechodzić przez różne shardy (cross-shard traversal). Neo4j komunity = single node.

---

### 5. Time-Series

**Struktura:** (timestamp, tags) → metryki  
**Dostęp:** range queries po czasie + agregacje  
**Optymalizacje:** kompresja temporalna (delta encoding), automatic downsampling, retention policies

**Przykłady:** InfluxDB, TimescaleDB (PostgreSQL ext.), Prometheus, QuestDB, TDengine  
**Use case:** metryki aplikacji, IoT sensoryka, financial ticks, logi numeryczne

**TimescaleDB** — PostgreSQL z hypertable (automatyczny partitioning po czasie). Pełne SQL, indeksy, JOIN-y. Najlepsza opcja jeśli już masz PostgreSQL i potrzebujesz time-series.

**InfluxDB** — standalone, własny query language (Flux), natywna kompresja, retention policies out of the box.

**Prometheus** — pull-based, scraping, nie nadaje się do długoterminowego storage (remote_write → Thanos/Cortex/Mimir).

---

### 6. Search Engine

**Struktura:** dokumenty + odwrócony indeks (inverted index)  
**Dostęp:** full-text search, faceted search, fuzzy matching, relevance scoring

**Przykłady:** Elasticsearch, OpenSearch, Typesense, Meilisearch  
**Use case:** wyszukiwarka produktów, logi (ELK stack), analityka tekstowa

**Elasticsearch internals:**

```
Index → Shard (Lucene instance) → Segment (immutable)
```

Zapisy trafiają do buffer → refresh (domyślnie 1s) → segment widoczny dla querów (near real-time).

**Nie używaj ES jako primary database** — eventual consistency przy zapisie, brak transakcji, komplikowane backup/restore.

---

## Indeksy w NoSQL — porównanie

|Typ bazy|Indeksowanie|
|---|---|
|Key-Value|Brak (tylko po kluczu)|
|Document|Secondary indexes na polach dokumentu|
|Wide-Column|Primary key only (SAI/SI w Cassandzie jako dodatek)|
|Graph|Automatyczne na węzłach/krawędziach|
|Time-Series|Tag-based index, kompresja temporalna|
|Search|Inverted index (Lucene)|

---

## Eventual Consistency — jak działa w praktyce

Replikacja async → węzeł B może mieć starszą wersję danych niż węzeł A przez chwilę.

**Mechanizmy rozwiązywania konfliktów:**

- **Last Write Wins (LWW)** — wygrywa zapis z wyższym timestamp. Problem: zegary w klastrze nie są idealnie zsynchronizowane (NTP ≠ atomowy). Cassandra domyślnie używa LWW.
- **Vector Clocks** — każdy węzeł trzyma wektor wersji. Umożliwia wykrycie konfliktów (nie rozwiązuje automatycznie). Riak, Dynamo.
- **CRDTs** (Conflict-free Replicated Data Types) — struktury matematycznie zaprojektowane tak, żeby merge był zawsze deterministyczny. Redis, Riak, niektóre Cassandra typy (Counter, Set).
- **Operational Transform / Paxos / Raft** — consensus-based, silna spójność, wyższy latency.

---

## Transakcje w NoSQL

|System|Transakcje|
|---|---|
|MongoDB 4.0+|ACID multi-document (replica set), multi-shard (droższe)|
|Cassandra|LWT (Paxos, tylko CAS) lub BATCH (atomowość, nie izolacja)|
|DynamoDB|TransactWriteItems (do 25 items, cross-table)|
|Redis|MULTI/EXEC (optimistic locking przez WATCH)|
|Neo4j|ACID (single-node), ograniczone w klastrze|
|FaunaDB/Spanner|Pełne ACID dystrybuowane|

**Reguła:** jeśli potrzebujesz ACID często i na wielu encjach — rozważ relacyjną bazę lub NewSQL (CockroachDB, Spanner, YugabyteDB).

---

## NewSQL — trzecia droga

Relacyjny model + SQL + horyzontalna skalowalność + ACID.

**Przykłady:** CockroachDB, Google Spanner, YugabyteDB, TiDB  
**Jak:** Raft/Paxos dla consensus, automatyczny sharding, distributed transactions przez 2PC + Raft  
**Koszt:** wyższy latency niż AP NoSQL (consensus round-trips)

Używaj gdy potrzebujesz skali Cassandry i transakcji PostgreSQL.

---

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

---

## Polyglot Persistence

Dojrzała architektura używa wielu baz jednocześnie, każdej do tego, do czego jest zoptymalizowana:

```
PostgreSQL   → dane transakcyjne (zamówienia, płatności)
MongoDB      → katalog produktów (zróżnicowana struktura)
Redis        → sesje, cache, rate limiting
Elasticsearch → wyszukiwarka produktów
Cassandra    → logi zdarzeń, historia aktywności
Neo4j        → rekomendacje ("klienci kupili też...")
InfluxDB     → metryki aplikacji
```

**Koszt:** złożoność operacyjna, synchronizacja danych między systemami (CDC, Kafka), spójność eventual między bazami.

---

## CDC — Change Data Capture

Mechanizm propagacji zmian z primary database do pozostałych systemów.

```
PostgreSQL (WAL) → Debezium → Kafka → [Elasticsearch, Redis, DWH]
MongoDB (oplog)  → Debezium → Kafka → ...
```

Alternatywa dla dual-write (write do dwóch baz w aplikacji) — dual-write jest błędogenny (partial failure → niespójność).

---

## Pułapki architektoniczne

- **Nie używaj NoSQL "bo modnie"** — jeśli dane są relacyjne, relacyjna baza wygra
- **Brak schematu ≠ brak myślenia o strukturze** — schemaless przesuwa walidację do aplikacji
- **Denormalizacja wymaga synchronizacji** — gdy dane są w wielu miejscach, każda zmiana musi trafić wszędzie
- **Eventual consistency w UI** — użytkownik zapisał, odświeżył, nie widzi — bug? Nie, feature. Trzeba projektować UX z tego świadomie
- **Vendor lock-in** — DynamoDB API nie jest standardem; migracja droga
- **"NoSQL skaluje lepiej"** — PostgreSQL z właściwym indeksem i connection poolingiem obsługuje miliony zapytań/s; nie uciekaj do NoSQL przed profilerem

---

_Źródła: "Designing Data-Intensive Applications" (Kleppmann), AWS re:Invent talks, dokumentacje oficjalne_

___
Metadate:

Tags: #empty
