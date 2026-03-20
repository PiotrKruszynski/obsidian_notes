Created: 2026-03-10  13:13
___
Note:

> [!important]
> 
> - **DMS = migracja baz danych z minimal downtime**
>     
> - robi **full load + CDC**
>     
> - **nie konwertuje schematu** → to robi **SCT**
>     
> - exam rule: **DB migration with minimal downtime → DMS**
>     
### Mental model
DMS kopiuje dane ze source do target, a potem dalej replikuje zmiany z logów transakcyjnych.
### Core facts
- use case: **database migration / replication**
- działa dla:
    - on-prem → AWS
    - AWS → AWS
    - DB → S3 / Redshift / DynamoDB
- typowy task:
    - **full load**
    - **full load + CDC**
    - **CDC only**

### DMS vs inne
- **DMS** → dane z bazy
- **SCT** → schema conversion
- **DataSync** → pliki, NFS, EFS
- **Glue** → ETL, nie migracja

### Exam traps

> [!exam]
> 
> - **different DB engines** → często **SCT + DMS**
>     
> - **same engine** → zwykle samo **DMS**
>     
> - DMS nie służy do transferu plików
>     
> - jak widzisz **minimal downtime DB migration**, to zwykle odpowiedź to **DMS**
>     

### TL;DR

- **DMS = baza danych, nie pliki**
- **minimal downtime** to główny trigger
- **CDC** to najważniejszy feature
- **schema conversion = nie DMS, tylko SCT**



![[Pasted image 20260310131434.png]]


![[Pasted image 20260310131451.png]]

# AWS Schema Conversion Tool
jak db source u target nie maja tego samego silnika
najlepiej jak mamy serwer aws sct installed u siebie (on-premises)
odpowiada za strukture i logikę

**SCT = structure + logic**  
**DMS = data movement**

![[Pasted image 20260310132036.png]]

![[Pasted image 20260310132047.png]]




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
