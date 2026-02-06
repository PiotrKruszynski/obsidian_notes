Created: 2026-02-04  18:02
___
Note:

>[! Important]
>are servers that forward traffic to multiple servers / instances / downstream

# Defaults
- load balancer = **entry point** for application traffic
- spread load & forwards traffic to downstream targets
- [[high availability]] across multiple AZs
- separate public from private traffic
- expose **single DNS name
- handle failures of downstream instances
- perform health checks
- can terminate SSL/TSL (HTTPS -> HTTP)
- **sticky sessions (session affinity)**
	- keeps users bound to same target
	- implemented via cookies
	- ==supported by: **CLB, ALB, NLB
	- cookie has config expiration
	- use case: make sure user doesnt lose his session data
	- may bring imbalance to the load
	- type of cookies:
		- application-based cookies: custom cookie and application cookie
		- duration-based cookies: generate by LB

# ELB types:

## CLB - classic load balancer
- support HTTP, HTTPS, troche[[WebSocket]] 
- brak nowoczesnych fn
- cross-zone disable by default, no inter AZ data charges
## ALB - application load balancer
- support HTTP, HTPS, WebSocket
- Layer 7 (HTTP) (warstwa aplikacji)
- routes traffic using listener rules:
	- path `example.com/users` & `example.com/post
	-  hostname `one.example.com % other.example.com`
	- Query String / Headers `example.com/users?id=123&order=false`
- **rozdziela ruch miedzy różne EC2
- work with **[[target groups]]
- support:
	- microservices
	- containers (ECS / EKS)
	- multiple app on one instance
- ma dynamic port mapping ([[ECS - elastic container service]] / EKS / Docker)
- świetne dla micro services & container-based application ( Docker & Amazon ECS)
- **cross-zone enabled by default**
- może zastępować potrzebę multiple Classic Load Balancer per application

![[Pasted image 20260205094026.png]]

- add headers:
	- **X-Forwarded-For** → original **client IP address**
	- **X-Forwarded-Port** → **destination port** used by the client
	- **X-Forwarded-Proto** → **protocol** used (http or https)

These headers allow backend applications to correctly identify the **real client IP**, port, and protocol, even though the request is proxied by the load balancer.
![[Pasted image 20260205100253.png]]

## NLB - network load balancer
- Layer 4 (TCP/UDP) transportu
- protocol TCP/UDP
- very high throughput, ultra-low latency
- handle milions of request per sec
- has **one static IP per AZ**,
- can use Elastic IP ([[whitelisting]])
- jego [[target groups]]:
	- EC2 instances
	- private IPs
	- ALB (static IP + L7 rules combo)
- health checks support TCP, HTTP, HTTPS protocols
- Cross-zone:
	- disable by default, 
	- inter AZ trafic $ $
## GWLB - gateway load balancer
- brama do API, obsługuje urządzenia sieciowe (firewall, IDS, WAF)
- protocol IP
- operates at OSI layer 3 (network layer) - handle IP packets, not app protocol
- deploy, scale and manage a fleet of 3rd party network virtual appliances in AWS
- **transparent** network gateway - single enter/exit for all trafic
- uses the **GENEVE** protocol on port 6081 (tunel dla oryginalnych pakietów)
- target group:
	- ec2 instances
	- private IP
- cross-zone disable by default, $ $ $ for inter AZ data


>[! Important]
**[upstream]** - użytkownicy / klienci / internet
**[downstream]** - wiele serwerów / instancji aplikacji

```bash
Load Balancer
  └─ Listener (port 80/443)
      └─ Target Group ← `TU SIĘ ROBI HEALTH CHECK`
          ├─ EC2-1
          ├─ EC2-2
          └─ EC2-3
```

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
