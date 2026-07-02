---
title: "Amazon SQS"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-15
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!important]  
>- SQS = **managed durable message queue** (asynchronous decoupling layer między komponentami)

SQS = **managed, durable message queue (asynchronous decoupling layer)**

---

## Mental model  
SQS = **buffer + failure isolation + backpressure control**  
`Producer → Queue → Consumer`

👉 producer nie czeka na wynik (async)  
👉 consumer może paść → queue dalej przyjmuje dane  
👉 queue amortyzuje spike’i (burst traffic)

---

## Standard Queue
- nearly unlimited throughput
- **at-least-once delivery** (duplikaty możliwe)
- **best-effort ordering** (brak gwarancji)
- retention:
  - default: 4 days
  - max: 14 days
- max message size:
  - **1 MiB**

> [!exam]  
> Standard = skala + odporność  
> musisz obsłużyć:
> - idempotency (duplikaty)
> - brak ordering

---

## FIFO Queue
- nazwa musi kończyć się `.fifo`
- **ordering per MessageGroupId**
- **exactly-once (deduplication window ~5 min)**
- throughput:
  - ~300 req/s (bez batch)
  - ~3000 req/s (batch)
- dostępny **high throughput FIFO**

> [!exam]  
> FIFO ≠ global ordering  
> 👉 ordering tylko w obrębie **MessageGroupId**

---

## Core mechanika

### Message
- payload + attributes
- max: 1 MiB
- można użyć **S3 (SQS Extended Client)** dla większych payloadów

---

### Visibility Timeout
- default: **30s**
- message znika z kolejki po `ReceiveMessage`
- wraca jeśli:
  - brak `DeleteMessage`
  - timeout minął

👉 **retry mechanism + lock semantyka**

> [!exam]  
> visibility timeout > processing time

---

### Receive / Delete pattern
- SQS nie usuwa wiadomości automatycznie  
- flow:
  1. receive
  2. process
  3. delete

👉 brak delete = ponowne przetwarzanie

---

## Delivery semantics

- **at-least-once** (Standard)
- **exactly-once (practical)** (FIFO + deduplication)

👉 system musi być **idempotentny**

---

## Scaling model

- pull-based (polling)
- horizontal scaling consumerów
- batch processing

👉 queue działa jako **buffer między szybkością producerów i consumerów**

---

## Long Polling
- max: **20s**
- zmniejsza empty responses
- niższy koszt + mniejsze CPU

---

## Batching
- do 10 messages / request
- zwiększa throughput
- zmniejsza API cost

---

## Reliability patterns

### Dead Letter Queue (DLQ)
- message trafia po X retry
- ustawiane przez **redrive policy**

👉 izolacja błędów + debug

---

### Delay Queue
- opóźnienie dostarczenia message (0–15 min)
👉 use case: retry z opóźnieniem

---

### Message Timer
- per-message delay (override queue delay)

---
## Security

- **IAM (identity-based)**
  - kto może używać kolejki

- **Queue Policy (resource-based)**
  - kto może wysyłać/odbierać (np. SNS, cross-account)

- **SSE (KMS)**
  - encryption at rest

- **HTTPS**
  - encryption in transit

- **VPC Endpoint (PrivateLink)**
  - dostęp bez Internetu

---
## Access Control

### IAM Policy
- przypisana do usera/role
- kontroluje:
  - SendMessage
  - ReceiveMessage
  - DeleteMessage

👉 standardowy access w AWS

---
### Queue Policy
- przypisana do SQS
- kontroluje external access:
  - SNS → SQS
  - cross-account
  - inne AWS services

> [!exam]  
> SNS → SQS = potrzebna **Queue Policy**

---
## Integracje

- Lambda (event source mapping)
  - automatyczny scaling consumerów
- EC2 / ECS workers
- SNS → SQS (fan-out pattern)
- Step Functions

---
## Ordering & Parallelism

- Standard → brak ordering, max parallelism  
- FIFO:
  - ordering per group
  - parallelism = liczba MessageGroupId

👉 więcej grup = więcej równoległości

---
## Use cases

- decoupling app tiers
- async processing (np. image/video)
- buffering spikes
- background jobs / workers
- event-driven pipelines

---

## Trade-offs

- + durability i odporność
- + prosty model async
- + skalowalność
- - polling (brak natywnego push)
- - duplikaty (Standard)
- - latency (nie real-time)

---

## SQS vs SNS

- SQS
  - queue
  - pull
  - 1 consumer per message
  - retry + durability

- SNS
  - pub/sub
  - push
  - fan-out
  - brak persistence (bez SQS)

👉 pattern:
SNS → SQS → consumers

---
## Exam traps

- Standard ≠ ordering
- FIFO ≠ infinite throughput
- FIFO ordering = **per MessageGroupId**
- brak `DeleteMessage` → retry
- visibility timeout ≠ retention
- SQS = polling (nie push)
- duplikaty → zawsze możliwe (Standard)

---
## TL;DR

- SQS = **async buffer + decoupling layer**
- Standard → skalowalność
- FIFO → ordering + deduplication
- Visibility Timeout → retry control
- DLQ → failure isolation
- IAM + Queue Policy + KMS → security




**SDK** = Software Development Kit = biblioteka którą instalujesz w kodzie żeby gadać z AWS bez pisania HTTP requestów ręcznie.

![[Pasted image 20260223145209.png]]

![[Pasted image 20260223145420.png]]

SQS to decouple between application tiers
![[Pasted image 20260223145444.png]]

![[Pasted image 20260223214028.png]]


>[!tip]
>**resource-based policy** przypięta do zasobu.
>>
`Queue Policy    → przyczepiasz do SQS kolejki`
`Bucket Policy   → przyczepiasz do S3 bucketa`
`Key Policy      → przyczepiasz do KMS klucza`
