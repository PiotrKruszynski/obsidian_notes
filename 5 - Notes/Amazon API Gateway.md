Created: 2026-02-24  08:42
___
Note:

![[Pasted image 20260320112651.png|100]]

>[!important]
>- API Gateway = **managed service do tworzenia API (HTTP/REST/WebSocket)**
>- działa jako **front door dla backendu**
>- integruje się z: **Lambda, EC2, ALB, AWS services**
>- serverless → brak zarządzania infrastrukturą
>- oferuje: **auth, throttling, caching, monitoring**

API Gateway = **reverse proxy + API management layer**  
  
- reverse proxy:  
  - przyjmuje request od klienta (HTTP/WebSocket)  
  - routuje do backendu (Lambda, ECS, EC2, ALB, AWS services)  
  - ukrywa backend (brak direct access, single entry point)  
  - decoupling: klient nie zna struktury systemu  
  
- API management layer:  
  - authentication / authorization  
    - IAM, Cognito, JWT, Lambda authorizer  
    - centralne egzekwowanie dostępu (backend nie musi)  
    
  - throttling / rate limiting / quotas  
    - kontrola ruchu (RPS, burst, limity miesięczne)  
    - ochrona backendu + kontrola kosztów  
    
  - API keys  
    - identyfikacja klienta (usage plans)  
    - nie security, tylko control + metering  
    
  - request / response transformation  
    - mapping payloadów (client ↔ backend contract)  
    - enables versioning i compatibility bez zmiany backendu  
    
  - monitoring  
    - CloudWatch metrics (latency, errors, count)  
    - central observability dla całego API  
    
  - caching  
    - response cache (TTL)  
    - redukcja latency i load na backendzie  
    
  - versioning  
    - /v1, /v2 lub stages  
    - izolacja zmian breaking  
    
  - custom domains  
    - własne domeny + TLS  
    - spójny publiczny endpoint  

#### Typy API  
_HTTP API  
- low-cost, low-latency  
- wspiera JWT / IAM auth  
- ograniczone feature’y (brak usage plans, API keys w pełnej formie)  
👉 default wybór (większość przypadków)  
  
_REST API  
- pełny feature set:  
- API keys  
- usage plans (limity per client)  
- advanced transformations (mapping templates)  
- caching  
- wyższy koszt i latency  
👉 gdy potrzebujesz granularnej kontroli i zarządzania klientami  
  
_WebSocket API  
- stateful, bidirectional communication  
- server push (real-time)  
👉 use case: chat, live updates, streaming events


Mental model:  
API Gateway ≠ tylko proxy    
API Gateway = **policy enforcement layer przed backendem**  
  
Flow:  
client → API Gateway (auth + limits + transform) → backend → response  
  
Use case:  
- publiczne API  
- backend dla mobile/web  
- serverless (API Gateway + Lambda)  
  
Trade-offs:  
- + centralna kontrola (security, limits, monitoring)  
- + brak zarządzania infra (serverless)  
- - większy latency niż ALB  
- - koszt przy dużym ruchu  
- - złożoność (mapping, konfiguracja)




---
### Endpoint types
- **Edge-optimized**
  - global (CloudFront pod spodem)
- **Regional**
  - jeden region
- **Private**
  - tylko w VPC (PrivateLink)

---
### Exam traps

- Lambda + HTTP → API Gateway  
- private API → Private endpoint (PrivateLink)  
- global API → edge-optimized  

- API Gateway ≠ Load Balancer  
- API Gateway ≠ CloudFront (choć może używać CF)

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
