---
title: "AWS Config"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-14
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# AWS Config

>[!Definition]
>- AWS Config → **resource configuration tracking + compliance auditing**
>- nagrywa zmiany (timeline) → **kto/co/kiedy zmienił resource**
>- **Config Rules** → sprawdzają zgodność (compliance)
>- snapshot + history konfiguracji
>- integracja: _SNS_, _Lambda_ (remediation)
>- use case: **audit, governance, compliance**

# Mental model
`Resource zmienia stan → Config zapisuje zmianę → rule ocenia → compliant / non-compliant`

- działa ciągle (continuous monitoring)  
- historia zmian (configuration timeline)  
- automatyczna ocena compliance  (zgodność)

**Use case**: security audits, drift detection, policy enforcement
