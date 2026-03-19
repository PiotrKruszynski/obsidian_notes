Created: 2026-02-23  16:27
___
Note:

>[!Definition]
>- KDS → **real-time streaming platform** for continuous data ingestion
>- dane napływają jako **stream** (nie batch) i są dzielone na _shards_
>- wielu konsumentów czyta **te same dane niezależnie**
>- dane **nie znikają po odczycie** (retention + replay)
>- _Kinesis Data Analitic_

**Use case**: logi, clickstream, IoT, real-time analytics

### Mental model
`Producer → Kinesis Stream (shards) → Consumer(s)`
- dane NIE znikają po odczycie  
- każdy consumer ma swój offset  
- można replay danych  
### Core features
- retention:
  - default: 24h
  - max: 365 dni
- replay / reprocessing
- ordering:
  - gwarantowane per **Partition Key**
- max record size: 1 MB
- encryption:
  - KMS (at rest)
  - HTTPS (in transit)
### Shards
Shard = jednostka throughput
- 1 shard:
  - write: 1 MB/s lub 1000 records/s
  - read: 2 MB/s
- więcej shardów = większa przepustowość

>[!exam]
>throughput problem → increase shards
### Capacity modes
#### Provisioned
- ręcznie ustawiasz liczbę shardów
#### On-Demand
- auto scaling

>[!exam]
>unknown traffic → on-demand
### KDS vs SQS
SQS → queue (task processing)  
KDS → stream (real-time data pipeline)

| Cecha | SQS | KDS |
|------|-----|-----|
| model | queue | stream |
| retention | do 14 dni | do 365 dni |
| replay | ❌ | ✅ |
| wielu konsumentów | ❌ | ✅ |
### Jak działa
```
Producer → shard → data stored  
Consumer 1 → czyta od początku  
Consumer 2 → czyta od swojego miejsca  
```

- każdy consumer niezależny  
- dane nie są usuwane po odczycie  

---

## TL;DR

```
SQS  →  kolejka, wiadomość znika po przetworzeniu
KDS  →  stream, dane zostają (domyślnie 24h, max 365 dni)
        wielu konsumentów czyta niezależnie, każdy od swojego miejsca
```




![[Pasted image 20260223185925.png]]

```
SQS  →  task queue, każda wiadomość przetwarza jeden konsument
KDS  →  analityka real-time, logi, wiele konsumentów czyta to samo
```

---

**Przykład:**

```
kliknięcia użytkowników → KDS → Lambda (real-time analityka)
                               → KDF (zapis do S3)
                               → ElasticSearch (wyszukiwanie)
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
