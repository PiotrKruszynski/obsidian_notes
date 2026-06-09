---
title: "AWS snowball"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!tip]
>Highly-secure, 
>portable devices 
>to collect and process data at the edge, 
>and migrate data into and out of AWS
>
>To **fizyczny serwer w obudowie typu rugged**, który AWS wysyła do Ciebie kurierem, żebyś mógł **skopiować dane lokalnie**, zamiast wysyłać je przez Internet.

Device Types (Snowball Edge)

There are two main types of Snowball Edge devices based on your needs:

• **Snowball Edge Storage Optimized:**
• **Snowball Edge Compute Optimized:**

![[Pasted image 20260218223310.png]]

Data Migration Strategy

![[Pasted image 20260218223340.png]]

![[Pasted image 20260218223358.png]]
Edge Computing with Snowball
![[Pasted image 20260218223450.png]]

Solutions Architect Tip

For ongoing data replication (not a one-time move), use services like **AWS DataSync** or **AWS Database Migration Service (DMS)** over a VPN or Direct Connect. Use Snowball for the initial "bulk" transfer to save time.

![[Pasted image 20260218223516.png]]
