Created: 2026-02-28  13:17
___
Note:

>[!tip]
> is based on PostgresSQL, but it's not used _OLTP_ (online transaction processing - typ obciążenia)
>  it's _OLAP_ -> online analytical processing (analytics and data warehousing)
> to hurtownia danych zorientowana na _OLAP_
> - columnar storage of data (not row) & parallel query engine
> - 10x better performance than other data warehouse, scale to PBs of data
> - has SQL interface for performing the queries
> - BI tool such as Amazon Quicksight or Tableau integrate with it
> - vs Athena: faster queries / joins/ aggrigations thanks to indexes
> - two mode: _Provisioned cluster_ and _Serverless cluster_
> 

# Redshift Cluster
leader node
compute mode

in provision mode: choose instance type

# Loading data into Redshift

Amazon Kinesis Data Firehose - w przypadku strumieniowania Firehoes dostarcza bezpośrednio
COPY z S3 - najczęściej, wydajna
Spectrum - można analizować bezpośrednio w S3 , a następnie zapisać wyniki do tabel Redshift - to tzw. external tables
Federated Query / Data API - pozwala na ładowanie danych z zewnętrznych baz (np. RDS poprzez zapytania SQL)
INSERT z innego źródła - klasyczne zapytania INSERT




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
