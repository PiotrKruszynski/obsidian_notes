Created: 2026-02-28  16:37
___
Note:

# AWS CloudWatch

>[!Definition]
>- CloudWatch → **monitoring + observability**
>- zbiera:
>  - **metrics** (numbers)
>  - **logs** (text)
>  - **events** (changes in AWS)
>- near real-time monitoring
>- region-based service

---

# Mental model (KLUCZ)

- **Metrics** → "co się dzieje, czy działa?" (CPU, latency)
- **Logs** → "dlaczego nie działa?" (debug, errors)
- **Events** → "kiedy coś się zmieniło?"
- dashboard - wizualizuj
- EventBridge - automatyzuj

---

# Core components

## 1. Metrics
- numeryczne dane czasowe (np. CPUUtilization, RequestCount)
- default AWS metrics (EC2, RDS, ALB, Lambda)
- custom metrics (możesz wysyłać własne, 1min / 5 min)

## 2. Alarms
- reagują na metryki
- OK, ALARM, INSUFFICIENT_DATA
- akcje:
  - SNS (alert)
  - Auto Scaling
  - EC2 recovery
  - Lambda

👉 **exam: auto reaction → CloudWatch Alarm**

---

## 3. Logs
- surowe logi aplikacji / systemu
- aplikacje, EC2, Lambda
- central storage logs
- struktura:
  - log group
  - log stream

👉 debug / troubleshooting

## 4. Dashboards
wizualizacja metryk

## 5. EventBridge (CloudWatch Events)
Definicja:
- event-driven routing
**Model:**
`Event → Rule → Target`
**Target:**
- Lambda
- SNS
- Step Functions
- SQS
**Use case:**
- automatyzacja
- reakcja na zmiany (np. EC2 state change)


---

# Advanced

## CloudWatch Logs Insights
- query logs (SQL-like)
- szybka analiza

## CloudWatch Agent
- zbiera:
  - memory
  - disk
  - custom logs

👉 EC2 default NIE ma memory metrics

# Typowe use case

- monitoring EC2 (CPU, disk)
- alerty (high CPU → SNS)
- auto scaling trigger
- debug Lambda (logs)
- event-driven automation

---

# Exam traps (VERY IMPORTANT)

- ❌ CloudWatch = logs only → NIE
- ❌ EC2 ma memory metrics default → NIE
- ❌ Events = logs → NIE
- ❌ Alarm działa na logs → NIE (na metrics!)
- ❌ CloudWatch = global → NIE (regional)

---

# TL;DR

- CloudWatch = **metrics + logs + events**
- Alarm → **reaction**
- Logs → debug
- Events → automation

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
