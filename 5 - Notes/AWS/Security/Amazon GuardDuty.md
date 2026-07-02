---
title: "Amazon GuardDuty"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-19
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

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
