Created: 2026-02-04  18:02
___
Note:

>[! Important]
>are servers that forward traffic to multiple servers / instances downstream

- spread load
- expose a single point of access (DNS) to app
- seamlessly handle failures of downstream instancees
- do regular health checks to your instances
- provide SSL termination (HTTPS). SSL kończy się na tym komponencie,  dalej HTTP
- enforce stickness with cookies (zapamietuje użytkownika, do której instancji trafił)
- [[high availability]] across zones 
- separate public from private traffic

# ELB - elastic load balancer

[upstream] - użytkownicy / klienci / internet
[downstream] - wiele serwerów / instancji aplikacji



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
