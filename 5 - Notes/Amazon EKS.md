Created: 2026-02-24  09:11
___
Note:

# AWS EKS (Elastic Kubernetes Service)

>[!Definition]
>- EKS → **managed Kubernetes cluster (control plane by AWS)**
>- Ty zarządzasz **worker nodes** (EC2) lub używasz **Fargate**
>- kompatybilny z **standard Kubernetes (kubectl, Helm, YAML)**
>- use case: **Kubernetes workloads / multi-cloud / migration**
>- EKS ≠ ECS → **EKS = K8s, ECS = AWS-native**
>- control plane HA, multi-AZ by default

# Mental model
AWS zarządza control plane (API server, etcd) → Ty dostarczasz compute (nodes) → Pods uruchamiane na nodes.

- Pod = najmniejsza jednostka (kontener + sidecar)  
- Node = EC2/Fargate compute  
- Scheduler przypisuje Pod → Node  
**Use case**: Kubernetes apps, hybrid cloud, standard tooling (kubectl)

# Core features
- Node options:
  - **Managed Node Groups (EC2)** → AWS zarządza lifecycle
  - **Self-managed nodes (EC2)** → pełna kontrola
  - **Fargate** → serverless pods
- Networking:
  - VPC-native, **ENI per Pod (AWS CNI)**
- Storage (CSI):
  - **EBS (single AZ)**, **EFS (shared)**, FSx
- Scaling:
  - **Cluster Autoscaler / Karpenter**
  - HPA (Pod scaling)
- Security:
  - IAM + RBAC (IAM Roles for Service Accounts)
# How it works
`kubectl → API server (EKS control plane) → scheduler → Pod → Node`
- control plane managed by AWS  
- nodes run kubelet + containers  
- Pods komunikują się przez VPC networking  
# Comparison

| Feature | EKS | ECS |
|--------|-----|-----|
| Tech | Kubernetes | AWS-native |
| Complexity | high | low |
| Portability | multi-cloud | AWS only |
| Control | full | medium |
| Default exam choice | when K8s required | otherwise |

# Exam traps
- ❌ EKS = serverless → NIE (chyba że Fargate)
- ❌ AWS zarządza worker nodes → NIE (chyba że managed group/Fargate)
- ❌ łatwiejszy niż ECS → NIE (bardziej złożony)
- ❌ brak Kubernetes API → NIE (pełny K8s)
- ❌ EKS zawsze najlepszy → NIE (overkill bez potrzeby K8s)

# TL;DR
- EKS = **Kubernetes na AWS**
- używaj gdy **K8s / portability wymagane**
- ECS prostszy → default bez K8s



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

**Fargate + EFS** = serverless + persistent storage. Klasyczny pattern na egzaminie.

![[Pasted image 20260224091200.png]]

## Logi i monitoring

**CloudWatch Container Insights** — zbiera logi i metryki z klastra EKS:
- CPU, RAM per Pod/Node
- logi kontenerów
- metryki sieciowe
Wymaga zainstalowania agenta CloudWatch na nodach.




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
