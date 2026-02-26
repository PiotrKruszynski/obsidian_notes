Created: 2026-02-11  11:58
___
Note:

- Menaged _Redis_ / _Memcached_ (similar offering as [[Amazon RDS]] but for _cache_)
- __

Podobnie jak RDS służy do zarządzania bazami relacyjnymi, ElastiCache zarządza bazami in-memory.

• **In-memory database:** 
Charakteryzuje się bardzo wysoką wydajnością i opóźnieniami poniżej milisekundy (sub-millisecond latency).
• **Reduces stress on DB:** 
Pomaga odciążyć bazy danych w przypadku obciążeń intensywnie korzystających z odczytu (read-intensive workloads).
• **Stateless Applications:** 
Pomaga uczynić aplikację bezstanową poprzez przechowywanie danych sesji.
• **Fully Managed:** 
AWS dba o konserwację systemu, łatki (patching), konfigurację, monitorowanie oraz odzyskiwanie po awarii.
• **Code changes required:** 
Wykorzystanie ElastiCache wymaga znacznych zmian w kodzie aplikacji.

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

• **Security:**
    ◦ **IAM Authentication:** Wspierane dla Redis.
    ◦ **Redis AUTH:** Możliwość ustawienia hasła/tokenu przy tworzeniu klastra.
    ◦ **Encryption:** Wsparcie dla szyfrowania SSL w locie (in-flight encryption).
    ◦ **Network:** Bezpieczeństwo poprzez Security Groups

![[Pasted image 20260211120837.png]]

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
