Created: 2026-03-07  21:24
___
Note:

>[! Important]
NAT – Network Address Translation
It is a networking technique used to allow instances in a **private subnet** to connect to the Internet or other AWS services, while preventing the public Internet from initiating connections with those instances.

# NAT Instance

Although considered outdated, NAT Instances still appear on the exam as a legacy option or for specific use cases.

- **Function:** Allows EC2 instances in private subnets to connect to the Internet.
- **Deployment:** Must be launched in a **public subnet**.
- **Critical Configuration:** You **must disable** the EC2 setting: **Source / Destination Check** for the instance to function as a NAT device.
- **Networking:** Must have an **Elastic IP** attached to it.
- **Management:**
    - Pre-configured Amazon Linux AMI is available.
    - Managed by you (you are responsible for OS patches and software updates).
- **Scalability & Availability:**
    - Not highly available or resilient "out of the box".
    - To make it resilient, you must manually create an Auto Scaling Group (ASG) across multiple Availability Zones and use a resilient user-data script.
    - Bandwidth depends entirely on the chosen EC2 instance type.
- _(Wytłumaczenie po polsku: NAT Instance to po prostu zwykła maszyna EC2, którą sam konfigurujesz. Musisz pamiętać o wyłączeniu "Source/Destination Check", inaczej nie będzie przesyłać ruchu)._

# NAT Gateway

The recommended, AWS-managed alternative to NAT Instances.

- **Managed Service:** AWS handles the maintenance, security patching, and scaling.
- **High Availability:** Highly available within a single Availability Zone.
- **Performance:** Starts at 5 Gbps and automatically scales up to **100 Gbps**.
- **Elastic IP:** Created in a specific AZ and requires an **Elastic IP**.
- **Subnet Restriction:** It **cannot be used by EC2 instances in the same subnet** where the NAT Gateway is located; it only serves instances in _other_ (private) subnets.
- **Pricing:** You pay an hourly rate for usage plus a fee per GB of data processed.
- **No Security Groups:** Unlike NAT Instances, you do not manage or require Security Groups for the NAT Gateway itself.
- _(Wytłumaczenie po polsku: NAT Gateway jest o wiele prostszy w obsłudze – nie musisz się martwić o aktualizacje ani przepustowość, ale pamiętaj, że płacisz za każdą godzinę działania i każdy GB przesyłanych danych)._

## NAT Gateway – High Availability Strategy

- NAT Gateway is resilient **only within a single Availability Zone**.
- **Fault-Tolerance:** To achieve a truly highly available architecture, you must create **multiple NAT Gateways in multiple AZs**.
- **Note:** If an AZ goes down, the resources in that AZ are lost anyway, so cross-AZ failover for NAT is not required.

## NAT Comparison for the Exam

|Feature|NAT Gateway|NAT Instance|
|---|---|---|
|**Availability**|High (within AZ)|Low (requires manual ASG)|
|**Bandwidth**|Up to 100 Gbps|Depends on EC2 type|
|**Maintenance**|Managed by AWS|Managed by you|
|**Cost**|Per hour + Data processed|Per hour + Instance size + Network|
|**Source/Dest Check**|Not required|**Must disable**|

## IPv6 Note: Egress-only Internet Gateway

- NAT is primarily for IPv4.
- For **IPv6**, AWS uses an **Egress-only Internet Gateway**.
- It functions similarly to a NAT Gateway by allowing outbound-only communication for IPv6 while preventing the Internet from initiating a connection to your instances.



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
