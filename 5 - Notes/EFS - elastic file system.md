Created: 2026-02-03  13:10
___
Note:

wspólny folder
menaged NFS ( network file system) that can be mounted on many EC2
EFS works with EC2 instances in multi-AZ
highly available, scalable, expensuve (3xgp2), pay per use

## Use cases:
- content management, web services, data sharing, wordpress
- uses NFSv4.1 protocol
- uses security group to control acces to EFS
- compatible with Linux based AMI ( not Windows)
- encryption at rest using KMS
- standard Linux file system API
- mają performance Mode:
	- general purpose
	- max I/O

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
