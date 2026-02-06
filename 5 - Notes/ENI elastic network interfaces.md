Created: 2026-02-03  10:53
___
Note:
>[! Core concepts]
>- logical component in a VPC that represents a virtual network card
>- virtual network interface for EC2, provides network identity to an instance
>- can be attached / detached from EC2
>- 

# Attributes:
- primary private IPv4 + one or more secondary IPv4
- one elastic IP
- one public IP
- one or more security groups ! to ENI trzyma security groups
- MAC Adress

# Rules / Defaults:
- can be **create independly** and **attach on the fly** to EC2 instance for failover (detach/attach)
- **bound to specyfic availability zone AZ
- delete on termination flag
- one EC2 can have multiple ENIs

#### Core exam traps
- ENI może być podłączony tylko do **jednej** instancji naraz
- ENI musi być w tej samej AZ co instancja. **nie da się przenieść ENI do innej AZ**
- Auto Scaling Group nie przenosi ENI
- ENI nie ma build-in failover (automation = Lambda+CloudWatch)


>[!Important]
>- **private IP** -> prywatny wewnątrz VPC, przypisany do ENI
>- Internal communication = private IP
>- **secondary private IP** - dodatkowe prywatne
>- Po co? wiele applikacji / usług na jednej EC2 & failover na poziomie aplikacji
>- multiple IPs on one instance -> secondary pricate IPs
>- **public IPv4** publiczny adres dostępny z Internetu, mapowany na private IP (NAT)
>- ! zmienia się po start / stop & nie nadaje się do stałych endpointów
>- ** elastic IP** - płatny-statyczny-publiczny IPv4
>- nie zmienia się
>- można przepinać między instancjami
>- $ $ $ gdy nieużzywany















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

