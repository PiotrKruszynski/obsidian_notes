---
title: "Amazon EC2"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-18
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!important]
- EC2 = **compute (VM) w AWS**
- pełna kontrola nad OS (SSH/RDP)
- płacisz za **czas działania + instance type**
- fundament: **instance type + AMI + storage + networking**
- skalowanie przez **Auto Scaling + Load Balancer**

---

## Mental model
EC2 = **compute node + attached resources (ENI + EBS)**

👉 compute (CPU/RAM) jest oddzielony od:
- network (ENI)
- storage (EBS)

👉 EC2 jest **stateless by design**  
→ state powinien być poza instancją (EBS / S3 / DB)

---

## Core elements

### Instance type
- określa: CPU, RAM, network, I/O limits
- rodziny:
  - **t (t3/t4g)** → burstable (CPU credits)
  - **m** → general purpose
  - **c** → compute optimized
  - **r** → memory optimized
  - **p / g** → GPU

> [!exam]
> sustained CPU → nie używaj t-class

---

### AMI (Amazon Machine Image)
- template instancji:
  - OS + software + config
- immutable pattern:
  - zamiast zmieniać → tworzysz nową AMI

---

### Storage

#### EBS
- block storage
- persistent
- AZ-scoped
- snapshot → backup (S3 under the hood)

---

#### Instance Store
- lokalny dysk (NVMe)
- bardzo szybki (low latency)
- **ephemeral (ginie przy stop/terminate)**

> [!exam]
> trwałe dane → EBS  
> cache / scratch → instance store  

---

### Networking

- EC2 używa **ENI**
- posiada:
  - private IP (zawsze)
  - public IP (opcjonalnie, ephemeral)

- routing:
  - przez route table subnetu

- security:
  - **Security Groups (stateful, na ENI)**
  - **NACL (stateless, na subnet)**

> [!exam]
> SG → allow only  
> NACL → allow + deny  

---

## Lifecycle

- launch → running → stop → start → terminate

- stop:
  - compute wyłączony
  - EBS zostaje
  - **public IP się zmienia**

- terminate:
  - instance usunięta
  - EBS usuwany jeśli `deleteOnTermination=true`

---

## Scaling

### Auto Scaling Group (ASG)
- dynamiczne skalowanie (CPU, SQS, custom metrics)
- health checks (EC2 / ELB)
- multi-AZ

---

### Load Balancer
- ALB (HTTP)
- NLB (TCP/low latency)

> [!exam]
> HA → ASG + multi-AZ + LB  

---

## Placement groups

### Spread
- max izolacja (HA)
- różne racki
- **max 7 instances per AZ**

---

### Cluster
- low latency + high throughput
- jedna AZ
- HPC / big data

---

### Partition
- podział na grupy (partitions)
- brak współdzielenia racków między partycjami
- use case:
  - Hadoop
  - Kafka

---

## Pricing models

- On-Demand
  - elastyczne, najdroższe long-term

- Reserved Instances
  - 1/3 lata
  - zniżka do ~70%

- Savings Plans
  - bardziej elastyczne niż RI
  - obejmuje różne instance typy / usługi

- Spot Instances
  - bardzo tanie (do ~90%)
  - **mogą zostać przerwane (2 min notice)**
  - use case:
    - batch
    - big data
    - stateless workloads

- Dedicated Hosts
  - pełna kontrola nad fizycznym serwerem

- Dedicated Instances
  - izolacja hardware (bez kontroli placement)

- Capacity Reservations
  - gwarancja capacity w AZ

---

## Launch Template

- versioned config:
  - AMI
  - instance type
  - network
  - storage
- używany przez ASG

---

## EC2 User Data

- skrypt wykonywany przy **pierwszym starcie**
- działa jako root
- use case:
  - install software
  - bootstrap config

⚠️ nie uruchamia się przy każdym starcie (chyba że wymusisz)

---

## Use cases

- custom backend
- legacy apps
- pełna kontrola OS
- workloads >15 min (Lambda limit)

---

## Trade-offs

- + pełna kontrola
- + elastyczność
- - ops overhead (patching, scaling)
- - nie serverless

---

## EC2 vs Lambda vs ECS

| Service | Typ | Use case |
|--------|-----|---------|
| EC2 | VM | full control |
| Lambda | serverless | event-driven |
| ECS/Fargate | containers | microservices |

## Elastic Fabric Adapter
EFA jest specjalnym interfejsem sieciowym dla workloadów **HPC / tightly coupled compute**, gdzie instancje muszą bardzo szybko komunikować się między sobą z niską latencją.


---

## Exam traps

- EC2 ≠ serverless  
- HA → min. 2 AZ + ASG  
- public IP zmienia się po stop/start  
- EBS = AZ-scoped  
- SG przypisane do ENI  
- Spot → może zostać przerwany  
- t-class → CPU credits  

---

## TL;DR

- EC2 = **VM + attached resources**
- compute oddzielony od storage/network
- EBS = trwałe dane, instance store = ephemeral
- HA = ASG + multi-AZ + LB
- więcej kontroli = więcej responsibility
