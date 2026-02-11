Created: 2026-02-11  11:37
___
Note:

# Amazon RDS Proxy – Overview

• **Fully managed** database proxy for RDS.
• Allows apps to **pool and share DB connections** (pula i współdzielenie połączeń).
• **Improving efficiency:** Reduces stress on CPU/RAM and minimizes open connections and timeouts.
• **Serverless**, autoscaling, and **highly available** (Multi-AZ).
• **Reduced failover time:** Skraca czas przełączania awaryjnego dla RDS & Aurora o **66%**.
• **Supported Engines:** RDS (MySQL, PostgreSQL, MariaDB, MS SQL Server) oraz Aurora (MySQL, PostgreSQL).

• no code changes required for most apps
•  ** Enforce 

# Amazon RDS Proxy – Security & Access

• **No code changes** required for most applications.
• Enforce **IAM Authentication** for DB (wymusza uwierzytelnianie IAM).
• Securely store credentials in **AWS Secrets Manager**.
• **Not publicly accessible:** Proxy nigdy nie jest dostępne publicznie; must be accessed from **VPC**.

# Lambda with RDS Proxy
• **Problem:** Jeśli funkcje Lambda bezpośrednio uzyskują dostęp do bazy, mogą otworzyć zbyt wiele połączeń pod wysokim obciążeniem (high load).
• **Solution:** RDS Proxy improves **scalability** by pooling and sharing connections.
• **Deployment:** Lambda must be deployed in your **VPC**, ponieważ RDS Proxy nie jest dostępne publicznie

![[Pasted image 20260211113825.png]]


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
