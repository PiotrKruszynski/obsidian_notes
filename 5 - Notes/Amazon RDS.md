Created: 2026-02-06  14:37
___
Note:

>[!info]
>- RDBMS_ystem_ (=SQL _język_  /OLTP online transaction processing - _typ obciążenia_) 
>- greate for _joints_ and _transactions_
>- managed: _MySQL_, _PostgreSQL_, _MariaDB_, _Oracle_, _Microsoft SQL Server_, _IBM DB2_, _Aurora_ (AWS-native), Custom
>- provisioned RDS Instance Size (vCPU i RAM) and [[Amazon EBS Volume]] Type & Size
>- support for _read replicas_ and _Multi AZ_
>- _Auto-Scaling_ capability (vertical and ~horizontal (_read replicas_)
>	- set max storage threshold (np. 64TB)
>	- auto modify storage (gdy zapełnienie zbliża się do 90% doda więcej)
>- security through _IAM, SecurityGroups, KMS, SSL in transit_ 
>- support for _IAM Authentication_, integration with _Secrets Manager_
>- [[Amazon RDS Custom]] for access to and customize the underlying instance _Oracle_, _Microsoft SQL Service_
>- _RDS Proxy_ - warstwa pośrednia App → RDS Proxy → RDS / Aurora
>	- utrzymuje connection pool
>	- reuse istniejące połączenia
>	- ogranicza liczbę nowych connections. Relacyjne mają limit połączeń
>	- rozwiązuje problem zbyt wielu połączeń do bazy
>
>**You manage:**
>	- schema, queries, indexes
>	- but cant SSH into instance 

**Use case:** store relational datasets (_RDBMS / OLTP_), perform _SQL queries_ and _transactions_.

### Mental model
RDS = **DB server bez zarządzania infrastrukturą**

👉 AWS:
- provisioning
- patching
- backup

👉 Ty:
- schema
- queries
- indexes

### Scaling
#### Vertical
- zmiana instance size (CPU/RAM)
#### Storage auto-scaling
- ustawiasz max (np. 64 TB)
- automatyczne zwiększanie storage
#### Horizontal
- **Read Replicas (tylko read scaling)**

>[!exam]
>Multi-AZ ≠ scaling  
>Read Replicas = scaling
# Security
- inside **VPC**
- **Security Groups**
- IAM auth (opcjonalnie)
- encryption:
  - at rest (KMS)
  - in transit (SSL/TLS)

- integracje:
  - _Secrets Manager_

>[!exam]
>RDS = no SSH access

# Backups & Snapshots
### Automated backups
- Point-In-Time Restore
- do 35 dni
### Snapshots (manual)
- long-term backup
- persist after deletion
- używane do:
  - migration
  - encryption

>[!exam]
>snapshot = manual, persistent
# Deployment models

## Single-AZ
- 1 instance
- niższy koszt
- brak HA
## Multi-AZ (HA / DR)
- synchronous replication
- standby w innej AZ
- automatic failover
- **same DNS endpoint**
- **≠ zero downtime dla wszystkiego** AWS upgraduje primary i standby jednocześnie np.upgrade engine

>[!exam]
>Multi-AZ = high availability, NIE performance

---

# Read Replicas
- do 15
- **asynchronous replication**
- tylko:
  - SELECT
- osobny endpoint
- może być:
  - same AZ
  - cross-AZ
  - cross-region
- można:
  - promote do standalone DB
- ❌ "no cost for cross-AZ" cross-region kosztuje

- replication:
  - engine-based (np. binlog dla MySQL)
  - async → możliwy lag

>[!exam]
>global read scaling → Read Replicas  
>HA → Multi-AZ  

---
# RDS Proxy
- connection pooling
- reuse connections
- zmniejsza load na DB
- pattern:
  `App → Proxy → RDS`

>[!exam]
>dużo connection → RDS Proxy
# RDS Custom
[[Amazon RDS Custom]]

>[! Important]
>**Amazon RDS Custom** to wyspecjalizowana usługa bazodanowa przeznaczona dla silników:
>- **Oracle** 
>- **Microsoft SQL Server**, 
>która łączy zalety zarządzanej usługi RDS z dostępem do OS

---
# Limitations / traps
- brak SSH (poza RDS Custom)
- storage = EBS (AZ-bound)
- Multi-AZ ≠ read scaling
- Read Replica ≠ HA (brak sync)
# TL;DR
- RDS = managed SQL DB  
- Multi-AZ = HA  
- Read Replicas = scaling  
- backups = auto + snapshot  
- Proxy = connection pooling  




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
