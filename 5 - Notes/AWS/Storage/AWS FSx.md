---
title: "AWS FSx"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!important]
>- FSx = **managed file systems** (nie object, nie block)
>- wybierasz **konkretny typ FS** pod workload (Windows / Lustre / NetApp / OpenZFS)
>- używany gdy potrzebujesz **file system semantics (POSIX / SMB)** + high performance
>- często pojawia się w pytaniach jako alternatywa dla: **EFS / S3 / EBS**
### Mental model
FSx = „**gotowy, zarządzany system plików** w AWS”  
→ zamiast budować własny NFS/SMB cluster na EC2  

👉 różnica:
- S3 → object storage  
- EBS → block storage  
- FSx / EFS → **file storage**

---
### Typy FSx (najważniejsze)

#### FSx for Windows File Server
- protokół: **SMB**
- integracja z **Active Directory**
- Windows workloads (home dirs, shared drives)

👉 use case:
- lift & shift Windows apps
- file shares dla użytkowników
- for Distributed File System Replication (DFSR)

---
#### FSx for Lustre 🔥 (najważniejszy na egzamin)
- **high-performance file system**
- POSIX
- setki GB/s ultra high throughput
- integracja z **S3**
	  - import/export danych
	  - cold data w S3, hot data w FSx
- 2 typy:
	  - **Scratch** → szybki, ale dane mogą zniknąć
	  - **Persistent** → trwały

👉 use case:
- HPC
- ML training
- big data
- rendering

>[!exam]
>- HPC / ML → FSx for Lustre  
>- bardzo szybki dostęp do danych z S3 → Lustre

---
#### FSx for NetApp ONTAP
- enterprise file system
- NFS + SMB + iSCSI
- snapshoty, deduplikacja

👉 use case:
- enterprise apps
- shared storage multi-protocol

---
#### FSx for OpenZFS
- NFS-based
- niskie latency
- snapshoty

👉 use case:
- Linux workloads
- database-like file systems

---
### FSx vs EFS vs S3 vs EBS

| Service | Typ | Use case |
|--------|-----|---------|
| **S3** | object | data lake, backup |
| **EBS** | block | single EC2 disk |
| **EFS** | file (NFS) | shared, scalable, general |
| **FSx** | file (specialized) | high performance / enterprise |

---
### Kiedy wybrać FSx
- potrzebujesz **file system + performance**
- potrzebujesz **Windows SMB**
- potrzebujesz **HPC / ML**
- potrzebujesz **enterprise features (snapshots, dedupe)**

---
### Trade-offs
- droższy niż S3 / EFS
- bardziej specjalizowany (trzeba dobrać typ)
- większa wydajność → większy koszt

---
### Exam traps
- FSx ≠ EFS  
  - EFS = prosty, serverless NFS  
  - FSx = specjalizowany, wydajny  

- HPC → zawsze **Lustre**, nie EFS  
- Windows share → **FSx Windows**, nie EFS  
- data lake → **S3**, nie FSx  
- ultra performance + S3 → **FSx Lustre**

---
### TL;DR
- FSx = managed file system pod konkretny use case  
- Lustre = HPC / ML / big data  
- Windows = SMB + AD  
- ONTAP / OpenZFS = enterprise Linux workloads  
- wybierasz FSx gdy EFS jest za wolny albo za prosty
