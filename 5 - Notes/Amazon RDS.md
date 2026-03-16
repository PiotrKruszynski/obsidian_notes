Created: 2026-02-06  14:37
___
Note:

>[!info]
>- RDBMS_ystem_ (=SQL _język_  /OLTP online transaction processing - _typ obciążenia_) 
>- greate for _joints_ and _transactions_
>- managed: _MySQL_, _PostgreSQL_, _MariaDB_, _Oracle_, _Microsoft SQL Server_, _IBM DB2_, _Aurora_ (AWS-native), Custom
>- provisioned RDS Instance Size (vCPU i RAM) and [[EBS Volume]] Type & Size
>- support for _read replicas_ and _Multi AZ_
>- _Auto-Scaling_ capability (vertical and ~horizontal (_read replicas_)
>	- set max storage threshold (np. 64TB)
>	- auto modify storage (gdy zapełnienie zbliża się do 90% doda więcej)
>- security through _IAM, SecurityGroups, KMS, SSL in transit_ 
>- support for _IAM Authentication_, integration with _Secrets Manager_
>- [[RDS Custom]] for access to and customizr the underlying instance _Oracle_, _Microsoft SQL Service_
>- [[RDS Proxy]] - warstwa pośrednia App → RDS Proxy → RDS / Aurora
>	- utrzymuje connection pool
>	- reuse istniejące połączenia
>	- ogranicza liczbę nowych connections. Relacyjne mają limit połączeń
>
>**You manage:**
>	- schema, queries, indexes
>	- but cant SSH into instance 

**Use case:** store relational datasets (_RDBMS / OLTP_), perform _SQL queries_ and _transactions_.

# Security
- Deployed inside **VPC**
- Controlled by **Security Groups** _firewall (porty i IP) na poziomie sieciowym_
- IAM authentication ( _kto i jak_ )
- Encryption:
    - At rest ( _KMS_ )
    - In transit [[SSL TLS]]

# Backups & Snapshots
- Automated Backup with _Point-In-Time Restore_ feature (_up to 35 days_)
- for _long-term recovery_ manual _snapshots_ 
	- snapshot restore cheaper then stop
	- persist after db deletion

# Deployment Models
 **Single-AZ**
- One DB instancs
- Lower cost    
 - From single-AZ to Multi-AZ **zero downtime** operation, no need to stop 
 
 **Multi-AZ** (Disaster Recovery):
 - Used for **High Avalibility**, not scaling
- Synchronous replication
- Standby instance in another AZ
- Automatic failover
- Same endpoint (DNS), keep the same connection string regardless of which db is up

![[Pasted image 20260206152157.png]]
# Read Replicas
- działa _SELECT_ , nie działa INSERT, UPDATE, DELETE
- up to 15 read replicas
- use _Asynchronous_ replication
- Used for _Read_
- zapisy muszą iść na master
- Separate DB instance with its own endpoint
- Can be in same AZ / cross-AZ / cross-region ==`$$$`==
- _RR_ można awansować do samodzielnej db
- _RR_ można ustawić na Multi AZ for _Disaster Recovery_
- można utworzyć encrypted _RR_ form unencrypted db
- w AWS płaci się za przechodzenie danych z AZ, w _RR_ nie _nawet między regionami_
- - replikacja jest **binlog-based** - śledzi dziennik binarny
- jest **asynchronous**
- przy globalnym ruchu pojawia się **replication lag**
- każda replica ma **własny storage**



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
