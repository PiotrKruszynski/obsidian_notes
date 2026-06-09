---
title: "AWS App Runner"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!Definition]  
>- **App Runner** → fully managed PaaS dla web apps (code / Docker → running service)  
>- zero infra (no ECS/EKS, no servers)  
>- auto build + deploy + scaling + LB  
>- **A2C** → tool do **containerization legacy apps (Java/.NET)**  
>- generuje: Dockerfile + CFN + deploy do ECS/EKS/App Runner  
  
# Mental model  
App Runner: `push code/image → AWS buduje → deploy → autoscale → endpoint HTTPS`  
A2C: bierze starą app → tworzy container → deploy do AWS  
  
- App Runner = **simplest path to run app**  
- A2C = **migration tool, nie runtime**  
**Use case**: szybki deploy bez AWS knowledge, lift-and-shift legacy apps  
# Core features  
- App Runner:  
- source: GitHub / ECR  
- auto scaling + HA + HTTPS  
- optional VPC access  
- A2C:  
- analizuje app  
- tworzy Docker image + infra templates  
- deploy: ECS / EKS / App Runner  
# How it works  
App Runner:  
`code/image → build → run service → public endpoint  `
  
A2C:  
existing app → containerize → deploy target  
# Comparison  

| Feature | App Runner | ECS |  
|--------|-----------|-----|  
| Control | minimal | medium |  
| Setup | zero | some |  
| Scaling | auto | config |  
| Use case | simple apps | production systems |  
# Exam traps  
- ❌ App Runner = ECS → NIE (wyższy poziom abstraction)  
- ❌ A2C uruchamia aplikację → NIE (tylko przygotowuje)  
- ❌ App Runner do complex systems → NIE (simple apps)  
- ❌ brak auto scaling → NIE (jest wbudowany)  
  
# TL;DR  
- App Runner = **najprostszy deploy web app**  
- A2C = **narzędzie migracyjne → kontenery**  
- wybór: **simplicity → App Runner, control → ECS/EKS**
