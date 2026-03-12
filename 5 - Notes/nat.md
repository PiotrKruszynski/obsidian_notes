Created: 2026-03-07  21:24
___
Note:

>[! Important]
NAT – Network Address Translation
It is a networking technique used to allow instances in a **private subnet** to connect to the Internet or other AWS services, while preventing the public Internet from initiating connections with those instances.


|ttribute|NAT gateway|NAT instance|
|---|---|---|
|Availability|Highly available. NAT gateways in each Availability Zone are implemented with redundancy. Create a NAT gateway in each Availability Zone to ensure zone-independent architecture.|Use a script to manage failover between instances.|
|Bandwidth|Scale up to 100 Gbps.|Depends on the bandwidth of the instance type.|
|Maintenance|Managed by AWS. You do not need to perform any maintenance.|Managed by you, for example, by installing software updates or operating system patches on the instance.|
|Performance|Software is optimized for handling NAT traffic.|A generic AMI that's configured to perform NAT.|
|Cost|Charged depending on the number of NAT gateways you use, duration of usage, and amount of data that you send through the NAT gateways.|Charged depending on the number of NAT instances that you use, duration of usage, and instance type and size.|
|Type and size|Uniform offering; you don’t need to decide on the type or size.|Choose a suitable instance type and size, according to your predicted workload.|
|Public IP addresses|Choose the Elastic IP address to associate with a public NAT gateway at creation.|Use an Elastic IP address or a public IP address with a NAT instance. You can change the public IP address at any time by associating a new Elastic IP address with the instance.|
|Private IP addresses|Automatically selected from the subnet's IP address range when you create the gateway.|Assign a specific private IP address from the subnet's IP address range when you launch the instance.|
|Security groups|You cannot associate security groups with NAT gateways. You can associate them with the resources behind the NAT gateway to control inbound and outbound traffic.|Associate with your NAT instance and the resources behind your NAT instance to control inbound and outbound traffic.|
|Network ACLs|Use a network ACL to control the traffic to and from the subnet in which your NAT gateway resides.|Use a network ACL to control the traffic to and from the subnet in which your NAT instance resides.|
|Flow logs|Use flow logs to capture the traffic.|Use flow logs to capture the traffic.|
|Port forwarding|Not supported.|Manually customize the configuration to support port forwarding.|
|Bastion servers|Not supported.|Use as a bastion server.|
|Traffic metrics|View [CloudWatch metrics for the NAT gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway-cloudwatch.html).|View CloudWatch metrics for the instance.|
|Timeout behavior|When a connection times out, a NAT gateway returns an RST packet to any resources behind the NAT gateway that attempt to continue the connection (it does not send a FIN packet).|When a connection times out, a NAT instance sends a FIN packet to resources behind the NAT instance to close the connection.|
|IP fragmentation|Supports forwarding of IP fragmented packets for the UDP protocol.<br><br>Does not support fragmentation for the TCP and ICMP protocols. Fragmented packets for these protocols will get dropped.|Supports reassembly of IP fragmented packets for the UDP, TCP, and ICMP protocols.|

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

![[Pasted image 20260310102203.png]]
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
