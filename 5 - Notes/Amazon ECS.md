Created: 2026-02-04  20:50
___
Note:


>[!Definition]
>- ECS → **managed container orchestration (Docker)** bez Kubernetes
>- 2 launch types: _Fargate_ (serverless)** vs **EC2 (self-managed nodes)**
>- uruchamiasz **Task / Service** → AWS zarządza schedulingiem
>- integracje: **ALB/NLB, ECR, CloudWatch, IAM**
>- networking: **awsvpc (ENI per Task)**
>- scaling: **Service Auto Scaling + (EC2) Capacity Providers**
>- use when: **containers without Kubernetes**
# Mental model
Definiujesz Task → ECS uruchamia go na Fargate lub EC2 → Service utrzymuje desired count + LB routing.

- Task = jednostka uruchomienia (jak Pod)  
- Service = desired state + HA + scaling  
- Fargate = brak serwerów, EC2 = kontrola/koszt  
**Use case**: microservices, APIs, workers (SQS), batch jobs

# Core features
- Launch types:
  - **Fargate** → serverless, per-task billing
  - **EC2** → pełna kontrola, niższy koszt przy skali
- Task Definition (JSON):
  - image (ECR), CPU/RAM, ports, env, **IAM roles**
- Networking:
  - **awsvpc (required for Fargate)** → ENI + SG per Task
- Load Balancing:
  - **ALB (HTTP)**, **NLB (TCP)**, dynamic port mapping
- Auto Scaling:
  - Service (CPU/Mem/ALB req/SQS depth)
  - **Capacity Provider (EC2 only)** → skaluje instancje
- Storage:
  - **EFS (Fargate + EC2)**, EBS/bind (EC2 only)
- Logging:
  - CloudWatch Logs (`awslogs`)


![[Pasted image 20260224115308.png]]

# How it works
Task Definition → ECS schedules:
- Fargate: AWS uruchamia Task w VPC (ENI)
- EC2: Task na instancji z cluster ASG

Service:
- utrzymuje N tasków  
- health check + restart  
- integracja z ALB/NLB  
# Comparison

| Feature | Fargate | EC2 |
|--------|--------|-----|
| Servers | AWS | You |
| Scaling | instant | depends on EC2 |
| Cost | higher/unit | cheaper at scale |
| Control | low | high (GPU, AMI) |
| Use case | default | custom infra |
# Exam traps
- ❌ ECS = Kubernetes → NIE (to EKS)
- ❌ Fargate daje dostęp SSH → NIE
- ❌ brak `awsvpc` w Fargate → NIE (required)
- ❌ Task Role = pull image → NIE (to Execution Role)
- ❌ Service = jednorazowe joby → NIE (Task do batch)
- ❌ EBS w Fargate → NIE (tylko EFS)

# TL;DR
- ECS = **containers bez K8s**
- Fargate → serverless (default exam choice)
- EC2 → control + cost optimization
- Task = run, Service = maintain + scale



```
Cluster
└── Service (chcę 3 taski)
    ├── Task (kontener web + kontener sidecar)
    ├── Task
    └── Task
```


![[Pasted image 20260224090752.png]]

---

## Launch Types — Fargate vs EC2

|Cecha|Fargate|EC2|
|---|---|---|
|Zarządzanie serwerami|AWS|Ty|
|Koszty|wyższe za jednostkę|niższe przy dużej skali|
|Kontrola|mniejsza|pełna (SSH, GPU, custom AMI)|
|Skalowanie|natychmiastowe|wolniejsze (trzeba odpalić EC2)|
|Kiedy|domyślny wybór|GPU, specjalne wymagania, koszt|

**Na egzaminie:** jeśli pytanie mówi "bez zarządzania serwerami" lub "serverless containers" → **Fargate**.

![[Pasted image 20260224090830.png]]

---
## Networking

ECS obsługuje trzy tryby sieci:

|Tryb|Opis|Kiedy|
|---|---|---|
|`awsvpc`|każdy Task dostaje własny ENI i prywatny IP|Fargate (wymagany), EC2 (zalecany)|
|`bridge`|Docker bridge network, port mapping na hoście|EC2, stare aplikacje|
|`host`|kontener używa portu hosta bezpośrednio|EC2, high performance|

**awsvpc** = Task wygląda jak osobny serwer w VPC. Możesz przypiąć Security Group bezpośrednio do Taska.

---
## Load Balancing

ECS integruje się z:

- **ALB** (Application Load Balancer) — HTTP/HTTPS, path-based routing, zalecany
- **NLB** (Network Load Balancer) — TCP, high throughput, static IP, [[AWS Private Link]]
- **CLB** — legacy, nie używaj

ALB + ECS = dynamiczny port mapping. Wiele Tasków na jednej instancji EC2, ALB sam ogarnia porty.

---
## Auto Scaling

Dwie warstwy skalowania:

**1. Auto Scaling Group Scaling** — skaluje liczbę Tasków
- Av COU utilization -
- Av memory utilization - scale in RAM
- Count per Target - metric from ALB
Target Scaling
Step Scaling
Scheduled Scaling

**Auto Scaling Group Scaling** to nie to smo co EC2 [[Auto Scaling]]

**2. ECS Cluster Capacity Provider** (tylko EC2 launch type) — skaluje liczbę instancji EC2 w klastrze przez [[Auto Scaling]] Group + Capacity Provider.

**Fargate** — tylko Service Auto Scaling, EC2 nie dotyczy.

![[Pasted image 20260224121124.png]]

---

## IAM Roles w ECS

Dwie osobne role — częsty temat na egzaminie:

|Rola|Kto jej używa|Do czego|
|---|---|---|
|**Task Role**|kod w kontenerze|dostęp do S3, DynamoDB, SQS itp.|
|**Task Execution Role**|agent ECS (nie Twój kod)|pull obrazu z ECR, logi do CloudWatch|

```
Task Execution Role  →  ECR (pull image), CloudWatch (push logs)
Task Role           →  S3, DynamoDB, SQS (Twoja aplikacja)
```

**Na egzaminie:** kontener nie może czytać S3 → brakuje **Task Role**.

![[Pasted image 20260224090913.png]]



---
## Amazon ECR — Elastic Container Registry

Prywatne repozytorium obrazów Docker na AWS.

```
docker build -t my-app .
docker tag my-app 123456.dkr.ecr.eu-west-1.amazonaws.com/my-app:latest
docker push 123456.dkr.ecr.eu-west-1.amazonaws.com/my-app:latest
```

- skanowanie obrazów pod kątem podatności (CVE)
- replikacja między regionami
- integracja z ECS, EKS, Lambda


![[Pasted image 20260224115308.png]]

## Integracje

**[[Amazon SQS]] + ECS** — klasyczny pattern:

```
SQS Queue  →  ECS Tasks (konsumenci)  →  Auto Scaling na podstawie długości kolejki
```

Wiele Tasków czyta z kolejki równolegle. ASG skaluje Taski gdy kolejka rośnie.

**[[Amazon SNS]] + ECS** — event-driven:

```
SNS Topic  →  SQS  →  ECS Tasks
```

**CloudWatch Logs** — każdy kontener wysyła logi przez log driver `awslogs`:


## ECS vs EKS vs Lambda

|ECS|EKS|Lambda|
|---|---|---|---|
|Technologia|własna AWS|Kubernetes|funkcje|
|Złożoność|niska|wysoka|najniższa|
|Kontrola|średnia|pełna|najniższa|
|Kiedy|kontenery bez K8s|potrzebujesz K8s|krótkie zadania event-driven|

**Na egzaminie:** "kontenery bez Kubernetes" → **ECS**. "Kubernetes na AWS" → **EKS**.

---

## Typowe patterny (egzamin)

**Microservices:**

```
ALB  →  /api/*  →  ECS Service A (Fargate)
     →  /web/*  →  ECS Service B (Fargate)
```

**Batch processing:** with [[Amazon EventBridge]]

```
S3 upload  →  EventBridge  →  ECS Task (jednorazowy, nie Service)
```

![[Pasted image 20260224121649.png]]

![[Pasted image 20260224122317.png]]

![[Pasted image 20260224122349.png]]

**Auto Scaling na SQS:**

```
SQS  →  ECS Service  →  CloudWatch Alarm (QueueDepth)  →  Scale Out/In
```

![[Pasted image 20260224122332.png]]

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
