---
title: "load balancer"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-02-04  18:02
___
Note:

>[!Important]
>Load Balancer = **managed service, który rozdziela ruch na wiele backendów (targets)**
>ruch przychodzący:  
>`client → LB (public DNS / IP)  `
>ruch wewnętrzny:  
>`LB → targets przez **private IP**`
>👉 **LB zawsze używa private networking do komunikacji z backendem**  
  
- **ALB** → HTTP / microservices / -> smart L7 routing  
- **NLB** → performance / TCP / static IP / preserve  IP  -> fast routing (L4)
- **GWLB** → firewall / network appliances -> inspection layer

- public IP = tylko **entry point**  
- backendy są **private (brak direct access)**  
- security + isolation

Load Balancer = **single entry (DNS) → routing → healthy targets**
### Core features
- entry point dla aplikacji (DNS name)
- routing do target groups
- high availability (**multi-AZ**)
- health checks (L7/L4 zależnie od LB)
- automatic failover (unhealthy → out)
- SSL termination (HTTPS → HTTP)
- separates public ↔ private traffic

>[!exam]
>Client → LB (public) → targets (private)

---
### Sticky sessions (session affinity)  
- user trafia do tego samego targetu  
- implementacja:  
	- ALB / CLB → cookie-based  
	- NLB → **source IP based**  
  
⚠️ trade-off:  
- uneven load distribution  
- utrudnia scaling  
  
👉 cloud pattern:  
- prefer **stateless + external session store (Redis)**
# ELB types  
## CLB — Classic Load Balancer (legacy)  
- Layer 4 + basic Layer 7  
- HTTP, HTTPS, TCP  
- brak:  
- advanced routing  
- host/path rules  
- cross-zone:  
- ❌ disabled by default  
  
👉 praktycznie **deprecated (egzaminowo jeszcze istnieje)**

## ALB — Application Load Balancer
- Layer 7 (HTTP/HTTPS)
- wspiera HTTP, HTTPS, WebSocket
- routing:
  - path-based `/users`
  - host-based `api.example.com`
  - headers / query params
- target groups:  
	- EC2  
	- ECS / EKS (containers)  
	- Lambda
- features:
  - dynamic port mapping (containers)
  - multiple apps per instance
  - **microservices ready
  - adds headers:
    - X-Forwarded-For (client IP)
    - X-Forwarded-Port
    - X-Forwarded-Proto
👉 **ALB = reverse proxy (terminates connection)**  
👉 client IP nie jest bezpośrednio widoczny (trzeba czytać header)
- cross-zone:
  - ✅ enabled by default (no extra cost)

>[!exam]
>ALB = HTTP routing + microservices + Lambda

![[Pasted image 20260205094026.png|500]]

## NLB — Network Load Balancer  
- Layer 4 (TCP/UDP)  
- **nie jest proxy (pass-through)**  
- preserves **source IP (client IP)**  
- performance:  
	- ultra low latency  
	- millions req/sec  
  
- *static IP:  -> nie zmienia, tamte jak DNS name ale ich IP moze sie zmienić
	- 1 per AZ  
	- supports Elastic IP  
  
- targets:  
	- EC2  
	- private IP  
	- ALB (pattern: NLB → ALB)  
  
- health checks:  
	- TCP / HTTP / HTTPS  
  
- cross-zone:  
	- ❌ disabled by default  
	- inter-AZ traffic = cost  
  
> [!exam]  
> NLB = static IP + preserve client IP + high performance  
  
---  
  
## GWLB — Gateway Load Balancer  
  
- Layer 3/4 (IP level)  
- use case:  
- firewall  
- IDS / IPS  
- deep packet inspection  
  
- działa jako:  
- transparent proxy (inline inspection)  
  
- protocol:  
- **GENEVE (6081)**  
  
- targets:  
- EC2 appliances  
  
- cross-zone:  
- ❌ disabled by default  
  
> [!exam]  
> GWLB = network security appliances

# Architecture

```bash
Client
  ↓
Load Balancer (DNS)
  └─ Listener (port 80/443)
      └─ Target Group ← health checks
          ├─ EC2
          ├─ ECS
          └─ IP

```




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
