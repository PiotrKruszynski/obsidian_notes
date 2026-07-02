---
title: "VPN"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!important]  
>- VPN = **encrypted tunnel over Internet**  
>- łączy on-premises z VPC ale nadal w internet
>- szybki setup (minuty)  
>- używany do: **hybrid connection / secure access**  
>- mniej stabilny niż Direct Connect  
  
---  
  
## Mental model  
   
`Data center → Internet (encrypted tunnel) → AWS VPC`

👉 Internet + encryption

---

## Typy VPN

### Site-to-Site VPN

on-prem → AWS VPC
- łączy całą sieć (nie usera)
- używa:
    - **Customer Gateway (on-prem)**
    - **Virtual Private Gateway (AWS)**

👉 najczęstszy w architekturze hybrid

---

### Client VPN

user laptop → AWS VPC
- dostęp dla użytkowników (remote access)
- działa jak firmowy VPN

---

## Jak działa (Site-to-Site)

on-prem router → IPSec tunnel → VGW → VPC
- używa **IPSec**
- 2 tunele (HA)

---

## Routing

- static routes
- albo dynamiczne:

BGP

---

## VPN vs Direct Connect

|Feature|VPN|Direct Connect|
|---|---|---|
|network|internet|private|
|encryption|✅|❌|
|latency|zmienna|stabilna|
|setup|szybki|wolny|
|cost|$|$$$|

---

## Best practice

Direct Connect + VPN

- VPN jako backup
    
- albo encryption layer
    

---

## Use cases

- szybkie połączenie on-prem → AWS
    
- secure access bez DX
    
- backup dla Direct Connect
    
- dev/test
    

---

## Exam traps

- VPN ≠ stable latency
    
- VPN ≠ high throughput guarantee
    
- VPN = Internet → może być jitter
    
- Site-to-Site ≠ Client VPN
    

---

## TL;DR

VPN = encrypted tunnel over Internet  
fast + cheap  
less stable than Direct Connect

  
---  
  
## 🧠 Dlaczego to działa  
  
VPN:  
```text  
public internet + IPSec encryption

👉 daje:

- poufność (encryption)
    
- autentyczność
    
- integrity
    

ale NIE daje:

- stabilnego routingu
    
- gwarantowanej przepustowości
    

---

## ⚖️ Trade-off

- ✔ szybki setup
    
- ✔ tani
    
- ✔ secure
    
- ❌ jitter
    
- ❌ latency spikes
    
- ❌ zależność od Internetu
    

---

## 🔥 Najważniejsze porównanie (egzamin)

VPN → security  
Direct Connect → performance
