---
title: "AWS integation and messaging"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---


Created: 2026-02-23  10:29
___
Note:

>[!tip]
>definition

## Core Concepts

- **Decoupling** → services communicate asynchronously to improve scalability and fault isolation
- **Message durability** → persistence and delivery guarantees differ between SQS (stored in queue), SNS (no storage for offline subscribers), and EventBridge (event bus with retention window)
- **Push vs Pull model** → SNS (push), SQS (polling/pull)
- **Fan-out pattern** → SNS → multiple SQS queues
- **Event-driven architecture** → EventBridge routes events based on rules
- **Ordering guarantees** → FIFO queues preserve strict order
- **At-least-once delivery** → default behavior in most messaging services
- **Exactly-once processing** → requires FIFO + deduplication logic

## Critical Rules / Defaults

### [[Amazon SQS]]

- Standard queue → unlimited throughput, best-effort ordering
- FIFO queue → strict ordering, exactly-once processing (with deduplication)
- Message retention → 1 minute to 14 days (default 4 days)
- Visibility timeout → prevents other consumers from processing same message
- Dead-Letter Queue (DLQ) → isolates failed messages

### [[Amazon SNS]]

- Pub/Sub model
- Push-based delivery
- Supports multiple protocols (HTTP, SQS, Lambda, email, SMS)
- No message persistence for consumers that are offline
- Used for fan-out architectures

### [[Amazon EventBridge]]

- Event bus architecture
    
- Rule-based routing
    
- Supports SaaS integrations
    
- Supports content-based filtering
    
- Enables cross-account event routing
    

### [[Amazon MQ]]

- Managed message broker
    
- Supports ActiveMQ / RabbitMQ
    
- Used for legacy system compatibility
    

---

## Common Exam Traps

- Confusing SNS (push) with SQS (pull)
    
- Using SNS when message durability is required
    
- Forgetting DLQ configuration for failed processing
    
- Assuming Standard SQS guarantees order
    
- Choosing FIFO when high throughput is required
    
- Forgetting visibility timeout tuning
    
- Confusing EventBridge with SQS for buffering workloads
    

---

## Exam Question Patterns

- "Decouple application tiers" → SQS
    
- "Fan-out to multiple systems" → SNS + SQS
    
- "Strict ordering required" → SQS FIFO
    
- "Event-based routing with filtering" → EventBridge
    
- "Integrate with SaaS application" → EventBridge
    
- "Legacy MQ system migration" → Amazon MQ
    
- "Handle failed message processing" → DLQ
    

---
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
