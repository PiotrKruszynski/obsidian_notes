---
title: "Amazon MQ"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-02-23  21:42
___
Note:


>[!Definition]
>- Amazon MQ → **managed message broker** (ActiveMQ / RabbitMQ)
>- kompatybilny z legacy protokołami: **JMS, AMQP, MQTT, STOMP**
>- **drop-in replacement** dla istniejących systemów on-prem
>- AWS zarządza: provisioning, patching, HA
>- NIE jest serverless → wymaga wyboru instance size
>- use when: **nie możesz zmienić aplikacji na SQS/SNS**

# Mental model
Aplikacja używa standardowego brokera (np. JMS) → Amazon MQ hostuje go w AWS → aplikacja działa bez zmian.
- klasyczny broker (queue / topic)  
- pełna kompatybilność API  
- stateful system  

**Use case**: migracja legacy apps, enterprise messaging, lift-and-shift

# Core features
- engines:
  - **ActiveMQ**
  - **RabbitMQ**
- protocols:
  - JMS, AMQP, MQTT, STOMP, OpenWire
- deployment:
  - **Single-instance** (dev)
  - **Active/Standby (Multi-AZ)** (prod)
- persistence:
  - durable queues/messages
- security:
  - VPC, SG, IAM (auth via users)
- scaling:
  - vertical (instance size), brak auto scaling
# How it works
`Producer → broker (queue/topic) → consumer`
- broker zarządza routingiem  
- wiadomości mogą być durable  
- konsument odbiera i usuwa message  
# Comparison

| Feature | Amazon MQ | SQS |
|--------|-----------|-----|
| Type | managed broker | serverless queue |
| Protocols | JMS, AMQP, MQTT | AWS proprietary |
| Scaling | manual | auto |
| Ops | more (stateful) | minimal |
| Use case | legacy apps | cloud-native |
# Exam traps
- ❌ Amazon MQ = lepszy SQS → NIE (większy overhead)
- ❌ serverless → NIE (instance-based)
- ❌ auto scaling → NIE
- ❌ używaj do nowych aplikacji → NIE (SQS/SNS lepsze)
- ❌ brak kompatybilności z legacy → NIE (to główny use case)
- ❌ fully AWS-native → NIE (to managed broker, nie AWS abstraction)

# TL;DR
- Amazon MQ = **managed broker dla legacy (JMS/AMQP)**
- wybierz gdy **nie możesz zmienić aplikacji**
- cloud-native → **SQS/SNS zamiast MQ**


![[Pasted image 20260223214534.png]]




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
