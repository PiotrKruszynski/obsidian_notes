Created: 2026-02-11  13:07
___
Note:

>[! Definition]
• **Fully managed Authoritative DNS:** 
Usługa DNS, w której klient może samodzielnie aktualizować rekordy
• **100% Availability SLA:** 
Jedyna usługa AWS oferująca gwarancję stuprocentowej dostępności.
• **Domain Registrar:** 
Możliwość zakupu i rejestracji domen (np. przez Amazon Registrar Inc. lub GoDaddy)
• **Resource Health Checks:** 
Możliwość sprawdzania stanu zdrowia zasobów i automatycznego przełączania ruchu (DNS failover).


**Ważne:** Route 53 nie „przesyła ruchu”. DNS tylko daje odpowiedź: _„idź pod ten endpoint”_.

**DNS wybiera endpoint**, **LB rozdziela ruch**, a **ENI to fizyczno-logiczny port sieciowy**, przez który ten ruch płynie.

#  Records & Hosted Zones

• **Public Hosted Zone:** Zawiera rekordy określające sposób kierowania ruchu w Internecie (publiczne domeny).
• **Private Hosted Zone:** Kieruje ruch wewnątrz jednej lub więcej sieci VPC (prywatne domeny).
**Hosted Zones:
![[Pasted image 20260211174309.png]]
• **TTL (Time To Live):** Czas przechowywania rekordu w pamięci cache resolverów; obowiązkowy dla każdego rekordu z wyjątkiem Aliasów.

![[Pasted image 20260211173351.png]]

• **Record Types:**
    ◦ **A:** mapuje nazwę hosta na IPv4.
    ◦ **AAAA:** mapuje nazwę hosta na IPv6.
    ◦ **CNAME:** mapuje nazwę hosta na inną nazwę hosta (tylko dla domen podrzędnych/non-root).
    ◦ **Alias:** Mapuje nazwę hosta na zasób AWS (np. ELB, CloudFront); działa dla domen głównych (Zone Apex), jest darmowy i posiada natywny health check.

![[Pasted image 20260211173940.png]]

![[Pasted image 20260211174805.png]]

![[Pasted image 20260211175536.png]]

![[Pasted image 20260211175611.png]]

# Route 53 – Routing Policies

### Simple Routing
- Default routing policy.
- Routes traffic to a single resource.
- Can return multiple IPs (random order).
- No built-in traffic control logic.

### Weighted Routing
- Distributes traffic based on defined percentage weights.
- Used for Blue/Green or Canary deployments.
- Allows gradual traffic shifting between resources.

### Latency-Based Routing
- Routes users to the AWS region with lowest latency.
- Improves performance for global applications.
- Based on AWS latency measurements, not geography.

### Failover Routing
- Active–Passive configuration.
- Uses health checks to detect failure.
- Automatically redirects traffic to secondary resource if primary fails.

### Geolocation Routing
- Routes based on user geographic location (continent, country, US state).
- Used for compliance, localization, or regional restrictions.
- Decision is strictly location-based.

### Geoproximity Routing
- Routes based on user and resource geographic location.
- Supports bias to expand or shrink traffic region.
- Provides fine-grained geographic traffic control.

### IP-Based Routing
- Routes traffic based on client IP CIDR blocks.
- Enables custom routing for specific networks.
- Useful for enterprise or partner-specific routing.

### Multi-Value Routing
- Returns up to 8 healthy records per DNS query.
- Supports health checks.
- Provides simple DNS-based load distribution.
- Does NOT replace ELB (no L4/L7 features).

---
## Critical Rules / Defaults

- Route 53 routing policies operate at DNS level.
- They do not inspect HTTP headers or application traffic.
- Multi-Value is not a substitute for Elastic Load Balancing.
- Weighted uses relative weights, not strict percentages.
- Failover requires health checks for automation.

---

## Common Exam Traps

- Confusing Latency-Based with Geolocation.
- Assuming Multi-Value equals load balancer.
- Forgetting that DNS caching (TTL) affects failover speed.→ Even if health check detects failure immediately, clients may continue using cached DNS records until TTL expires.
- Mixing Weighted routing with Geoproximity bias.

---

## Exam Question Patterns

- "Control traffic percentage" → Weighted.
- "Disaster recovery active-passive" → Failover.
- "Lowest response time globally" → Latency-Based.
- "Compliance by country" → Geolocation.
- "CIDR-based routing" → IP-Based.
- "Simple DNS load distribution without ELB" → Multi-Value.
- "Need SSL termination or path-based routing" → Use ELB (not Route 53).
    

---

![[Pasted image 20260211175714.png]]
# Health Checks & Hybrid DNS

• **Health Checks:** Około 15 globalnych „sprawdzaczy” monitoruje punkty końcowe (HTTP/HTTPS/TCP); wymagają przepuszczenia ruchu na firewallu/routerze.
• **Calculated Health Checks:** Monitorowanie innych health checków w celu stworzenia złożonych reguł.
• **Route 53 Resolver:** Automatycznie odpowiada na zapytania DNS dla lokalnych nazw EC2 i prywatnych stref.
• **Hybrid DNS Endpoints:**
    ◦ **Inbound Endpoint:** Pozwala zewnętrznym resolverom na rozwiązywanie nazw zasobów wewnątrz AWS.
    ◦ **Outbound Endpoint:** Pozwala Route 53 na przekazywanie zapytań do zewnętrznych serwerów DNS (np. on-premises).

# Route 53 Resolver
automatically answers DNS queries for
- local domain names for ec2 instances
- records in private hosted zone
- records in public hosted zone

hybrid DNS - resolving DNS queries between VPC (Route 53 Resolver) and your networks (other DNS Resolvers)
Network can be:
- VPC itself / peered VPC
- on-permises Network (connected through [[AWS Direct Connect]] or AWS VPN)
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
