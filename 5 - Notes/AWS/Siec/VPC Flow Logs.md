---
title: "VPC Flow Logs"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[! ]
>**VPC Flow Logs** to funkcja, która zbiera informacje o ruchu sieciowym w Twoim VPC. Rejestruje zarówno ruch przychodzący, jak i wychodzący, a także to, czy dany ruch został dozwolony czy zablokowany. 
>Dane te możesz przesyłać do S3 lub CloudWatch Logs, co pozwala analizować przepływy, diagnozować problemy sieciowe czy monitorować bezpieczeństwo. 
>W skrócie, to **logi ruchu sieciowego na poziomie VPC**.
>- IAM Service Role associated with VPC Flow Logs must have required permission to publish logs to CloudWatch Logs

Może łapać na poziomie:
- VPC Flow Logs
- Subnet Flow Logs
- ENI Flow Logs

Query VPC flow logs using **Athena** on S3 or **CloudWatch Logs Insights**.

![[Pasted image 20260324123911.png]]
