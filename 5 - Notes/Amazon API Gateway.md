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

### Mental model
API Gateway = **reverse proxy + API management layer**

reverse proxy - serwerowy pośrednik przyjmuje żądania od klientów i przekazujący do serwerów backendowych

👉 klient:
- wysyła request HTTP  
👉 API Gateway:
- autoryzuje  
- throttluje  
- routuje do backendu  
### Typy API
- **HTTP API**
  - tańsze, prostsze
- **REST API**
  - więcej feature’ów (np. API keys, usage plans)
- **WebSocket API**
  - real-time (bidirectional)
### Integracje (backend)
- **Lambda** (najczęściej)
- **ALB / EC2**
- **AWS services (np. S3, DynamoDB)**

>[!exam]
>serverless API → API Gateway + Lambda  

---
### Kluczowe funkcje
- **Authentication**
  - IAM
  - Cognito
  - Lambda authorizer
- **Throttling**
  - limit requestów (rate limiting)
- **Caching**
  - response cache (REST API)
- **Monitoring**
  - CloudWatch logs

---
### Endpoint types
- **Edge-optimized**
  - global (CloudFront pod spodem)
- **Regional**
  - jeden region
- **Private**
  - tylko w VPC (PrivateLink)

---
### API Gateway vs ALB

| Feature | API Gateway | ALB |
|--------|------------|-----|
| typ | API mgmt | load balancer |
| auth | zaawansowane | podstawowe |
| serverless | ✅ | ❌ |
| WebSocket | ✅ | ❌ |

---

### Kiedy używać
- serverless backend (Lambda)
- publiczne API
- kontrola ruchu i auth

---

### Trade-offs
- koszt przy dużym ruchu
- latency > ALB
- bardziej złożony config

---

### Exam traps

- Lambda + HTTP → API Gateway  
- private API → Private endpoint (PrivateLink)  
- global API → edge-optimized  

- API Gateway ≠ Load Balancer  
- API Gateway ≠ CloudFront (choć może używać CF)

---

### TL;DR

- API Gateway = front door dla API  
- Lambda integration = klasyk  
- auth + throttling + monitoring  
- serverless API → API Gateway  

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
