Created: 2026-02-03  13:10
___
Note:

	highly available, scalable, expensive (3x more then gp2 volume), pay per use
# managed NFS ( network file system) that can be mounted on many EC2
# works with EC2 instances in multi-AZ

### Use cases:
- content management, web services, data sharing, wordpress
- uses NFSv4.1 protocol
- use security group to control acces to EFS
- **compatible with Linux based AMI ( not Windows)
- encryption at rest using KMS
- scale automatically


Amazon **Elastic File System (EFS)** to w pełni zarządzany, **sieciowy system plików (NFS)** dla instancji EC2 (Linux), umożliwiający **współdzielony dostęp** wielu maszyn do jednego filesystemu.

> **EFS = folder sieciowy w AWS dla Linuxa**

---

## **2. Architektura**

- jeden **filesystem** w regionie
- **Mount Targets** w każdej AZ
- EC2 łączy się z najbliższym mount targetem
- dostęp przez **NFSv4.1**

EFS nie replikuje danych między regionami.

---
# 3. Performance Mode

Określa **latency i skalę równoległości**.

### **General Purpose (default)**
- niskie opóźnienia
- najlepsze dla aplikacji webowych
- ograniczona skala równoległości
  
Use-case
- Django / Flask
- CMS
- shared uploads
# Max I/O

- bardzo duża liczba klientów
- wyższe latency
- lepsze dla batch / analytics

Use-case:
- big data
- HPC
- ML pipelines

## **4. Throughput Mode**

Określa **ile MB/s** filesystem może dostarczyć.

### **Bursting (default)**
- throughput zależny od rozmiaru danych
- mały FS → niski throughput
- duży FS → wysoki throughput
- używa burst credits

### **Provisioned**
- stały throughput (MB/s)
- niezależny od rozmiaru FS
- dodatkowy koszt

Use-case:
- mało danych, ale intensywne I/O

  
### **Elastic**
- automatyczne skalowanie throughput
- brak burst credits
- płacisz za użycie

  
Rekomendowane w nowych projektach.

---

## **5. Storage Classes (Tiers)**

Klasy storage dotyczą **kosztu i dostępności**, nie performance.
### **Multi-AZ (High Availability)**

- **EFS Standard** – często używane dane
- **EFS Infrequent Access (IA)** – rzadko używane dane

Cechy IA:
- tańsze GB
- opłata za odczyt

### **Single-AZ (One Zone)**

- **EFS One Zone**
- **EFS One Zone–IA**
  

Cechy:
- niższy koszt
- brak odporności na awarię AZ

---

## **6. Lifecycle Management**

EFS może automatycznie przenosić **pliki** między klasami:
- Standard → IA
- One Zone → One Zone–IA

  
Po czasie braku dostępu:
- 7 / 14 / 30 / 60 / 90 dni

  
Ważne:
- dotyczy **plików**, nie całego filesystemu
- mount point zawsze ten sam

---

## **7. Security**

### **Szyfrowanie**

- at rest: AES-256 (KMS)
- in transit: TLS


### **Dostęp**

- Security Groups (na mount targetach
- IAM (kontrola API)
- POSIX permissions (filesystem)

---

## **8. EFS vs EBS vs S3**

|**Cecha**|**EFS**|**EBS**|**S3**|
|---|---|---|---|
|Typ|File|Block|Object|
|Multi-EC2|Tak|Nie*|Tak|
|AZ|Multi|Single|Regional|
|Mount jako FS|Tak|Tak|Nie|
|Auto-scaling|Tak|Nie|Tak|

- wyjątek: EBS Multi-Attach (io1/io2)
    

---

## **9. Typowe use-case**

- współdzielone media aplikacji
- katalogi domowe użytkowników
- EKS / ECS storage
- raporty, logi, pliki robocze

  
Nie używać do:
- baz danych o bardzo niskim latency
- workloadów typowo block-level

---

## **10. Egzaminowe pułapki**

- Performance mode ≠ throughput mode
- Storage tier ≠ performance
- IA ≠ wolne (latency podobne)
- EFS ≠ Windows (Windows → FSx)

---

## **11. Jednozdaniowa definicja**

  
> **Amazon EFS to regionalny, zarządzany system plików NFS, umożliwiający współdzielony dostęp wielu instancji EC2 z automatycznym skalowaniem, różnymi trybami wydajności i klasami storage.**

---

## **12. Szybka mapa pamięciowa**

- folder współdzielony → EFS
- wiele EC2 → EFS
- niskie latency → General Purpose
- dużo klientów → Max I/O
- zmienny ruch → Elastic Throughput
- oszczędności → IA + Lifecycle


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
