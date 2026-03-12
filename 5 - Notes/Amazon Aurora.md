Created: 2026-02-11  10:41
___
Note:

>[! Important]
>- **Managed relational database** in the Amazon RDS family
>- Compatible with **MySQL** and **PostgreSQL**
>### Architecture
>- Storage and compute are separated
> ### Storage layer
> - Distributed storage
> - 6 copies across 3 Availability Zones
> - **Self-healing**
> - **Auto-scaling storage:** **10 GB → 256 TB**
> - Replication happens at **storage level**
> ### Compute layer
> - **Aurora Cluster**
> - 1 Writer instance
> - 0–15 Aurora Read Replicas
> - Read replicas share the **same storage**
> ### Endpoints
> - **Writer endpoint** → write queries
> - **Reader endpoint** → load-balances read queries across replicas
> - **Custom endpoints** possible
> ### Availability
> - Built-in Multi-AZ storage
> - Automatic **failover (~30s)** to another instance
> ### Performance
> - Up to 5× faster than MySQL
> - Up to 3× faster than PostgreSQL
> - Read scaling via **Aurora Replicas**
> ### Cost
> - Typically **~20% more expensive than standard RDS**

**Use case:** same as RDS, but with _less maintenance / more flexibility / more performance_

![[Pasted image 20260211105457.png]]

![[Pasted image 20260312161051.png]]
#  Backup & Restore

| Cecha              | RDS            | Aurora                                                          |
| ------------------ | -------------- | --------------------------------------------------------------- |
| Backup             | instance-level | cluster-level, automatic, ze _storage_ nie wpływa na _compute_, |
| automatic failover | Multi-AZ       | tak                                                             |
| Storage            | EBS            | distributed storage                                             |
| Performance impact | minimalny      | jeszcze mniejszy                                                |
| PITR               | tak            | tak                                                             |
|                    |                |                                                                 |


![[Pasted image 20260211111005.png]]


# Aurora Serverless

- scales _compute_ automatically
- Pay per second
- Ideal for unpredictable workloads


![[Pasted image 20260211111229.png]]

---

# Aurora Global Database

- Cross-region replication
- < 1 second replication lag
- Disaster recovery solution

![[Pasted image 20260211111359.png]]

# Custom endpoint

![[Pasted image 20260211111158.png]]

Aurora Machine Learning
perform ML using _SageMaker AI_ & _Comprehend_ on Aurora

# Aurora Database Cloning
new _cluster_ from existing, faster than _snapshot_

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
