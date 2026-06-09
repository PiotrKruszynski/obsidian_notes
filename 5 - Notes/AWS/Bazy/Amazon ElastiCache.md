---
title: "Amazon ElastiCache"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!Definition]
>ElastiCache = **managed in-memory cache (_Redis_, _Memcached_)**
>data model: **key-value, cannot use SQL**
>ElastiCache = **cache przed DB**
>
👉 App:
>- najpierw pyta cache  
>- jeśli MISS → idzie do DB
>
> **code change require**
> max Redis item size **512 MB**

**Use case:** caching DB queries, session store, frequent reads, real-time data  
⚠️ cache ≠ source of truth

Redis: _gaming leaderboards_ bo gwarantuje uniqueness and element ordering

### Core properties
- key-value store (no SQL)
- in-memory → **sub-millisecond latency**
- managed (jak RDS, ale dla cache)
- działa w **VPC (brak public access)**

>[!exam]
>cache nie działa automatycznie → aplikacja musi go używać
## Engines  
  
### Redis (default)  
- replication (primary + read replicas)  
- HA (Multi-AZ failover)  
- persistence (RDB / AOF)  
- advanced data structures:  
	- list, set, sorted set, hash  
- pub/sub  
- TTL per key  
  
👉 use case:  
	- session store  
	- leaderboard (ordering + uniqueness)  
	- real-time apps  
### Memcached  
- prosty key-value  
- brak:  
	- replication  !
	- persistence  !
	- failover  !
- multi-threaded (bardzo szybki)  
  
👉 use case:  
- simple cache (stateless)

>[!exam]
>HA / failover / backup → Redis
>simple, ultra-fast cache → Memcached

## Caching patterns (KLUCZOWE)  
### Cache-aside (lazy loading)  

`App → Cache → (MISS) → DB → i do Cache → App`
👉 najczęstszy pattern  

⚠️ możliwe **stale data** -> _jak stale bread_ no longer fresh
### Write-through  
- zapis:  
  - `App → cache + DB `   
  
👉 zawsze spójne    
⚠️ większa latencja zapisu  
  
---  
### Write-back (write-behind)  
- zapis:  
  - `App → cache → async DB `   
  
👉 szybkie write    
⚠️ ryzyko utraty danych  
  
---  
## Redis architecture  
### Replication  
- primary → replicas (async)  
- read scaling  
  
---  
### Multi-AZ  
- automatic failover  
- replica → primary  
  
---  
### Cluster mode  
- sharding (partitioning danych)  
- scaling write throughput  
  
👉 dane podzielone na **hash slots**  
  
---  
## Eviction policies (WAŻNE)  
  
gdy brak pamięci:  
- LRU (least recently used)  
- LFU (least frequently used)  
- TTL-based  
  
👉 cache może usuwać dane automatycznie  
  
---  
## Persistence (Redis only)  
  
- RDB:  
  - snapshot co X czasu  
  
- AOF:  
  - log operacji  
  
👉 opcjonalne → kosztem performance  
  
> [!exam]  
> Memcached = brak persistence    
  
---  
## Security  
  
- VPC only (no public access)  
- Security Groups  
- encryption:  
  - at rest (KMS)  
  - in transit (TLS)  
- Redis:  
  - AUTH (password)  
  - IAM authentication (nowsze)  
  
---  
## Scaling  
  
- vertical:  
  - większe node’y  
  
- horizontal:  
  - Redis Cluster (sharding)  
  - read replicas  
  
---  
## Use cases  
  
- cache DB queries  
- session store (TTL)  
- real-time analytics  
- leaderboards / counters  
- rate limiting  
  
---  
## ElastiCache vs RDS  
  
- ElastiCache:  
  - RAM  
  - µs latency  
  - cache layer  
  
- RDS:  
  - persistent  
  - source of truth  
  
👉 pattern:  
`App → Cache → DB  `
  
---  
## ElastiCache vs DynamoDB DAX  
  
- ElastiCache:  
  - general-purpose cache  
  - app-managed  
  
- DAX:  
  - cache dla DynamoDB  
  - transparentny (no code change)  
---  
## Trade-offs  
  
- + bardzo szybki  
- + odciąża DB  
- - cache invalidation problem  
- - brak durability (domyślnie)  
- - dodatkowa warstwa    
---  
## Exam traps  
  
- cache ≠ source of truth    
- Redis → persistence opcjonalna    
- Memcached → brak HA    
- Multi-AZ → tylko Redis    
- eviction → dane mogą zniknąć    
- DAX → tylko dla DynamoDB    
- ElastiCache → zawsze w VPC    
  
---  
## TL;DR  
  
- ElastiCache = **RAM cache layer**  
- Redis → advanced + HA + persistence    
- Memcached → prosty cache    
- cache-aside = default pattern    
- cel: latency ↓ + DB load ↓

`App → Cache → (MISS) → DB → Cache → App`
