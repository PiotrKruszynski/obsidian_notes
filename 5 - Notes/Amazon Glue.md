Created: 2026-02-28  14:30
___
Note:

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

_Glue data catalog_: jest wspólną warstwą, która opisuje, gdzie i w jakiej strukturze znajdują się Twoje dane. Przechowuje informacje o schematach danych z różnych źródeł. Umożliwia łatwe odnajdywanie i klasyfikowanie danych.
_Glue Job_: to zadanie ETL, które przetwarza dane wsadowo
_Glue Bookmarks_: zapamiętuje, gdzie ostatnio Glue zakończył przetwarzanie, by kontynuować od tej pozycji. Prevent re-processing old data.
_Glue DataBrew_: to narzędzie wizualne, które pozwala na interaktywne przygotowywanie danych, **bez kodowania**
_Glue Studio_: new GUI, środowisko no-code do zarządzania i tworzenia Glue jobów.
_Glue Streaming ETL_: umożliwia przetwarzanie danych w czasie rzeczywistym, czyli Glue przetwarza strumienie danych na bieżąco, a nie w partiach. build on **Apache Spark Streaming**: compatible with _Kinesis Data Streaming_, _Kafka_, _MSK_
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
