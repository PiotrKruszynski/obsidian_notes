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
→ używane przy delegowaniu uprawnień (dev teams)  do non administrators , example create new IAM users, self assign policies while making sure they wont make themself admin.
-> useful to restrict one specific user, instead of a whole account using Organisation & SCP
  
- **SCP (Service Control Policy)**  
→ _max permissions_ dla AWS account (Organizations)  
  
- **Resource policy**  
→ kontrola dostępu do konkretnego resource  

  
---  
# IAM Conditions

`aws:SourceIp` -> ogranicza do określonych IP
`aws:RequestedRegion` -> restrict the region the API calls are made to
`ec2:ResourceTag` -> restrict based on tags
`aws:MultiFactorAuthPresent` -> to force MFA
for S3:
`s3:ListBucket` -> na poziomie bucketu, pozwala uzyskać spis zawartości
`s3:GetObject/PutObject/DeleteObject` -> operacje na poziomie obiektu, 
									musi być arn:aws:s3:::bucket1/_*_
resource policies & aws:PrincipalOrgID
`aws:PrincipalOrgID` -> ogranicza resource policies to only acconuts that awe a member of AWS Organization


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
- EventBridge
EventBridge może mieć też IAM Role lda Kinesis, EC2 Auto Scaling, ECS tasks
---  
# Exam traps (VERY IMPORTANT)  

## Cross-account  
potrzeba zaufania między kontami
- ❌ IAM Role wystarczy → NIE !
→ ✅ **IAM role**(jedno konto) + **assume role**(drugie konto) + **resource policy** (np. S3 bucket policy) 
- ❌ resource policy zastępuje IAM → NIE (uzupełnia)  

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
