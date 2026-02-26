Created: 2026-02-11  11:58
___
Note:

- Menaged _Redis_ / _Memcached_ (similar offering as [[Amazon RDS]] but for _cache_)
- **Cache** = in-memory data store, _sub-millisecond_ latency
- select _ElastiCache_ instance type (np. cache.m6g.large)
- code change require!
- security through _IAM_, _Security Groups_, _KMS_, _Redis Auth_
- backup / snapshot / point in time restore feature
- managed and scheduled maintenance

**Use case:** key-value store, frequent reads - less writes, cache results for DB queries, store session data for websites, cannot use SQL

# Redis vs Memcached

|**Cecha**|**Redis**|**Memcached**|
|---|---|---|
|Typ|key-value + struktury danych|czysty key-value|
|Trwałość|snapshot / AOF|brak|
|Replikacja|tak|nie|
|Cluster mode|tak|nie|
|Zastosowanie|sessions, rate limiting, pub/sub|prosty cache|
W praktyce:
- **Nowe projekty → Redis**
- Memcached = prosty, lekki cache bez HA




Podobnie jak RDS służy do zarządzania bazami relacyjnymi, ElastiCache zarządza bazami in-memory.


• **Reduces stress on DB:** 
Pomaga odciążyć bazy danych w przypadku obciążeń intensywnie korzystających z odczytu (read-intensive workloads).
• **Stateless Applications:** 
Pomaga uczynić aplikację bezstanową poprzez przechowywanie danych sesji.


**Redis vs. Memcached**
• **Redis:**
    ◦ **High Availability:** Wspiera Multi-AZ z funkcją Auto-Failover.
    ◦ **Scalability:** Posiada repliki do odczytu (Read Replicas) do skalowania odczytów.
    ◦ **Durability:** Dane są trwałe (persistence) dzięki funkcji AOF.
    ◦ **Features:** Obsługuje zaawansowane zestawy danych (np. Sorted Sets).

• **Memcached:**
    ◦ **Sharding:** Wykorzystuje wiele węzłów do partycjonowania danych.
    ◦ **No High Availability:** Brak replikacji danych.
    ◦ **Non-persistent:** Dane nie są przechowywane na stałe.
    ◦ **Multi-threaded:** Posiada architekturę wielowątkową.

![[Pasted image 20260211120814.png]]

**Caching Patterns & Security**
• **Lazy Loading:** Dane są buforowane tylko wtedy, gdy są odczytywane; dane w pamięci podręcznej mogą stać się nieaktualne (stale).
• **Write Through:** Dane są dodawane lub aktualizowane w pamięci podręcznej natychmiast po zapisaniu do bazy danych (brak nieaktualnych danych).
• **Session Store:** Przechowywanie tymczasowych danych sesji z wykorzystaniem funkcji TTL (Time To Live).





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
