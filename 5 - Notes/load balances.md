Created: 2026-02-04  18:02
___
Note:

>[! Important]
>are servers that forward traffic to multiple servers / instances / downstream

- spread load
- expose a single point of access (DNS) to app
- seamlessly handle failures of downstream instancees
- do regular health checks to your instances
- provide SSL termination (HTTPS). SSL kończy się na tym komponencie,  dalej HTTP
- enforce stickness with cookies (zapamietuje użytkownika, do której instancji trafił)
- [[high availability]] across zones 
- separate public from private traffic


## ELB - elastic load balancer type:

# CLB - classic load balancer (old)
- support HTTP, HTTPS, troche[[WebSocket]] 
- obsługuje warstwa 4 + 7 częściowo
- brak nowoczesnych fn
# ALB - application load balancer
- support HTTP, HTPS, WebSocket
- Layer 7 (HTTP) (warstwa aplikacji)
- load balancing to multiple HTTP applications across machines ( [[target groups]])
- **rozdziela ruch miedzy różne EC2
- load balancing to multiple applications on the same machine ( ex: containers)
- wiele aplikacji na jednej maszynie ([[ECS - elastic container service]] / EKS / Docker)
# NLB - network load balancer
- szybki, nie patrzy na HTTP, działa na warstwie 4 (transport) interesuje sie portem IP
- TCP, TLS (secure TCP), UDP
# GWLB - gateway load balancer
- brama do API
- operates at layer 3 (network layer) - IP Protocol



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
