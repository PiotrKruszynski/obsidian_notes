Created: 2026-02-04  11:47
___
Note:

>[! Important]
>control how traffic is allowed in or out of  EC2 Instances
>fundamental of network security in AWS
>są _statefull_

![[Pasted image 20260206121052.png]]

# Kluczowe cechy:
- only contains **allow** rule
- acting as a firewall
- good to maintain one separate security group for SSH access
- all ==inbound== traffic is blocked by default
- all ==outbound== traffic is authorised by default
- can be attach to multiple instance
- locked down to a region/VPC combination
- "live" outside EC2 - if traffic is blocked the EC2 instance wont see it
- not accessible(time out) app is a security group issue
# Co kontrolują:
- access to Ports
- authorised IP ranges IPv4 and IPv6
- control of in out network

![[Pasted image 20260204115120.png]]



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
