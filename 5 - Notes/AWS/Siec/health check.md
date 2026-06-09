---
title: "health check"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[! Important]
>definition

## **🟦 Health check** 

## **Load Balancera**

**Problem, który rozwiązuje:**

> „Czy ten backend _powinien dostać ruch_?”





## **🟨 Health check** 

## **Route 53 (DNS)**

**Problem, który rozwiązuje:**

> „Czy ten _endpoint w ogóle istnieje logicznie_ i ma być zwracany w DNS?”


# **2️⃣ HEALTH CHECK LOAD BALANCERA (ALB / NLB)**

```
Client → DNS → Load Balancer → Target Group → Backend
                                    ↑
                               health check
```

# **3️⃣ HEALTH CHECK ROUTE 53 (DNS-level)**
```
Client → DNS Resolver → Route 53
                       ↑
                 health check
```

## **🔧 Jak działa technicznie**

- Route 53 **sam monitoruje endpoint**
    
- może sprawdzać:
    - HTTP / HTTPS
    - TCP
    
- z **kilku lokalizacji na świecie**
- **nie jest powiązany z ALB health checkiem**
## **✅ Co się dzieje, gdy DNS health check FAIL**

- Route 53:
    
    - **przestaje zwracać rekord**
        
    - albo **przełącza na inny rekord** (failover)
        
    

  

### **Typowe użycie:**

- multi-region
    
- active / passive
    
- DR (Disaster Recovery)
    

---

## **❌ Czego DNS health check NIE robi**

- nie wie nic o target group
    
- nie wie, czy jedna instancja padła
    
- nie reaguje na „częściowe problemy”
    

  

To jest **grube sito**:

  

> endpoint działa / nie działa

# **4️⃣ JAK ONE WSPÓŁPRACUJĄ (KLUCZOWE)**

```
Route 53
 └─ health check: ALB endpoint
       ↓
ALB
 └─ health check: backendy
```

### **Co to daje:**

- ALB **lokalnie** wycina złe instancje
    
- Route 53 **globalnie** wycina cały ALB (np. region)
