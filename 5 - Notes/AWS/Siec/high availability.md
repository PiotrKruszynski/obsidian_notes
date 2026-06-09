---
title: "high availability"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[! Important]
> it means running your system in at least 2 data centers (== AZ)

the goal of high availability is to survive a data center loss

can be passive (RDS Multi AZ - to sposób uruchomienia DB tak by nie przestała działać przy awarii) or active (horizontal scaling)
- auto scaling group multi AZ
- load balancer multi AZ
