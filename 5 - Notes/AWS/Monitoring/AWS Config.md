---
title: "AWS Config"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-03-19  23:55
___
Note:

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
