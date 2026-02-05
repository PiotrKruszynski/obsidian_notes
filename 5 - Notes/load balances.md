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
	- routing based on path ) `example.com/users` & `example.com/post
	-  routing based on hostname in URL `one.example.com % other.example.com`
	- routing based on Query String, Headers `example.com/users?id=123&order=false`
- **rozdziela ruch miedzy różne EC2
- load balancing to multiple applications on the same machine ( ex: containers)
- wiele aplikacji na jednej maszynie ([[ECS - elastic container service]] / EKS / Docker)
- świetne dla micro services & container-based application ( Docker & Amazon ECS)
- ma port mapping feature to redirect to a dynamic port in ECS
- może zastępować potrzebę multiple Classic Load Balancer per application

![[Pasted image 20260205094026.png]]

- During request forwarding, the **load balancer adds headers** that pass client connection details to the target:
	- **X-Forwarded-For** → original **client IP address**
	- **X-Forwarded-Port** → **destination port** used by the client
	- **X-Forwarded-Proto** → **protocol** used (http or https)

These headers allow backend applications to correctly identify the **real client IP**, port, and protocol, even though the request is proxied by the load balancer.
![[Pasted image 20260205100253.png]]

# NLB - network load balancer
- szybki, nie patrzy na HTTP, działa na warstwie 4 (transport) interesuje sie portem IP
- forward TCP, TLS (secure TCP), UDP traffic to your instance
- handle milions of request per sec
- ultra-low latency
- has **one static IP per AZ**, and supports assigning Elastic IP -> helpful for whitelisting spec IP
- jego [[target groups]]:
	- EC2 instances
	- IP Addresses - must be private IPs
	- Application Load Balancer -> NLB daje fix IP adresses, a ALB regóły z HTTP
- health checks support TCP, HTTP, HTTPS protocols
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
