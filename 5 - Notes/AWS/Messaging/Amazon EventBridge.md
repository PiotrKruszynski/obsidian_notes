---
title: "Amazon EventBridge"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!tip]
>centralny router zdarzeń **event bus**, który działa w modelu **push + filtering + routing**
>schedule: Cron jobs (scheduled scripts)
>**push**
>

Amazon EventBridge to **serverless event bus**, który umożliwia:
- odbieranie zdarzeń (events)
- filtrowanie (advance filtering option with JSON rules metadata, obj size, name..)
- routowanie do targetów
- budowę architektury event-driven
- EventBridge Capabilities - Archive, Replay Events, Reliable deliveryo

To jest warstwa **event routing**, nie messaging queue.

![[Pasted image 20260317152337.png]]

---

## 2️⃣ Główne komponenty

### 🔹 Event Bus

Logiczny kanał, przez który przechodzą eventy.

Typy:
- Default Event Bus (AWS services)
- Custom Event Bus (aplikacje)
- Partner Event Bus (SaaS integrations)

---

### 🔹 Event

JSON payload zawierający:
{  
  "source": "my.app",  
  "detail-type": "order.created",  
  "detail": {  
    "orderId": "123",  
    "amount": 500  
  }  
}
Event jest immutable.

---
### 🔹 Rule
Reguła zawierająca:
- pattern (filter)
- target
Event → match pattern → trigger target

---

### 🔹 Target
Może być:
- Lambda
- SQS
- SNS
- Step Functions
- ECS Task
- API Destination
- Kinesis

---

## 3️⃣ Jak działa przepływ
`Producer → Event Bus → Rule → Target`
Nie ma pollingu.  
EventBridge pushuje event do targetu.

---

## 4️⃣ EventBridge vs SQS

|Feature|EventBridge|SQS|
|---|---|---|
|Routing|Tak (pattern matching)|Nie|
|Kolejkowanie|Nie|Tak|
|Fan-out|Naturalnie|Z SNS|
|Replay|Tak|Nie|
|Ordering|Brak gwarancji|FIFO w FIFO queue|
|Pull / Push|Push|Pull|

EventBridge = routing layer  
SQS = durable buffer

---

## 5️⃣ EventBridge vs SNS

SNS:

- Pub/Sub
- Brak zaawansowanego filtrowania (tylko proste)

EventBridge:

- Pattern matching (deep JSON filtering)
- SaaS integrations
- Replay events
- Cross-account routing

---

## 6️⃣ Use cases

✔ Microservices decoupling  
✔ Serverless orchestration  
✔ Domain events (order.created, payment.failed)  
✔ Cross-account communication  
✔ SaaS integration

---

## 7️⃣ Delivery semantics

- At-least-once delivery
- Best effort ordering
- Retry with exponential backoff
- DLQ supported (SQS)

---

## 8️⃣ Event pattern example

{  
  "source": ["my.app"],  
  "detail-type": ["order.created"],  
  "detail": {  
    "amount": [{  
      "numeric": [">", 100]  
    }]  
  }  
}
Zaawansowane filtrowanie po polach JSON.

---

## 9️⃣ Architektura backendowa
Typowy pattern:
`API → write to DB → emit domain event → EventBridge → downstream services`

To pozwala:
- decoupling
- async processing
- scalable event-driven system

---

## 🔟 Czego EventBridge NIE robi

❌ Nie przechowuje wiadomości długo jak queue  
❌ Nie gwarantuje kolejności  
❌ Nie jest systemem streamingowym (jak Kinesis)

---

## 🔥 Egzamin AWS – czego się spodziewać
>„You need loosely coupled event-driven architecture across accounts with filtering and SaaS integration.”

Odpowiedź: EventBridge

>„You need durable buffering and consumer control.”

Odpowiedź: SQS

---
## 🔐 Resource-based policy (EventBridge)

Pozwala zarządzać **kto może wysyłać eventy do konkretnego Event Bus** (nie kto je odbiera).

### 🔹 Co to znaczy w praktyce

- kontrolujesz dostęp na poziomie **Event Bus (resource)**
- dopuszczasz **inne konta AWS / regiony**
- umożliwiasz **cross-account event ingestion**

---

### 🔹 Kluczowa akcja

- `events:PutEvents` → pozwala wysyłać eventy do busa

---

### 🔹 Przykład (cross-account)

{  
  "Version": "2012-10-17",  
  "Statement": [  
    {  
      "Effect": "Allow",  
      "Action": "events:PutEvents",  
      "Principal": { "AWS": "111122223333" },  
      "Resource": "arn:aws:events:us-east-1:123456789012:event-bus/central-event-bus"  
    }  
  ]  
}

👉 Konto `111122223333` może pushować eventy do `central-event-bus`

---

### 🔹 Mental model (ważne na egzamin)

- IAM policy → **co JA mogę zrobić**
- Resource policy → **kto może używać MOJEGO zasobu**

EventBridge używa resource policy, bo:  
➡️ event bus jest **shared ingress point**

---

### 🔹 Typowy use case (organizacje)

Multiple accounts → central Event Bus → rules → targets

✔ centralizacja eventów  
✔ governance / auditing  
✔ prostsze routing rules

---

### 🔹 Dlaczego to działa

EventBridge to **push system**, więc:

- producer musi mieć **permission do target busa**
- brak tego → event jest odrzucony (no implicit trust)

To jest odwrotność SQS pull modelu, gdzie consumer kontroluje dostęp.

---

### 🔹 Trade-offs

**Zalety**

- prosty cross-account routing (bez SNS + SQS glue)
- central event hub (org-wide architecture)

**Wady**

- dodatkowa warstwa IAM complexity
- brak izolacji jeśli policy jest zbyt szeroka (`Principal: "*"`)
- trudniejsze debugowanie (permission vs rule mismatch)

---

### 🔥 Egzaminowy trigger

> „Allow events from another AWS account / aggregate events centrally”

➡️ **EventBridge + resource-based policy (`events:PutEvents`)**


---

## 1️⃣1️⃣ Mental model

EventBridge = router zdarzeń  
SQS = bufor  
SNS = broadcast  
Kinesis = streaming
