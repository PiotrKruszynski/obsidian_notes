Created: 2026-02-05  21:25
___
Note:

>[! Important]
>**scale out** to increase
>**scale in** to decreas
>**ensure min and max
>** **auto register** new instance to load balancer                        *superpower*
>**re-create** instance in case a previous is terminated           *superpower*
>

![[Pasted image 20260205212848.png]]

![[Pasted image 20260205212904.png]]

![[Pasted image 20260205212920.png]]

## Information to Launch Template

![[Pasted image 20260205212931.png]]

## Scaling Policies
- dynamic scaling
	- target tracking scaling
		- simple to setup
		- example: I want average ASG CPU to stay at 40%
	- simple / step scaling
		- when a CloudWatch alarm is triggered (example CPU > 70%) then add 2 units
- scheduled scaling
	- anticipate a scaling based on known usage patterns
	- example: increase the min capacity to 10 at 5pm Fridays
- predictive scaling:
	- continuously forcast load and schedule scaling ahead

## Metric to scale on
- **CPUUtilization**: avg CPU utilization across your instances
- **RequestCountPerTarget**: to make sure the number of requests per EC2 instance is stable
- **Average Network in / Out** : if you aplication is network bound
- **Any custom metric**: what u push using CloudWatch


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
