---
title: "Amazon EKS"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-06
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

> [!Definition]
> 
> - **EKS = managed Kubernetes (control plane by AWS)**
> - Ty dostarczasz compute:
> 	- **EC2 nodes** albo **Fargate**
> - pełna kompatybilność z **Kubernetes (kubectl, YAML, Helm)**
> - **EKS ≠ ECS → EKS = K8s, ECS = AWS-native**

---
## 🧠 Mental model

👉 AWS zarządza **control plane** → Ty zarządzasz **compute**  (zasoby obliczeniowe, np. grupa węzłów EC2 lub Fargate)

👉 **Pod**(kontener/y) → **Node** (EC2 v Fargate) → **VPC** (izoluje klaster) **networking** (pozwala na komunikację między podami)


---

## ⚙️ Core
- **Compute:**
    - EC2 (Managed / Self-managed)
    - Fargate (serverless)
- **Networking:**
    - **VPC-native (AWS CNI)**
    - Pod = **osobny IP**
- **Storage:**
    - EBS (single AZ)
    - EFS (shared)
    - FSx (specialized)
- **Scaling:**
    - Nodes → Cluster Autoscaler / Karpenter
    - Pods → HPA

---

## 🔐 Security (KLUCZ)

- **RBAC** (Role Base Acccess Control) → **Kubernetes API** kontrola dostępu na poziomie Kubernetes -> które akcje mogą być wykonywane w klastrze
- **IAM → AWS services** jakie zasoby AWS mogą być używane i przez kogo

---

## 🔥 IRSA (IAM Role for Service Account)
pozwala podob używać ról IAM
konkretne kontenery mają precyzyjne uprawnienia

---

## ❌ Anti-pattern
👉 IAM na **node (EC2 role)**  
→ wtedy wszystkie Pody mają te same uprawnienia !

---

## TL;DR

- EKS = Kubernetes na AWS
- IRSA = must-have do security
- ECS = prostsze (default choice)

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
