Created: 2026-02-04  11:47
___
Note:

![[Pasted image 20260206121052.png]]

>[!IMPORTANT]
>- Security Group = **instance-level firewall (L4)**
>- kontroluje **inbound + outbound traffic**
>- **stateful** → response traffic automatycznie dozwolony
>- działa na poziomie **ENI (Elastic Network Interface)**
>- only **ALLOW rules** (no deny)

---

# Mental model
```
EC2 (ENI)
   ↓
Security Group (stateful firewall)
   ↓
Allow / Drop

👉 jeśli ruch zablokowany → EC2 **nigdy go nie widzi**
```

# Kluczowe cechy
- only **ALLOW rules** (no deny)
- default:
  - inbound → ❌ blocked
  - outbound → ✅ allowed
- **stateful**
  → jeśli inbound allowed → response outbound automatycznie allowed
- może być przypięta do wielu instancji
- instancja może mieć wiele SG
- działa w ramach **VPC (region + VPC scope)**
- zmiany działają **natychmiast (no restart)**

---

# Co kontrolują
- ports (np. 22, 80, 443)
- protocols (TCP / UDP / ICMP)
- IP ranges (IPv4 / IPv6)
- source (dla ruchu przychodzącego) podając konkretny _IP_, _CIDR_, inna _SG_
- destination(dla ruchu wychodzącego) podając konkretny _IP_, _CIDR_, inna _SG_

---
# Gdzie używane są Security Groups  
- EC2 (primary use case)  
- RDS / Aurora  
- Lambda (jeśli w VPC)  
- ECS / Fargate  
- EKS (worker nodes, pods przez CNI)  
- Elastic Load Balancer (ALB / NLB*)  
- ElastiCache  
- OpenSearch  
  
👉 wszystko co ma ENI może mieć Security Group

---

# Advanced (bardzo ważne)
- można używać **Security Group jako source**
  → np. app → db (SG-to-SG communication)

---
# Typowe use case
- SSH access → osobny SG
- web server:
  - inbound: 80/443 from 0.0.0.0/0
- database:
  - inbound: tylko z SG aplikacji

---
# Exam traps (VERY IMPORTANT)

- ❌ Security Group = stateless → NIE (jest stateful) , a porty efemeryczne
- ❌ trzeba dodać outbound rule dla response → NIE
- ❌ można zrobić DENY → NIE
- ❌ działa na subnet → NIE (to NACL)
- ❌ blokada = ICMP error → NIE (timeout)

---

# SG vs NACL (klucz!)

| Feature        | Security Group | NACL          |
|---------------|---------------|---------------|
| Level         | instance (ENI)| subnet        |
| Rules         | allow only    | allow + deny  |
| State         | stateful      | stateless     |
| Evaluation    | all rules     | ordered rules |

---

# TL;DR

Security Group = **stateful firewall dla EC2 (ENI)**  
- allow only  
- inbound blocked, outbound allowed  
- response traffic auto-allowed  
- działa na poziomie instancji (nie subnetu)






![[Pasted image 20260204115120.png]]



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
