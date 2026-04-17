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
  
- **ALB** → HTTP / microservices / L7 routing  
- **NLB** → performance / TCP / static IP / preserve source IP  
- **GWLB** → firewall / network appliances

## ⚠️ Dlaczego to jest ważne   
- public IP = tylko **entry point**  
- backendy są **private (brak direct access)**  
- security + isolation
# Load Balancer — core
### Mental model
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

## CLB — Classic Load Balancer
- legacy (stary)
- Layer 4 + Layer 7 (basic)
- HTTP, HTTPS, TCP
- **no advanced routing**
- cross-zone:
  - ❌ disabled by default

## ALB — Application Load Balancer
- Layer 7 (HTTP)
- HTTP, HTTPS, WebSocket
- routing:
  - path-based `/users`
  - host-based `api.example.com`
  - headers / query params
- works with:
  - **target groups**
  - ECS / EKS / containers
  - multiple apps per instance
- features:
  - dynamic port mapping (containers)
  - **microservices ready
  - adds headers:
    - X-Forwarded-For (client IP)
    - X-Forwarded-Port
    - X-Forwarded-Proto
- cross-zone:
  - ✅ enabled by default (no extra cost)

>[!exam]
>ALB = microservices + HTTP routing

![[Pasted image 20260205094026.png]]

## NLB — Network Load Balancer
- Layer 4 (TCP/UDP)
- ultra high performance
- **preserves client IP (no proxy)**
- millions req/sec
- ultra low latency

- static IP:
  - 1 per AZ
  - supports Elastic IP

- targets:
  - EC2
  - private IP
  - ALB (hybrid pattern)

- health checks:
  - TCP / HTTP / HTTPS

- cross-zone:
  - ❌ disabled by default
  - inter-AZ traffic = $ $ 

>[!exam]
>NLB = performance + static IP + preserve client IP

## GWLB — Gateway Load Balancer
- Layer 3 (IP)
- use case:
  - firewall
  - IDS / IPS
  - network appliances
- features:
  - transparent traffic inspection
  - single entry/exit point
  - scale 3rd party appliances
- protocol:
  - **GENEVE (port 6081)**
- targets:
  - EC2 / private IP
- cross-zone:
  - ❌ disabled
  - inter-AZ traffic = $ $

>[!exam]
>GWLB = security appliances (network layer)
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
