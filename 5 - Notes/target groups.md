Created: 2026-02-04  20:46
___
Note:

>[! Important]
>zbiór backendów (np. EC2, ECS tasks, IP adress) do których [[load balances]] faktycznie wysyła ruch

- can route traffic to multiple target groups
- routing is based on **Layer 7**APP rules (host, path, headers)
- **health checks** are defined at the target group level
- traffic is sent only to healthy targets

## Supported target types
- EC2 instance
	- can be managed by **Auto Scaling Group
	- protocol HTTP / HTTPS
- ECS tasks
	- managed directly by ECS
	- protocol HTTP / HTTPS
- Lambda fn
	- HTTP request in transfered into JSON event
	- no servers involved
- IP Adresses
	- must be private IPs only
	- useful for on-permises nr non-EC@ targets



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
