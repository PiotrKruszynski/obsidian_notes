---
title: "Amazon SNS"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!important]  
>- SNS = **pub/sub messaging (push model)**  
>- służy do **decoupling** systemów (event-driven)  
>- wysyła wiadomość do wielu subscriberów jednocześnie (**fan-out**)  
>- **brak buforowania** (nie przechowuje jak SQS)  
  
### Mental model  
Producer → SNS Topic → multiple subscribers
👉 push natychmiast  
👉 brak kolejki  
👉 brak oczekiwania
### Core features
- **Push mechanism** → wiadomości wysyłane natychmiast
- **Fan-out** → 1 → wiele subscriberów
- **Highly available & scalable**
- **No long-term persistence**
- **Retry mechanism (best-effort)**
### Subscribers
- SQS
- Lambda
- HTTP / HTTPS endpoints
- Email / SMS
- Kinesis Data Firehose

> [!exam]  
> SNS → wiele subscriberów jednocześnie

---
### SNS vs SQS

|Cecha|SNS|SQS|
|---|---|---|
|model|pub/sub (push)|queue (pull)|
|decoupling|✅|✅|
|fan-out|✅|❌|
|buffering|❌|✅|
|durability|❌|✅|
|retry|limited|full control|
|ordering|❌ (std) / ✅ FIFO|❌ (std) / ✅ FIFO|
### SNS FIFO
- wspiera:
    - **ordering**
    - **deduplication**
- działa tylko z:
    - **SQS FIFO**

> [!exam]  
> ordering + pub/sub → SNS FIFO + SQS FIFO
### Message Filtering
- JSON-based filter policy
- subscriber dostaje tylko wybrane wiadomości
👉 use case:
- routing eventów bez dodatkowego kodu
### Fan-Out Pattern
Producer → SNS → SQS1  
                 → SQS2  
                 → Lambda

✔ zalety:
- skalowalność
- brak utraty danych (bo SQS)
- różne processing pipelines

> [!exam]  
> SNS + SQS = durable fan-out

### Durability (ważne!)
- SNS:
    - ❌ nie przechowuje wiadomości
    - ✔ retry delivery (best effort)
- SQS:
    - ✔ trwałe przechowywanie
### Security
- IAM → kto publikuje / subskrybuje
- Topic Policy → access (cross-account / services)
- KMS → encryption at rest
- HTTPS → encryption in transit
### Dead Letter Queue (DLQ)
- dla failed deliveries
- używane z:
    - SQS
    - Lambda

> [!exam]  
> failed processing → DLQ

---
### Use cases
- event-driven architecture
- fan-out (np. S3 events → multiple consumers)
- notifications (SMS, email)
- microservices communication
### Exam traps
- SNS ≠ queue
- SNS nie buforuje wiadomości
- SNS = push, SQS = pull
- fan-out → SNS
- durability → SQS
- ordering → tylko FIFO
### TL;DR
SNS → push + fan-out  
SQS → buffer + retry  
SNS + SQS → scalable + durable architecture



![[Pasted image 20260223155048.png]]

![[Pasted image 20260223162512.png]]

![[Pasted image 20260223162544.png]]

![[Pasted image 20260223214028.png]]

Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```
