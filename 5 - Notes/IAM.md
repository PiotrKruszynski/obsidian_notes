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
>- use case: **secure access control, cross-service permissions**

# Mental model
Principal (user/role) → policy → action → resource → allow/deny

- IAM = control plane security  
- default: **implicit deny**  
- explicit deny > allow  

**Use case**: app access (S3/DynamoDB), cross-account access, service permissions
# Core features
- identities:
  - **User** (long-term, avoid in prod)
  - **Role** (preferred, temporary creds)
- policies:
  - identity-based + resource-based
- STS:
  - temporary credentials (assume role)
- MFA:
  - dodatkowa warstwa security
- federation:
  - SSO / external IdP (Google, AD)
# How it works
Request → IAM evaluates:
1. explicit deny?
2. explicit allow?
3. else → deny

- policies evaluated together  
- least privilege enforced  
- credentials signed (SigV4)
# Comparison

| Feature     | IAM Role      | IAM User         |
| ----------- | ------------- | ---------------- |
| Credentials | temporary     | long-term        |
| Security    | higher        | lower            |
| Use case    | apps/services | humans (limited) |


## Typowe use case

**IAM Role**
- EC2 → S3 access
- Lambda → DynamoDB
- ECS → SQS

**Resource policy**
- S3 bucket sharing
- SNS → SQS subscription
- Lambda invoke z innego accounta
## Exam traps (bardzo ważne)

- ❌ IAM Role wystarczy do cross-account → NIE (potrzebny trust / resource policy)
- ❌ resource policy zastępuje IAM → NIE (uzupełnia)
- ❌ zawsze trzeba assume role → NIE (resource policy może wystarczyć)
- ❌ działa tylko dla S3 → NIE (SQS, SNS, Lambda też)

---

## TL;DR

- IAM Role → **co możesz zrobić**
- Resource policy → **czy resource Ci pozwala**
- access = **ALLOW + ALLOW (i brak DENY)**

# Exam traps
- ❌ IAM = regional → NIE (global)
- ❌ allow > deny → NIE (deny wins)
- ❌ roles mają static credentials → NIE (temporary)
- ❌ root user do codziennej pracy → NIE
- ❌ brak MFA → NIE (should be enabled)
- ❌ IAM kontroluje network access → NIE (to SG/NACL)

# TL;DR
- IAM = **who can do what on which resource**
- role > user (security)
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
