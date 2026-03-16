Created: 2026-02-11  10:41
___
Note:

>[! Important]
>- RDBMS with separation of storage and compute (architektura rozproszona)
>- Compatible API for **MySQL** and **PostgreSQL**
>- storage: data is storage in 6 replicas, across 3 AZ - [[high availability]], _self-healing_, [[auto scaling]] **10 GB → 256 TB**, automatic **failover (~30s)**
> - replication happens at **storage level**
> ### Compute layer
> - **Aurora Cluster**
> - 1 Writer instance
> - 0–15 Aurora Read Replicas
> - Read replicas share the **same storage**
> ### Endpoints
> - **Writer endpoint** → write queries
> - **Reader endpoint** → load-balances read queries across replicas
> - **Custom endpoints** possible
> ### Performance
> - Up to 5× faster than MySQL
> - Up to 3× faster than PostgreSQL
> - Read scaling via **Aurora Replicas**
> ### Cost
> - Typically **~20% more expensive than standard RDS**
> ### Extra features
> - **Aurora Serverless** - for unpredicted / intermitten workloads, no capacity planning
> - **Aurora Global** - up to 16 DM Read Instance in each region, <1sec storage replication
> - **Aurora Machine Learning** with using [SageMaker & Comprehend] on Aurora
> - **Aurora Database Cloning** - new cluster from existing one, faster than restoring a snapshot

**Use case:** same as RDS, but with _less maintenance / more flexibility / more performance_




![[Pasted image 20260211105457.png]]

#  Backup & Restore

| Cecha              | RDS            | Aurora                                                          |
| ------------------ | -------------- | --------------------------------------------------------------- |
| Backup             | instance-level | cluster-level, automatic, ze _storage_ nie wpływa na _compute_, |
| automatic failover | Multi-AZ       | tak                                                             |
| Storage            | EBS            | distributed storage                                             |
| Performance impact | minimalny      | jeszcze mniejszy                                                |
| PITR               | tak            | tak                                                             |

# Aurora Serverless
- for unpredicted / intermiteen workloads, no capacity planning
- scales _compute_ automatically
- Pay per second

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
