---
title: "AWS Storage Gateway"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-03-18  21:50
___
Note:
 
>[!important]
>- Storage Gateway = **hybrid _ONLY_ storage (on-prem ↔ AWS)**
>- lokalny dostęp + wszystko finalnie ląduje w **S3** (pośrednio lub bezpośrednio)
>- 3 typy integracji on-prem / AWS: **File / Volume / Tape**
>- używany do: backup, migration, hybrid apps

---
### Mental model
Storage Gateway = **proxy/cache między on-prem a AWS**

👉 lokalnie:
- aplikacja widzi normalny storage (NFS / iSCSI)
👉 w tle:
- dane lecą do AWS (S3 / EBS / Glacier)

---
### Typy Gateway

#### S3 File Gateway
- protokół: **NFS / SMB**
- backend: pliki są przechowywane jako obiekty w **S3** (1:1 mapping)

👉 use case:
	- lift & shift file apps
	- backup do S3
	- data lake ingestion
#### Volume Gateway
- protokół: **iSCSI (block)**
- backend: dane do **S3**, restore **EBS snapshots**

2 tryby:
**Stored volumes**
- dane lokalnie + backup do AWS  
👉 low latency
**Cached volumes**
- dane w AWS + cache lokalny  
👉 oszczędność storage on-prem
#### Tape Gateway
- symuluje **taśmę (Virtual Tape Library)**
- backend: **S3 Glacier**

👉 use case:
- backup systems (legacy)
- replace physical tapes

---
### Kiedy używać
- masz **on-prem + chcesz AWS**
- backup do chmury
- migracja danych
- hybrid architecture
- disaster recovery (on-prem backup → AWS)

---
### Trade-offs
- latency (bo network lub Direct Connect)
- wymaga gateway appliance (VM)
- bardziej złożone niż pure S3/EFS

---
### Exam traps
- File Gateway → zawsze **S3**, nie EFS  
- Tape Gateway → zawsze **Glacier**  
- Volume Gateway → block (iSCSI), nie file  

- on-prem + AWS → Storage Gateway  
- cloud-native → NIE używaj Storage Gateway  

---
### TL;DR
- hybrid (on-prem + AWS) → Storage Gateway  
- file (NFS/SMB) → S3  
- block (iSCSI) → S3 + EBS snapshots  
- tape (VTL) → Glacier  



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
