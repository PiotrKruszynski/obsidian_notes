Created: 2026-02-24  16:38
___
Note:

>[! Important]
>- AWS native technology
>- data type: _key-value_ and _document_, ma możliwość _transakcji_
>- managed _serverless NoSQL_ database, _milisecond_ latency
>- **RCU/WCU = throughput**
>- capacity (througnput) mode: 
>	- **provisioned capacity** with _auto scaling_ option
>	- **on-demand_ capacity**
>- can replace [[Amazon ElastiCache]] as a key-value store (storing session data using _TTL_ feature)
>- _Highly Available_ , _Multi AZ by default_, Read and Writes are decupled
>- **transaction** (ACID) do 100 itemów
>- **DAX** key-value cluster for read cache, _microsecond_ read latency
>- [[IAM]] base security
>- event processing: _DynamDB Stream_ to integrate with [[AWS Lambda]], or [[Kinesis Data Streams]]
>- _Global Table_ feature: active-active setup
>- auto backups:  _PITR_ window (up to 35 day), on-demand backups 
>- można masowo przenosić dane do S3 bez zużywania jednostek RCU/WCU
>- **greate to rapidly evolve schemas** and high-scale app
>- max _item_ size 400 KB

**Use case:** serverless applications development (small docks 100s KB), distributed serverless cache, **greate for rapidly evolve schemas**

# Mental model  
  
DynamoDB = **ultra-scalable key-value store bez joinów**    
- brak relacji między tabelami  
- wszystko projektujesz pod access pattern  
- schema flexible (JSON-like)
# Data model  
Tabela = collection itemów , bez relacji między tabelami
Item = wiersz (max 400 KB)  
Atrybut = kolumna (JSON-like)  
  
### Primary Key  
**Partition Key (PK)**  
- musi być unikalny  
**Composite Key (PK + Sort Key)**  
- PK → grouping  
- SK → sorting / range queries  
  
>[!exam]  
>dobry PK = wysoka kardynalność → brak hot partitions  
  
### Item
Odpowiednik wiersza w SQL. Max 400 KB. Może zawierać zagnieżdżone atrybuty (JSON-like).
### Atrybut
Odpowiednik kolumny. Typy: String, Number, Binary, Boolean, Null, List, Map, Set.
## Capacity modes  
### On-Demand  
- auto scaling  
- płacisz per request  
- brak throttlingu (praktycznie)  
👉 kiedy:  
- nieznany ruch  
- spiky traffic  
### Provisioned  
- ustawiasz RCU / WCU  
- tańsze przy stabilnym ruchu  
- może być throttling  
### RCU / WCU  
  
- **1 WCU** = 1 write (1 KB / s)  
- **1 RCU** =  
  - 1 strongly consistent read (4 KB)  
  - 2 eventually consistent reads  

## Read consistency  
**Eventually (default)**    
- tańsze    
- może być lekko stale    
**Strongly consistent**    
- zawsze aktualne    
- droższe    
## Indexes  
### LSI  
- ten sam PK, inny SK    
- tylko przy tworzeniu    
- max 5    
### GSI  
- nowy PK (+ opcjonalny SK)    
- można dodać później    
- max 20    
- osobne RCU/WCU    
  
>[!exam]  
>query po innym atrybucie → GSI  

## DynamoDB Streams  
  
- stream zmian (INSERT / UPDATE / DELETE)  
- retention: 24h  
- ordered per partition key  
  
`DynamoDB → Stream → Lambda / Kinesis`
👉 use cases:
- event-driven apps
- audit
- replication

## TTL
- auto delete itemów
- ustawiasz timestamp (Unix time)

👉 use cases:
- sessions
- cache
- logs
## Global Tables
replikuje dane między wieloma regionami AWS w czasie rzeczywistym
- multi-region active-active (read write bez konfliktów)
- replication < 1s
- write/read lokalnie

> [!exam]  
> low latency global → Global Tables

## DAX (DynamoDB Accelerator)

`App → DAX → DynamoDB`
- in-memory cache
- microsecond latency
- read-heavy workloads
⚠️:
- nie wspiera strongly consistent reads
---

## Backup & Recovery

### PITR
- do 35 dni
- restore do dowolnego momentu
### On-Demand
- snapshot
## Security
- IAM → access control
- KMS → encryption at rest
- HTTPS → in transit
- VPC Endpoint → private access
## DynamoDB vs RDS

|Cecha|DynamoDB|RDS|
|---|---|---|
|model|NoSQL|SQL|
|schema|flexible|fixed|
|joins|❌|✅|
|scaling|horizontal|vertical|
|use case|high scale|relational|
## Use cases
- serverless backend
- session store (TTL)
- event-driven apps
- high-scale APIs
- global apps
## Exam traps
- brak joinów
- PK design = klucz
- hot partition = zły PK
- GSI → query po innym polu
- DAX ≠ strongly consistent
- Streams = 24h only
## TL;DR
DynamoDB = serverless + scalable + NoSQL  
PK design > wszystko inne  
GSI = query flexibility  
DAX = cache  
Global Tables = multi-region


![[Pasted image 20260224214302.png]]


![[Pasted image 20260224214224.png]]

![[Pasted image 20260224223803.png]]

## Typowe patterny (egzamin)

**Serverless API:**

```
API Gateway  →  Lambda  →  DynamoDB
```

**Session store:**

```
App  →  DynamoDB (TTL na sesje)
```

**Event-driven:**

```
DynamoDB  →  Streams  →  Lambda  →  SNS / SQS
```

**Global low-latency:**

```
Users (EU)  →  DynamoDB Global Table (eu-west-1)
Users (US)  →  DynamoDB Global Table (us-east-1)
```

**Read-heavy z cache:**

```
App  →  DAX  →  DynamoDB
```


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
