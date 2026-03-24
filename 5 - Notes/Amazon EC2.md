Created: 2026-02-03  12:27
___
Note:


>[!important]
>- EC2 = **compute (VM) w AWS**
>- pełna kontrola nad OS (SSH/RDP)
>- płacisz za **czas działania + typ instancji**
>- fundament: **instance type + AMI + storage + networking**
>- skalowanie przez **Auto Scaling + Load Balancer**

---
### Mental model
EC2 = **serwer w chmurze na żądanie**

👉 masz:
- CPU / RAM / disk / network  
- pełny dostęp do systemu  
👉 AWS zapewnia:
- infrastrukturę  
- provisioning  

---
### Core elements
#### Instance type
- określa: CPU, RAM, network
- rodziny:
  - **t / t3 / t4g** → burst (tanie)
  - **m** → general purpose
  - **c** → compute optimized
  - **r** → memory optimized
  - **p / g** → GPU
#### AMI (Amazon Machine Image)
- template systemu (OS + config)
- np.:
  - Amazon Linux
  - Ubuntu
  - Windows
#### Storage
- **EBS**
  - persistent
  - block storage
- **Instance Store**  - physical storage (high IOPS)
  - ephemeral (ginie przy stop)

>[!exam]
>trwałe dane → EBS  
>cache/temp → instance store  
#### Networking
- działa w **VPC**
- ma:
  - private IP (zawsze)
  - public IP (opcjonalnie)
- security:
  - **Security Groups (stateful)**
  - **NACL (stateless)**

---
### Scaling
- **Auto Scaling Group (ASG)**
  - automatyczne dodawanie/usuwanie instancji
- **Load Balancer (ALB/NLB)**
  - rozkład ruchu

>[!exam]
>high availability → ASG + ALB  

# Placement groups
### Spread Placement Group  = maksymalna izolacja
>[!important]  
>- maksymalna izolacja instancji (HA)  
>- każda instancja na osobnym racku (power + network)  
>- **max 7 instances per AZ**
### Cluster Placement Group = blisko siebie
>[!important]  
>- **high performance (low latency, high throughput)**  
>- instancje bardzo blisko siebie  
>- 1 AZ

### Partition Placement Group  
>[!important]  
>- dla **dużych systemów rozproszonych**  
>- instancje podzielone na **partitions (grupy racków)**  
>- **Use case**: _Hadoop_, _Kafka_

---
### Pricing models
**On-Demand Instances** - płacisz za dokładny czas działania, bez zobowiązań, najdroższa w długim użyciu
**Reserved Instance** - rezerwujesz instancję na 1 lub 3 lata, zniżka do70%
**Convertible Reserved Instances** - masz opcje zmiany typu instancji
**Savings Plans** - możesz zmienić typ instancji, nawet usługę (np. na lambda) zobowiązanie na 1 lub 3 lata
**Spot Instance** - masz spota na niewykorzystanej mocy obliczeniową ale AWS może przerwać działanie instancję, jeżeli ktoś zapłaci więcej. 
Spoko dla Batch processing, BigData(Spark, Hadoop), ML training, renderingm stateless microservices
**Dedicated Hosts** - book an entire physical server, control instance placement.
**Dedicated Instances** - no other customer will share your hardware. Tu mamy izolacje instancji ale nie ma kontroli nad fizycznym serwerem.
**Capacity Reservations** - reserve capacity in a specific AZ for any duration. Gwarancja dostępności

Częsty pattern
`Auto Scaling Group + Launch Template + MixedInstancesPolicy`

**Launch Template** to „versioned, composable config”, który pozwala budować warianty instancji bez duplikacji

**EC2 User Data**
bootstrap our instance using an EC2 User data script, only once at the instance first start
can automate boot tasks such as:
 - installing updates and dynamic part
 - installing software
 - downloading common files from internet
 _run with root user_ nie trzeba `sudo`
 
---
### Kiedy używać
- pełna kontrola nad systemem
- custom software
- legacy apps
- gdy Lambda jest za ograniczona
	- np. lambda świetna do krótkich, max 15min

---
### Trade-offs
- wymaga zarządzania (patching, scaling)
- większy ops niż serverless
- większa elastyczność vs większa złożoność

---
### EC2 vs Lambda vs ECS

| Service | Typ | Use case |
|--------|-----|---------|
| EC2 | VM | full control |
| Lambda | serverless | event-driven |
| ECS/Fargate | containers | microservices |

---

### Exam traps
- EC2 ≠ serverless  
- HA → minimum 2 AZ + ASG  
- public access → przez ALB lub public IP  
- EBS jest **AZ-scoped**  

---

### TL;DR
- EC2 = VM w chmurze  
- kontrola vs ops  
- ASG + ALB = skalowanie + HA  
- EBS = trwałe dane  
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
