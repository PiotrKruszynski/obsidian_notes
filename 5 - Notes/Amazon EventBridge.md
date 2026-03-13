Created: 2026-02-24  12:18
___
Note:

>[!tip]
>definition

Amazon EventBridge to **serverless event bus**, który umożliwia:
- odbieranie zdarzeń (events)
- filtrowanie ich
- routowanie do targetów
- budowę architektury event-driven

To jest warstwa **event routing**, nie messaging queue.

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

Producer → Event Bus → Rule → Target

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

API → write to DB → emit domain event → EventBridge → downstream services

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

Scenariusze typu:

„You need loosely coupled event-driven architecture across accounts with filtering and SaaS integration.”

Odpowiedź: EventBridge

Jeśli:

„You need durable buffering and consumer control.”

Odpowiedź: SQS

---

## 11️⃣ Mental model

EventBridge = router zdarzeń  
SQS = bufor  
SNS = broadcast  
Kinesis = streaming


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
