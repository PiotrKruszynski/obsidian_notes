Created: 2026-02-05  16:37
___
Note:

>[! Important]
>certificate allows traffic between your clients and your load balancer to be **encrypted** in transition(in-flight encryption)

- TLS newer version, people still refer as SSL
- u can manage certificates using AWS Certificate Manager
- u can create upload your own certificate 
- HTTPS listener:
	- u must specify a default certificate
	- u can add an optional list of certs to support multiple domains
	- Clients can use SNI Server Name Indication to specify the hostname they reach
	- ability to specufy a security policy to support older version of SSL/TSL (legacy client)

Problem:
- jeden serwer / jeden IP
- wiele stron, każda ma inny ceetyfikat SSL
bez SNI serwer nie wie jaki certyfikat wysłać

SNI - server name indication
SNI solves the problem of loading multiple SSL certificates onto one web server (to serve multiple websites)
It is a newer protocol and requires the client to **indicate** the hostname of the target server in the initial SSL handshake
the server will then find correct certificate or return the default one
SNI work for ALB & NLB, CloudFront
Does not work for CLB(old gen)





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
