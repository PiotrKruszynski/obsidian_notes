Created: 2026-03-20  22:05
___
Note:


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
