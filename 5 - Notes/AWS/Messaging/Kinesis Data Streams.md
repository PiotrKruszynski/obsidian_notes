---
title: "Kinesis Data Streams"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-06
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!Definition]
>- KDS → **real-time streaming platform (ordered, replay able event log)**
>- dane napływają jako **continuous stream (append-only log)** podzielony na _shards_
>- wielu konsumentów czyta **te same dane niezależnie (fan-out)**
>- dane **nie znikają po odczycie** (retention + replay)
>- używa wyłącznie HTTPS(TLS)
>- integracje:
  >	- Kinesis Data Analytics (SQL / Apache Flink)
  >	- Lambda, Firehose, custom consumers

**Use case**: logi, clickstream, IoT, monitoring, real-time analytics

---

## Mental model
`Producer → Kinesis Stream (shards) → Consumer(s)`

- dane są zapisywane jako **append-only log**
- każdy consumer ma swój **offset (sequence number)**
- możliwy **replay danych w oknie retencji**
- wielu consumerów może czytać równolegle (nie blokują się)

---

## Core features

- retention:
  - default: 24h
  - max: 365 dni

- replay / reprocessing
  - consumer może czytać od dowolnego miejsca (offset)

- ordering:
  - gwarantowane **per shard (czyli per partition key mapping)**

- max record size:
  - **1 MB**

- encryption:
  - KMS (at rest)
  - HTTPS (in transit)

---

## Shards

Shard = **unit of throughput + ordering**

- 1 shard:
  - write: **1 MB/s lub 1000 records/s**
  - read:
    - standard: **2 MB/s shared**
    - EFO: **2 MB/s per consumer**

- partition key:
  - decyduje do którego shardu trafia rekord (hash)
  - ⇒ ordering tylko w obrębie shardu

👉 więcej shardów:
- + większy throughput
- + większy parallelism
- - słabszy global ordering

> [!exam]
> throughput problem → increase shards  
> hot partition → zmień partition key

---

## Capacity modes

### Provisioned
- ręcznie ustawiasz liczbę shardów
- pełna kontrola + niższy koszt przy stabilnym ruchu

### On-Demand
- auto scaling shardów
- lepsze dla nieprzewidywalnego trafficu

> [!exam]
> unknown / spiky traffic → on-demand

---
## Consumers

### Standard consumer
- pull model
- współdzielony throughput (2 MB/s per shard)

---
### Enhanced Fan-Out (EFO)
- dedykowany throughput per consumer
- ~2 MB/s per shard **per consumer**
- niższy latency (~70 ms)

👉 gdy masz wielu niezależnych consumerów

---
## Offset / Checkpointing

- consumer zarządza offsetem (sequence number)
- checkpoint zwykle w:
  - DynamoDB
  - KCL (Kinesis Client Library)

👉 pozwala na:
- resume
- replay
- fault recovery

---
## Scaling

- manual:
  - split / merge shards

- on-demand:
  - AWS skaluje automatycznie

---
## KDS vs SQS

SQS → queue (task processing)  
KDS → stream (event pipeline)

| Cecha | SQS | KDS |
|------|-----|-----|
| model | queue | append-only log |
| retention | do 14 dni | do 365 dni |
| replay | ❌ | ✅ |
| wielu konsumentów | ❌ (1 msg → 1 consumer) | ✅ |
| ordering | FIFO tylko | per shard |

---

## Jak działa (dokładniej)



![[Pasted image 20260223185925.png]]

```
SQS  →  task queue, każda wiadomość przetwarza jeden konsument
KDS  →  analityka real-time, logi, wiele konsumentów czyta to samo
```

---

**Przykład:**

```
kliknięcia użytkowników → KDS → Lambda (real-time analityka)
                               → KDF (zapis do S3)
                               → ElasticSearch (wyszukiwanie)
```
