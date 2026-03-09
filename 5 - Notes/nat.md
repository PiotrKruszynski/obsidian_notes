Created: 2026-03-07  21:24
___
Note:

>[!tip]
>network adress translation
>INSTANCE:
>allow ec2 instances in private subnets to connect to the Internet
>must be launched in a public subnet
>must disable EC2 setting: Source / destination Check
>must  have Elastic IP attached to it
>pre-configured Amazon Linux [[AMI]] is available
>not _highly available_ / resilient setup out of a box:
>	- you need to create an ASG in multi-AZ +resilient user-data script


Gateway
- AWS-managed NAT, highier bandwidth, high availability, no administration
- pay per hour of usage and bandwidth
- NATGW is ceated in specyfic AZ, uses an _Elastic IP_
- can't be used by EC2 instance in the same subnet (only from other subnets)
- 











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
