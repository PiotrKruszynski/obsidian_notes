AlloyDB - analityczna baza danych


takie rozwiązanie przestaje wystarczać przy gromadzeniu znacznych ilości danych
![[Pasted image 20260419093727.png]]

powstaje data warehouse - można na wielu serwerach

zwykły postgres działa na jednym serwerze -> Redshift
postgres silnik dużo równoległych małych zapytań
postgres - pod zastosowania optymalizacyjne

w rozwiązaniach analitycznych przechodzimy na formaty kolumnowe.
![[Pasted image 20260419094907.png]]

google miał problem z dwh, bo to startup i za drogo. wymyślili system rozproszony -> Google MapReduce , GoogleFileSystem
Następca Colossus
https://cloud.google.com/blog/products/storage-data-transfer/a-peek-behind-colossus-googles-file-system
![[Pasted image 20260419095940.png]]
teraz Google MapReduce już nie istnieje, a warstwa Compute wygląda teraz tak:

![[Pasted image 20260419114922.png]]

Presto -> 
Trin - open source fork Presto 
Athena -> hybryda połączenia Presto z Trino

w ATHENA
## Query Cost

$5.00 per TB of data scanned

## How to Save up to 90%

- Compression
- Partitioning
- Converting data to columnar formats (e.g. Parquet)

## Practical Tip

Always filter on the partition column:

sql

```sql
WHERE date >= '2024-01-01'
```

Without this, BigQuery scans the **entire table** and you pay for all of it.