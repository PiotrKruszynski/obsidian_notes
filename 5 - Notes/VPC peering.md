Created: 2026-03-09  20:42
___
Note:

>[!important]
>- VPC Peering = **bezpośrednie prywatne połączenie między dwoma VPC**
>- ruch idzie po **AWS backbone**, nie przez Internet
>- działa tylko **peer-to-peer** (brak transitive routing)
>- wymaga aktualizacji **route tables po obu stronach**
### Mental model
VPC Peering = **jak kabel Ethernet między dwoma VPC**

👉 instancje w różnych VPC:
- komunikują się jakby były w jednej sieci
### Jak to działa
- tworzysz:
  - **VPC Peering Connection (pcx-xxxx)**
- potem:
  - dodajesz route w obu VPC:
    - destination → CIDR drugiego VPC
    - target → peering connection

---
### Wymagania
- CIDR bloków **nie mogą się pokrywać**
- musisz mieć:
  - accept peering request
  - routing w obu kierunkach
### Transitive routing — kluczowe
Jeśli masz:
- VPC A ↔ VPC B
- VPC B ↔ VPC C
👉 to:
- A **nie może** rozmawiać z C przez B

>[!exam]
>brak transitive routing = klasyczny trap
### Cross-account / cross-region
- działa:
  - między kontami
  - między regionami
### VPC Peering vs Transit Gateway

| Feature | Peering | Transit Gateway |
|--------|--------|----------------|
| liczba VPC | mała | duża |
| transitive routing | ❌ | ✅ |
| zarządzanie | manualne | centralne |
### Kiedy używać
- mała liczba VPC
- prosta topologia
- brak potrzeby hub-and-spoke
### Kiedy NIE
- dużo VPC
- skomplikowana sieć
- potrzeba routingu przez hub
### Security
- Security Groups nadal obowiązują
- NACL nadal obowiązuje
### Exam traps
- peering ≠ VPN
- peering ≠ internet
- brak transitive routing
- trzeba dodać route w **obu** VPC

---
### TL;DR
- VPC ↔ VPC private connection
- brak transitive routing
- CIDR nie mogą się pokrywać
- dla większych architektur → Transit Gateway

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
