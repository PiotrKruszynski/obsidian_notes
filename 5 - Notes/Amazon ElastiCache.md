Created: 2026-02-11  11:58
___
Note:

- Menaged _Redis_ / _Memcached_ (similar offering as [[Amazon RDS]] but for _cache_)
- cannot use SQL
- **Cache** = in-memory data store, _sub-millisecond_ latency
- select _ElastiCache_ instance type (np. cache.m6g.large)
- code change require!
- security through _IAM_, _Security Groups_, _KMS_, _Redis Auth_
- backup / snapshot / point in time restore feature
- managed and scheduled maintenance

**Use case:** key-value store, frequent reads - less writes, cache results for DB queries, store session data for websites, _cannot use SQL !_

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

![[Pasted image 20260211120814.png]]


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
