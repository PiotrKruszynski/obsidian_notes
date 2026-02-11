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

• **Simple:** Kieruje ruch do pojedynczego zasobu lub zwraca wiele losowych wartości.
• **Weighted:** Kontroluje procentowy udział ruchu (traffic %) kierowanego do poszczególnych zasobów.
• **Latency-based:** Kieruje użytkownika do regionu AWS z najniższym opóźnieniem (lowest latency).
• **Failover:** Wykorzystywany w konfiguracjach Active-Passive do odzyskiwania po awarii (Disaster Recovery).
• **Geolocation:** Kierowanie ruchu na podstawie fizycznej lokalizacji użytkownika (kontynent, kraj).
• **Geoproximity:** Kierowanie oparte na lokalizacji użytkownika i zasobów z możliwością zmiany zasięgu regionu (bias).
• **IP-based:** Routing oparty na adresach IP klientów (listy CIDR).

• **Multi-Value Answer:** Zwraca do 8 zdrowych rekordów (healthy records) dla jednego zapytania; nie zastępuje ELB.

![[Pasted image 20260211175714.png]]
# Health Checks & Hybrid DNS

• **Health Checks:** Około 15 globalnych „sprawdzaczy” monitoruje punkty końcowe (HTTP/HTTPS/TCP); wymagają przepuszczenia ruchu na firewallu/routerze.
• **Calculated Health Checks:** Monitorowanie innych health checków w celu stworzenia złożonych reguł.
• **Route 53 Resolver:** Automatycznie odpowiada na zapytania DNS dla lokalnych nazw EC2 i prywatnych stref.
• **Hybrid DNS Endpoints:**
    ◦ **Inbound Endpoint:** Pozwala zewnętrznym resolverom na rozwiązywanie nazw zasobów wewnątrz AWS.
    ◦ **Outbound Endpoint:** Pozwala Route 53 na przekazywanie zapytań do zewnętrznych serwerów DNS (np. on-premises).


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
