---
title: "AWS DataSync"
type: service
topic: aws
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-03-18  22:02
___
Note:


>[!important]
>- DataSync = **automatyczny, szybki transfer danych (on-prem ↔ AWS / AWS ↔ AWS)**
>- obsługuje: **NFS, SMB, object storage**
>- przenosi dane do: **S3, EFS, FSx**
>- zoptymalizowany pod **duże migracje i sync**
>- automatyzuje: copy + verify + retry
>- nie jest continous jak streaming, ustawiasz jednorazowy / lub schedule

### Mental model
DataSync = **managed rsync + parallel transfer + integrity check**

👉 zamiast:
- pisać skrypty (`aws s3 sync`)
- ręcznie retry
masz:
- service, który robi to za Ciebie
### Co robi
kopiuje dane:
  - on-prem → AWS  
  - AWS → AWS  
automatycznie:
  - parallel transfer
  - compression
  - encryption in transit
  - checksum validation
### Obsługiwane źródła
- NFS  
- S3  
- FSx  
- EFS  
### Targets (najważniejsze)
- **S3**
- **EFS**
- **FSx**

>[!exam]
>duża migracja danych → DataSync
### Kiedy używać
- migracja TB/PB danych
- synchronizacja datasetów
- backup / archiwizacja
- data lake ingestion

---
### DataSync vs aws s3 sync

| Feature | DataSync | aws s3 sync |
|--------|---------|-------------|
| managed | ✅ | ❌ |
| retry / validation | ✅ | ❌ |
| performance | bardzo wysoka | średnia |
| automation | scheduler | ręcznie |
| on-prem support | ✅ | ograniczone |

👉 decyzja:
- małe rzeczy → `aws s3 sync`
- duże / production → **DataSync**
### Trade-offs
- koszt (service)
- setup (agent on-prem)
- overkill dla małych transferów
### Exam traps
- DataSync ≠ Storage Gateway  
  - Gateway → dostęp do storage  
  - DataSync → transfer danych  

- migracja danych → **DataSync**, nie Snowball (chyba że offline)  
- ciągła synchronizacja → DataSync (z schedule)

### TL;DR

- duże transfery danych → DataSync  
- on-prem ↔ AWS → DataSync  
- szybkie, bezpieczne, automatyczne  
- przy przenoszeniu/kopiowaniu zachowujesz prawa POSIX, tak jak na lokalnym Linux

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
