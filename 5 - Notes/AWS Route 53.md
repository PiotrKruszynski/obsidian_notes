Created: 2026-02-11  13:07
___
Note:

# Route 53 — minimum pod SAA

>[!Definition]
>Route 53 = **managed DNS + routing policy engine**
>
👉 DNS tylko zwraca IP / endpoint  
 ❗ NIE forwarduje ruchu
> Route53 = DNS (NIE load balancer)
  
## Routing 
Route 53 zwraca IP według ustalonej polityki:
- Weighted → % traffic  
- Latency → najbliższy region  
- Failover → DR (health check)  
- Geolocation → kraj  
## Health check  
- potrzebny do failover  
### TTL
- cache DNS u klienta
- wpływa na:
  - failover speed

>[!exam]
>niski TTL = szybszy failover

## Multi-value
Zwraca kilka zdrowych, ale nie zastępuje LB
- do 8 healthy IP
- prosty load balancing

❗ NIE zastępuje ELB

---
# Route 53 Resolver

👉 DNS w VPC
- resolves:
  - EC2 names
  - private hosted zones
![[Pasted image 20260323123000.png]]

---
# Hybrid DNS

## Inbound endpoint
- on-prem → AWS DNS
## Outbound endpoint
- AWS → on-prem DNS

>[!exam]
>hybrid DNS → inbound/outbound endpoints

![[Pasted image 20260323123020.png]]
![[Pasted image 20260323123030.png]]
---
# Najważniejsze rozróżnienia

- Route53 = DNS  
- ALB = load balancing  
- CloudFront = Content Delivery Network  
# TL;DR
- Route53 = DNS + routing  
- Alias dla AWS resources  
- Failover = DR  
- Weighted = traffic split  
- Latency = performance  


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
