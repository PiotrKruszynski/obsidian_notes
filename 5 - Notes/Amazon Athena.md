Created: 2026-02-28  12:37
___
Note:

>[!tip]
>_serverless_ query service to analyze daata stored in [[Amazon S3]]
>use standard SQL language to query files (built on _Presto_)
>support csv, json, orc, avro, parquet
>kosztuje 5$ / TB przeskanowanych danych
>commonly use with [[Amazon Quicksight]] for reporting
>- use column data for cost-savings (less scan)
>	- Apache Parquet or ORC is recommended
>	- huge performence improvement
>	- use [[Amazon Glue]] to conver your data to Parquet or ORC

**Use case:** Business Inteligence / analitics / reporting
when you want to analyze data in S3 using serverless SQL -> Athena

>
>




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
