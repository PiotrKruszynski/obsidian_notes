Created: 2026-03-28  22:50
___
Note:


>[! Definition ]
>**Hadoop** = **batch processing** + **distributed storage** [[HDFS]]
> - Skalowanie poziome → tanie maszyny zamiast jednego dużego serwera
> - Obliczenia blisko danych (data locality)
> - High latency, high throughput → NIE do real-time
> - Core: [[HDFS]] + [[YARN]] + [[MapReduce]]
> - Dziś często zastępowany przez [[Spark]] / cloud-native (_S3 + EMR / Glue_)

# Definition
- **Apache Hadoop** → open-source framework do **distributed storage + distributed processing**
- działa na **klastrze commodity hardware (tanie maszyny)**
- core:
    - **HDFS** → storage
    - **MapReduce** → processing
- klucz: **data locality (liczenie tam gdzie dane)**

# Mental model 
> ** przenosisz compute do danych** -> wysyłam kod (kilka KB) do node’a z dannymi
- dane są **rozbite na bloki i rozproszone po node’ach**
- job jest wysyłany do node’ów → każdy liczy lokalnie
- wynik składany na końcu
👉 efekt: skalowanie poziome + mniej network bottleneck

# Architektura (core komponenty)

### 1. HDFS (storage layer)
- **block storage** (po 128MB)**
- każdy blok ma **replikację** (domyślnie **x3**) → fault tolerance
- role:
    - **NameNode** → metadata (gdzie są dane)
    - **DataNodes** → trzymają dane

👉 właściwości:
- write-once, read-many
- zoptymalizowane pod **duże pliki (TB/PB)**
- HDFS trzyma wszystko -> schema-free
---

### 2. MapReduce (compute layer)
- model przetwarzania:
    - **Map → Shuffle → Reduce**
- działa równolegle na wielu node’ach
👉 problem:
- wolny (disk-based, batch)
- skomplikowany dla devów

---
### 3. YARN (resource manager)
- zarządza:
    - CPU
    - memory
    - scheduling jobów -> przypisuje task do node’a z danymi
kto, gdzie może liczyć
scheduler

---
# Jak to działa (flow)
1. wrzucasz dane do HDFS
2. Hadoop dzieli je na bloki
3. MapReduce uruchamia joby na node’ach
4. każdy node liczy lokalnie
5. wyniki są agregowane

---
# Core właściwości (egzaminowe)
- **horizontal scalability** (dodajesz node’y)
- **fault tolerance** (replication)
- **data locality**
- **batch processing**
- działa na **commodity hardware**

---
# Ekosystem Hadoop (ważne)
- **Hive** → SQL na Hadoop
- **HBase** → NoSQL (column store)
- **Pig** → data pipelines
- **Spark** → nowy engine (ważne!)

---
# Use cases
- ETL (duże batch joby)
- log processing
- data lake (historycznie)
- archiwizacja danych

---
# Dlaczego Hadoop powstał (principle)

Problem:
- dane rosną szybciej niż pojedyncze maszyny
Rozwiązanie:
- zamiast **scale up (większy serwer)** → **scale out (więcej serwerów)**

---
# Wady (bardzo ważne — real world)
- ❌ **wysoka latencja (batch)**
- ❌ **MapReduce trudny w użyciu**
- ❌ **duża złożoność operacyjna (cluster management)**
- ❌ **disk-based → wolny vs RAM**

👉 dlatego:
- Spark → in-memory
- Databricks → managed platform

---
# Hadoop vs Spark / Databricks (intuicja)

- Hadoop = **infrastructure + system**
- Spark = **engine (szybszy compute)**
- Databricks = **platform (managed Spark + ecosystem)**

👉 mental shortcut:
> Hadoop = “DIY big data cluster”  
> Databricks = “managed big data platform”

---
# Kiedy używasz Hadoop (dziś)
- legacy systemy
- bardzo tanie storage + batch
- on-prem big data

👉 w cloud:
- zamiast Hadoop → **EMR / Databricks / Spark**

---
# TL;DR
- Hadoop = **HDFS + MapReduce + YARN**
- działa na **klastrze**
- **przetwarzanie blisko danych**
- **fault tolerance przez replikację**
- **batch → wolny → wypierany przez Spark**

___
Metadata:

```yaml
---
language: bigdata
---
```

Status: #pending
Tags: #bigdata 
