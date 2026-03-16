Created: 2026-02-11  11:58
___
Note:

- Menaged _Redis_ / _Memcached_ (similar manage as [[Amazon RDS]] but for _cache_)
- data model: key -> value, cannot use SQL
- **Cache** = in-memory data store, _sub-millisecond_ latency
- select _ElastiCache_ instance type (np. cache.m6g.large)
- **code change require
- security through _IAM_, _Security Groups_, _KMS_, _Redis Auth_
- backup / snapshot / point in time restore feature
- managed and scheduled maintenance
- max Redis item size 512 MB

**Use case:** key-value store, frequent reads - less writes, cache results for DB queries, store session data for user on websites, _cannot use SQL !_

# Redis vs Memcached
- Nowe projekty → Redis
- Memcached = prosty, lekki cache bez HA
- wspiera pub/sub

Redis:
- wspiera replikacje wiec HA oraz bardziej zaawansowane struktury danych
- ma maste-replica czyli przejmowanie roli mastera przez slava
Memcached:
- prostszy, przechowuje pary klucz-wartość
- nie ma replikacji, w przypadku awarii węzła tracisz dane

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
