---
title: "AWS Lake Formation"
type: service
topic: aws
tags: ["big-data"]
created: 2026-06-09
status: draft
---

# AWS Lake Formation + Data Lake

>[!Definition]
>- **Data Lake** → centralne repo danych (**S3**) w raw form (structured + semi + unstructured)
>- **schema-on-read** (interpretujesz dane przy zapytaniu, nie przy zapisie)
>- **Lake Formation** → service do **governance + security + setup data lake**
>- centralne zarządzanie dostępem (fine-grained: DB/table/column/row)
>- integruje się z: **Glue, Athena, Redshift, EMR**
>- eliminuje ręczne IAM/ACL chaos

# Mental model
Dane trafiają do S3 → Glue tworzy metadata → Lake Formation kontroluje dostęp → Athena/Redshift query

- S3 = storage  
- Glue = schema (catalog)  
- Lake Formation = security + governance  
**Use case**: data lake, analytics platform, multi-team data access

# Core features
- Data Lake (concept):
  - storage: **S3**
  - format: raw + Parquet/ORC
  - cheap + scalable
- Lake Formation:
  - central permissions (table/column/row-level)
  - data sharing (cross-account)
  - data ingestion + setup automation
- integrates:
  - Athena, Redshift Spectrum, EMR

# How it works
S3 → Glue Catalog → Lake Formation permissions → query (Athena/Redshift)

- user → request access → LF enforces policy  
- query engine → reads only allowed data  
- brak bezpośredniego dostępu do S3 (controlled)
# Comparison

| Feature | Data Lake | Data Warehouse |
|--------|----------|---------------|
| Storage | S3 | internal |
| Schema | on-read | on-write |
| Data type | any | structured |
| Cost | low | higher |
| Use case | exploration | BI/reporting |

# Exam traps
- ❌ Lake Formation = storage → NIE (to governance)
- ❌ Data Lake = database → NIE (storage layer)
- ❌ Glue zarządza dostępem → NIE (Lake Formation)
- ❌ schema required upfront → NIE (schema-on-read)
- ❌ brak security → NIE (fine-grained access)

# TL;DR
- Data Lake = **S3 + raw data**
- Glue = schema, Lake Formation = access control
- wybór: **flexible analytics → Data Lake, structured BI → Redshift**
