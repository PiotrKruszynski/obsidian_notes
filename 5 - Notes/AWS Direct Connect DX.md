Created: 2026-02-14  15:07
___
Note:
![[Pasted image 20260321012503.png|100]]

>[!important]  
>- Direct Connect = **dedicated private connection (on-prem → AWS)**  
>- NIE używa internetu    
>- stabilna latency + przewidywalny throughput    
>- do: **hybrid architecture / data transfer / enterprise workloads**  
  
## Mental model  
`Data center → Direct Connect → AWS VPC`

👉 prywatna linia zamiast Internetu

---
## Co daje

- niższa latency (bardziej stabilna, nie zawsze najniższa)
- wyższa i przewidywalna przepustowość
- brak jitter / mniej packet loss
- niższy koszt transferu przy dużym ruchu

---

## Jak działa

- fizyczne połączenie do **AWS Direct Connect Location**
- potem:
    - Virtual Interface (VIF)
    - routing przez **BGP**

---
## Typy VIF (ważne!)
zależy z czym się łączysz. Jak S3 lub inne publicze to Public VIF
### Private VIF
on-prem → VPC (private resources)
- dostęp do private IP (EC2, RDS)

---
### Public VIF
on-prem → AWS public services
- dostęp do:
    - S3
    - DynamoDB
- nadal NIE przez internet (AWS backbone)

![[Pasted image 20260324140036.png]]

---

### Transit VIF

on-prem → wiele VPC (Transit Gateway)

---

## Direct Connect vs VPN

|Feature|Direct Connect|VPN|
|---|---|---|
|network|private|internet|
|latency|stabilna|niestabilna|
|setup|wolny (fizyczny)|szybki|
|cost|$$$|$|
|encryption|❌ (opcjonalnie VPN)|✅|

---

## Best practice (egzamin)

👉 często łączy się:
Direct Connect + VPN
- VPN jako backup
- lub encryption

---

## Use cases
- hybrid cloud
- migracje danych (TB/PB)
- stały ruch między DC a AWS
- compliance / predictable network

---

## Exam traps

- Direct Connect ≠ encryption
- Direct Connect ≠ internet
- potrzebuje czasu (weeks)
- nie zastępuje VPN (często razem)

---

## TL;DR

Direct Connect = private link to AWS  
VPN = szybki + encrypted  
Best: DX + VPN

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
