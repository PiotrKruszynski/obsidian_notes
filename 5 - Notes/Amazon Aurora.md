Created: 2026-02-11  10:41
___
Note:

>[! Important]
>Amazon Aurora is a fully managed relational database engine compatible with MySQL and PostgreSQL.  

It is designed for high performance, high availability, and automatic scaling in AWS environments.

![[Pasted image 20260211105457.png]]

## Core Concepts

- Managed under **Amazon RDS**
- Compatible with:
  - Aurora MySQL
  - Aurora PostgreSQL
- Cloud-native architecture (not traditional RDS engine)
- Storage auto-scales from **10 GB up to 256 TB**
- 6-way replication across **3 Availability Zones**
- Read replicas (up to 15)

## Features

- automatic fail-over
- backup and recovery
- isolation and security
- industry compliance
- push button scaling
- automated patching with zero downtime
- advanced monitoring
- routine maintenance
- backtrack: restore data at any point of time without using backups

---

## Architecture

- 1 **Primary (Writer)** instance
- Multiple **Read Replicas**
- Single shared storage volume
- Storage layer:
  - ==6 copies across 3 AZ
  - 2 copies per AZ
  - Self-healing
  - Continuous backups to S3

---

## High Availability

- Automatic failover (<30 seconds typically)!
- No data loss (quorum-based writes)
- Aurora Replicas support automatic failover
- Multi-AZ built-in by design

---

## Storage & Replication

- Storage automatically grows in 10 GB increments
- Replication happens at storage layer (not engine level)
- Only redo logs are sent to storage
- Faster crash recovery

![[Pasted image 20260211111005.png]]

---

![[Pasted image 20260211105235.png]]
## Aurora vs Standard RDS

| Feature         | Aurora        | RDS MySQL/Postgres |
| --------------- | ------------- | ------------------ |
| Storage scaling | Automatic     | Manual             |
| Replication     | Storage-level | Engine-level       |
| Read replicas   | Up to 15      | Up to 5            |
| Performance     | Higher        | Standard           |
| Failover        | Faster        | Slower             |
| Cost            | $$  +20%      |                    |
|                 |               |                    |

---

## Aurora Serverless

- On-demand auto scaling
- Scales compute capacity automatically
- Pay per second
- Ideal for unpredictable workloads


![[Pasted image 20260211111229.png]]

---

## Aurora Global Database

- Cross-region replication
- < 1 second replication lag
- Disaster recovery solution

![[Pasted image 20260211111359.png]]
---

## Critical Rules / Defaults

- Backups enabled by default
- Encryption supported (KMS)
- Cannot SSH into DB instance
- Uses DB Subnet Group
- Requires at least 2 AZs

---

## Common Exam Traps

- Aurora ≠ just RDS MySQL (different architecture)
- Storage is NOT attached EBS
- Multi-AZ is inherent, not optional like RDS
- Replication is storage-based, not SQL replication
- Failover faster than RDS Multi-AZ

---

## Exam Question Patterns

- “Need fastest MySQL in AWS” → Aurora
- “Need automatic storage scaling” → Aurora
- “Need cross-region low-latency replication” → Aurora Global DB
- “Unpredictable workload” → Aurora Serverless
- “Need up to 15 read replicas” → Aurora


## Custom endpoint

![[Pasted image 20260211111158.png]]



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
