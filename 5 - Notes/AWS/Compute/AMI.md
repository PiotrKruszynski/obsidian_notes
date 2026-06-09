---
title: "AMI"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!Definition]
>AMI = **template (image)** używany do uruchamiania EC2  
>zawiera:
>- OS
>- aplikacje
>- konfigurację
>- referencję do EBS snapshot

### Mental model
AMI = **"golden image" serwera**

👉 launch EC2 = create instance from AMI
### Co zawiera AMI
- root volume (snapshot EBS)
- OS (Linux / Windows)
- software (np. nginx, app)
- konfiguracje
### Properties
- **immutable** (nie edytujesz → tworzysz nowy)
- **region-scoped**
- można kopiować między regionami
- można udostępniać:
  - private
  - public
  - specific accounts
### Typy AMI
- AWS-provided
- marketplace (płatne)
- custom (twój image)
### Jak powstaje AMI
1. konfigurujesz EC2  
2. tworzysz AMI  
3. AWS robi snapshot EBS  
4. powstaje reusable image  

### Use cases
- autoscaling (identyczne instancje)
- szybki deploy
- DR / backup environment
- pre-configured environments
### AMI vs Snapshot

| Feature | AMI | Snapshot |
|--------|-----|---------|
| cel | uruchamianie EC2 | backup |
| zawiera OS | ✅ | ❌ |
| bootowalny | ✅ | ❌ |

---
### Exam traps
- AMI = region-specific  
- snapshot → S3 (pośrednio AMI też)  
- AMI nie jest modyfikowalne  
- launch template ≠ AMI  
### TL;DR
- AMI = template EC2  
- built from snapshot EBS  
- immutable  
- region-based
