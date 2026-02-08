Created: 2026-02-06  14:37
___
Note:

>[! Important]
>- RDS = managed DB service for DB use SQL as a query language

# Default:
- managed **relational database** service
- allows to create databases in the cloud that are managed by AWS
- AWS manages:
    - OS patching
    - backups and restore to specific timestamp
    - monitoring dashboarars
    - read replicas for improved read performance
    - multi AZ setup for DR (disaster recovery)
    - scaling capability (vertical and horizontal)
	    - **Storage Auto Scaling
		    - set max storage threshold
		    - auto modifi storage
    - storage backed by EBS

- You manage:
    - schema
    - queries
    - indexes
    - but cant SSH into instance ❌
- Supported Engines
	- MySQL
	- PostgreSQL
	- MariaDB
	- Oracle
	- Microsoft SQL Server
	- IBM DB2
	- Aurora (AWS-native)

# Deployment Models

### **Single-AZ**
- One DB instancs
- Lower cos    
- ❌ No high availability
## From single-AZ to Multi-AZ
- **zero downtime** operation, no need to stop
- just click 'modify' (snapshot->new DB restore->Sync)
### **Multi-AZ** (Disaster Recovery)
- Synchronous replication
- Standby instance in another AZ
- Automatic failover
- Same endpoint (DNS)
- Used for **High Avalibility**, not scaling

![[Pasted image 20260206152157.png]]
# Read Replicas

- ==SELECT ONLY==
```python
✅ SELECT * FROM users -- OK na replice 
❌ INSERT INTO users VALUES(...) -- ERROR 
❌ UPDATE users SET ... -- ERROR 
❌ DELETE FROM users ... -- ERROR
```
- up to 15 read replicas
- use **Asynchronous** replication
- Used for **read scaling** ==skalowanie odczytów, nie zapisów==
- zapisy muszą iść na **primary** (master)
- Separate DB instance with its own endpoint
- Can be in same AZ / cross-AZ / cross-region ==`$$$`==
- can be manual promotion to standalone DB
- **==Read Replica can be setup as Multi AZ for Disaster Recovery (DR)==

![[Pasted image 20260206151936.png]]
---

# Backups & Snapshots

- Automated backups:
    - Enabled by default
    - PITR (Point-In-Time Recovery)
    
- Manual snapshots:
    - User-managed
    - Persist after DB deletion

---

# Storage

- EBS-backed
- Types:
    - gp3 (general purpose)
    - io1 / io2 (provisioned IOPS)
- Storage autoscaling supported

---

# Security

- Deployed inside **VPC**
- Controlled by **Security Groups**
- IAM authentication (engine-specific)
- Encryption:
    - At rest (KMS)
    - In transit (SSL/TLS)

---

## **Critical Rules / Defaults**

- RDS = **not serverless** (except Aurora Serverless)
- Cannot SSH into DB instance
- Multi-AZ ≠ Read Replica

---

## **Common Exam Traps**

- ❌ Multi-AZ improves read performance
- ❌ Read Replicas provide automatic failover
- ❌ Snapshots are incremental copies of the DB engine
- ❌ You can scale RDS like EC2

---

## **Exam Question Patterns**

- _High availability_ → Multi-AZ
- _Read scaling_ → Read Replicas
- _Disaster recovery (region)_ → Cross-region Read Replica
- _Managed relational DB_ → RDS





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
