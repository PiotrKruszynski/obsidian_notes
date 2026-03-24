Created: 2026-02-28  14:30
___
Note:

# AWS Glue

>[!Definition]
>- Glue → **serverless ETL service + Data Catalog**
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
# Core features
Glue Data Catalog:
  - central metadata store (tables, partitions)
Crawlers:
  - auto schema detection
ETL Jobs:
  - Spark-based, serverless
Glue Studio:
  - visual ETL builder
- integration:
  - Athena, Redshift, EMR
- pricing:
  - per job runtime (DPU)

Glue data catalog: run Glue data clowlers
_Glue JobBookmarks_: prevent re-processing old data
_Glue DataBrew_: clean and normalize data using pre-built transformation
_Glue Studio_: new GUI to create, run and monitor ETL jobs in Glue
_Glue Streaming ETL_: build on Apache Spark Streaming: compatible with Kinesis Data Streaming, Kafka, MSK
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
