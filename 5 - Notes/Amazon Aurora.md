Created: 2026-02-11  10:41
___
Note:

>[! Important]
>- relational database engine managed under [[Amazon RDS]]
>- compatible API for _MySQL_ and _PostgreSQL_
>- _storage_ and _compute_ are seperated!!
>- Storage: data is stored in _6 replicas_, across _3 AZ_ and _highly available_, _self-healing_, _auto-scaling_ from **10 GB up to 256 TB**
>- Compute: Cluster of DB Instance across multiple AZ, _auto-scaling_ of _RR_
>- _Cluster_ (klaser) custom endpoint for writer and reader DB instances
>- same security / monitoring / maintenance features as [[Amazon RDS]]
>- _Multi-AZ_ build-in
>-  +20% więcej kosztuje od RDS

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
