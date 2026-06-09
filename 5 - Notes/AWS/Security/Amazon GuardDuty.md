---
title: "Amazon GuardDuty"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-03-17  11:08
___
Note:

### Co robi GuardDuty

`logi + ML + threat intel → wykrywanie zagrożeń`
Analizuje:
- CloudTrail (API activity)
- VPC Flow Logs (ruch sieciowy)
- DNS logs

👉 wykrywa:
- podejrzane IP (np. botnet)
- crypto mining
- anomalie w IAM (np. nietypowe użycie kluczy)

### Use case (egzamin)
`"detect suspicious activity / threats" → GuardDuty`
### Różnica vs Macie (to musisz umieć)
GuardDuty → zagrożenia / zachowanie  
Macie → dane w S3 (PII)


![[Pasted image 20260317111256.png]]






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
