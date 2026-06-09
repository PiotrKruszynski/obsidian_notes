---
title: "Amazon ECR"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!tip]
>Prywatne repozytorium obrazów Docker na AWS.

![[Pasted image 20260224091049.png]]



```
docker build -t my-app .
docker tag my-app 123456.dkr.ecr.eu-west-1.amazonaws.com/my-app:latest
docker push 123456.dkr.ecr.eu-west-1.amazonaws.com/my-app:latest
```

- skanowanie obrazów pod kątem podatności (CVE)
- replikacja między regionami
- integracja z ECS, EKS, Lambda
