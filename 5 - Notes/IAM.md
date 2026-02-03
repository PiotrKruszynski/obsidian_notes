Created: 2026-02-03  19:22
___
Note:


tags: #aws #iam #security #exam #saa  
type: exam-note  
source: AWS Certified Solutions Architect Slides v45 (Stephane Maarek)

## 👤 IAM Users

- 1 **physical person = 1 IAM user**
    
- User may have:
    - **Password** → AWS Management Console
    - **Access Keys** → CLI / SDK
- ❌ Never share users or access keys
    

---

## 👥 IAM Groups

- Group contains **ONLY users**
- Groups **cannot contain other groups**
- Permissions are assigned to **groups, not users** (best practice)

---

## 🎭 IAM Roles (CRITICAL)

- Role = **identity without permanent credentials**
- Assumed via **STS (AssumeRole)**
- Used by:
    - EC2
    - Lambda
    - ECS / EKS
    - Cross-account access
- ✅ Always use **Roles for AWS services**

---

## 📜 IAM Policies

- JSON documents defining permissions
- Key fields:
    
    - Effect (Allow / Deny)
    - Action
    - Resource
        
- Types:
    - AWS Managed
    - Customer Managed
    - Inline (❌ avoid)
        

---

## 🚫 Default Rule

> **Everything is denied by default**

Evaluation order:

1. Explicit **Deny** → always wins
2. Explicit **Allow** → access granted
3. No rule → Deny

---

## 🔑 Root Account (EXAM ALERT)

- ❌ Do NOT use for daily work

---

## 🔐 MFA (Multi-Factor Authentication)

---

## 🔑 Access Keys

- Access Key ID ≈ username
- Secret Access Key ≈ password
- Used only for:
    - AWS CLI
    - AWS SDK
- ❌ Never commit to Git
- ❌ Never attach to EC2 → use Role instead
    

---

## 🧰 How users access AWS

Three access methods:

1. **AWS Console** → password + MFA
2. **AWS CLI** → access keys
3. **AWS SDK** → access keys

---

## 🔍 IAM Security & Audit Tools

- **IAM Credentials Report**
    - account-level
    - shows users and credential status
- **IAM Access Advisor**
    - shows when permissions were last used
- Used to enforce **least privilege**

---

## ⚠️ Common Exam Traps

- ❌ Access keys on EC2 → WRONG
- ❌ Root user for operations → WRON    
- ❌ Inline policies as standard → WRONG
- ✅ IAM Role for services → CORRECT
- ✅ Groups + managed policies → CORRECT

---

## 🧪 Exam Question Patterns

- “EC2 needs access to S3” → **IAM Role**
- “Single login for multiple AWS accounts” → **IAM Identity Center**
- “Allow exists but access denied” → check **Explicit Deny**



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
