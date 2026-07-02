---
title: "VPC endpoints"
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

![[Pasted image 20260324115941.png|100]]
  
>[!important]  
>- VPC Endpoint = **private access to AWS services** (bez Internetu, to nie tunel)
>	- bez IGW, NAT, public IP, VPN, Direct Connect
>- ruch zostaje w **AWS network (backbone)**  
>- zwiększa security + zmniejsza cost  
>- S3/DynamoDB w tym samym VPC to _Gateway Endpoint_
  
## Mental model  
`EC2 → VPC Endpoint → AWS service`

👉 zamiast:
`EC2 → NAT → Internet → AWS`

---

# Types of endpoint (CRITICAL)
jest wiele ale
### 1. Gateway Endpoint
`Route Table → AWS service`
- tylko:
    - **S3**
    - **DynamoDB**
- działa przez:
    - route table (nie ENI)
- **FREE**
- brak Security Groups

> [!exam]  
> S3 / DynamoDB → zawsze Gateway Endpoint

### 2. Interface Endpoint (PrivateLink)

EC2 → ENI (private IP) → service
- działa przez stworzony:
    - **ENI w subnet**
- wymaga:
    - Security Group
- koszt:
    - $/hour + $/GB
- używany do:
    - AWS services (SNS, SSM, etc.)
    - **cross-VPC**
    - **SaaS / custom service (NLB)**

---

## 🔥 Kluczowa różnica

Gateway → routing  
Interface → network interface (ENI)

---

## DNS (często pomijane!)

Endpoint działa dzięki DNS
s3.amazonaws.com → private IP (endpoint)
👉 bez DNS:
- endpoint NIE działa

> [!exam]  
> problem z endpoint → sprawdź DNS

---

## S3: Gateway vs Interface
### Gateway (default)
- free
- działa w tym samym VPC
👉 90% przypadków
### Interface (rzadko)
- gdy potrzebujesz:
    - on-prem → S3 (VPN / DX)
    - cross-region access
    - specyficzne security requirement

👉 NIE standardowy wybór
## Use case (classic exam)

### ❌ Złe:

`Lambda → NAT → DynamoDB`

### ✅ Dobre:

`Lambda → Gateway Endpoint → DynamoDB`

## Security
- Gateway:
    - endpoint policy
- Interface:
    - Security Group + endpoint policy

## Troubleshooting
- DNS resolution ENABLED
- route table (Gateway)
- security group (Interface)
- endpoint policy

## Porównanie (ważne)

|Solution|Use case|
|---|---|
|VPC Endpoint|AWS services private access|
|NAT Gateway|Internet access|
|VPC Peering|full VPC ↔ VPC|
|PrivateLink|service-level access|
|Transit Gateway|many VPC hub|
|VPN|encrypted internet|
|Direct Connect|private physical link|

## Exam traps
- S3 → Gateway (nie Interface!)
- brak Internetu → Endpoint
- Interface = ENI
- Gateway = route table
- Endpoint ≠ pełne połączenie VPC

---

## TL;DR

VPC Endpoint = private AWS access  
S3/DynamoDB → Gateway (FREE)  
reszta → Interface (PrivateLink)  
no Internet, no NAT
