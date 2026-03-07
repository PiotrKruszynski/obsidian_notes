Created: 2026-03-07  21:24
___
Note:

>[!tip]
>network adress translation
>allow ec2 instances in private subnets to connect to the Internet
>must be launched in a public subnet
>must disable EC2 setting: Source / destination Check
>must  have Elastic IP attached to it
>pre-configured Amazon Linux [[AMI]] is available
>not _highly available_ / resilient setup out of a box:
>	- you need to create an ASG in multi-AZ +resilient user-data script











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
