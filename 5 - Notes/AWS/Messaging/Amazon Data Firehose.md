---
title: "Amazon Data Firehose"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-13
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# AWS Kinesis Data Firehose

>[!Definition]
>- zarządzany potok dostarczania danych strumieniowych do miejsc docelowych.
>- Firehose → **fully managed delivery stream** (stream → storage/analytics)
>- **serverless, auto-scaling, no shards**
>- **near real-time (buffered, mini-batch)**
>- brak retention → dane **od razu dostarczane do destination**
>- built-in: **buffering + batching + retries + compression**
>- optional **Lambda transform**
>- NIE służy do konsumowania danych (to nie stream jak KDS)
>- **near real-time** with buffering capability based on size / time ( zapisuje co jakiś czas paczkami)

# Mental model
`Producer wysyła dane → Firehose buforuje → opcjonalnie transformuje → zapisuje batch do destination.`
- brak kontroli nad offsetem (to nie log jak KDS)  
- Firehose = **delivery pipeline, nie processing engine**  
- push model → automatyczny delivery  

**Use case**: logi, analytics data lake, ingest do S3/Redshift/OpenSearch

# Core features
- buffering:
  - size: **1–128 MB**
  - interval: **60–900 s**
- destinations:
  - **S3 (default)**, Redshift (via S3), OpenSearch, Splunk, HTTP
- transform:
  - AWS Lambda (per record)
- format conversion:
  - JSON → **Parquet / ORC**
- compression:
  - GZIP, Snappy, ZIP
- security:
  - HTTPS + KMS (SSE)
- scaling:
  - **automatic (no shards, no capacity planning)**

# How it works
Producer → Firehose → buffer (size/time) → optional Lambda → batch write to destination

- zapis wyzwala: size OR time (co pierwsze)  
- Redshift → zawsze przez S3 staging  
- S3 → automatyczne prefixy (time-based partitioning)
# Comparison

| Feature | KDS | Firehose |
|--------|-----|---------|
| Model | stream (log) | delivery pipeline |
| Retention | do 365 dni | ❌ brak |
| Consumers | many | ❌ brak |
| Processing | custom | limited (Lambda) |
| Scaling | shards | auto |
| Latency | real-time | near real-time (buffer) |

# Exam traps
- ❌ Firehose = real-time processing → NIE (buffering)
- ❌ można replay dane → NIE (brak retention)
- ❌ Firehose replaces KDS → NIE (inne use case)
- ❌ Redshift direct ingest → NIE (zawsze przez S3)
- ❌ trzeba zarządzać shardami → NIE (serverless)
- ❌ multiple consumers → NIE (to nie pub/sub)

# TL;DR
- Firehose = **managed delivery → S3/Redshift/OpenSearch**
- auto scaling, zero ops, buffering (mini-batch)
- brak replay i consumerów → nie zastępuje KDS
- wybór: **store data → Firehose, process stream → KDS**










![[Pasted image 20260223210523.png]]

# [[Amazon SQS]] vs [[Kinesis Data Streams]] vs [[Amazon Data Firehose]]

| Cecha       | SQS               | Kinesis Data Streams         | Firehose                          |
| ----------- | ----------------- | ---------------------------- | --------------------------------- |
| Typ         | Kolejka           | Stream, niskopoziomowe       | Delivery , pipeline fully managed |
| Konsument   | Pull (sam bierze) | Pull (wiele niezależnych)    | Push (automatyczny)               |
| Retencja    | do 14 dni         | do 365 dni                   | brak — dostarcza od razu          |
| Real-time   | tak               | tak                          | mini-batch (bufor)                |
| Cel         | task queue        | analityka, wiele konsumentów | zapis do S3/Redshift              |
| Zarządzanie | managed           | shardy (ręczne skalowanie)   | w pełni managed                   |

![[Pasted image 20260223210549.png]]
## Typowe patterny

**Fan-out z SNS:**

```
Aplikacja  ->  SNS  ->  Firehose  ->  S3  ->  Athena / Redshift
```

**Logi z EC2:**

```
EC2 (CloudWatch Logs)  ->  Firehose  ->  S3 (partycjonowane)
```
