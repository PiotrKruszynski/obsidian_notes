Created: 2026-02-23  10:19
___
Note:

>[!important]  
>- SQS = **managed message queue** (decoupling layer między komponentami)
>- producer wrzuca wiadomość, consumer odbiera ją asynchronicznie  
>- 2 typy kolejek:  
>  - **Standard** → skala  
>  - **FIFO** → kolejność + deduplikacja  

**Decoupling** → services communicate asynchronously to improve scalability and fault isolation. You can decoupling app using:
	• [[Amazon SQS]]: queue model 
	• [[Amazon SNS]]: pub/sub model 
	• [[Amazon Data Firehose]]: real-time streaming model

---
### Mental model  
SQS = **bufor między warstwami aplikacji**   
`Producer → Queue → Consumer`
👉 aplikacje nie muszą gadać synchronicznie  
👉 awaria consumerów nie zatrzymuje producerów
### Standard Queue
- prawie nieograniczony throughput
- **at-least-once delivery**
- **best-effort ordering**
- retention:
    - default 4 days
    - max 14 days
- max message size:
    - **1 MiB**

> [!exam]  
> Standard = skala, ale licz się z:
> - duplikatami
> - brakiem gwarancji kolejności
>     

### FIFO Queue
- nazwa musi kończyć się na `.fifo`
- gwarantuje kolejność **w ramach Message Group ID**
- wspiera **exactly-once processing**
- klasycznie:
    - 300 API calls/s per method bez batchingu
- z batchingiem:
    - 3000 API calls/s 
- istnieje też **high throughput FIFO**

> [!exam]  
> FIFO = ordering + deduplication  
> nie wybierasz FIFO „bo lepsze”, tylko gdy naprawdę potrzebujesz kolejności

### Visibility Timeout
- po odebraniu wiadomość staje się niewidoczna dla innych consumerów
- default: **30 s**
- jeśli consumer nie usunie wiadomości przed timeoutem:
    - wraca do kolejki

> [!exam]  
> visibility timeout ustaw dłuższy niż czas przetwarzania
### Long Polling
- consumer czeka na wiadomości zamiast pytać non-stop
- max: **20 s**
- mniej pustych odpowiedzi
- niższy koszt
### Batching
- wysyłanie/odbieranie wielu wiadomości na raz
- poprawia throughput
- zmniejsza liczbę wywołań API
### Security
- **IAM** → kto może używać kolejki
- **Queue Policy** → co z zewnątrz może wysyłać / czytać
- **SSE / KMS** → szyfrowanie at rest
- **HTTPS** → szyfrowanie in transit
- **VPC Endpoint** → prywatny dostęp bez Internetu

### Access Control (SQS)  
#### IAM Policy (identity-based)  
- przypisana do usera / roli  
- definiuje:  
- kto może:  
- SendMessage  
- ReceiveMessage  
- DeleteMessage  
👉 używane wewnątrz AWS  
#### Queue Policy (resource-based)  
- przypisana do **SQS queue**  
- definiuje:  
- kto (zewnętrznie) może wysyłać / czytać  
👉 używane dla:  
- SNS → SQS  
- cross-account access  
- inne AWS services  
  
>[!exam]  
>jeśli SQS ma odbierać z SNS → potrzebujesz **Queue Policy**

---
### Typical use cases
- decoupling app tiers
- async processing
- buffering spikes
- background jobs
### Exam traps
- Standard ≠ ordering
- FIFO ≠ nieskończony throughput
- FIFO ordering działa **per Message Group ID**
- wiadomość usuwa się dopiero po successful processing
- jeśli nie zrobisz `DeleteMessage`, wiadomość może wrócić

### TL;DR
- **Standard** → skala
- **FIFO** → kolejność
- **Visibility Timeout** → ochrona przed równoczesnym przetwarzaniem
- **Long Polling** → mniej pustych odczytów
- **IAM + Queue Policy + KMS** → security


![[Pasted image 20260223110148.png]]

**SDK** = Software Development Kit = biblioteka którą instalujesz w kodzie żeby gadać z AWS bez pisania HTTP requestów ręcznie.

![[Pasted image 20260223145209.png]]

![[Pasted image 20260223145420.png]]

SQS to decouple between application tiers
![[Pasted image 20260223145444.png]]

![[Pasted image 20260223214028.png]]


>[!tip]
>**resource-based policy** przypięta do zasobu.
>>
`Queue Policy    → przyczepiasz do SQS kolejki`
`Bucket Policy   → przyczepiasz do S3 bucketa`
`Key Policy      → przyczepiasz do KMS klucza`


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
