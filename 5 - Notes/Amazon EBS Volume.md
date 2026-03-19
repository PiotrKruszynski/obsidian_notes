Created: 2026-02-03  10:20
___


>[!Definition]
>EBS = **block storage (pamięć blokowa)** dla EC2  
>działa jak **network-attached disk (USB przez sieć)**

---
### Mental model
- EBS = **dysk dla EC2**
- EC2 = compute  
- EBS = storage  
👉 separation of compute & storage
### Core properties
- block storage (raw blocks)
- attach do EC2
- **bound to AZ**
- persistent (dane nie znikają po stop instance)
- **1 volume → 1 instance (default)**  
- można:
  - detach
  - attach do innej instancji w tej samej AZ
### Delete on termination
- root volume:
  - default → **deleted**
- additional volumes:
  - default → **NOT deleted**
### Snapshot

>[!Definition]
>snapshot = **backup punktowy EBS (do S3)**

- incremental backup
- używany do:
  - backup
  - restore
  - kopiowania między AZ/Region

>[!exam]
>snapshot = stored in S3 (nie w EBS)

---
### Volume types

#### SSD
- **gp2 / gp3**
  - general purpose
  - low latency
  - cost-effective
- **io1 / io2**
  - provisioned IOPS
  - high performance
  - DB, critical apps
#### HDD
- **st1 (throughput optimized)**
- **sc1 (cold HDD)**
- lowest cost
- for:
  - big data
  - logs
  - backup

>[!exam]
>HDD = ❌ cannot be boot volume  
>HDD = ❌ not for DB

---
### Multi-Attach
- tylko dla **io1 / io2**
- attach do wielu EC2
- **same AZ**
- do 16 instancji
- full read/write

>[!important]
>wymaga **cluster-aware filesystem**
### Encryption
- encryption by default możliwe
- obejmuje:
  - at rest
  - in transit (EC2 ↔ EBS)
  - snapshots
- AES-256
- KMS (key management)
### Jak zaszyfrować istniejący volume
1. snapshot
2. copy snapshot + encrypt
3. create new volume
### Backup notes
- snapshot = point-in-time
- można robić na działającym volume  
  👉 ale:
  - **lepiej detach (consistency)**

---
### Limitations / traps
- AZ-bound → nie cross-AZ attach
- trzeba zrobić snapshot żeby przenieść
- EBS ≠ shared filesystem (to nie EFS)
### TL;DR
- EBS = block storage dla EC2  
- AZ-scoped  
- snapshot → S3  
- SSD = DB  
- HDD = big data  
- Multi-attach tylko io1/io2  


![[Pasted image 20260203104908.png]]


___
Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```

Status: #pending
Tags: #aws #ebs #volume
