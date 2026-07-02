---
title: "NAT"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-04
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

![[Pasted image 20260320123302.png|100]]
  
>[!important]  
>- NAT = (tylko) **outbound** internet access dla **private subnet**  , odpowiedź sama wraca
>- **blokuje inbound z internetu**  
>- działa tylko dla **IPv4**  
>- dla IPv6 → **Egress-only Internet Gateway**  

[[Internet Gateway IGW]] -> inbound + outbound

---
## Mental model  
  
```
Private EC2 (no public IP)
   ↓
Route table: 0.0.0.0/0 → NAT Gateway
   ↓
NAT Gateway (ma public IP / EIP)
   ↓
Internet Gateway (IGW)
   ↓
Internet

← odpowiedź wraca tą samą ścieżką (stateful)
```
  
---  
  
## NAT Gateway vs NAT Instance  
  
| Feature        | NAT Gateway        | NAT Instance  |     |
| -------------- | ------------------ | ------------- | --- |
| managed        | ✅ AWS              | ❌ Ty          |     |
| HA             | ✅ (per AZ)         | ❌ manual      |     |
| scaling        | auto (do 100 Gbps) | zależy od EC2 |     |
| maintenance    | brak               | wymagane      |     |
| security group | ❌                  | ✅             |     |
| cost           | $$$                | $             |     |
| use case       | default            | legacy        |     |
  
---  
## NAT Gateway  
  
- managed przez AWS    
- musi być w **public subnet**    
- wymaga **Elastic IP**    
- obsługuje private subnety    
- brak Security Groups, używa [[NACLs]] subnetu   
- jest **stateful** (odpowiedź wraca automatycznie)
  
>[!exam]  
>NAT Gateway = default wybór  
  
---  
  
## NAT Instance  
- EC2 acting as NAT    
- musi mieć:  
  - Elastic IP    
  - disabled **Source/Destination Check**    
- możesz używać:  
  - Security Groups    
- brak HA bez konfiguracji    
  
>[!exam]  
>jeśli pytanie mówi:  
>- custom routing    
>- port forwarding (tunelowanie manulane)    
>- bastion    
→ NAT Instance    
  
---  
  
## Routing (klucz!)  
  
Private subnet route table:  -> wychodzi do internetu przez NAT (pośrednik)

`0.0.0.0/0 → NAT Gateway`

Public subnet route table: -> mam dostęp dzięki IGW

`0.0.0.0/0 → Internet Gateway`

---

## High Availability
- NAT Gateway działa tylko w **1 AZ**
- best practice:
    - **1 NAT Gateway per AZ**
👉 każda AZ ma swój NAT

---

## IPv6
- NAT NIE działa dla IPv6
- używamy:
_Egress-only Internet Gateway_
👉 outbound only

---

## Use cases

- private EC2 potrzebuje:
    - internet (updates, APIs)
- secure outbound traffic
- brak public IP na instancjach

---

## Exam traps

- NAT ≠ inbound access
- NAT ≠ security layer
- NAT Gateway ≠ global (per AZ!)
- IPv6 → NIE NAT → Egress-only IGW
- NAT Instance → trzeba wyłączyć Source/Dest Check

---

## TL;DR

NAT = outbound internet for private subnet  
NAT Gateway = default  
NAT Instance = legacy / special cases  
IPv6 = Egress-only IGW


# NAT Instance

![[Pasted image 20260310102203.png]]
# NAT Gateway

![[Pasted image 20260320123126.png]]
