---
title: "AWS Route 53"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-12
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

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
Inbound → ON-PREM → AWS (Route 53)  
Outbound → AWS → ON-PREM DNS
## Inbound endpoint
- zapytania **z on-prem → do VPC**
- używasz gdy:
    - masz DNS on-prem
    - chcesz rozwiązać nazwy z Private Hosted Zone
👉 przykład:
`on-prem → query: db.internal → AWS PHZ → IP`
## Outbound endpoint
- zapytania **z VPC → do on-prem DNS**
- używasz gdy:
    - masz własne DNS poza AWS
👉 przykład:
`EC2 → query: corp.local → on-prem DNS`

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
