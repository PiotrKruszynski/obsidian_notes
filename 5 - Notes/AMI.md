Created: 2026-02-03  11:57
___
Note:

>[! Important]
>- Amazon Machine Image - snapshot-based image of instance state
>- immutable template for customization of  EC2 instance
>- faster boost & consistent configuration
>- build for specific region

# AMI sources:
I can launch EC2 instance from
- public AMI
- my own AMI
- AWS Marketplace AMI

AMIs are ==build for specific region==. You must copy the AMI to the target AWS Region==
# What AMI contains
- EBS snapshot (root + optional data volumes)
- boot configuration & metadata
- permissions (private / public / shared)

#### What AMI does not contains
- running instance itself
- instance ID
- elastic IP
- instance store data (lost)
# AMI Process from EC2 instance
1. **Launch EC2 instance**
    Startujesz instancję EC2 z bazowego AMI.
2. **Customize the instance**
    Instalujesz software, konfigurujesz system i aplikację.
3. **Stop the instance (recommended)**
    Zapewnia **data integrity** (spójność systemu plików).
    > Stop ≠ delete (EBS volumes remain).
4. **Create AMI from the instance**
    AWS:
    - creates **EBS snapshots**,
    - stores **boot & volume metadata**,
    - does **not remove the original instance**.
    
5. **AMI is created (immutable template)**
    AMI = snapshots + launch configuration.
6. **Launch new EC2 instances from AMI**
    Each new instance:
    - gets **new EBS volumes**,
    - data is copied **from snapshots**,
    - is fully **independent**
### **What happens to the original instance?**
- Can be **restarted**,
- can stay **stopped** (pay only for EBS),
- or can be **terminated manually**.
    👉 AMI is **not dependent** on it.

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
