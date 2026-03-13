Created: 2026-03-13  15:26
___
Note:

>[!tip]
>**DDoS (Distributed Denial of Service)** to atak polegający na **zalaniu systemu ogromną ilością ruchu**, aby przestał działać dla normalnych użytkowników.
## Scope

AWS managed protection against **DDoS attacks**. Protects applications running on AWS from network and transport layer attacks.

---

## Core Concepts

- Protects against **DDoS (Distributed Denial of Service)** attacks
- Works automatically with AWS edge services
- Focuses mainly on **Layer 3 / Layer 4 attacks**
- Two tiers:
    - **Shield Standard**
    - **Shield Advanced**

---

## Critical Rules / Defaults

- **Shield Standard is enabled automatically for all AWS customers**
- No configuration required
- Protects services like:
    - CloudFront
    - Route 53
    - Global Accelerator
    - ELB

Shield Standard protects against:
- SYN floods
- UDP floods
- reflection attacks

---

## Shield Advanced

Extra paid protection with additional capabilities:
- Advanced DDoS detection
- Real‑time metrics and visibility
- Integration with **AWS WAF**
- Access to **AWS DDoS Response Team (DRT)**
- Cost protection for scaling during attacks

Used for protecting critical workloads.

---

## Common Exam Traps

- Thinking **Shield replaces WAF** → it does not
- Shield protects **network layer attacks**, WAF protects **application layer attacks (Layer 7)**

---

## Exam Question Patterns

- "Protect AWS infrastructure from DDoS" → **AWS Shield**
- "Application layer protection / block malicious HTTP requests" → **AWS WAF**
- "Global edge protection" → **Shield + CloudFront**

If your organization has multiple AWS accounts, then you can subscribe multiple AWS Accounts to AWS Shield Advanced by individually enabling it on each account using the AWS Management Console or API. You will pay the monthly fee once as long as the AWS accounts are all under a single _consolidated billing_, and you own all the AWS accounts and resources in those accounts.


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
