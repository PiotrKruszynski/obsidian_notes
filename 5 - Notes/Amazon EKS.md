Created: 2026-02-24  09:11
___
Note:

>[!tip]
>Managed container orchestration service. 
>Uruchamiasz kontenery Docker bez zarządzania klastrem Kubernetes.

EKS = managed Kubernetes clusters na AWS. AWS zarządza control plane (master nodes) — Ty zarządzasz worker nodes (lub oddajesz to Fargate).

Kubernetes to open-source system do automatycznego deployment, skalowania i zarządzania kontenerami Docker.

**Kiedy EKS zamiast ECS:**

- firma już używa Kubernetes on-premises lub w innym cloudzie (Azure, GCP)
- chcesz migrować do AWS bez zmiany narzędzi
- Kubernetes jest **cloud-agnostic** — ten sam tooling wszędzie

**Na egzaminie:** "Kubernetes on AWS" → **EKS**. "kontenery bez Kubernetes" → [[Amazon ECS]]

![[Pasted image 20260224091126.png]]
node - dostarcza moc obliczeniową, fizyczna lub wirtualna maszyna
pod - uruchamia aplikację, najmniejsza jednostka wdrożeniowa

![[Pasted image 20260224091137.png]]

## Node Types — 3 opcje

### Managed Node Groups

- AWS tworzy i zarządza instancjami EC2 za Ciebie
- Nodes są częścią ASG zarządzanej przez EKS
- Wspiera On-Demand i Spot Instances

### Self-Managed Nodes

- Ty tworzysz instancje EC2 i rejestrujesz do klastra
- Zarządzane przez własną ASG
- Możesz użyć gotowego AMI — **Amazon EKS Optimized AMI**
- Wspiera On-Demand i Spot Instances
- Pełna kontrola (custom AMI, GPU, specjalne wymagania)

### AWS Fargate

- Serverless — zero zarządzania nodami
- Brak maintenance
- Najprostrza opcja gdy nie potrzebujesz kontroli nad infrastrukturą


|-|Managed Node Groups|Self-Managed|Fargate|
|---|---|---|---|
|Zarządzanie EC2|AWS|Ty|brak|
|Custom AMI|nie|tak|nie|
|Spot Instances|tak|tak|nie|
|Maintenance|AWS|Ty|brak|

---

![[Pasted image 20260224091149.png]]

## Data Volumes

EKS wspiera montowanie storage przez **Container Storage Interface (CSI) driver**.

| Storage                         | Opis                        | Kiedy                                |
| ------------------------------- | --------------------------- | ------------------------------------ |
| **Amazon EBS**                  | blokowy dysk, jeden Pod     | bazy danych, high IOPS               |
| **Amazon EFS**                  | współdzielony filesystem    | działa z Fargate, dane między Podami |
| **Amazon FSx for Lustre**       | high-performance filesystem | HPC, ML, big data                    |
| **Amazon FSx for NetApp ONTAP** | enterprise NAS              | migracja z on-prem NetApp            |

**Fargate + EFS** = serverless + persistent storage. Klasyczny pattern na egzaminie.

![[Pasted image 20260224091200.png]]

## Logi i monitoring

**CloudWatch Container Insights** — zbiera logi i metryki z klastra EKS:

- CPU, RAM per Pod/Node
- logi kontenerów
- metryki sieciowe

Wymaga zainstalowania agenta CloudWatch na nodach.

---

## AWS App Runner

> Nie jest częścią EKS, ale pojawia się w tym samym kontekście — alternatywa dla ECS/EKS gdy chcesz maksymalnie uproszczonego deployu.

- Fully managed — zero infrastruktury
- Start z kodu źródłowego lub obrazu Docker
- Automatyczny build i deploy
- Auto scaling, HA, load balancer, szyfrowanie — w pakiecie
- VPC access support
- Integracja z bazami danych, cache, message queue

**Kiedy App Runner:** developer chce wrzucić aplikację bez znajomości AWS. Brak wymagań na kontrolę infrastruktury.

---

## AWS App2Container (A2C)

CLI tool do migracji istniejących aplikacji Java i .NET do kontenerów Docker.

**Lift-and-shift** — migracja bez zmiany kodu:

```
Discover & Analyze  →  Extract & Containerize  →  Create Artifacts  →  Deploy to AWS
(inwentarz app)        (Dockerfile, image)        (CloudFormation,      (ECR + ECS/EKS/
                                                   Task Definition,       App Runner)
                                                   EKS Pod spec)
```

- generuje CloudFormation templates (compute, network)
- rejestruje obraz w ECR
- deploy do ECS, EKS lub App Runner
- wspiera CI/CD pipelines

**Kiedy A2C:** masz stare aplikacje Java/.NET na bare metal lub VM i chcesz je skonteneryzować bez przepisywania.

---

## ECS vs EKS vs App Runner

| ECS            | EKS               | App Runner     |                         |
| -------------- | ----------------- | -------------- | ----------------------- |
| Technologia    | własna AWS        | Kubernetes     | managed PaaS            |
| Złożoność      | niska             | wysoka         | najniższa               |
| Kontrola       | średnia           | pełna          | minimalna               |
| Cloud-agnostic | nie               | tak            | nie                     |
| Kiedy          | kontenery bez K8s | K8s / migracja | szybki deploy bez infra |

---

## Flashcards

**Q: Czym różni się EKS od ECS?** A: EKS używa Kubernetes (open-source, cloud-agnostic). ECS używa własnego systemu AWS. Ten sam cel — różne API.

**Q: Kiedy wybrać EKS zamiast ECS?** A: Gdy firma już używa Kubernetes on-premises lub w innym cloudzie i chce migrować do AWS bez zmiany narzędzi.

**Q: Jakie są 3 typy nodów w EKS?** A: Managed Node Groups (AWS zarządza EC2), Self-Managed Nodes (Ty zarządzasz EC2), AWS Fargate (serverless, zero nodów).

**Q: Który storage działa z EKS Fargate?** A: Amazon EFS — jedyna opcja shared persistent storage dla Fargate.

**Q: Do czego służy CloudWatch Container Insights w EKS?** A: Zbiera logi i metryki (CPU, RAM, sieć) per Pod i Node z klastra EKS.

**Q: Co to AWS App Runner i kiedy go używać?** A: Fully managed serwis do deployu aplikacji web z kodu lub obrazu Docker. Gdy developer nie chce zarządzać infrastrukturą — zero konfiguracji, auto scaling w pakiecie.

**Q: Co to AWS App2Container (A2C)?** A: CLI tool do lift-and-shift aplikacji Java/.NET do kontenerów Docker. Generuje Dockerfile, CloudFormation, Task Definition i deployuje do ECS/EKS/App Runner bez zmiany kodu.

**Q: Ile klastrów EKS na region?** A: Jeden klaster EKS per region, rozłożony na wiele AZ.



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
