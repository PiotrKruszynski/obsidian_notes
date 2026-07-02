---
title: "Amazon Macie"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-15
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

#### dla S3

`S3 objects → analiza zawartości → wykrywanie danych wrażliwych`
- PII (np. imiona, adresy, PESEL-like)
- dane finansowe (numery kart)    
- dane poufne

👉 robi **content inspection**, nie tylko metadata
### Jak działa
```
- skanuje buckety S3
- używa ML + pattern matching
- generuje **findings (alerty)**
```

`S3 → Macie → finding (np. "found credit card data")`


![[Pasted image 20260321002759.png]]
