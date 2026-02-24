Created: 2026-02-24  13:57
___
Note:

>[!tip]
>Serverless Functions-as-a-Service. Uruchamiasz kod bez zarządzania serwerami — płacisz tylko za czas wykonania.

Lambda to FaaS — uruchamiasz funkcję w odpowiedzi na event. AWS zarządza wszystkim: serwerami, skalowaniem, dostępnością.

**Kluczowe cechy:**

- **Serverless** — zero zarządzania infrastrukturą
- **Automatic scaling** — od 0 do tysięcy równoległych wywołań automatycznie
- **Pay per use** — płacisz za liczbę wywołań i czas wykonania (ms), nie za idle
- **Event-driven** — Lambda reaguje na eventy, nie działa ciągle

![[Pasted image 20260224145409.png]]

---

## Limity (ważne na egzamin)

|Parametr|Limit|
|---|---|
|Timeout|max **15 minut**|
|RAM|128 MB – 10 GB|
|CPU|proporcjonalne do RAM (nie konfigurujesz osobno)|
|Deployment package|50 MB (zip), 250 MB (unzipped)|
|/tmp storage|512 MB – 10 GB|
|Concurrency|1000 (domyślnie, można zwiększyć)|

**Na egzaminie:** zadanie trwa dłużej niż 15 minut → Lambda nie nadaje się → użyj [[Amazon ECS]] / [[AWS Fargate]] lub EC2.

---

## Języki (Runtimes)

- Node.js, Python, Java, C#, Go, Ruby
- **Custom Runtime** — dowolny język przez Lambda Layers
- **Container Image** — obraz Docker do 10 GB z ECR (musi implementować Lambda Runtime API)

---

## Triggery (źródła eventów)

Lambda może być wywołana przez:

|Trigger|Przykład|
|---|---|
|**API Gateway**|HTTP request → Lambda|
|**S3**|upload pliku → Lambda przetwarza|
|**DynamoDB Streams**|zmiana w tabeli → Lambda reaguje|
|**Kinesis**|stream danych → Lambda przetwarza|
|**SQS**|wiadomość w kolejce → Lambda|
|**SNS**|notyfikacja → Lambda|
|**CloudWatch Events / EventBridge**|harmonogram (cron) → Lambda|
|**ALB**|HTTP request przez Load Balancer|
|**Cognito**|event autoryzacji|
|**CloudFront (Lambda@Edge)**|request przy edge location|

---

## Pricing

- **Requests:** pierwsze 1 mln wywołań/miesiąc — free. Potem $0.20 za 1 mln.
- **Duration:** pierwsze 400 000 GB-sekund/miesiąc — free. Potem $0.0000166667 za GB-sekundę.

Bardzo tanie przy nieregularnym ruchu. Przy ciągłym wysokim ruchu może być droższe niż EC2.

---

## Lambda + Application Load Balancer

Lambda może odbierać HTTP/HTTPS przez ALB jako target group.

```
Client  →  ALB  →  Lambda Function
```

- ALB konwertuje HTTP request na JSON event dla Lambdy
- Lambda odpowiada JSON-em który ALB konwertuje na HTTP response
- Wspiera Multi-Header Values (jeden klucz, wiele wartości)

---

## Asynchronous vs Synchronous

**Synchronous** — czekasz na odpowiedź:

```
API Gateway → Lambda → zwraca wynik
```

**Asynchronous** — Lambda przetwarza w tle, nie czekasz:

```
S3 Event → Lambda (przetwarza async)
```

- przy błędzie Lambda retry 2 razy automatycznie
- nieudane eventy trafiają do **Dead Letter Queue** (SQS lub SNS)

---

## Event Source Mapping

Mechanizm gdzie Lambda sama polluje źródło danych i przetwarza rekordy w batchach.

Działa z:

- **SQS** — Lambda polluje kolejkę, przetwarza batch wiadomości
- **Kinesis** — Lambda czyta ze streamu, przetwarza rekordy
- **DynamoDB Streams** — Lambda reaguje na zmiany w tabeli

```
SQS / Kinesis / DynamoDB  →  [Event Source Mapping]  →  Lambda (batch)
```

Przy błędzie batch może trafić do DLQ lub być podzielony na mniejsze.

---
# Customization at the edge
#### Lambda@Edge - pełna moc aws lambda /  CloudFront Functions - lżejszy do prostszych działa w momentach viewer request (jak trafia do CloudFront) lub viewer response (przed response)

Uruchamiasz kod blisko użytkownika przy edge locations.

| -       |          Lambda@Edge           |       CloudFront Functions       |
| ------- | :----------------------------: | :------------------------------: |
| Gdzie   |   CloudFront edge locations    |    CloudFront edge locations     |
| Runtime |        Node.js, Python         |            JavaScript            |
| Timeout |          5–30 sekund           |              < 1 ms              |
| Użycie  | heavy logic, auth, A/B testing | lekkie transformacje headers/URL |

**Przypadki użycia**

| Use case                                           | CloudFront Functions | Lambda@Edge | kiedy które                                                                                                                                  |
| -------------------------------------------------- | -------------------: | ----------: | -------------------------------------------------------------------------------------------------------------------------------------------- |
| Website security and privacy                       |                    ✅ |           ✅ | Functions: proste blokady/headers/redirect HTTPS. Lambda@Edge: bardziej złożone reguły/rewriting/odpowiedzi.                                 |
| Dynamic web app at the edge                        |                    ❌ |           ✅ | Zwykle wymaga generowania/transformacji odpowiedzi.                                                                                          |
| SEO                                                |                    ✅ |           ✅ | Functions: redirect/rewrite dla botów, canonical, headers. Lambda@Edge: prerender / warianty treści dla crawlerów.                           |
| Intelligently route across origin and data centers |                   ⚠️ |           ✅ | Functions: proste przełączanie origin po host/path (limited). Lambda@Edge: routing na origin-request z większą logiką.                       |
| Bot mitigation at the edge                         |                    ✅ |           ✅ | Functions: szybkie blokowanie po UA/IP/cookies. Lambda@Edge: bardziej zaawansowane challenge/flow (często i tak z WAF).                      |
| Real-time image transformation                     |                    ❌ |           ✅ | Wymaga obróbki/zmiany payloadu (Functions nie).                                                                                              |
| A/B testing                                        |                    ✅ |           ✅ | Functions: split po cookie/header i rewrite. Lambda@Edge: bardziej złożone reguły + modyfikacja odpowiedzi.                                  |
| User auth and authorization                        |                    ✅ |           ✅ | Functions: JWT/cookie check + allow/deny/redirect. Lambda@Edge: bardziej złożone flow (np. token refresh, dynamic policies).                 |
| User prioritization                                |                    ✅ |           ✅ | Functions: proste reguły i headers. Lambda@Edge: złożone priorytety + routing/odpowiedzi.                                                    |
| User tracking and analytics                        |                    ✅ |           ✅ | Functions: dodanie/normalizacja headers/cookies, lightweight tracking. Lambda@Edge: bardziej rozbudowane przekształcenia odpowiedzi/żądania. |
# VPC

Domyślnie Lambda działa **poza VPC** — ma dostęp do internetu, ale nie do zasobów prywatnych (RDS, ElastiCache, prywatne EC2).

Żeby Lambda mogła łączyć się z zasobami w VPC:
- konfigurujesz VPC, subnety i Security Group w ustawieniach Lambdy
- Lambda tworzy **ENI (Elastic Network Interface)** w Twoim VPC
- jeśli potrzebuje internetu → potrzebny **NAT Gateway** w publicznym subnecie

Lambda (w VPC)  →  NAT GW  →  Internet  
Lambda (w VPC)  →  RDS (private subnet)  ✅

---

## Problem: Lambda + RDS (bez proxy)

Lambda skaluje się automatycznie.

Jeśli masz 1000 równoczesnych wywołań:  
→ możesz mieć 1000 połączeń do bazy.

Relacyjne bazy (MySQL, PostgreSQL) **nie lubią tysięcy krótkich połączeń**.

Skutek:
- exhausted connections
- timeouts
- niestabilność

## RDS Proxy – rozwiązanie

**Amazon RDS Proxy** to warstwa pośrednia między Lambda a RDS.

Działa jako:

- connection pooler
- zarządca połączeń
- bufor połączeń do DB

### Architektura:

Lambda  →  RDS Proxy  →  RDS

# Concurrency i Throttling

**Concurrency** = ile funkcji działa równolegle.

- Domyślny limit: **1000 concurrent executions** per konto/region
- Gdy limit przekroczony → **throttling** (błąd 429)

**Reserved Concurrency** — gwarantujesz X równoległych wywołań dla konkretnej funkcji. Reszta konta ma limit - X.

**Provisioned Concurrency** — Lambda z góry inicjalizuje N instancji. Eliminuje **cold start**.

---

# Cold Start

Przy pierwszym wywołaniu (lub po długiej przerwie) Lambda musi:

1. załadować kod
2. zainicjalizować runtime
3. uruchomić handler

To trwa kilkaset ms do kilku sekund — **cold start**.

**Jak unikać:**

- Provisioned Concurrency — Lambda zawsze ciepła
- mniejszy deployment package — szybszy init
- unikaj VPC jeśli nie potrzebujesz (VPC + ENI wydłuża cold start)

---

# Lambda Layers

Mechanizm współdzielenia kodu i bibliotek między funkcjami.

```
Lambda Function
├── Twój kod
└── Layer (biblioteki, dependencies, custom runtime)
```

- max 5 layers per funkcja
- layer może być współdzielony między funkcjami i kontami
- zmniejsza rozmiar deployment package

---

# Storage

|Typ|Zakres|Rozmiar|Kiedy|
|---|---|---|---|
|`/tmp`|per invocation (persist między warm wywołaniami)|512 MB – 10 GB|tymczasowe pliki|
|Lambda Layers|deployment-time|250 MB|biblioteki, dependencies|
|S3|zewnętrzny|nieograniczony|duże pliki, persistent data|
|EFS|zewnętrzny, VPC|nieograniczony|shared persistent storage|

---

# Typowe patterny (egzamin)

**Serverless API:**

```
Client  →  API Gateway  →  Lambda  →  DynamoDB
```

**Event-driven processing:**

```
S3 upload  →  Lambda (thumbnail)  →  S3 (wynik)
```

**Scheduled job (cron):**

```
EventBridge (cron)  →  Lambda
```

**Stream processing:**

```
Kinesis / DynamoDB Streams  →  Lambda (batch)
```

**Async z DLQ:**

```
SNS  →  Lambda  →  błąd  →  SQS DLQ  →  analiza
```

---

## Lambda vs EC2 vs ECS

||Lambda|EC2|ECS/Fargate|
|---|---|---|---|
|Max czas|15 min|nieograniczony|nieograniczony|
|Skalowanie|automatyczne natychmiastowe|wolniejsze (ASG)|szybsze niż EC2|
|Cold start|tak|nie|nie|
|Cena|per ms|per godzinę|per vCPU/RAM/s|
|Kiedy|krótkie zadania event-driven|długie procesy, pełna kontrola|kontenery, długie zadania|

---

## Flashcards

**Q: Jaki jest maksymalny timeout Lambdy?** A: 15 minut. Dłuższe zadania → ECS/Fargate lub EC2.

**Q: Co to cold start i jak go unikać?** A: Opóźnienie przy pierwszym wywołaniu gdy Lambda inicjalizuje środowisko. Unikasz przez Provisioned Concurrency lub mniejszy package.

**Q: Jaka jest różnica między Reserved a Provisioned Concurrency?** A: Reserved — gwarantujesz limit dla funkcji (ochrona przed throttlingiem innych). Provisioned — pre-inicjalizujesz instancje (eliminuje cold start).

**Q: Jak Lambda czyta z SQS?** A: Przez Event Source Mapping — Lambda sama polluje SQS i przetwarza wiadomości w batchach.

**Q: Kiedy Lambda potrzebuje VPC?** A: Gdy musi gadać z zasobami prywatnymi — RDS, ElastiCache, zasoby w prywatnych subnetach.

**Q: Co to Lambda Layers?** A: Mechanizm współdzielenia bibliotek i dependencies między funkcjami. Max 5 layers per funkcja.

**Q: Lambda@Edge vs CloudFront Functions — różnica?** A: Lambda@Edge — ciężka logika, auth, do 30s timeout. CloudFront Functions — lekkie transformacje headers/URL, < 1ms.

**Q: Co się dzieje przy błędzie w asynchronicznym wywołaniu Lambdy?** A: Lambda retry 2 razy automatycznie. Po wyczerpaniu prób event trafia do Dead Letter Queue (SQS lub SNS).

**Q: Ile kosztuje Lambda przy zerowym ruchu?** A: Zero — płacisz tylko za wywołania i czas wykonania. Brak idle costs.




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
