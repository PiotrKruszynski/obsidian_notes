Created: 2026-03-19  23:56
___
Note:

# AWS Organizations

> [!important]
> 
> - **Global service** do zarządzania multi-account
>     
> - Hierarchia: **Root → OU → Accounts**
>     
> - **Management account** kontroluje wszystko, member accounts są zależne
>     
> - **SCP = guardrails** (co account _może_, nie co _ma_)
>     
> - **Consolidated billing + volume discounts**
>     
> - **Shared RI & Savings Plans** między kontami
>     

### Mental model

AWS Organizations to **control plane dla multi-account AWS** → zamiast jednego konta robisz **isolation + governance przez wiele kont**, a Organizations spina to w jedną strukturę.  
To działa jak **organizacyjny “policy + billing + account factory layer”** nad wszystkimi kontami.

### Core facts

- **Global service** (nie regionalny)
    
- Struktura:
    
    - `Root`
        
    - `OU (Organizational Units)` → logiczne grupowanie (np. prod / dev / security)
        
    - `Accounts`
        
- Typy kont:
    
    - **Management account (root account organizacji)**
        
    - **Member accounts**
        
- Ograniczenia:
    
    - Account może należeć tylko do **jednej organizacji**
        
- **SCP (Service Control Policies)**:
    
    - działają na poziomie **OU / account**
        
    - definiują **maksymalne uprawnienia (deny/allow boundary)**
        
- **Billing**:
    
    - **Consolidated Billing → jedna metoda płatności**
        
    - **Aggregated usage → volume discounts (EC2, S3, etc.)**
        
    - **Shared Reserved Instances & Savings Plans**
        
- **Automation**:
    
    - API dostępne → automatyczne **account provisioning (account factory)**
        

### Kiedy używać

- **Multi-account strategy (recommended)**:
    
    - isolation: prod / dev / test / security / logging
        
- **Security boundaries**:
    
    - oddzielne konta = blast radius reduction
        
- **Central governance**:
    
    - enforce policies (SCP)
        
- **Cost optimization**:
    
    - shared RI / Savings Plans
        
- **Enterprise / compliance**:
    
    - różne teamy, BU, workloady
        

### Trade-offs

- **+ izolacja** (security, fault isolation)
    
- **+ governance na poziomie org**
    
- **+ cost optimization przez agregację**
    
- **- większa złożoność operacyjna** (IAM, networking, CI/CD cross-account)
    
- **- SCP może “zabić” dostęp** (debug trudniejszy niż IAM policy)
    
- **- management account = single point of control (high risk)**
    

### Powiązane feature / usługi / elementy

- **SCP vs IAM policy**
    
    - SCP = **guardrail (max permissions)**
        
    - IAM = **actual permissions**
        
- **AWS Control Tower**
    
    - opinionated setup dla Organizations (landing zone)
        
- **AWS IAM Identity Center (SSO)**
    
    - central access management dla wielu kont
        
- **AWS Billing / Cost Explorer**
    
    - korzysta z consolidated billing
        
- **Service Quotas / tagging strategy**
    
    - governance + cost allocation
        

### Exam traps / edge cases

> [!warning]
> 
> - SCP **nie daje uprawnień** → tylko ogranicza
>     
> - Deny w SCP = **hard deny** (nie obejdziesz IAM)
>     
> - Management account **nie jest ograniczany przez SCP (domyślnie)** → krytyczne bezpieczeństwo
>     
> - Volume discount działa tylko przy **consolidated billing**
>     
> - Account **nie może być w wielu Organizations**
>









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
