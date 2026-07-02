---
title: "AWS Cognito"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-12
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

## 🔑 Core mental model

`User logs in → Cognito → token (JWT) → access to app / AWS`

Tokeny JWT, czyli JSON Web Tokens, to standardowy sposób przekazywania informacji o użytkowniku

---

## 1️⃣ Cognito User Pool (AUTH)

**Co robi:**  
→ **uwierzytelnianie użytkowników (login system)**
→ daje katalog użytkowników, tokeny JWT i natywną integrację z API Gateway.

## 2️⃣ Cognito Identity Pool (AUTHORIZATION)

służy do przyznawania tymczasowych **IAM Role**  na podstawie już uwierzytelnionych użytkowników.


## ❌ Czego Cognito NIE robi

- nie jest IAM replacement
- nie zarządza EC2 access
- nie przechowuje business data

## ⚡ Ultra skrót

Auth → User Pool  
AWS access → Identity Pool
