Created: 2026-02-03  19:22
___
Note:

# AWS IAM (Identity and Access Management)

>[!Definition]
>- IAM → **authentication (who?) + authorization (what?)**
>- zarządza dostępem do AWS resources (users, roles, policies)
>- **policies = JSON (allow/deny actions on resources)**
>- **roles → temporary credentials (STS)**, brak long-term keys
>- **least privilege** = kluczowa zasada
>- global service (nie per region)
>Use case: **secure access control, cross-service & cross-account access**

# Mental model
```
Identity
   ↓
Requests Action on Resource
   ↓
AWS checks:
   - policy (identity & resource)
   - permission boundary
   - session policy
   - SCP / org controls
   - explicit deny
   ↓
Final decision: Allow / Deny
```
   
- default: **implicit deny**  
- explicit deny > allow  
- dostęp = **ALLOW (identity policy) + ALLOW (resource policy) + brak DENY**
## Identity  
- **User** → long-term credentials (avoid in prod)  
- **Role** → temporary credentials (preferred)  
- federated principal
## Policy  
- **Identity-based** → attached to user/role  
- **Resource-based** → attached to resource (S3, SQS, SNS, Lambda)  
## Boundaries / guards that limit permissions  
- permission boundary  
- ServiceControlPolicy (AWS Organizations)  
- session policy  
- explicit deny
## STS  Security Token Service
- generuje temporary credentials via **AssumeRole**  
  
## Security  
- MFA  
- Federation (SSO / external IdP)  
  
---  
# Advanced (Guardrails)  
  
- **Permissions Boundary**  
→ max permissions dla IAM principal  
→ używane przy delegowaniu uprawnień (dev teams)  
  
- **SCP (Service Control Policy)**  
→ _max permissions_ dla AWS account (Organizations)  
  
- **Resource policy**  
→ kontrola dostępu do konkretnego resource  
  
---  
# Mental model (IMPORTANT)  
  
- **IAM policy** → co możesz zrobić  
- **Permissions Boundary** → ile maksymalnie możesz dostać  
- **SCP** → ile konto może zrobić  
  
---  
# How IAM evaluates request  
  
1. explicit deny?  
2. explicit allow?  
3. else → deny  
  
→ wszystkie policies są evaluowane razem  
  
---  
# Comparison  
  
| Feature | IAM Role | IAM User |  
|------------|--------------|------------------|  
| Credentials | temporary | long-term |  
| Security | higher | lower |  
| Use case | apps/services | humans (limited) |  
  
---   
# Typowe use case  

## IAM Role  
- EC2 → S3  
- Lambda → DynamoDB  
- ECS → SQS  
## Resource policy  
- S3 bucket sharing (cross-account)  
- SNS → SQS  
- Lambda invoke (cross-account)  
  
---  
# Exam traps (VERY IMPORTANT)  

## Cross-account  
- ❌ IAM Role wystarczy → NIE  
→ ✅ **IAM role + resource policy (np. S3 bucket policy)**  
  
- ❌ resource policy zastępuje IAM → NIE (uzupełnia)  
- ❌ zawsze trzeba assume role → NIE  
## General  
- ❌ IAM = regional → NIE (global)  
- ❌ allow > deny → NIE (deny wins)  
- ❌ roles mają static credentials → NIE  
- ❌ root user do pracy → NIE  
- ❌ brak MFA → NIE  
- ❌ IAM kontroluje network → NIE (SG/NACL)  
  
---  
  
# TL;DR  
  
- IAM = **who can do what on which resource**  
- access = **ALLOW + ALLOW (no DENY)**  
- role > user  
- deny > allow  
- zawsze **least privilege**







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
