Created: 2026-02-28  14:30
___
Note:

>[!tip]
>managed extract, transform, load _ETL_ service
>fully serverless
>automatyzacja procesów _ETL_ (wyciąga dane, zmienia, filtruje, ładuje )
>**nie do migracji DB** (brak CDC / transactional consistency)

natomiast [[Amazon EMR]] - daje elastyczne klastry z Hadoop, Spark (przetwarzanie, analizy, transformacje, budować modele, przekształcać dane w wiedze) 

![[Pasted image 20260228143223.png]]

how to convert data into Parquet format (kolumny)

![[Pasted image 20260228143333.png]]

Glue data catalog: run Glue data clowlers

_Glue JobBookmarks_: prevent re-processing old data
_Glue DataBrew_: clean and normalize data using pre-built transformation
_Glue Studio_: new GUI to create, run and monitor ETL jobs in Glue
_Glue Streaming ETL_: build on Apache Spark Streaming: compatible with Kinesis Data Streaming, Kafka, MSK


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
