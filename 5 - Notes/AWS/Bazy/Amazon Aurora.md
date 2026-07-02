---
title: "Amazon Aurora"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-19
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!Definition]  
>Aurora = **AWS-native relational DB (MySQL/PostgreSQL compatible)**  
>oddziela **compute od storage**
>Aurora = **RDS++ (lepsza wydajność + storage distributed)**  
>jak potrzeba można ustawić więcej RR i przekierować endpoint na read
>
>👉 compute:  
>- instances (writer + replicas)
>
>👉 storage:
>- shared, distributed, auto-scaling
> ### Extra features
> - **Aurora Serverless** - for unpredicted / intermitten workloads, no capacity planning
> - **Aurora Global** - up to 16 Read Instance in each region, <1sec storage replication
> - **Aurora Machine Learning** with using [SageMaker & Comprehend] on Aurora
> - **Aurora Database Cloning** - new cluster from existing one, faster than restoring a snapshot

**Use case:** same as RDS, but with _less maintenance / more flexibility / more performance_
# Architecture  
### Storage layer  
- **6 replicas (3 AZ × 2)**  
- quorum-based writes  
- self-healing  
- auto scaling:  
- **10 GB → 256 TB**  
- replication:  
- **na poziomie storage (nie DB engine)**  
  
>[!exam]  
>Aurora = replication at storage layer  
  
### Compute layer (Cluster)  
- **1 Writer**  
- **0–15 Read Replicas**  
- wszystkie instancje:  
- używają **tego samego storage**  
👉 brak kopiowania danych między RR  
  
# Endpoints   
- **Writer endpoint**  
	- write (INSERT/UPDATE)  
- **Reader endpoint**  - rozkłada ruch na RR
- load balancing read queries  
- **Custom endpoint**  - możesz precyzyjniev kontrolować gdzie trafia dany ruch
- wybór konkretnych instancji  
  
>[!exam]  
>Reader endpoint = load balancing reads  
  
# Performance  
- ~5× MySQL  
- ~3× PostgreSQL  
- szybkie failover (~30s)  
👉 bo:  
- brak replikacji engine-level  
- shared storage  
# Scaling  
### Read scaling  
- do 15 replicas  
- natychmiastowe (shared storage)  
### Storage  
- automatyczne  
  
>[!exam]  
>Aurora = lepsze scaling niż RDS  
  
# High Availability  
- built-in (storage layer)  
- failover:  
- automatic  
- fast (~30s)  
👉 Multi-AZ = **default behavior**  
# Backup  
- continuous backup (S3)  
- PITR  
- **cluster-level backup**  
- zero impact na performance  
  
>[!exam]  
>Aurora backup ≠ instance-level (jak RDS)  
  
# Cost  
- ~20% droższy niż RDS  
- ale:  
- mniej ops  
- lepsza wydajność  
----
#### Aurora Serverless  
- auto scale compute  
- pay per second  
- use case:  
- unpredictable workload  
#### Aurora Global DB  
- cross-region replication  
- **< 1 sec lag (typowo)**  
- DR / global read  
  
>[!exam]  
>global low-latency reads → Aurora Global  
  
#### Aurora ML  
- integracja:  
- SageMaker  
- Comprehend  
---
# Aurora Cloning  
- szybkie kopiowanie cluster  
- copy-on-write  
- dużo szybsze niż snapshot restore  
  
# Aurora vs RDS (klucz)  

| Feature | RDS | Aurora |  
|--------|-----|--------|  
| storage | EBS | distributed |  
| replication | engine | storage |  
| scaling | ograniczone | bardzo dobre |  
| HA | Multi-AZ opcjonalne | built-in |  
| performance | standard | high |  

---
# Exam traps  
- Aurora ≠ Multi-AZ (ma HA wbudowane)  
- Aurora RR ≠ RDS RR (shared storage!)  
- backup = cluster-level  
- Global DB ≠ zwykłe RR  
  
# TL;DR  
- Aurora = RDS na sterydach  
- shared storage  
- szybkie scaling  
- HA built-in  
- najlepsze dla high-performance SQL


![[Pasted image 20260211105457.png]]



![[Pasted image 20260211111229.png]]


![[Pasted image 20260211111359.png]]


![[Pasted image 20260211111158.png]]
