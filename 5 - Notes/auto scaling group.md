Created: 2026-02-05  21:25
___
Note:


>[!important]
>**scale out** → increase instances  
>**scale in** → decrease instances  
>**desired capacity** → target liczba instancji  
>**min / max** → bounds  
>**self-healing** → replace unhealthy  
>**auto register/deregister** → z Load Balancer  

## 🧠 Mental model
ASG = **self-healing + auto-scaling orchestrator**
- utrzymuje **desired capacity**
- automatycznie **replace dead instances**
- skaluje się na podstawie **metrics**
- integruje się z **Load Balancer**
## ⚙️ Core behavior
- **health checks**
  - EC2 status + ELB health check
  - unhealthy → 1. replace -> 2 terminate
- **desired / min / max**
  - desired = target
  - ASG zawsze dąży do desired
## 🚀 Launch Template
- AMI, instance type
- security groups
- key pair
- user data
- EBS config
👉 ASG używa LT do tworzenia instancji

## 📈 Scaling Policies
### dynamic scaling
- **target tracking**
  - utrzymuje np. CPU = 40%
- **step / simple scaling**
  - np. CPU > 70% → +2 instances
### scheduled scaling
- scaling wg czasu (np. peak hours)
### predictive scaling
- forecast + scaling ahead

### 🚨 Pułapka egzaminacyjna
- AWS lubi sprawdzać czy:
    - wybierzesz **lifecycle control (Standby / Suspend)**
    - zamiast przebudowy architektury (AMI, nowe ASG)
👉 zasada:  
**jeśli problem = zachowanie ASG → rozwiązanie = zmiana zachowania ASG, nie infrastruktury**

## 📊 Metrics (kluczowe)
- **CPUUtilization**
- **RequestCountPerTarget (ALB)** ⭐
- **Network In/Out**
- **custom (CloudWatch)** ⭐ (np. SQS queue depth)
👉 CPU nie zawsze najlepszy

## 🔥 Warmup / Cooldown
- **instance warmup**
  - nowa instancja nie wpływa od razu na metryki
  - zapobiega over-scaling
- **cooldown (legacy)**
  - pause między scaling
## 🧠 Lifecycle Hooks
- pause przy:
  - launch
  - terminate
- use cases:
  - install software (launch)
  - snapshot / drain (terminate)
#### 👉 ASG = jedyne miejsce gdzie możesz zatrzymać lifecycle

---

## 🔄 Instance Refresh
- rolling update instancji
- używa nowej wersji Launch Template
👉 use case:
- update AMI
- patching

---

## ⚡ Mixed Instances Policy
- mix:
  - On-Demand + Spot
  - multiple instance types
👉 cost ↓ / resilience ↑

---

## 🔗 Load Balancer integration
- auto register do ALB/NLB
- auto deregister przy terminate
- **connection draining (deregistration delay)**
👉 brak traffic do terminating instance

## 🧪 Common Patterns (SAA)
- **ALB + ASG**
  - scale na RequestCountPerTarget
- **SQS + ASG**
  - scale na queue depth

---

## ⚠️ Pułapki
- brak warmup → over-scaling
- CPU jako metric dla I/O app → błąd
- brak ELB health check → traffic do dead instance
- brak lifecycle hook → utrata danych
- brak deregistration delay → dropped requests

---

## 🔥 Exam Takeaways
- ASG = **self-healing + scaling**
- lifecycle hook = **pause lifecycle**
- best metric = **RequestCountPerTarget / SQS depth**
- warmup = **stabilizacja scalingu**
- instance refresh = **rolling update**




![[Pasted image 20260205212848.png]]

![[Pasted image 20260205212904.png]]

![[Pasted image 20260205212920.png]]

## Information to Launch Template

![[Pasted image 20260205212931.png]]

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
