Created: 2026-03-09  18:46
___
Note:

# Network Access Control List (NACL) 

- NACLs act as a firewall that controls traffic to and from your **subnets**.
- **Association:** There is exactly one NACL per subnet. New subnets created in a VPC are automatically assigned the **Default NACL**.
- **Scope:** They provide an additional layer of security at the network level, supplementing Security Groups which operate at the instance level.

_(Wytłumaczenie: NACL to pierwsza linia obrony na poziomie całej podsieci. Zanim ruch dotrze do konkretnej instancji EC2 i jej Security Group, musi najpierw przejść przez bramkę NACL)._

![[Pasted image 20260309185038.png]]
# NACL Rules Logic

- **Rule Numbering:** Rules are numbered from 1 to 32766.
- **Precedence:** Rules are evaluated in order starting from the lowest number. A lower number has **higher precedence**.
- **Decision Making:** The decision to allow or deny traffic is made as soon as the **first rule matches** the traffic.
- **The Final Rule:** Every NACL ends with an asterisk (`*`) rule which **denies all traffic** if no previous rules matched.
- **Best Practice:** AWS recommends adding rules in increments of 100 (e.g., 100, 200, 300) to allow space for future rules.

# Default vs. Custom NACLs

- **Default NACL:**
    - Automatically created with your VPC.
    - **Accepts all inbound and outbound traffic** by default.
    - AWS recommends not modifying the Default NACL; instead, create custom ones for specific needs.
- **Custom NACL:**
    - **Denies everything** inbound and outbound by default until you manually add allow rules.
    - Great for **blocking specific IP addresses** at the subnet level, which Security Groups cannot do (SGs only support "allow" rules).
![[Pasted image 20260309191710.png]]
# Statelessness and Ephemeral Ports

- **Stateless Nature:** NACLs are **stateless**, meaning return traffic is **not** automatically allowed. You must explicitly define rules for both inbound and outbound traffic.
- **Ephemeral Ports:** Because NACLs are stateless, you must open "ephemeral ports" to allow response traffic to return to the client.
    - **IANA/Windows 10 range:** 49152 – 65535.
    - **Linux range:** 32768 – 60999.
- _(Wytłumaczenie: Jeśli serwer WWW odpowiada klientowi, musisz mieć regułę outbound otwierającą porty efemeryczne, bo NACL "nie pamięta", że to tylko odpowiedź na legalne zapytanie)._

# Security Groups vs. NACLs

|Feature|Security Group|NACL|
|:--|:--|:--|
|**Level**|Instance level (ENI)|Subnet level|
|**State**|**Stateful**: Return traffic is auto-allowed|**Stateless**: Return traffic must be explicitly allowed|
|**Rules**|Supports **Allow rules only**|Supports **Allow and Deny rules**|
|**Evaluation**|All rules evaluated before deciding|Rules evaluated in order (first match wins)|
|**Application**|Applies only if specified|Applies to all instances in the subnet|

- Source:

# Troubleshooting with VPC Flow Logs

- You can use **VPC Flow Logs** to identify if traffic is being blocked by a NACL or a Security Group by looking at the "ACTION" field.
- **Inbound REJECT:** Could be either the NACL or the Security Group.
- **Inbound ACCEPT but Outbound REJECT:** This is almost certainly a **NACL** issue, as Security Groups would have automatically allowed the return traffic (stateful), but the NACL blocked it (stateless).
- **Analysis:** Flow logs can be sent to S3 and analyzed using **Amazon Athena** or viewed in **CloudWatch Logs Insights**.


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
