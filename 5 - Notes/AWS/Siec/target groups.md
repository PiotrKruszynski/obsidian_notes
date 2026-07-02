---
title: "target groups"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-10
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[! Important]
>**target groups = collection of backends** (np. EC2, ECS tasks, IP adress) do których [[load balancer]] faktycznie wysyła ruch
>- actual destination for load balancer traffic
>- load balancer routes traffic to target groups, not directly to instances

# Defaults:
- target group **is regional** ❌ AZ
- targets must be reachable from VPC
- health check failure = target removed from routing

#### Common exam trap:
- ❌ LB sends traffic directly to EC2
- ❌ healtch checks configured on LB
- ❌ IP targets can be public IPs
- ❌ target groups are AZ-scoped

# Routing rules
- one LB -> multiple target groups
- routing based on:
	- host
	- path
	- headers
- layer7(application) rules -> ALB

# Health checks
- **health checks** are defined at the target group level
- traffic is sent only to healthy targets

## Supported target types
- EC2 instance
	- can be managed by **Auto Scaling Group
	- protocol HTTP / HTTPS
- ECS tasks
	- managed directly by ECS
	- protocol HTTP / HTTPS
- Lambda fn
	- HTTP request in transfered into JSON event
	- no servers involved
- IP Adresses
	- must be private IPs only
	- useful for on-permises nr non-EC@ targets
