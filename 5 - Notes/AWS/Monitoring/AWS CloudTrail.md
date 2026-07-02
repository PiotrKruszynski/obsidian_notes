---
title: "AWS CloudTrail"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-21
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!important]  
>- CloudTrail = **audit + logging**  wykonanej akcji, kliknięcia (API calls) w AWS  
>- zapisuje: **kto zrobił co, kiedy, skąd**  
>- **enabled by default**  
>- kluczowy do: **security, compliance, troubleshooting**  
  
---  
  
## Mental model  
  
CloudTrail = **historia wszystkich działań w AWS**  
`User / Service → API call → CloudTrail → log`

👉 każde kliknięcie w konsoli = API call

---

## Co loguje

- AWS Console
- CLI
- SDK
- AWS Services
👉 wszystko co robi zmiany w AWS

---

## Gdzie trafiają logi

- domyślnie:
    
    - Event History (90 dni)
        
- opcjonalnie:
    
    - **S3 (long-term storage)**
        
    - **CloudWatch Logs (monitoring + alerty)**
        

---

## Typy eventów (ważne!)

### Management Events (default)

- operacje na zasobach:
    
    - create / delete / modify
        
- np:
    
    - uruchomienie EC2
        
    - zmiana IAM policy
        

👉 **włączone domyślnie**

---

### Data Events

- operacje na danych:
    
    - S3 (GetObject, PutObject)
        
    - Lambda invoke
        

👉 **wyłączone domyślnie (duży koszt!)**

---

### CloudTrail Insights

- wykrywa **nietypowe zachowania**
    
- np:
    
    - nagły spike API calls
        

---

## 🔥 Najważniejsze use case

resource deleted → sprawdź CloudTrail

👉 kto usunął, kiedy, z jakiego IP

---

## Integracja z EventBridge

CloudTrail może wysyłać eventy do EventBridge:

CloudTrail → EventBridge → SNS / Lambda

👉 przykłady:

- ktoś przyjął rolę IAM
    
- ktoś usunął DB
    
- ktoś zmienił security group
    

👉 możesz:

- wysłać alert (SNS)
    
- uruchomić Lambda
    

---

## Security

- integracja z:
    
    - IAM
        
    - CloudWatch
        
    - EventBridge
        
- logi można:
    
    - szyfrować (KMS)
        
    - archiwizować (S3)
        

---

## Exam traps

- CloudTrail ≠ monitoring (to audit log)
    
- nie loguje metryk (to CloudWatch)
    
- Data Events są wyłączone domyślnie
    
- Event History = tylko 90 dni
    

---

## TL;DR

CloudTrail = kto zrobił co w AWS  
  
Management → default  
Data → optional  
Insights → anomaly detection  
  
debug/security → CloudTrail first

![[Pasted image 20260320224923.png]]



---
