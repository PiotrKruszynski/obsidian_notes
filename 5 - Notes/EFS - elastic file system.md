Created: 2026-02-03  13:10
___
Note:

	highly available, scalable, expensive (3x more then gp2 volume), pay per use


- managed NFS ( network file system) -> folder sieciowy w AWS
- can be mounted on many EC2
- works with EC2 instances in multi-AZ

![[Pasted image 20260206111051.png]]

### Use cases:
- content management, web services, data sharing, wordpress
- uses **NFSv4.1 protocol
- use **security group** to control acces to EFS
- **compatible with Linux based AMI ( not Windows)
- encryption at rest using KMS
- scale automatically

---
# Performance & Storage classes

- scale automatically
## Performance Mode:
- **General Purpose (default)**
	- niskie opóźnienia
	- najlepsze dla aplikacji webowych
	- ograniczona skala równoległości
	- Django / Flask / CMS / shared uploads
- **Max I/O
- bardzo duża liczba klientów
- wyższe latency
- lepsze dla batch / analytics
- big data / HPC /  ML pipelines

## Throughput Mode

Określa **ile MB/s** filesystem może dostarczyć.
### Bursting (default)
- throughput zależny od rozmiaru danych
- mały FS → niski throughput
- duży FS → wysoki throughput
- używa burst credits
### Provisioned
- stały throughput (MB/s)
- niezależny od rozmiaru FS
- dodatkowy koszt
Use-case:
- mało danych, ale intensywne I/O
### Elastic
- automatyczne skalowanie throughput
- brak burst credits
- płacisz za użycie
Rekomendowane w nowych projektach.

## **Storage Classes (Tiers)**

Lifecycle management feature - move file after N days


### Multi-AZ (High Availability)

- **EFS Standard** – często używane dane
- **EFS Infrequent Access (IA)** – rzadko używane dane
	- tańsze GB
	- opłata za odczyt
### Single-AZ (One Zone)

- **EFS One Zone**
- **EFS One Zone–IA**
	- niższy koszt
	- brak odporności na awarię AZ

---

## **6. Lifecycle Management**

EFS może automatycznie przenosić **pliki** między storage classes:
- Standard → IA
- One Zone → One Zone–IA
  
Po czasie braku dostępu:
- 7 / 14 / 30 / 60 / 90 dni

  
Ważne:
- dotyczy **plików**, nie całego filesystemu
- mount point zawsze ten sam
- to move implement **livecycle policies**

---
## **Security**

### **Szyfrowanie**

- at rest: AES-256 (KMS)
- in transit: TLS

### **Dostęp**

- Security Groups (na mount targetach)
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

![[Pasted image 20260204143122.png]]






___
Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```
[[EBS Volume]]
Status: #pending
Tags: #aws
