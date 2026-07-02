---
title: "Amazon Glue"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-03
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# AWS Glue

>[!Definition]
>- Glue → **serverless batch ETL service + Data Catalog**
>- przetwarza dane (extract → transform → load) bez zarządzania infra
>- centralny **Data Catalog (metadata)** dla S3 (Athena, Redshift, EMR)
>- oparty o **Apache Spark**
>- automatyczne wykrywanie schematu (**crawlers**)
>- use case: **data lake ETL, schema management**
>- nie w czasie rzeczywistym, nie dla HPC

# Mental model
`Dane w S3 → Glue crawler tworzy schema → Glue job (Spark) przetwarza → zapis do S3/Redshift`
- catalog = metadata (tables, schema)  
- job = transformacja danych  
- crawler = discovery schema  

**Use case**: ETL pipelines, przygotowanie danych pod Athena/Redshift

![[Pasted image 20260416134250.png]]
# Core features

### Glue Data Catalog -> - **control plane dla danych**
Wspólna warstwa metadanych — opisuje gdzie i w jakiej strukturze znajdują się twoje dane. Przechowuje schematy z różnych źródeł (S3, RDS, Redshift) i umożliwia łatwe odnajdywanie danych. Używany przez Athena, EMR i Redshift Spectrum.
Credential Vending -> to mechanizm, w którym system (np. Athena / EMR) **dynamicznie dostarcza tymczasowe credentials (IAM)** do dostępu do danych.

### Glue Job
Zadanie ETL przetwarzające dane **wsadowo** (batch). Piszesz skrypt Python/Spark, Glue go wykonuje na zarządzanym klastrze.

### Glue Bookmarks
Zapamiętuje gdzie ostatnio Glue skończył przetwarzanie — przy kolejnym uruchomieniu kontynuuje od tego miejsca. Zapobiega ponownemu przetwarzaniu starych danych.

### Glue DataBrew
Wizualne narzędzie do przygotowywania danych **bez kodowania** — drag-and-drop. Transformacje zapisywane jako **recipes** (przepisy) — wielokrotnego użytku, wersjonowane, współdzielone z zespołem. Wbudowany **data profiling** — statystyki kolumn, wartości null, rozkłady, wykrywanie anomalii. Idealne dla analityków i biznesu, nie tylko inżynierów.
![[Pasted image 20260416141018.png|800]]
### Glue Studio
Graficzny interfejs (GUI) do tworzenia i zarządzania Glue jobami **bez pisania kodu**. Generuje pod spodem skrypty Spark — skierowany do data engineerów.
### Glue Streaming ETL
Przetwarzanie danych **w czasie rzeczywistym** zamiast w partiach. Zbudowany na **Apache Spark Streaming**. Kompatybilny z Kinesis Data Streams, Kafka i MSK.


# How it works
`S3 → crawler → schema in catalog → Glue job → transform → output`
- schema-on-read  
- Spark job przetwarza dane  
- wynik trafia do S3 / warehouse  
# Comparison

| Feature | Glue | EMR |
|--------|------|-----|
| Type | serverless ETL | cluster processing |
| Infra | none | EC2/serverless |
| Control | low | high |
| Use case | pipelines | custom processing |

# Exam traps
- ❌ Glue = database → NIE (metadata + ETL)
- ❌ tylko ETL → NIE (też Data Catalog)
- ❌ wymaga cluster → NIE (serverless)
- ❌ zastępuje Athena → NIE (współpracuje)
- ❌ crawler zmienia dane → NIE (tylko schema)

# TL;DR
- Glue = **ETL + metadata (Data Catalog)**
- crawler → schema, job → transform
- wybór: **pipeline → Glue, heavy compute → EMR**



![[Pasted image 20260228143223.png]]

how to convert data into Parquet format (kolumny)

![[Pasted image 20260228143333.png]]
