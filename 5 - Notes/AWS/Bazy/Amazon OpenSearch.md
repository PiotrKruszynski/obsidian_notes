---
title: "Amazon OpenSearch"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!Definition]
>- OpenSearch → **managed search & analytics engine (Elasticsearch-based)**
>- full-text search + near real-time analytics
>- dane indeksowane → szybkie zapytania (nie full scan)
>- use case: **log analytics, search, observability**
>- integracje: CloudWatch Logs, Kinesis, Firehose

# Mental model
`Data → index (inverted index) → query → fast lookup`
- zamiast scan → indeks → szybkie wyszukiwanie  
- dokumenty JSON → indeksowane  
- near real-time (sekundy opóźnienia)  

**Use case**: log search, monitoring dashboards, app search

# How it works
`Data → indexed into shards → stored → query hits index → result`
- primary shards → data distribution  
- replicas → HA + read scaling  
- search = lookup, nie scan  

# Comparison

| Feature | OpenSearch | Athena |
|--------|------------|--------|
| Model | indexed search | scan query |
| Speed | very fast | slower |
| Data | ingested | S3 raw |
| Use case | logs/search | analytics |

# Exam traps
- ❌ OpenSearch = database → NIE (search engine)
- ❌ brak indexów → NIE (core feature)
- ❌ real-time (0 latency) → NIE (near real-time)
- ❌ replace Athena → NIE (inne use case)
- ❌ no scaling → NIE (shards)

# TL;DR
- OpenSearch = **fast indexed search (logs)**
- indeks → szybkie query
- wybór: **search/logs → OpenSearch, SQL analytics → Athena**
