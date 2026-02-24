Created: 2026-02-24  08:42
___
Note:

>[!tip]
>API Gateway to fully managed serwis który działa jako "drzwi wejściowe" do Twoich serwisów backendowych. Obsługuje autoryzację, throttling, caching, transformacje requestów i monitoring.

**Kluczowe cechy:**

- **Serverless** — zero zarządzania infrastrukturą
- **Automatic scaling** — obsługuje dowolną liczbę requestów
- **Pay per use** — płacisz za wywołania API i transfer danych
- Integracja z Lambda = w pełni serverless stack

# Typy API

### REST API

- najbardziej rozbudowany, pełne funkcje
- obsługuje: caching, request/response transformation, usage plans, API keys
- **kiedy:** produkcyjne API z pełną kontrolą

### HTTP API

- prostszy i tańszy niż REST API (ok. 70% taniej)
- mniej funkcji — brak caching, brak request transformation
- niższa latencja
- **kiedy:** proste Lambda proxy, JWT autoryzacja, niższy koszt

### WebSocket API

- dwukierunkowa komunikacja w czasie rzeczywistym
- serwer może pushować do klienta
- **kiedy:** chat, live dashboard, gaming, notyfikacje real-time

|-|REST API|HTTP API|WebSocket API|
|---|---|---|---|
|Cena|najwyższa|~70% taniej|per message|
|Caching|tak|nie|nie|
|Request transform|tak|nie|nie|
|Auth|Lambda, Cognito, IAM|JWT, Lambda|Lambda, IAM|
|Kiedy|pełna kontrola|prostota, koszt|real-time|

---

# Integracje backendowe

```
Client  →  API Gateway  →  Lambda Function
                        →  HTTP endpoint (EC2, ECS, publiczny URL)
                        →  AWS Service (DynamoDB, SQS, SNS — bezpośrednio)
                        →  Mock (zwraca statyczną odpowiedź bez backendu)
```

**AWS Service Integration** — API Gateway może bezpośrednio pisać do SQS, DynamoDB itp. bez Lambdy:

```
POST /orders  →  API Gateway  →  SQS SendMessage
```

---

# Endpoint Types

### Edge-Optimized (domyślny)

- request przechodzi przez CloudFront Edge Locations
- niższa latencja dla globalnych użytkowników
- API Gateway fizycznie w jednym regionie, ale CloudFront globalnie

### Regional

- dla klientów w tym samym regionie
- możesz sam podpiąć CloudFront z własną konfiguracją

### Private

- dostępny tylko z VPC przez VPC Endpoint (Interface Endpoint)
- używasz resource policy żeby kontrolować dostęp

---

# Autoryzacja

### IAM Authorization

- dla wewnętrznych serwisów AWS i użytkowników z uprawnieniami IAM
- request podpisywany Sig V4
- **kiedy:** serwisy AWS, EC2, Lambda wywołują API

### Lambda Authorizer (Custom Authorizer)

- Lambda sprawdza token (JWT, OAuth, custom) i zwraca IAM policy
- wynik cachowany (TTL konfigurowalny)
- **kiedy:** własna logika autoryzacji, zewnętrzny OAuth

```
Client  →  API Gateway  →  Lambda Authorizer (sprawdź token)
                                ↓ zwraca Allow/Deny policy
                        →  Backend Lambda
```

### Cognito User Pools

- API Gateway automatycznie weryfikuje JWT token z Cognito
- brak custom kodu — konfiguracja w konsoli
- **kiedy:** autoryzacja użytkowników aplikacji mobilnych/webowych

|-|IAM|Lambda Authorizer|Cognito|
|---|---|---|---|
|Dla kogo|serwisy AWS|custom token/OAuth|end users|
|Custom logika|nie|tak|nie|
|Caching|nie|tak|tak|
|Koszt|free|koszt Lambdy|koszt Cognito|

---

# Caching

Cachuje odpowiedzi backendu — zmniejsza liczbę wywołań i latencję.

- dostępny tylko w **REST API**
- TTL: 0–3600 sekund (domyślnie 300s)
- rozmiar cache: 0.5 GB – 237 GB
- cache per stage (np. prod, dev)
- można invalidować cache per request (header `Cache-Control: max-age=0`) — wymaga uprawnień IAM

---

# Throttling

Ochrona backendu przed przeciążeniem.

**Domyślne limity:**

- 10 000 requests/sekundę per konto/region (soft limit)
- 5 000 burst limit

**Usage Plans + API Keys:**

- tworzysz plan z limitem requestów (per dzień, per miesiąc) i throttlingiem
- przypisujesz API Key do planu
- klienci wysyłają klucz w headerze `x-api-key`
- **kiedy:** monetyzacja API, różne limity dla różnych klientów

---

# Stages i Deployment

Zmiany w API Gateway wymagają **deployment** do **stage**.

```
API  →  deploy  →  Stage: dev   (https://xxx.execute-api.../dev/...)
                →  Stage: prod  (https://xxx.execute-api.../prod/...)
```

**Stage Variables** — jak zmienne środowiskowe dla stage. Możesz wskazywać na różne wersje Lambdy:

```
Lambda alias: ${stageVariables.lambdaAlias}
dev stage  → lambdaAlias = dev
prod stage → lambdaAlias = prod
```

**Canary Deployment** — część ruchu (np. 10%) idzie do nowej wersji API, reszta do starej. Rollout bez downtime.

---

# CORS

Cross-Origin Resource Sharing — wymagany gdy frontend (np. S3 static website) wywołuje API z innej domeny.

- API Gateway może automatycznie obsłużyć CORS (enable w konsoli)
- dodaje headery `Access-Control-Allow-Origin` do response
- przy Lambda proxy — Lambda musi sama zwracać CORS headery

---

# WebSocket API — szczegóły

Utrzymuje persistent połączenie między klientem a API Gateway.

```
Client  ←→  API Gateway (WebSocket)  →  Lambda / HTTP / AWS Service
```

**Kluczowe pojęcia:**

- `connectionId` — unikalny ID każdego połączonego klienta
- `@connections` API — serwer może pushować wiadomości do konkretnego klienta przez connectionId
- Routes: `$connect`, `$disconnect`, `$default`, custom routes

**Pattern — chat app:**

```
User A connects  →  connectionId zapisany w DynamoDB
User A wysyła    →  Lambda broadcast  →  API Gateway @connections  →  User B, C, D
```

---

# Security — dodatkowe

**AWS WAF** — podpinasz do API Gateway, filtruje złośliwe requesty (SQL injection, XSS, IP blocking).

**Resource Policy** — kto może wywołać API (per IP, per VPC, per konto AWS).

**Mutual TLS (mTLS)** — klient i serwer wzajemnie weryfikują certyfikaty. Dla B2B API.

---

# Monitoring

- **CloudWatch Metrics:** `Count`, `Latency`, `IntegrationLatency`, `4XXError`, `5XXError`
- **CloudWatch Logs:** request/response logging per stage
- **X-Ray** — tracing end-to-end przez API Gateway → Lambda → DynamoDB

---

# Typowe patterny (egzamin)

**Serverless REST API:**

```
Client  →  API GW  →  Lambda  →  DynamoDB
```

**Serverless + autoryzacja:**

```
Client  →  API GW  →  Cognito (verify token)  →  Lambda  →  DynamoDB
```

**Direct service integration (bez Lambdy):**

```
POST /messages  →  API GW  →  SQS SendMessage
GET /items      →  API GW  →  DynamoDB Query
```

**Real-time chat:**

```
Client  ←→  API GW (WebSocket)  →  Lambda  →  DynamoDB (connectionIds)
```

**API z throttlingiem per klient:**

```
API GW  →  Usage Plan (1000 req/day)  →  API Key  →  Klient A
        →  Usage Plan (10000 req/day) →  API Key  →  Klient B (premium)
```

---

# Flashcards

**Q: Jaka różnica między REST API a HTTP API w API Gateway?** A: HTTP API jest prostszy i ~70% tańszy, ale bez cachingu i transformacji requestów. REST API ma pełne funkcje. HTTP API gdy zależy Ci na koszcie i prostocie.

**Q: 3 typy autoryzacji w API Gateway?** A: IAM (serwisy AWS), Lambda Authorizer (custom token/OAuth), Cognito User Pools (end users z JWT).

**Q: Kiedy użyć WebSocket API?** A: Real-time dwukierunkowa komunikacja — chat, live dashboard, gaming, notyfikacje push.

**Q: Co to Stage Variables?** A: Zmienne per stage (dev/prod) — pozwalają wskazywać na różne wersje Lambdy lub backendy bez zmiany kodu API.

**Q: Jak API Gateway chroni backend przed przeciążeniem?** A: Throttling — domyślnie 10 000 req/s per konto. Usage Plans z API Keys dla per-klient limitów.

**Q: Co to Canary Deployment w API Gateway?** A: Część ruchu (np. 10%) kierujesz do nowej wersji API — testowanie w produkcji bez pełnego rollout.

**Q: Kiedy potrzebujesz CORS w API Gateway?** A: Gdy frontend z innej domeny (np. S3 static website) wywołuje API. API Gateway może automatycznie dodać CORS headery.

**Q: Jak serwer pushuje wiadomość do konkretnego klienta w WebSocket API?** A: Przez `@connections` API używając `connectionId` klienta — zapisujesz connectionId w DynamoDB przy połączeniu.

**Q: Jaki endpoint type użyć dla prywatnego API dostępnego tylko z VPC?** A: Private endpoint type z VPC Endpoint (Interface Endpoint).




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
