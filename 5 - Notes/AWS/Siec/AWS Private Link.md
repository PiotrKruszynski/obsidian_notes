---
title: "AWS Private Link"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---

  
>[!important]  
>- PrivateLink = **private connection to service via VPC Endpoint**  
>- ruch NIE wychodzi do Internetu    
>- używa **ENI (private IP w Twoim VPC)**  
>- do: **secure service access / cross-account / SaaS**  
  
---  
  
## Mental model  
  
Your VPC → Interface Endpoint (ENI) → AWS service / other VPC

👉 wygląda jak lokalny adres IP

---

## Co to rozwiązuje

- brak Internetu (lepsze security)
- brak NAT Gateway (oszczędność)
- brak VPC Peering (mniej złożoności)
- brak problemów CIDR overlap

---

## Jak działa

- tworzysz:
Interface VPC Endpoint
- AWS tworzy:
ENI w Twoim subnet
- łączysz się:

private IP → endpoint → service

---

## Typy endpointów (ważne!)

### Interface Endpoint (PrivateLink)

- działa przez **ENI**
- dla:
    - większości usług AWS
    - custom services (NLB)

---

### Gateway Endpoint (NIE PrivateLink!)

- tylko:
    - S3
    - DynamoDB

👉 exam trap:
S3/DynamoDB → Gateway Endpoint  
NIE PrivateLink

---

## Use cases

- EC2 → S3 bez Internetu
- EC2 → API AWS bez NAT
- VPC → VPC (bez peeringu)
- SaaS provider → klient

---

## PrivateLink vs VPC Peering

|Feature|PrivateLink|VPC Peering|
|---|---|---|
|connectivity|service-level|network-level|
|CIDR overlap|✅ działa|❌ nie działa|
|exposure|tylko service|cały VPC|
|direction|one-way|two-way|

---

## PrivateLink vs NAT

|Feature|PrivateLink|NAT|
|---|---|---|
|traffic|private|internet|
|security|wysokie|niższe|
|use case|AWS services|general internet|

---

## Exam traps

- PrivateLink ≠ Gateway Endpoint
    
- PrivateLink = Interface Endpoint
    
- S3/DynamoDB → NIE PrivateLink
    
- brak Internetu → PrivateLink
    

---

## TL;DR

PrivateLink = private access to service (ENI)  
no internet, no NAT  
secure service-to-service

  
---  
  
## 🧠 Dlaczego to działa  
  
PrivateLink:  
```text  
network-level isolation → traffic stays inside AWS backbone

👉 zamiast:

EC2 → NAT → Internet → AWS service

masz:

EC2 → ENI (endpoint) → AWS service

---

## ⚖️ Trade-offs

- ✔ security (no public exposure)
    
- ✔ prostszy niż peering
    
- ✔ działa z overlapping CIDR
    
- ❌ koszt (per endpoint + data)
    
- ❌ tylko do usług (nie full network)
    

---

## 🔥 Najważniejszy pattern (egzamin)

“private access to AWS service without Internet”  
→ VPC Endpoint  
→ jeśli S3/DynamoDB → Gateway  
→ reszta → PrivateLink

#aws