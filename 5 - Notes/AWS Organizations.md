Created: 2026-03-19  23:56
___
Note:

# AWS Organizations

>[!Definition]
>- AWS Organizations → **central account management + governance (multi-account)**
>- tworzy strukturę: **root unit → OU (organizational units) → accounts**
>- centralne **billing (consolidated billing)**
>- **SCP (Service Control Policies)** → ograniczają co accounty MOGĄ zrobić
>- automatyczne tworzenie kont + zarządzanie dostępem + można się dzielić Safe Plan
>- use case: **multi-account strategy, governance, security boundaries**
>- Shared reserved instances and Savings Plans discounts across accounts

# Mental model
`Organization → OU → accounts → SCP definiuje maksymalne uprawnienia`

- IAM daje permissions, **SCP je ogranicza (guardrails)**  
- billing centralny (jedna faktura)  
- separacja środowisk (prod/dev/security)  


**Use case**: enterprise setup, isolation, compliance









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
