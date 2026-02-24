Created: 2026-02-04  20:50
___
Note:

>[! Important]
>Managed container orchestration service. 
>Uruchamiasz kontenery Docker bez zarządzania klastrem Kubernetes.

Powiązane: [[Amazon ECR]] | [[Amazon SQS]] | [[Amaon Fargate]] | [[Amazon EC2]] | ALB[[load balancer]] | [[IAM]] | [[CloudWatch]] | [[Amazon SNS]] | [[Amazon SQS]] | [[Auto Scaling]]
## Co to jest?

ECS to serwis do uruchamiania kontenerów Docker na AWS. Ty definiujesz **co** ma działać — AWS ogarnia **gdzie** i **jak**.

Dwa tryby uruchomienia (Launch Type):

- **Fargate** — serverless, AWS zarządza serwerami
- **EC2** — Ty zarządzasz instancjami EC2 w klastrze

___
## Kluczowe pojęcia

### Cluster

Logiczna grupa zasobów gdzie działają kontenery. Może zawierać instancje EC2 lub być pusty (Fargate).

### Task Definition

Przepis na kontener — plik JSON opisujący:

- obraz Docker (z [[Amazon ECR]] lub Docker Hub)
- CPU i RAM
- zmienne środowiskowe
- port mappings
- IAM role
- volumes

```json
{
  "family": "my-app",
  "containerDefinitions": [{
    "name": "web",
    "image": "123456.dkr.ecr.eu-west-1.amazonaws.com/my-app:latest",
    "cpu": 256,
    "memory": 512,
    "portMappings": [{ "containerPort": 80 }]
  }],
  "requiresCompatibilities": ["FARGATE"],
  "networkMode": "awsvpc",
  "cpu": "256",
  "memory": "512"
}
```

### ECS Task

Jeden lub więcej kontenerów działających razem (jak Pod w Kubernetes).

### Service

Zapewnia że określona liczba Tasków zawsze działa. Ogarnia restart po awarii, integrację z Load Balancerem, Auto Scaling.

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

---

## Data Volumes — Storage

**Opcje montowania storage w ECS:**

| Typ                       | Opis                                       | Kiedy                             |
| ------------------------- | ------------------------------------------ | --------------------------------- |
| EFS (Elastic File System) | współdzielony filesystem, działa z Fargate | dane współdzielone między Taskami |
| EBS                       | blokowy dysk, tylko EC2 launch type        | jeden Task, wysokie IOPS          |
| Bind Mount                | lokalny folder hosta, EC2                  | tymczasowe dane, logi             |
| S3                        | x                                          | x                                 |

**Fargate + EFS** = serverless + persistent storage. Popularny pattern na egzaminie.

![[Pasted image 20260224115308.png]]

---

## Integracje

**[[SQS]] + ECS** — klasyczny pattern:

```
SQS Queue  →  ECS Tasks (konsumenci)  →  Auto Scaling na podstawie długości kolejki
```

Wiele Tasków czyta z kolejki równolegle. ASG skaluje Taski gdy kolejka rośnie.

**[[SNS]] + ECS** — event-driven:

```
SNS Topic  →  SQS  →  ECS Tasks
```

**CloudWatch Logs** — każdy kontener wysyła logi przez log driver `awslogs`:

json

```json
"logConfiguration": {
  "logDriver": "awslogs",
  "options": {
    "awslogs-group": "/ecs/my-app",
    "awslogs-region": "eu-west-1",
    "awslogs-stream-prefix": "ecs"
  }
}
```

---

## Security

- **Security Groups** — przypisane do Taska (awsvpc) lub instancji EC2
- **VPC** — Tasks działają w prywatnych subnetach, dostęp przez ALB
- **Secrets Manager / SSM Parameter Store** — zmienne środowiskowe z sekretami, nigdy hardcode w Task Definition
- **ECR Image Scanning** — automatyczne skanowanie CVE przy push

---

## ECS vs EKS vs Lambda

||ECS|EKS|Lambda|
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

---

## Flashcards

**Q: Jaka jest różnica między Task a Service w ECS?** A: Task to jednorazowe uruchomienie kontenera. Service zapewnia że określona liczba Tasków zawsze działa i restartuje je po awarii.

**Q: Kiedy wybrać Fargate zamiast EC2 launch type?** A: Gdy nie chcesz zarządzać serwerami. Fargate = serverless containers. EC2 gdy potrzebujesz GPU, niższych kosztów przy dużej skali lub pełnej kontroli.

**Q: Do czego służy Task Role, a do czego Task Execution Role?** A: Task Role — uprawnienia dla kodu w kontenerze (S3, DynamoDB). Task Execution Role — uprawnienia dla agenta ECS (pull obrazu z ECR, logi do CloudWatch).

**Q: Jaki network mode jest wymagany dla Fargate?** A: `awsvpc` — każdy Task dostaje własny ENI i prywatny IP w VPC.

**Q: Jak podłączyć persistent storage do Fargate?** A: EFS (Elastic File System) — jedyna opcja shared storage dla Fargate.

**Q: Jak skalować ECS na podstawie kolejki SQS?** A: CloudWatch Alarm na metrykę `ApproximateNumberOfMessagesVisible` → Service Auto Scaling.

**Q: Gdzie przechowywać sekrety (hasła, klucze API) dla kontenerów ECS?** A: AWS Secrets Manager lub SSM Parameter Store. Nigdy hardcode w Task Definition.

**Q: ECS czy EKS — co wybrać?** A: ECS — prostszy, własna technologia AWS. EKS — gdy potrzebujesz Kubernetes. Na egzaminie "bez K8s" = ECS.



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
