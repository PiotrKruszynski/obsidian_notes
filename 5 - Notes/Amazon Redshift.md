Created: 2026-02-28  13:17
___
Note:


>[!Definition]
>- Redshift → **managed data warehouse (OLAP)** online _analytical processing_
>- kolumnowa baza danych (**columnar storage**) → szybkie analizy
>- zapytania SQL na dużych datasetach (PB scale)
>- **MPP (Massively Parallel Processing)**
>- integracja z S3 (COPY / UNLOAD, Redshift Spectrum) ale można z DynamoDB,Kinesis, DataLake i innymi bazami
>- use case: **BI, analytics, reporting**
>- _Redshift Serverless_ -> bez klastra → płacisz za użycie, nie za infrastrukturę
>- _Redshift ML_ to build and train ML models

**Use case**: dashboards, reporting, complex aggregations
# Mental model
`Dane ładowane do Redshift → rozproszone na nodes → query wykonywane równolegle → szybki wynik`
- columnar → czyta tylko potrzebne kolumny  
- MPP → wiele nodes liczy jednocześnie  
- zoptymalizowany pod **read-heavy workloads**  
# Core features
- node types:
  - **RA3 (managed storage)** → compute + storage separated
- scaling:
  - resize cluster / concurrency scaling
- loading:
  - **COPY from S3 (fast, parallel)**
- query:
  - standard SQL (PostgreSQL-like)
- Spectrum:
  - query S3 without loading
- compression + encoding (auto)
# How it works
`S3 → COPY → Redshift tables → distributed across nodes → query (MPP)`

- data shardowane między nodes  
- leader node planuje query  
- compute nodes wykonują  
# Loading data into Redshift

_Amazon Kinesis Data Firehose_ - w przypadku strumieniowania Firehose dostarcza bezpośrednio poleceniem COPY 
COPY z S3 - najczęściej, wydajna
_Spectrum_ - można analizować bezpośrednio w S3 , a następnie zapisać wyniki do tabel Redshift - to tzw. external tables
_Federated Query / Data API_ - pozwala na ładowanie danych z zewnętrznych baz (np. RDS poprzez zapytania SQL)
_INSERT z innego źródła_ - klasyczne zapytania INSERT

# Enhanced VPC Routing
umożliwia niewchodzenie w internet, wszystko po VPC miedzy S3 a Redshift (COPY / UNLOAD itd.)

# Comparison

| Feature | Redshift | Athena |
|--------|----------|--------|
| Model | warehouse | query engine |
| Storage | internal | S3 |
| Performance | high | medium |
| Cost | cluster-based | per query |
| Use case | постоян analytics | ad-hoc |
# Exam traps
- ❌ Redshift = OLTP → NIE (OLAP only)
- ❌ dane w S3 zawsze trzeba ładować → NIE (Spectrum)
- ❌ scaling = instant → NIE (resize time)
- ❌ dobre dla małych zapytań → NIE (overkill)
- ❌ brak parallelism → NIE (MPP core feature)

# TL;DR
- Redshift = **fast OLAP warehouse**
- columnar + MPP = high performance
- S3 integration → COPY / Spectrum
- wybór: **heavy analytics → Redshift, ad-hoc → Athena**



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
