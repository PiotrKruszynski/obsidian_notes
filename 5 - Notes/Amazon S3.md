
Created: 2026-02-16 11:05

istnieją block storage / file storage / object storage

>[!important]
>**Amazon S3 = object storage**
>- przechowuje dane jako **objects** w **buckets**
>- bucket = kontener, object = dane + metadata + key
>- **max object size = 5 TB**
>- praktycznie nieograniczona skala
>- świetne dla: static files, backup, archive, data lake, media, DR, static website
>- **nie jest file systemem** i nie jest block storage
>- strong read-after-write consistency

>S3 automatycznie skaluje wydajność per prefix — min. ok. 3,500 zapisów/s i 5,500 odczytów/s na prefix — więc przy dużym ruchu najprościej i najtaniej rozproszyć obiekty w jednym bucketcie po wielu prefixach, np. per customer/date/hash.
# 1. Mental model / feature map
### Cost / storage classes
- **S3 Standard**  
    → hot data, low latency, high durability, frequent access
- **S3 Intelligent-Tiering**  
    → auto tiering, unknown access pattern, cost optimized
- **S3 Standard-IA**  
    → infrequent access, cheap storage, retrieval cost, 30 days min
- **S3 One Zone-IA**  
    → 1 AZ only, cheaper, no HA, infrequent access
- **S3 Glacier Instant Retrieval**  
    → archive + ms access, rare but instant, higher storage
- **S3 Glacier Flexible Retrieval**  
    → archive, minutes–hours retrieval, cheaper
- **S3 Glacier Deep Archive**  
    → cheapest, hours retrieval (12h), long-term archive
- **S3 Express One Zone**  
    → ultra low latency, high throughput, single AZ, real-time
### Security
- **IAM policies**
- **Bucket policies**
- **ACL** (legacy)
- **Block Public Access**
- **Access Points**
- **Object Lock**
- **Encryption at rest + in transit**
### Data protection
- **Versioning**
- **Replication (CRR / SRR / Batch Replication)**
- **Multi-Region Access Points**
- **AWS Backup**
### Performance / transfer
- **Multipart Upload**
- **Byte-Range Fetches**
- **Transfer Acceleration**
### Automation / processing
- **Event Notifications**
- **EventBridge**
- **S3 Batch Operations**
- **S3 Inventory**
- **S3 Object Lambda**
- **S3 Select**
# 2. Core facts
- bucket names są **globally unique**
- bucket tworzysz w konkretnym **Region**
- obiekt identyfikuje **key**
- "foldery" w S3 to tylko **prefixes** _prefixy rozpraszają request load_
- obiekt = **data + metadata + tags**
- metadata user-defined po uploadzie nie edytujesz bezpośrednio → zwykle **copy object z nową metadata**

>[!tip]
>Myśl o S3 jak o:
>- ogromnym **key-value store dla obiektów**
>- gdzie key = pełna ścieżka logiczna
>- ale bez prawdziwej hierarchii katalogów
# 3. Bucket types
## General purpose bucket
- domyślny i najczęstszy typ
- do prawie wszystkich use case’ów
- obsługuje prawie wszystkie storage classes
## Directory bucket
- używany z **S3 Express One Zone**
- pod bardzo niską latencję i wysoką wydajność
- **single AZ**
## Table bucket
- pod analitykę i dane tabelaryczne
- powiązany z **S3 Tables**
- bardziej niszowy niż klasyczny bucket

---
# 4. Storage classes — co wybrać

>**retrieval** - pobranie danych ( odczyt) ze storage
>odczyt obiektu z bucketu
## S3 Standard
- hot data
- niski latency, wysoka dostępność
- najczęstszy default
S3 Standard
## S3 Intelligent-Tiering
- gdy nie znasz patternu dostępu
- automatycznie przenosi dane między tierami
## Standard-IA 
- infrequent access
- dane rzadziej używane, ale potrzebny szybki dostęp
- tańszy storage, ale opłata za retrieval
## One Zone-IA
- jak IA, ale w **jednej AZ**
- tańszy, ale mniejsza odporność
## Glacier Instant Retrieval
- archive, ale dostęp w milisekundach
## Glacier Flexible Retrieval
- archive z wolniejszym retrieval
	- expedited(1-5min)
	- standard(3-5h)
	- bulk(5-12)
## Glacier Deep Archive
- najtańszy, bardzo wolny retrieval (12-48h)
## S3 Express One Zone
- najwyższa wydajność
- single-digit millisecond latency
- **single AZ**

# podsumowanie:

>[!exam]
>- **unknown access pattern** → Intelligent-Tiering
>- **rare access but fast retrieval** → Standard-IA
>- **archive** → Glacier
>- **ultra low latency** → Express One Zone

---
# 5. Upload / download / integrity

## Upload
- wymaga uprawnień do zapisu
- jeśli **versioning ON** i wrzucisz ten sam key → nowa wersja
- nowe obiekty są domyślnie szyfrowane **SSE-S3**
## Multipart Upload
- recommended **>= 100 MB**, require **> 5GB**
- plik dzielisz na części
- części można wysyłać równolegle
- retry tylko nieudanego parta
- proces:
	  1. initiate
	  2. upload parts
	  3. complete
- jeśli nie kończysz upload → warto **abort**, bo części kosztują

## Checksums / integrity
S3 wspiera checksumy do walidacji integralności
- single upload → ETag = MD5
- przy multipart ❌ nie gwarantuje MD5

## Byte-Range Fetches
- pobierasz tylko fragment obiektu
- dobre do równoległego downloadu dużych plików

---
# 6. Security / access control

## IAM
- user-based permissions
- kontrola kto może zrobić `GetObject`, `PutObject`, itd.
## Bucket Policy
- resource-based
- bardzo częste w cross-account i public/private access
## ACL
- legacy Access Control List
- egzaminowo: **prefer IAM + Bucket Policy**
## Block Public Access
- ochrona przed przypadkowym upublicznieniem
## Access Points
- osobne endpointy i polityki dostępu do jednego bucketu
- dobre dla wielu aplikacji / zespołów / data lake
## Object Lambda
- modyfikuje wynik **GET / HEAD / LIST** przez Lambda
- np. redakcja danych, resize obrazów, custom view
## Presigned URL
- tymczasowy dostęp do GET/PUT bez nadawania userowi AWS credentials
- upload przez presigned URL może nadpisać istniejący obiekt z tym samym key

---
# 7. Encryption

## At rest
- **SSE-S3** — default
- **SSE-KMS** — więcej kontroli, audit, KMS permissions
- **DSSE-KMS** — podwójna warstwa szyfrowania
- **SSE-C** — klucz dostarcza klient
- **Client-side encryption** — szyfrujesz przed wysłaniem do S3
## In transit
- **SSL/TLS**
- wymuszanie HTTPS zwykle przez bucket policy z warunkiem `aws:SecureTransport`

>[!exam]
>- default encryption now = **SSE-S3**
>- jeśli chcesz audit / key control / cross-service KMS → **SSE-KMS**
>- SSE-KMS może generować dużo requestów do KMS → pomagają **S3 Bucket Keys**

---
# 8. Versioning / deletion / immutability

## Versioning
- chroni przed accidental overwrite i accidental delete
- delete zwykle dodaje **delete marker**
- po włączeniu bucket nie wraca do truly unversioned; można tylko **suspend**
## MFA Delete
- dodatkowa ochrona przed usunięciem wersji lub zmianą versioning state
- temat bardziej egzaminowy niż praktyczny
## Block Public Access
- Settings used to prevent accidental data leaks; can be applied at the account or bucket level.
## Origin Access Control (OAC): 
- Used when **CloudFront accesses a private S3 bucket**.
- keep buckets **private**
- enforce secure CloudFront only access
## Object Lock
- model **WORM**
- działa na **object version (nie bucket!)**
- wymaga **versioning**
### Retention (klucz do egzaminu)
- można ustawić:
    - **Retain Until Date** (explicit na object version)
    - **retention period** (np. 30 dni — bucket default)
- **bucket default** działa tylko gdy brak explicit na obiekcie
- **explicit retention > bucket default**
### Version behavior
- każda **wersja obiektu ma własny retention**
- różne wersje → różne retention / mode
### Tryby
- **Governance**
- **Compliance** /zgodność/
### Legal Hold
- niezależne od retention (blokuje delete bez daty końcowej)

> [!exam]
> 
> - compliance = nawet root nie może usunąć przed końcem retention
> - governance = można obejść (z odpowiednimi uprawnieniami)
> - **default = period, explicit = Retain Until Date**
> - **Object Lock działa per version (nie per object)**
---
# 9. Replication / DR

## Live replication
- automatyczna, asynchroniczna
- dla nowych / zmienionych obiektów
## CRR
- **Cross-Region Replication**
- compliance, niższa latencja dla innych regionów, DR
## SRR
- **Same-Region Replication**
- np. log aggregation, kopiowanie między kontami w tym samym regionie
## Batch Replication
- do istniejących obiektów
- on-demand
## Multi-Region Access Points
- global endpoint dla wielu bucketów w różnych regionach
- ruch idzie do najbliższego aktywnego regionu
- przydatne w multi-region apps i failover

>[!exam]
>- live replication nie służy do kopiowania historycznych danych
>- do starych obiektów → **Batch Replication**
>- replication jest **asynchroniczna**

---
# 10. Automation / analytics / operations

## Event Notifications
- zdarzenia do:
  - [[Amazon SQS]]
  - [[Amazon SNS]]
  - [[AWS Lambda]]
- model dostarczenia: **at least once**
- możliwe duplikaty i out-of-order events

![[Pasted image 20260217133035.png]]
## EventBridge
- alternatywna integracja eventowa dla szerszych scenariuszy routingu

![[Pasted image 20260217133731.png]]

## S3 Batch Operations
- masowe operacje na dużej liczbie obiektów
- np. copy, tagging, restore, invoke Lambda
- bazuje na **manifest**
## S3 Inventory
- periodyczny raport o obiektach
- lepsze do audytu niż ręczne listowanie przez List API
## S3 Select
- pobierasz tylko część danych z jednego obiektu
- SQL-like query na obiekcie
## S3 Object Lambda
- transformacja odpowiedzi przy odczycie

---
# 11. Performance

- S3 skaluje się automatycznie
- można robić bardzo dużo requestów na sekundę
- dla lepszej wydajności:
  - wiele równoległych połączeń
  - multipart upload
  - byte-range fetches
  - EC2 i S3 w tym samym Region
  - retry i timeout tuning
  - **Transfer Acceleration** dla klientów daleko geograficznie
## Transfer Acceleration
- przyspiesza upload/download klient ↔ S3 przez edge locations
- dobre dla globalnych uploadów
- **nie do S3→S3 copy**
### CLI / data transfer
- `aws s3 sync` = diff + copy , kopiuje tylko zmienione,
- działa rekurencyjnie (foldery)
- wspiera:  
	- local → S3  
	- S3 → local  
	- S3 → S3  
- używa parallelizacji → szybkie transfery

>[!exam]  
>- szybka migracja danych → `aws s3 sync`  
>- S3 → S3 copy (cross-region) → często `sync` lub replication

---
# 12. Static website / data lake / VPC

## Static website hosting
- S3 może hostować statyczną stronę
- typowo dla HTML/CSS/JS
- w praktyce często z **CloudFront**
- bez CloudFront klasyczny website endpoint ma ograniczenia bezpieczeństwa i HTTPS
## Data Lake
- S3 to podstawowy storage dla data lake
- integruje się z:
  - Athena
  - Glue
  - EMR
  - Redshift
## Private access from VPC
- do prywatnego dostępu do S3 z VPC zwykle:
  - **Gateway Endpoint for S3**

---
# 13. SAA traps

- S3 **nie jest file systemem**
- foldery w S3 **nie istnieją naprawdę**
- multipart upload → **recommended od ~100 MB**
- versioning chroni przed overwrite/delete, ale nie zastępuje backupu/compliance
- replication jest **asynchroniczna**
- stare dane → **Batch Replication**, nie zwykłe CRR/SRR
- Event Notifications = **at least once**, brak gwarancji kolejności
- ETag przy multipart **!= zawsze MD5**
- default encryption = **SSE-S3**
- **Access Points** = osobny "entrypoint + policy" do jednego bucketu
- **Object Lock** wymaga versioning


>[!tip]
>**resource-based policy** przypięta do zasobu.
>>```
Queue Policy    → przyczepiasz do SQS kolejki
Bucket Policy   → przyczepiasz do S3 bucketa
Key Policy      → przyczepiasz do KMS klucza

```

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
