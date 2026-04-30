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
>poprawna konserwacja - żeby natychmiast nie zabijało `unhealthy`:
>- Put the instance into Standby - nadal zyje czasowo nie obsługuje ruchu
>- `ReplaceUnhealthy` - nie zabijaj mi tej instancji podczas maintenance
>- shapshot + AMI za wolne

## 🧠 Mental model
ASG = **self-healing + auto-scaling orchestrator**
- utrzymuje **desired capacity**
- automatycznie **replace dead instances**
- skaluje się na podstawie **metrics**
- integruje się z **Load Balancer**
## ⚙️ Core behavior
- **health checks**
    - EC2 status + ELB health check
    - unhealthy:
        - **1.terminate →2.launch replacement**
- **desired / min / max**
    - **desired = target liczby instancji**
    - ASG **zawsze dąży do desired**
### 🧠 Mental model (do pytania)
- **problem = unhealthy → usuń najpierw**
- **problem = imbalance → dołóż najpierw**
### 🔥 Ultra skrót
- unhealthy → **terminate → launch**
- rebalance → **launch → terminate**
## 🚀 Launch Template
- AMI, instance type
- security groups
- key pair
- user data
- EBS config
👉 ASG używa LT do tworzenia instancji

## 📈 Scaling Policies — ASG

### Dynamic Scaling

Reaguje na **bieżące** metryki.

- **Target Tracking** — utrzymuje metrykę na stałym poziomie (np. CPU = 40%). ASG sam dodaje/usuwa instancje żeby to osiągnąć. Najprostsze w konfiguracji.
- **Step Scaling** — progi z krokami: CPU > 70% → +2 instancje, CPU > 90% → +4 instancje. Masz pełną kontrolę.
- **Simple Scaling** — jak step ale tylko jeden próg, jeden krok. Starsza wersja step scaling, raczej nie używaj.
### Scheduled Scaling

Skalujesz **z góry wg harmonogramu** — np. codziennie o 8:00 dodaj 5 instancji, o 22:00 usuń. Używasz gdy ruch jest przewidywalny (peak hours, koniec miesiąca).
### Predictive Scaling

ASG analizuje **historyczny ruch** i sam przewiduje kiedy będzie potrzeba więcej instancji — skaluje **zanim** ruch wzrośnie. Wymaga minimum 24h historii danych.

> **Praktyczna zasada:** Target Tracking jako baza, Scheduled jeśli znasz wzorce ruchu, Predictive jeśli masz dużo historycznych danych.

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
