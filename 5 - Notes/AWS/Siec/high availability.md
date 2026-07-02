---
title: "high availability"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-12
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[! Important]
> it means running your system in at least 2 data centers (== AZ)

the goal of high availability is to survive a data center loss

can be passive (RDS Multi AZ - to sposób uruchomienia DB tak by nie przestała działać przy awarii) or active (horizontal scaling)
- auto scaling group multi AZ
- load balancer multi AZ
