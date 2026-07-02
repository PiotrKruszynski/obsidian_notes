---
title: "Amazon CloudFront"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!important]
>- CloudFront = **CDN (Content Delivery Network)**
>- cache’uje content **blisko użytkownika (edge locations)**
>- zmniejsza latency i load na origin
>- wspiera: **S3, EC2, ALB, custom origins**
>- używany do: **static + dynamic content delivery**
### Mental model
CloudFront = **cache przed Twoim backendem**
👉 user:
- trafia do najbliższego edge location  
👉 jeśli cache HIT:
- dostaje odpowiedź od razu  
👉 jeśli MISS:
- CloudFront idzie do **origin**
#### Origin of data
- **S3**
- **ALB** / **EC2**
- custom **HTTP server**
- on-prem!

---
### Jak działa cache
- **Cache Hit** → szybka odpowiedź  
- **Cache Miss** → fetch z origin  

👉 TTL decyduje:
- jak długo trzymać dane w cache

---
### Kiedy używać
- strony statyczne (S3 + CloudFront)
- globalne aplikacje
- streaming
- działa tylko dla **HTTP (L7)
- **nie dla TCP/UDP** → wtedy _Global Accelerator_

---
### Security
- HTTPS (SSL/TLS) -> encryption in transit
- **AWS Shield** (DDoS protection) -> (L3/L4)
- **WAF** (Web Application Firewall)-> filtruje ruch HTTPS (L7), SQL injection, Cross-Site Scripting złośliwy kod JavaScript wstrzykiwany do strony, IP blocking
- Signed URLs / Signed  Cookies

>[!exam]
>secure content delivery → CloudFront + WAF  

---
### CloudFront + S3
- można zablokować public access używając OriginAccessControl - **OAC**

👉 tylko CloudFront ma dostęp

>[!exam]
>private S3 + public access → CloudFront  

---
### Edge compute  
CloudFront Functions:
- szybkie, proste (JS)  
Lambda@Edge:
- bardziej zaawansowane (Node/Python)

### Geo Restriction  
- allowlist / blocklist countries  
- based on Geo-IP  
  
>[!exam]  
>blokowanie kraju → CloudFront (nie Route53!)

### CloudFront vs S3 static hosting

| Feature        | CloudFront | S3  |
| -------------- | ---------- | --- |
| CDN            | ✅          | ❌   |
| global cache   | ✅          | ❌   |
| security (WAF) | ✅          | ❌   |

---
### CloudFront vs Global Accelerator

- CloudFront → HTTP + cache
- Global Accelerator → TCP/UDP + static IP

>[!exam]
>non-HTTP / gaming / VoIP → Global Accelerator
### Exam traps
- global content → CloudFront, nie ALB  
- private S3 → CloudFront (OAC/OAI)  
- low latency worldwide → CloudFront  

- CloudFront ≠ API Gateway  
- CloudFront ≠ S3  
### TL;DR
- CDN → CloudFront  
- cache → edge locations  
- origin → S3 / ALB / EC2  
- security → WAF + Shield
