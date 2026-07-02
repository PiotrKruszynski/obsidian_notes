---
title: "AWS Certificate Manager ACM"
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

>Easily provision, manage, and deploy TLS Certificates

Provide in-flight encryption for websites (HTTPS)
Supports both public and private TLS certificates
Free of charge for public TLS certificates
Automatic TLS certificate renewal:
- 60 days before expiry
- menaged rule `acm-certificate-expiration-check`
Integrations with (load TLS certificates on) 
- Elastic Load Balancers (CLB, ALB, NLB) 
- CloudFront Distributions 
- APIs on API Gateway
#### Cannot use ACM with EC2 directly (can’t be extracted)

![[Pasted image 20260316142503.png]]
