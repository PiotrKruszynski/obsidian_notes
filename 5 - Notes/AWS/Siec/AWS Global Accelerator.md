---
title: "AWS Global Accelerator"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-02-18  20:49
___
Note:


![[Pasted image 20260218205113.png]]


>[!Definition]
>Global Accelerator = **network layer optimizer (TCP/UDP)**  
>zapewnia **stałe IP + szybki routing globalny**
>brak DNS cache problem
>dla **non-HTTP** np. gry , VoIP, IoT
>

### Mental model
Global Accelerator = **„szybsza droga do Twojej aplikacji” (bez cache)**

👉 user:
- łączy się do **static Anycast IP**
👉 AWS:
- kieruje ruch przez backbone do najbliższego zdrowego endpointu
# Core features
- **2 static Anycast IP**
- działa na:
  - TCP
  - UDP
- routing:
  - lowest latency
- brak DNS cache problem

>[!exam]
>fixed IP + global routing → Global Accelerator

---

# GA regularnie sprawdza endpoint'y

- TCP → czy port odpowiada
- HTTP/HTTPS → czy endpoint zwraca poprawną odpowiedź (np. 200)

endpoint nie odpowiada → oznaczony jako unhealthy

Jeśli endpoint padnie:
```
było:  
user → GA → region A  
  
awaria:  
region A down ❌  
  
jest:  
user → GA → region B ✅
```

✔ bez zmiany IP  
✔ bez DNS  
✔ bez restartu klienta

---
# Use cases
global apps (multi-region)
**non-HTTP** (UDP/TCP):
  - gaming
  - VoIP
  - IoT
gdy potrzebujesz:
  - **static IP**
Global Accelerator ≠ S3 service

---

# Global Accelerator vs CloudFront

| Feature | CloudFront | Global Accelerator |
|--------|-----------|-------------------|
| layer | L7 (HTTP) | L4 (TCP/UDP) |
| cache | ✅ | ❌ |
| static IP | ❌ | ✅ |
| use case | CDN | networking |

>[!exam]
>cache → CloudFront  
>TCP/UDP / static IP → Global Accelerator  

---
# Key advantages

- omija public internet (AWS backbone)
- stabilniejszy latency
- łatwe whitelisting (2 IP)

---

# Exam traps

- Global Accelerator ≠ ContentDeliveryNetwork -> nie trzyma danych, nie cach'uje, działa na TCP/UDP (L4), przyspiesza przez lepszą trasę sieciową
- Global Accelerator ≠ DNS  
- GA nie działa na HTTP-level logic (path, headers)

---
# TL;DR
- static IP → Global Accelerator  
- TCP/UDP → Global Accelerator  
- cache → CloudFront  

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
