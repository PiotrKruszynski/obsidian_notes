Created: 2026-02-11  11:58
___
Note:


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

**Use case:** key-value store, frequent reads - less writes, cache results for DB queries, store session data for user on websites, _cannot use SQL !_

### Core properties
- key-value store (no SQL)
- in-memory → **sub-millisecond latency**
- managed (jak RDS, ale dla cache)
- wymaga **zmiany kodu aplikacji**

>[!exam]
>cache = aplikacja musi z niego korzystać (nie działa automatycznie)
### Engines
- **Redis**
- **Memcached**
----
## Redis
- wspiera:
  - replication
  - HA (failover)
  - persistence (backup)
- advanced data structures:
  - list, set, sorted set
- pub/sub
- **preferred (default wybór)**
## Memcached
- prosty key-value
- brak:
  - replication
  - persistence
- brak HA
- multi-threaded (bardzo szybki)

>[!exam]
>HA / backup → Redis  
>simple cache → Memcached  


![[Pasted image 20260211120814.png]]


---
# Security
- **Security Groups**
- encryption:
  - at rest (KMS)
  - in transit (TLS)
- Redis:
  - AUTH (password) - może też używać IAM Authentication for Redis


---
# Persistence (Redis only)
- snapshot (RDB)
- optional persistence
- backup/restore

>[!exam]
>Memcached = brak backup  

---
# Use cases
- cache DB queries
- session store
- real-time analytics
- leaderboard / counters

---
# Architecture

```text
Client → App → ElastiCache → DB
                ↑
             cache hit

```

![[Pasted image 20260319130159.png]]

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
