Created: 2026-02-18  12:13
___
Note:

>[!tip]
>fast **Content Delivery Network (CDN)** service that improves read performance by caching content at the "edge". It is a global service designed to deliver data, videos, applications, and APIs to customers around the world with low latency and high transfer speeds
>
>_CloudFront to sieć serwerów na całym świecie, które trzymają kopie Twoich plików blisko użytkownika, dzięki czemu strona ładuje się błyskawicznie. **Tymczasowo catch'uje dane**_

# CloudFront – Global Infrastructure

- content is cached at the edge
- improves read performance and user experience
- DDoS protection (because worldwide), integration with Shield, [[AWS Web Application Firewall]]
- great for static content that must be available everywhere

![[Pasted image 20260218130450.png]]

# CloudFront – Origins (backend to connect to)

![[Pasted image 20260218122624.png]]

1. **S3 Bucket:** 
- for distributing files and caching them at the edge.
- for uploading files to S3 through CloudFront
- secured using **Origin Access Control (OAC)
![[Pasted image 20260218122640.png]]

2. **VPC Origins:**  
- for applications hosted in private subnets, such as an **ALB, NLB, EC2 Instances**
![[Pasted image 20260218191026.png]]
1. **Custom Origin (HTTP):** 
- S3 website (must first enable bucket as a static S3 website)
- Any public HTTP backend you want (public ALB)







# CloudFront – Performance & Caching

- **TTL (Time To Live):** Files are cached at edge locations for a specific duration (TTL); CloudFront only checks the origin for updates after the TTL expires.
- Cross Region Replication


• **Cache Invalidations:** If you update your backend, you can force CloudFront to bypass the TTL and refresh the cache immediately by performing an **Invalidation** (e.g., path `/images/*` or all files `*`).

![[Pasted image 20260218191756.png]]



# CloudFront – Security

• **Origin Access Control (OAC):** A security feature used to ensure that only CloudFront (and not the public internet) can access your S3 bucket origin.

• **Geo Restriction:** You can use an **Allowlist** or **Blocklist** to control access to your content based on the user's country (determined by a 3rd party Geo-IP database).

• **DDoS Protection:** CloudFront is globally distributed, providing native protection against DDoS attacks. It integrates with **AWS Shield** and **AWS WAF** (Web Application Firewall) to filter and block bad requests at Layer 7.

• **ACM Integration:** Integrates with AWS Certificate Manager to provide HTTPS encryption; certificates for CloudFront must be created in the `us-east-1` region.

# CloudFront – Customization at the Edge

Many modern applications execute logic at the edge to minimize latency. CloudFront offers two serverless options for this:

• **CloudFront Functions:**
    ◦ Written in **JavaScript**.
    ◦ Lightweight and designed for high-scale (millions of requests/sec).
    ◦ Used for simple manipulations of **Viewer Request** and **Viewer Response** (e.g., URL rewrites, header manipulation).

• **Lambda@Edge:**
    ◦ Written in **Node.js or Python**.
    ◦ Scales to thousands of requests/sec.
    ◦ Supports all four triggers: **Viewer Request/Response** and **Origin Request/Response**.
    ◦ Used for complex logic, such as A/B testing, image transformation, or accessing external libraries.

# CloudFront vs. AWS Global Accelerator

• **CloudFront:** Improves performance for **cacheable content** (images/videos) and **dynamic web content** (HTTP). Content is served directly from the edge.
• **Global Accelerator:** Improves performance for a wide range of applications over **TCP or UDP** (e.g., gaming, VoIP). It proxies packets at the edge to applications in AWS Regions and provides **fixed IP addresses**.

![[Pasted image 20260218204828.png]]

![[Pasted image 20260218204842.png]]

# Solutions Architect – Cost Optimization Tip

CloudFront can make an existing application **scalable and cheaper**. By caching static software update files or website assets at the edge, it reduces the load on your EC2 Auto Scaling Group (ASG), saving on compute and network bandwidth costs.


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
