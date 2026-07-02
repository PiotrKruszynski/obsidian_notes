---
title: "Internet Gateway IGW"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-19
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!tip]
>komponent [[VPC]]  , który zapewnia dwukierunkową komunikację między zasobami w twojej chmurze a Internetem. Umożliwia instancją z **publicznymi adresami IP** odbieranie i wysyłanie ruchu. Nie przekłada ruchu wewnętrznego, nie dokonuje translacji. 
>- Allows resources in a VPC (like EC2) to connect to the Internet.
>- It is _highly available_, _redundant_, and scales horizontally.
>- **Constraint:** One VPC can be attached to only one IGW, and vice versa.
>- **Note:** Creating an IGW is not enough; you must also edit _Route Tables_ to allow Internet access.
>- działa w warstwie sieciowej
>- subnet staje się publiczny tylko wtedy, gdy:
>	- w Route Table jest wpis 0.0.0.0/0 -> Internet Gateway
>	- instancja ma Public IP / Elastic IP
>- IGW nie wykonuje NAT
>- jest _stateless_

![[Pasted image 20260307211525.png]]


# Egress-only Internet Gateway

used for IPv6 only
similar to NAT Gateway but for IPv6
you must update Route Tables

## zestawienie możliwości
![[Pasted image 20260310102739.png]]

  
>[!important]  
>- IGW = **komponent VPC umożliwiający dostęp do Internetu**  
>- działa jako **target w route table**  
>- zapewnia:  
>  - inbound + outbound Internet  
>- wymagany dla **public subnets**  
  
---  
  
### Mental model  
IGW = **brama między VPC a Internetem**  
  
👉 bez IGW:  
- brak dostępu do Internetu    
👉 z IGW:  
- VPC może wysyłać i odbierać ruch publiczny    
  
---  
  
### Jak to działa  
  
1. tworzysz IGW    
2. attach do VPC    
3. w route table:  

`0.0.0.0/0 → igw-xxxx`

---

### Warunki dostępu do Internetu

EC2 ma Internet **tylko jeśli spełnia WSZYSTKIE:**
- subnet ma route → IGW
- instancja ma:
    - public IP / Elastic IP
- Security Group pozwala na ruch

> [!exam]  
> public subnet = route do IGW

---
### Public vs Private subnet

|Typ|Route|Internet|
|---|---|---|
|public|IGW|✅|
|private|brak IGW|❌|

---
### IGW vs NAT Gateway

|Feature|IGW|NAT Gateway|
|---|---|---|
|inbound|✅|❌|
|outbound|✅|✅|
|public IP wymagane|✅|❌ (dla instancji)|

👉 NAT:
- dla private subnet
- tylko outbound

---

### High availability
- IGW jest:
    - managed
    - highly available
    - scalable

---

### Security

- IGW nie filtruje ruchu
- kontrola przez:
    - Security Groups
    - NACL

---

### Exam traps

- IGW ≠ NAT
- private subnet → nie ma IGW route
- public IP bez IGW → brak Internetu

---

### TL;DR

- IGW = dostęp do Internetu dla VPC
- route `0.0.0.0/0 → IGW`
- public subnet → IGW
- inbound + outbound
