---
title: "Amazon EFS - elastic file system"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!Definition]
>EFS = **POSIX file storage (system plików NFS)**  for Linux instanecs 
>shared storage dla wielu EC2 jednocześnie
>highly available, scalable, expensive (3x more then gp2 volume), pay per use
>regionalny filesystem (multi-AZ, ale nie multi-region)
### Mental model
EFS = **network shared drive (jak NAS)**
👉 wiele EC2 → jeden filesystem

![[Pasted image 20260206111051.png]]

### Core properties
- file storage (nie block!)
- mount przez NFS
- **multi-AZ (regional service)**
- autoscaling (rośnie automatycznie)
- fully managed
- high availability
### Access
- mount na EC2 (Linux)
- przez **mount targets (ENI)** w VPC -> dla każdej AZ
- kontrola:
  - Security Groups
  - POSIX permissions
  
>[!exam]
>każda AZ ma swój mount target
### Performance modes
- General Purpose (low latency)
- Max I/O (high throughput)
### Throughput modes
- Bursting (default) -> 
- Provisioned -> 
- Elastic (auto scale throughput)
### Storage classes
- Standard (częsty dostęp)
- Infrequent Access (tańszy, wyższa latencja)
### Use cases
- shared config
- web servers (shared content)
- CMS
- ML / analytics
### EFS vs EBS
| Feature | EFS | EBS |
|--------|-----|-----|
| typ | file | block |
| multi-instance | ✅ | ❌ |
| AZ | multi-AZ | single AZ |
| scaling | auto | manual |
### Limitations / traps
- tylko Linux (NFS)
- wyższa latencja niż EBS
- droższy niż EBS
- nie jako boot volume
### TL;DR
- EFS = shared file system  
- multi-AZ  
- NFS  
- autoscaling
