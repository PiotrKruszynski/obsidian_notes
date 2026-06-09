---
title: "Amazon EMR"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-02-28  14:20
___
Note:


>[!Definition]
>- EMR → **managed big data platform (Hadoop/Spark ecosystem)**
>- uruchamiasz frameworki: **Apache Spark, Hadoop, Hive, HBase, Presto**
>- przetwarzanie dużych datasetów (ETL, batch analytics)
>- działa na **EC2 cluster** lub **serverless (EMR Serverless)**
>- integracja z **S3 (data lake)** zamiast HDFS
>- use case: **ETL, big data processing, ML pipelines**
>- serverless

# Mental model
`Data w S3 → EMR cluster (Spark/Hadoop) → distributed processing → wynik do S3`
- cluster = wiele EC2 (master + core + task nodes)  
- job dzielony na części → parallel processing  
- S3 jako storage → compute decoupled  

**Use case**: ETL pipelines, large-scale transformations, batch processing

# Core features
- frameworks:
  - **Spark (default)**, Hadoop, Hive
- deployment:
  - **EMR on EC2**
  - **EMR Serverless**
  - EMR on EKS
- storage:
  - **S3 (EMRFS)** zamiast HDFS
- scaling:
  - auto scaling nodes
- pricing:
  - EC2 + EMR fee / serverless per job
- Spot Instances:
  - tańsze przetwarzanie batch

# How it works
`S3 → EMR (Spark job) → distributed compute → output to S3`
- master node → zarządza job  
- workers → wykonują tasks  
- Spark → in-memory processing (fast)  

# Comparison

| Feature | EMR | Athena |
|--------|-----|--------|
| Model | processing engine | query engine |
| Use | ETL, transform | query |
| Control | high | low |
| Infra | cluster/serverless | none |

# Exam traps
- ❌ EMR = database → NIE (processing engine)
- ❌ zawsze serverless → NIE (EC2 default)
- ❌ dane w EMR → NIE (S3 preferred)
- ❌ lepsze do simple queries → NIE (Athena lepsza)
- ❌ brak Spark → NIE (core use case)

# TL;DR
- EMR = **big data processing (Spark/Hadoop)**
- S3 = storage, EMR = compute
- wybór: **ETL/transform → EMR, SQL query → Athena**


___
Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```

Status: #pending
Tags: #aws
