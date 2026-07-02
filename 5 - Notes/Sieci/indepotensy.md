---
title: "indepotensy"
type: concept
topic: networking
tags: ["networking"]
created: 2026-06-09
status: draft
sr_due: 2026-07-13
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

**Idempotentna operacja** to taka, którą można wykonać **wielokrotnie**, a **wynik po pierwszym wykonaniu już się nie zmienia**.

```python
x = "ala"

x.upper()              # "ALA"
x.upper().upper()      # "ALA"
"ALA".upper()          # "ALA"
```
