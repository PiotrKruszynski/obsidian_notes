---
title: "Amazon Athena"
type: service
topic: aws
tags: ["aws", "big-data"]
created: 2026-06-09
status: draft
sr_due: 2026-07-04
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!Definition]
>- Athena → **serverless query engine (SQL on S3)**
>- zapytania SQL bez infrastruktury (no clusters)
>- działa bezpośrednio na danych w **S3 (data lake)**
>- billing: **per TB scanned**
>- wspiera formaty: CSV, JSON, **Parquet, ORC (columnar)**
>- integracja z Glue Data Catalog (metadata)
>- use column data for cost-savings (less scan)
>- prefere bigger files (>128 MB) to minimize _overhead_
>- commonly use with [[Amazon Quicksight]] for reporting


**Use case:** Business Inteligence / analitics / reporting
when you want to analyze data in S3 using serverless SQL -> Athena

# Mental model
`Dane leżą w S3 → Athena czyta pliki → wykonuje SQL → zwraca wynik`
- brak ETL / load → query-in-place  
- koszt zależy od **ilości zeskanowanych danych**  
- schema-on-read (definiujesz przy query)  
**Use case**: log analysis, ad-hoc queries, data lake analytics
# How it works
`S3 data → Athena query → scan files → return result → save output to S3`
- brak indeksów → full scan (chyba że partitioned)  
- schema definiowana w Glue  
- optymalizacja = format + partitioning  

# Comparison

| Feature | Athena | Redshift |
|--------|--------|----------|
| Model | query on S3 | data warehouse |
| Infra | none | cluster |
| Performance | lower | higher |
| Use case | ad-hoc | heavy analytics |
# Exam traps
- ❌ Athena = database → NIE (query engine)
- ❌ dane muszą być załadowane → NIE (query in place)
- ❌ koszt zależy od czasu → NIE (data scanned)
- ❌ CSV = optymalny format → NIE (Parquet lepszy)
- ❌ brak optymalizacji → NIE (partitioning kluczowe)

# TL;DR
- Athena = **SQL na S3 bez infra**
- koszt = **data scanned**
- optymalizacja: **Parquet + partitioning**


każde zapytanie w Athena to osobny request

#### **4. Convert to columnar (ETL step)** -> techniki na tańsze query
- compressing → Apache Parquet
- partitioning
- converting your data into columnar formats → Apache Parquet

👉 pełny pattern:
- raw data (JSON/CSV) → S3
- Glue / EMR → **transform → Parquet + partitioning**
- Athena → query

### **Anti-patterns**

❌ query na:
- CSV / JSON bez partitioning
    → full scan → $$$

❌ brak WHERE po partition key
→ Athena czyta wszystko

❌ małe pliki (small files problem)
→ overhead + wolniej
