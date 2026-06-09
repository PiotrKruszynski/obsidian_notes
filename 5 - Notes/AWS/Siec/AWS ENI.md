---
title: "AWS ENI"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!Core concepts]
>- ENI (Elastic Network Interface) = **virtual NIC w VPC (network identity)**
>- reprezentuje: `IP + MAC + Security Groups`
>EC2 **nie ma networkingu sam z siebie** → używa ENI
>ENI może być:
  >- tworzony niezależnie
  >- attach/detach (secondary ENI)

---

## Attributes

- primary private IPv4 (stały dla ENI)
- secondary private IPv4 (dynamiczne)
- optional:
  - public IPv4 (ephemeral)
  - Elastic IP (static public)
- MAC address
- **security groups (przypisane do ENI, nie EC2)**

👉 ENI = miejsce gdzie żyje konfiguracja sieciowa

---
## Rules / Defaults

- ENI jest **bound do jednej AZ** (nieprzenoszalny między AZ)
- ENI może być:
  - attached tylko do **jednej instancji naraz**
- EC2 może mieć **wiele ENI** (zależne od instance type)
- każdy ENI musi być w **tej samej AZ co EC2**

---

## Primary vs Secondary ENI

- **primary ENI (eth0)**:
  - tworzony automatycznie z EC2
  - **nie można odłączyć**
  - lifecycle = EC2

- **secondary ENI**:
  - można attach / detach
  - można przenieść między instancjami (tej samej AZ)

👉 tylko secondary ENI daje failover pattern

---

## IP model

- **private IP (primary)**:
  - podstawowy adres w VPC
  - używany do komunikacji wewnętrznej

- **secondary private IP**:
  - wiele IP na jednym ENI
  - use case:
    - multiple services
    - failover (przeniesienie IP między instancjami)

- **public IP (ephemeral)**:
  - mapowany do private IP (1:1 NAT)
  - zmienia się po stop/start

- **Elastic IP (EIP)**:
  - statyczny publiczny IP
  - można przepinać między ENI
  - koszt gdy nieużywany

---

## Networking behavior

- routing:
  - subnet route table → kieruje ruch z ENI
- security groups:
  - przypisane do ENI
  - **stateful firewall**

👉 ENI = punkt kontroli ruchu

---

## Failover pattern (ważne)

- przeniesienie:
  - secondary ENI **lub**
  - secondary private IP

👉 szybki failover bez zmiany DNS

⚠️ brak built-in automation:
- trzeba użyć:
  - Lambda + CloudWatch / EventBridge

---

## Limits

- liczba ENI / instance → zależna od typu EC2
- liczba IP / ENI → też zależna od typu

👉 networking scale = zależny od instance type

---

## Integracje

- Lambda (VPC → tworzy ENI)
- ECS / EKS (awsvpc mode → każdy task/pod ma ENI)
- NLB / PrivateLink
- NAT instances / appliances

---

## Exam traps

- SG przypisane do **ENI, nie EC2**
- ENI = AZ-bound (nie przeniesiesz między AZ)
- primary ENI → nie detachable
- ENI → tylko 1 instancja naraz
- Auto Scaling:
  - nie przenosi ENI
- Lambda w VPC → tworzy ENI (cold start latency)

---

## TL;DR

- ENI = **network identity (IP + SG + MAC)**
- EC2 używa ENI do komunikacji
- failover = przeniesienie ENI lub secondary IP
- AZ-bound → kluczowe ograniczenie
