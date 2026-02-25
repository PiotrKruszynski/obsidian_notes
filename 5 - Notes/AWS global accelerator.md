Created: 2026-02-18  20:49
___
Note:

>[!tip]
>**AWS Global Accelerator** is a networking service (usługa sieciowa) optymalizująca routing sieciowy (TCP/UDP) do wielu regionów, poprawiając stabilność i redukując opóźnienia.
>Używa **anycast ip** to work

Global accelerator - optymalizator ruchu do aplikacji globalnych
natomiast
[[Amazon CloudFront]] - globalny CDN, który cachuje i dostarcza treści (statyczne i dynamiczne) 


![[Pasted image 20260218205113.png]]

# Key Characteristics

• **Anycast IP:** It provides **2 static Anycast IPv4 addresses** for your application.

• **Fixed Entry Point:** These Anycast IPs send traffic directly to **AWS Edge Locations**, which then route the traffic to your application.
 _(Wytłumaczenie: Anycast IP oznacza, że wiele serwerów na świecie używa tego samego adresu IP, a użytkownik jest automatycznie kierowany do najbliższego punktu wejścia sieci AWS)_.

• **No DNS Caching Issues:** Because the IP addresses are static and do not change, there are no issues with client-side DNS caching.

• **Intelligent Routing:** It automatically routes users to the endpoint with the **lowest latency**.

# Performance & Reliability

• **Consistency:** It improves performance by up to 60% by keeping traffic on the private AWS network backbone instead of the public internet.

• **Health Checks:** Global Accelerator performs continuous health checks (TCP, HTTP, HTTPS) on your application endpoints.

• **Fast Failover:** If an application endpoint is unhealthy, failover to a healthy region happens in **less than 1 minute**.

• **Traffic Dials:** You can use traffic dials to control the percentage of traffic directed to specific regional endpoints.

# Security

• **DDoS Protection:** Integrates natively with **AWS Shield** to protect your application from attacks.

• **Simplified Whitelisting:** Since you only have 2 external static IPs, they are easy for your clients or partners to whitelist in their firewalls.

# Global Accelerator vs. CloudFront

Both services use the global AWS network and edge locations, but they serve different purposes:

• **Amazon CloudFront:**
    ◦ Designed for **cacheable content** (images, videos) and dynamic site delivery.
    ◦ Content is **served at the edge**.

• **AWS Global Accelerator:**
- Improves performance for a wide range of applications over **TCP or UDP**.
- **Proxies packets at the edge** to applications running in one or more AWS Regions.
- Ideal for **non-HTTP use cases** like gaming (UDP), IoT (MQTT), or Voice over IP (VoIP).
- Best for HTTP use cases that require **fixed IP addresses** or deterministic, fast failover.



# Solutions Architect Tip

You can use **AWS Global Accelerator** together with an **Application Load Balancer (ALB)** to provide a fixed IP address for a web application that also needs the Layer 7 protection of **AWS WAF**. _(Wytłumaczenie: WAF nie wspiera Network Load Balancera (Warstwa 4), więc używamy Global Acceleratora dla stałego adresu IP i podpinamy go pod ALB z aktywnym WAFem)_


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
