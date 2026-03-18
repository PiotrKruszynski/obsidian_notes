Created: 2026-03-18  21:50
___
Note:
 
>[!important]
>- Storage Gateway = **hybrid storage (on-prem ↔ AWS)**
>- daje lokalny dostęp + backend w AWS
>- 3 typy: **File / Volume / Tape**
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
- backend: **S3**

👉 use case:
- lift & shift file apps
- backup do S3
- data lake ingestion

>[!exam]
>File → S3
#### Volume Gateway
- protokół: **iSCSI (block)**
- backend: **EBS snapshots**

2 tryby:
**Stored volumes**
- dane lokalnie + backup do AWS  
👉 low latency
**Cached volumes**
- dane w AWS + cache lokalny  
👉 oszczędność storage on-prem

>[!exam]
>block storage → Volume Gateway
#### Tape Gateway
- symuluje **taśmę (VTL)**
- backend: **S3 Glacier**

👉 use case:
- backup systems (legacy)
- replace physical tapes

>[!exam]
>backup na taśmy → Tape Gateway

---
### Kiedy używać
- masz **on-prem + chcesz AWS**
- backup do chmury
- migracja danych
- hybrid architecture

---
### Trade-offs
- latency (bo network)
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
- hybrid storage → Storage Gateway  
- file → S3  
- block → EBS snapshots  
- tape → Glacier  

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
