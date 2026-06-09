---
title: "AWS Transfer Family"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-03-18  21:58
___
Note:

>[!important]
>- Transfer Family = usługa **managed file transfer in/out of S3 or EFS using FTP protocol**
>- obsługuje: **SFTP / FTPS / FTP**
>- backend: **S3 lub EFS**
>- używany gdy musisz obsłużyć **legacy protokoły transferu plików**

### Mental model
Transfer Family = **“FTP/SFTP endpoint w AWS”**

👉 klient (np. partner, system legacy):
- łączy się przez SFTP / FTP
👉 w tle:
- pliki trafiają do **S3 lub EFS**
### Co daje
- brak potrzeby stawiania własnego serwera FTP
- integracja z:
  - IAM
  - CloudWatch
- managed service → brak ops

---
### Backend storage
**S3**
  - scalable, cheap
  - data lake, ingestion
**EFS**
  - file system
  - low latency access

>[!exam]
>SFTP + S3 → Transfer Family

---
### Kiedy używać
masz partnerów używających:
  - SFTP / FTP / FTPS
migracja z legacy FTP serverów
- secure file exchange

---

### Trade-offs
- droższe niż zwykłe S3 upload
- dodatkowa warstwa (endpoint)
- tylko dla konkretnych protokołów

---

### Exam traps
- Transfer Family ≠ Storage Gateway  
  - Storege Gateway → hybrid storage  
  - Transfer Family → file transfer protocols  

- SFTP do S3 → **Transfer Family**, nie EC2 FTP  
- upload przez API → użyj **S3 PUT**, nie Transfer  

---
### TL;DR
- FTP/SFTP do AWS → Transfer Family  
- backend → S3 lub EFS  
- legacy integration → główny use case  

|Metoda|Protokół/Mechanizm|Use Case|Zalety|Ograniczenia|
|---|---|---|---|---|
|S3 PUT/CLI/API|HTTPS (REST API)|Typowe operacje na S3 (upload pojedynczych plików)|Proste, natywne dla S3|Brak optymalizacji dla dużych transferów|
|AWS DataSync|NFS, SMB, HDFS|Migracja i ciągła synchronizacja danych|Automatyzacja, weryfikacja, duże zbiory|Wymaga agenta on-premises, koszt|
|AWS Transfer Family|SFTP, FTPS, FTP|Integracja z tradycyjnymi systemami|Bezpieczny, zarządzany transfer|Ograniczony do obsługiwanych protokołów|
|AWS Snowball/ Snowmobile|Fizyczne urządzenia (offline)|Transfer petabajtów danych (np. migracja)|Duże wolumeny, offline|Fizyczny transport, dłuższy lead time|
|aws s3 sync (CLI)|HTTPS (CLI narzędzie)|Rekurencyjny sync folderów do/z S3|Proste i szybkie w CLI|Tylko do S3, brak zaawansowanej orkiestracji|

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
