---
title: "Cassandra database"
type: concept
topic: databases
tags: []
created: 2026-06-09
status: draft
---

main:  #database #nosql #distributed #cassandra
Status: #pending 

Created: 2026-05-24  19:50
___
# Apache Cassandra — Architektura

Rozproszona baza bez żadnego SPOF, share nothing
wysoko dostępna
ma regulowaną spójność ( od AP do CP)
wspiera replikacje z różnymi strategiami rozpraszania danych
integruje się z Hadoop do map/reduce

## Czym jest i kiedy używać

Cassandra to **wide-column distributed database** zoptymalizowana pod write-heavy workloady z wymaganiem wysokiej dostępności i liniowej skalowalności. Nie jest relacyjna — nie ma joinów, nie ma transakcji ACID w klasycznym sensie.

**Używaj gdy:**

- _write intensive workload_ (IoT, eventy, logi, time-series data)
- Potrzebujesz multi-datacenter replication out of the box
- biznesowe wymagania dużej dostępności
- Read pattern znany z góry (denormalizacja jest wymagana, nie opcjonalna)
- Brak single point of failure jest niezbędny

**Nie używaj gdy:**

- Potrzebujesz ad-hoc queries (OLAP → Spark, ClickHouse)
- Relacje między encjami są złożone
- Dane muszą być silnie spójne (RDBMS)

# Jak działa klaster cassandry

- ring
- multi master
- partitioner: consistent hashing (Murmur3 -> -2^63 , 2^63)

---

## Model danych

```
Keyspace → Table → Partition → Row
```

### Partition Key

Determinuje **na którym węźle** leżą dane. Wszystkie dane z tym samym partition key są na tym samym węźle (i jego replikach). Źle dobrany → hot partition → śmierć klastra.

### Clustering Columns

Sortują dane **wewnątrz partycji**. Definiują kolejność odczytu. Wybierasz je pod kątem `ORDER BY` w zapytaniach.

### Primary Key = Partition Key + Clustering Columns

```cql
CREATE TABLE events (
    user_id   UUID,
    timestamp TIMESTAMP,
    event_type TEXT,
    payload   TEXT,
    PRIMARY KEY (user_id, timestamp)
) WITH CLUSTERING ORDER BY (timestamp DESC);
```

Powyżej: `user_id` → partition key, `timestamp` → clustering column. Zapytanie `WHERE user_id = ? ORDER BY timestamp DESC LIMIT 100` jest O(1) — trafia do jednej partycji.

---

## Architektura węzłów

### Ring & Consistent Hashing

Wszystkie węzły tworzą **ring** (pierścień). Token space (2^64 wartości) jest podzielony między węzły. Każdy węzeł odpowiada za zakres tokenów. Brak mastera — każdy węzeł jest równorzędny (**peer-to-peer**).

```
hash(partition_key) → token → węzeł odpowiedzialny za ten token
```

### Virtual Nodes (vnodes)

Każdy fizyczny węzeł ma wiele tokenów (domyślnie 256). Ułatwia rebalancing przy dodawaniu/usuwaniu węzłów. Bez vnodes: dodanie węzła = ręczna rekonfiguracja tokenów.

### Gossip Protocol

Węzły wymieniają stan przez gossip (co sekundę, do 3 peers). Każdy węzeł zna stan całego klastra. Nie ma centralnego rejestru — failure detection jest dystrybuowane (Phi Accrual Failure Detector).

---

## Replikacja

```
Replication Factor (RF) = ile kopii danych trzyma klaster
```

**NetworkTopologyStrategy** (produkcja):

```cql
CREATE KEYSPACE app
WITH replication = {
    'class': 'NetworkTopologyStrategy',
    'dc1': 3,
    'dc2': 2
};
```

Repliki rozkładane są na różne rack-i w obrębie DC — tolerancja na awarię szafy/switcha.

**SimpleStrategy** — tylko dev/single-DC.

---

## Spójność (CAP & tunable consistency)

Cassandra to **AP** w CAP theorem — wybiera dostępność i partition tolerance kosztem ścisłej spójności. Ale spójność jest **tunable per query**.

### Poziomy spójności (wybrane)

|Level|Węzłów do odpowiedzi|Opis|
|---|---|---|
|`ONE`|1|Najszybszy, możliwy stale read|
|`QUORUM`|⌊RF/2⌋+1|Balans speed/consistency|
|`LOCAL_QUORUM`|quorum w lokalnym DC|Multi-DC, bez cross-DC latency|
|`ALL`|RF|Silna spójność, brak tolerancji na awarie|
|`LOCAL_ONE`|1 w lokalnym DC|Low-latency reads|

### Reguła silnej spójności

`CL_write + CL_read > RF` → strong consistency.  
Np. `QUORUM` + `QUORUM` z RF=3: `2+2 > 3` ✓

---

## Mechanizmy zapisu

### Ścieżka zapisu (write path)

```
Client → Coordinator → Węzły replik
         ↓
         Commit Log (durable, sekwencyjny) → ack do klienta
         ↓
         Memtable (in-memory, sorted)
         ↓ (flush, gdy pełna lub TTL)
         SSTable (immutable, on disk)
```

**Commit log** jest sekwencyjny → zapisy są szybkie niezależnie od rozmiaru danych.

**Memtable** → trzyma posortowane dane w pamięci przed flushem.

**SSTable (Sorted String Table)** → immutable. Każdy flush tworzy nowy plik. Dlatego potrzebny jest **Compaction**.

### Compaction

Łączy wiele SSTable → mniej plików, usuwa dane wygasłe (TTL) i oznaczone jako usunięte (tombstones). Strategie:

- **STCS** (Size-Tiered) — domyślna, dobra dla write-heavy
- **LCS** (Leveled) — dobra dla read-heavy, mniejsza amplifikacja odczytu, wyższa write amplification
- **TWCS** (Time-Window) — idealna dla time-series (dane wygasają całymi oknami czasowymi)

---

## Mechanizmy odczytu

### Read path

```
Client → Coordinator → węzeł z repliką
                        ↓
                  Bloom Filter (czy klucz jest w SSTable?)
                        ↓
                  Key Cache / Partition Summary / Partition Index
                        ↓
                  SSTable (disk read)
                  + Memtable merge
                  → Row Cache (opcjonalnie)
```

**Bloom Filter** — probabilistyczny, false positives możliwe (→ zbędny disk read), false negatives niemożliwe. Trzymany w RAM.

**Read Repair** — jeśli repliki mają różne wersje danych, coordinator naprawia je przy odczycie (async lub sync zależnie od CL).

---

## Tombstones i usuwanie

`DELETE` w Cassandzie nie usuwa natychmiast — tworzy **tombstone** (znacznik usunięcia z timestampem). Dane żyją do czasu `gc_grace_seconds` (domyślnie 10 dni), żeby replikacja mogła rozpropagować usunięcie.

**Pułapka:** Dużo tombstones → wolne odczyty. Przy query z `LIMIT` Cassandra musi przejść przez tombstones zanim zbierze wymagane wiersze. Monitor: `tombstone_warn_threshold`, `tombstone_failure_threshold`.

---

## TTL

```cql
INSERT INTO events (user_id, timestamp, payload)
VALUES (uuid(), toTimestamp(now()), 'data')
USING TTL 86400;  -- 1 dzień w sekundach
```

Wygasłe dane tworzone są jako tombstones usuwane przez compaction. TWCS + TTL = idealne combo dla time-series.

---

## Lightweight Transactions (LWT)

Jedyna forma CAS (Compare-And-Set) w Cassandzie. Używa **Paxos** — bardzo kosztowne (4x round-trips).

```cql
INSERT INTO users (id, email) VALUES (uuid(), 'x@y.com')
IF NOT EXISTS;

UPDATE users SET email = 'new@y.com'
WHERE id = ?
IF email = 'old@y.com';
```

**Używaj oszczędnie** — LWT niszczy throughput. Jeśli potrzebujesz LWT często, przemyśl model danych.

---

## Modelowanie danych — zasady

1. **Query-first design** — najpierw pytanie, potem tabela. Odwrotnie niż w SQL.
2. **Jedna tabela = jeden query pattern**. Duplikacja danych jest normalna.
3. **Partition nie może być nieograniczona** — max ~100MB, praktycznie max kilka tysięcy wierszy.
4. **Nigdy `ALLOW FILTERING`** w produkcji — full partition scan.
5. **Secondary indexes** (SI) — unikać na high-cardinality kolumnach. SAI (Storage-Attached Index) w nowszych wersjach jest lepszy.

### Przykład denormalizacji

Zamiast jednej tabeli `orders` joinowanej z `users`:

```cql
-- Query: "daj zamówienia usera X"
CREATE TABLE orders_by_user (
    user_id UUID,
    order_id TIMEUUID,
    status TEXT,
    total DECIMAL,
    PRIMARY KEY (user_id, order_id)
) WITH CLUSTERING ORDER BY (order_id DESC);

-- Query: "daj zamówienia o statusie PENDING"
CREATE TABLE orders_by_status (
    status TEXT,
    order_id TIMEUUID,
    user_id UUID,
    total DECIMAL,
    PRIMARY KEY (status, order_id)
) WITH CLUSTERING ORDER BY (order_id DESC);
```

Zapis do obu tabel — po stronie aplikacji lub przez **Materialized Views** (ostrożnie, MV mają overhead).

---

## Koordynator i hinted handoff

Gdy węzeł docelowy jest niedostępny, **coordinator** trzyma "hint" (zapamiętany zapis) i retransmituje go gdy węzeł wróci. Ograniczony czasowo przez `max_hint_window_in_ms`.

Długie awarie węzła → hinty przepełniają dysk koordynatora. Po powrocie węzła po dłuższej awarii: **repair** (`nodetool repair`) jest konieczny.

---

## Narzędzia operacyjne

|Narzędzie|Co robi|
|---|---|
|`nodetool status`|Stan klastra, tokeny, load|
|`nodetool repair`|Sync danych między replikami (konieczny regularnie)|
|`nodetool compactionstats`|Postęp compaction|
|`nodetool tpstats`|Thread pool stats — wąskie gardła|
|`nodetool tablestats`|Stats per tabela (tombstones, SSTables count)|
|`cqlsh TRACING ON`|Trace zapytania przez klaster|

**Repair** powinien być uruchamiany przynajmniej raz na `gc_grace_seconds`. Bez tego: ghost data po awariach węzłów.

---

## Metryki do monitorowania (prod)

- `ReadLatency`, `WriteLatency` — p99 kluczowe, nie średnia
- `PendingTasks` per thread pool — wzrost = saturacja
- `SSTableCount` per tabela — za dużo = compaction nie nadąża
- `TombstoneScannedHistogram` — spike = problem z modelem
- Heap usage + GC pauses — Cassandra jest JVM, G1GC standardowo
- `HintsInProgress` — węzły niedostępne

---

## Wersje i ekosystem

- **Apache Cassandra 5.x** — najnowsza gałąź OSS, SAI, Accord (nowy consensus protocol zastępujący Paxos)
- **DataStax Astra** — DBaaS oparty na Cassandze
- **ScyllaDB** — kompatybilny z CQL, przepisany w C++ (niższe latencje, brak JVM)
- **Amazon Keyspaces** — managed Cassandra-compatible na AWS (nie pełna kompatybilność)

---

## Pułapki seniorskie

- **Hot partition** — zły partition key (np. `date` zamiast `user_id`) → jeden węzeł pod pełnym obciążeniem
- **Unbounded partitions** — wiersze rosną bez ograniczeń → wolne odczyty, OOM
- **MV (Materialized Views)** — kuszące, ale mają znane bugi i performance issues; często lepiej duplikować ręcznie w aplikacji lub przez Kafka
- **Batch statements** — w Cassandzie batch ≠ szybkość. Batch jest do atomowości (i to ograniczonej), nie do bulk insert. Duże batche → koordynator staje się bottleneckiem
- **Zbyt niski `gc_grace_seconds`** — usunięte dane wracają (zombie data) jeśli zreplikowany węzeł wróci po dłuższej awarii i nie był objęty repair

---

## Quick reference — CQL

```cql
-- Sprawdź token węzłów
SELECT tokens FROM system.local;

-- Trace query
TRACING ON;
SELECT * FROM events WHERE user_id = ?;
TRACING OFF;

-- TTL aktualny dla wiersza
SELECT TTL(payload) FROM events WHERE user_id = ? AND timestamp = ?;

-- Compaction strategy zmiana
ALTER TABLE events
WITH compaction = {'class': 'TimeWindowCompactionStrategy',
                   'compaction_window_unit': 'DAYS',
                   'compaction_window_size': 1};
```

---

_Źródła: Apache Cassandra Docs, Datastax Academy, "Cassandra: The Definitive Guide" (Carpenter & Hewitt)_

___
Metadate:

Tags: #empty
