Created: 2026-03-09  20:42
___
Note:

>[!tip]
>**VPC Peering** is a networking connection that allows you to privately connect two VPCs using the AWS global network. This connection makes the VPCs behave as if they were part of the same network. _(Wytłumaczenie: VPC Peering to najprostszy sposób na połączenie dwóch chmurowych sieci tak, aby serwery mogły ze sobą rozmawiać bezpośrednio__)._

Key Rules and Characteristics
- **No Overlapping CIDRs:** The VPCs involved in a peering connection must not have overlapping IP address ranges.
- **Non-Transitive:** VPC Peering is not transitive.
- If VPC A is peered with VPC B, and VPC B is peered with VPC C, VPC A **cannot** communicate with VPC C through VPC B.
- To allow VPC A and VPC C to communicate, you must establish a separate, direct peering connection between them.
- _(Zasada braku przechodniości: Połączenie działa tylko bezpośrednio między dwiema sieciami; nie możesz "przejeżdżać" przez jedną sieć do drugiej__)._

Connectivity and Scope
- **Route Tables:** Simply creating the peering connection is not enough; you must update the route tables in the subnets of both VPCs to ensure instances can find each other.
- **Global Reach:** You can create peering connections between VPCs in different AWS accounts and different AWS regions.
- **Security Group Referencing:** You can reference a security group from a peered VPC in your own security group rules, which works across accounts as long as they are in the same region.
- **Private Network:** Peering traffic always stays on the private AWS network and never traverses the public Internet.

Peering vs. Alternatives
- **Simple Routing:** Peering is recommended for simple routing needs between a limited number of VPCs.
- **Transit Gateway:** For complex environments involving thousands of VPCs or on-premises connections, a hub-and-spoke topology using AWS Transit Gateway is preferred.
- **AWS PrivateLink:** If your workload only requires specific components to talk to each other rather than entire network ranges, PrivateLink provides a point-to-point alternative that reduces the need for full peering.
- **Troubleshooting:** You can use VPC Flow Logs to identify if peering traffic is being accepted or rejected by security groups or NACLs.

Best Practices for Solutions Architects
- **Active Planning:** Always plan your IP address space (CIDR) in advance to avoid conflicts when you eventually need to peer networks.
- **Hub-and-Spoke:** Prefer hub-and-spoke topologies (Transit Gateway) over a complex mesh of many-to-many peering connections to simplify management.
- **Cost Efficiency:** While peering itself is a standard tool, consider Gateway VPC Endpoints for S3 and DynamoDB as they are free and do not require peering to function.

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
