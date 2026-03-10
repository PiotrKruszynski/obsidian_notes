Created: 2026-03-09  21:24
___
Note:

# VPC Endpoints – Overview

- **Definition:** VPC Endpoints allow you to connect your VPC to supported AWS services and VPC endpoint services powered by AWS PrivateLink without using an Internet Gateway (IGW), NAT Gateway, VPN connection, or AWS Direct Connect.
- **Network Path:** Traffic between your VPC and the other service does not leave the Amazon network.
- **Key Benefits:**
    - Redundant and scale horizontally.
    - They remove the need for IGW or NATGW to access AWS Services.
    - Improved security by keeping traffic within the private network.
- _(Wytłumaczenie: VPC Endpoint to "prywatne przejście" z Twojej sieci do usług AWS. Dzięki niemu serwer w prywatnej podsieci nie potrzebuje wyjścia na świat, by pogadać np. z S3 czy DynamoDB)._

# Types of VPC Endpoints

AWS offers two types of endpoints depending on the service you want to access:

**1. Interface Endpoints** (powered by _PrivateLink_):
    - Provisions an [[ENI elastic network interfaces]] with a private IP address from your subnet as an entry point.
    - Security: You must attach a [[security group]] to the _ENI_.
    - **Compatibility:** Supports most AWS services (e.g., SNS, CloudFormation, SSM).
    - **Cost:** Costs money ($ per hour + $ per GB of data processed).

**2. Gateway Endpoints:**
    - Provisions a gateway that must be specified as a **target in a route table**.
    - **Security:** Does not use Security Groups.
    - **Compatibility:** Supports only **Amazon S3** and **Amazon DynamoDB**.
    - **Cost:** Completely **Free**.
    
 _Wytłumaczenie: 
 Interface Endpoint to wirtualna karta sieciowa w Twojej podsieci, za którą płacisz. 
 Gateway Endpoint to darmowy wpis w tablicy routingu, ale działa tylko dla S3 i DynamoDB._

# S3 Endpoints: Gateway vs. Interface

- **Gateway Endpoints (Preferred):** For the exam, Gateway Endpoints are almost always preferred for S3 because they are free.
- **Interface Endpoints (Specific Use Cases):** Preferred only if access is required from:
    - On-premises (via Site-to-Site VPN or Direct Connect).
    - A different VPC or a different AWS Region.
- _(Wskazówka egzaminacyjna: Jeśli masz wybór dla S3 wewnątrz tego samego VPC, bierz darmowy Gateway. Jeśli łączysz się z biura przez VPN – musisz użyć Interface)._

# Use Case: Lambda in VPC accessing DynamoDB

- **Option 1 (Expensive):** Lambda in a VPC needs a NAT Gateway in a public subnet and an Internet Gateway to talk to the public DynamoDB endpoint.
- **Option 2 (Better & Free):** Deploy a **VPC Gateway Endpoint** for DynamoDB and update the Route Tables. This keeps traffic private and eliminates NAT Gateway costs.

# Troubleshooting and Security

- **Connectivity Issues:** If an endpoint is not working, check:
    - **DNS Settings:** Resolution must be enabled in your VPC. _to DNS kieruje na właściwą nazwę_
    - **Route Tables:** Ensure the Gateway Endpoint is listed as a target. _bez wpis nie trafi_
    - **Endpoint Policies:** Resource policies can be used to define which users or actions are allowed through the endpoint.
- **VPC Flow Logs:** Can capture information about traffic going through endpoints to help identify rejected requests or potential attacks.


# Alternatywa:
s2s - lokalna infrastruktura z AWS, jednak ruch jest szyfrowany przez publiczny internet
direct connect - dedykowana prywatna ścieżka
VPC Endpoint - dla usług wewnętrznych AWS
Transit Gateway
 - centralizacja ruchu między VPC i sieciami
VPC Peering - prywatne między VPC

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
