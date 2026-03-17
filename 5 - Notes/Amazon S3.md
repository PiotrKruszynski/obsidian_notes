Created: 2026-02-16  11:05
___
Note:

>[! Important]
>- _Amazon Simple Storage Service_ is a key / value store for objects
>- greate for bigger objects, not so great for many small object
>- serverless, scales infinitely, max object size is 5TB, versioning capability
>- **tiers:** _S3 Standard_, _S3 Infrequent Access_, _S3 Intelligent_, _S3 Glacier_ + lifecycle policy
>- **features:** Versioning, Encryption, Replication, MFA-Delete, Access Log ..
>- **security:** [[IAM]], _bucket policies_, _ACL_ (stare), _Access Points_, _Object Lambda_, [[CORS cross-origin resource sharing]], _Object/Vault Lock_
>- **encription:** _SSE-S3_, _SSE-KMS_, _SSE-C_, client-side, [[SSL TLS]] in transit, default encription
>- **batch operations** on objects using _S3 Batch_, -> if u want to copy or encript not encripted S3
>	- batch replication - kopiuj stare dane, ogromne dane przez AWS
>	- można też polecenie `aws s3 sync` -> ty decydujesz, szybkie
>- **listing files** using _S3 Inventory_ -> periodycznie generuje raport  z zawartością bucketu
>- **performance:**
>	- _Multi-part uploads_ -> parallel uploads of files
>	- _S3 Transfer Acceleration_, -> transfer faster, nie działa S3 -> S3 tylko dla klient -> S3
>	- _S3 Select_ -> pozwala wykonać SQL bezpośrednio na obiekcie w S3 i pobrać tylko wybrane dane zamiast całego pliku
>- **automation:** 
>	- S3 Event Notifications:
>		- [[Amazon SNS]], 
>		- [[Amazon SQS]],
>		- [[AWS Lambda]],
>		- [[Amazon EventBridge]]

**Use case:** static files, key value store for big files, website hosting

usecase:
- backup and storage
- disaster recovery
- archive
- hybrid cloud storage
- app hosting
- media hosting
- data lakes & big data analytics
- software delivery
- static website

---
# 📋 1. Core Concepts: Buckets & Objects

• **Buckets:**
    ◦ **Naming** Bucket names must be **globally unique** across all AWS accounts and regions. Must be 3–63 characters, no uppercase, no underscores, and must start with a lowercase letter or number.
    ◦ **Regional Service:** While the namespace is global, buckets are created in a specific **AWS Region**.
![[Pasted image 20260216111457.png]]

• **Objects (Files):**
    ◦ **Key:** The full path (e.g., `s3://my-bucket/folder/file.txt`). There is no true concept of "directories," only long keys with slashes.
    ◦ **Size Limits:** Max object size is **5 TB**. Single uploads are limited to 5 GB; for anything larger, you **must use Multi-part upload**.
    ◦ **Metadata & Tags:** Objects can have system/user metadata (key-value pairs) and up to 10 Unicode tags (useful for security and lifecycle rules).
    
![[Pasted image 20260216111511.png]]

--------------------------------------------------------------------------------

# 💰 2. Storage Classes & Cost Optimization

AWS offers various storage tiers depending on access frequency and cost requirements:

>[!tip]
>**retrieval** - pobranie danych ( odczyt) ze storage
>odczyt obiektu z bucketu

![[Pasted image 20260217115002.png]]

| Storage Class                        | Availability | Characteristics & Use Cases                                                                                                                                                  |                         |
| ------------------------------------ | ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| **S3 Standard**                      | 99.99%       | General purpose; high throughput, low latency; for frequently accessed data. ==big data, mobile, gaming app, content distribution==                                          | netflix                 |
| **S3 Intelligent-Tiering**           | 99.9%        | Automatically moves data between tiers based on usage; **no retrieval fees**.                                                                                                |                         |
| **Standard-IA**. (Infrequent Access) | 99.9%        | for data that is **less frequent accessed**, but requires rapid access; lower storage cost but has a **retrieval fee**; for backups/DR.                                      | backups                 |
| **One Zone-IA** (Infrequent Access)  | 99.5%        | for data that is **less frequent accessed**, but requires rapid access.  Stored in a **single AZ**; 20% cheaper than Standard-IA; data lost if AZ is destroyed. No analytics |                         |
| **S3 Glacier Instant**               | 99.9%        | Millisecond retrieval; for data accessed once a quarter. No analytics                                                                                                        | archiwizacja dokumentów |
| **S3 Glacier Flexible**              | 99.99%       | Retrieval times: Expedited (1-5 min), Standard (3-5 hrs), Bulk ( 5-12 hrs). No analytics                                                                                     |                         |
| **S3 Glacier Deep Archive**          | 99.99%       | Long-term storage (years); retrieval in 12–48 hours; cheapest tier. No analytics                                                                                             |                         |
| **S3 Express One Zone**              | 99.95%       | **Highest performance**; single-digit millisecond latency; for AI/ML and HPC. No analytics                                                                                   |                         |
![[Pasted image 20260217115022.png]]

![[Pasted image 20260217115035.png]]

• **Lifecycle Rules:** Automate the:
- **transition between classes** (e.g., move to Glacier after 60 days) or 
- **expire (delete)**  objects.

![[Pasted image 20260217125401.png]]

![[Pasted image 20260217124612.png]]

• **S3 Analytics:** Provides recommendations on when to transition objects to IA.

![[Pasted image 20260217115111.png]]

jeszcze S2 one zone
![[Pasted image 20260217122500.png]]

---
# 🔒 3. Security and Access Control

## 3.1  **User-Based:** 
**IAM Policies** define which API calls a specific user can make.

## 3.2 Resource-Based:
**[[resource-based policy]]:**
- **Bucket Policies:** JSON-based rules for the entire bucket (often used for public access or cross-account permissions).
polityka w bucket policy jest przypięta do zasobu i może powiedzieć
```JSON
{
  "Effect": "Allow",
  "Principal": {
    "AWS": "arn:aws:iam::123456789012:root"
  },
  "Action": "s3:GetObject",
  "Resource": "arn:aws:s3:::my-bucket/*"
}
```
![[Pasted image 20260316140233.png]]
-  **Access Control Lists (ACLs):** Legacy fine-grained control (can be disabled).
-  **Origin Access Control (OAC):** Used when **CloudFront accesses a private S3 bucket**.
 Why OAC?
-  Keeps bucket **private**
 - Prevents direct S3 URL access
 - Enforces secure CloudFront-only access
 
![[Pasted image 20260225121304.png]]

• **Block Public Access:** Settings used to prevent accidental data leaks; can be applied at the account or bucket level.
• **MFA Delete:** Requires multi-factor authentication to permanently delete a version or suspend versioning.
• **[access points]:** Simplify managing data access for shared datasets by creating unique hostnames for different applications.
- izoluje ruch
- prostsze skalowanie dostępu
- specyficzne zasady dla konkretnego kontekstu
![[Pasted image 20260217235637.png]]

access point - [[VPC origin]]
![[Pasted image 20260217235655.png]]

--------------------
# 🔑 4. Data Encryption

• **Encryption at Rest:**
    ◦ **SSE-S3 (==Default==):** Handled and managed by AWS using AES-256. **You Must set header
    ![[Pasted image 20260217142048.png]]
    ◦ **SSE-KMS:** Uses AWS Key Management Service; provides audit trails and user control. **Must set header**
    nowe **DSSE-KMS is just "double encryption based on KMS".** 
    ![[Pasted image 20260217142100.png]]
    ![[Pasted image 20260217142308.png]]
    ◦ **SSE-C:** Customer manages the keys; AWS handles encryption/decryption. **HTTPS must be used** 
    ![[Pasted image 20260217142403.png]]
    ◦ **Client-Side Encryption:** Customer encrypts data _before_ uploading to S3.
    ![[Pasted image 20260217142438.png]]

• **Encryption in Transit:** Uses **SSL/TLS**. Use bucket policies with `aws:SecureTransport: false` to **deny HTTP** requests.
![[Pasted image 20260217142533.png]]

a jak wymusić encription in transit? DAJĄC **bucket policy** z SecureTransport
![[Pasted image 20260217143357.png]]

--------------------------------------------------------------------------------

# 🔄 5. Durability, Versioning, and Replication

• **Durability:** All storage classes (except One Zone) provide **11 9's (99.999999999%)** durability.
• **Versioning:** Protects against accidental deletes or overwrites by keeping previous versions of an object.

![[Pasted image 20260217122920.png]]

• **Replication:** ! versioning must be enable
- **CRR ([Cross Region Replication]):** For compliance, lower latency, or cross-account needs.
- **SRR:** For log aggregation or live replication between test/prod.
![[Pasted image 20260218130244.png]]


   
![[Pasted image 20260217111907.png]]

![[Pasted image 20260217112139.png]]
--------------------------------------------------------------------------------

# ⚡ 6. Performance & Automation

• **Acceleration:**
    ◦ **Multi-part upload:** Recommended for files > 100MB; parallelizes the upload. Nie działa w locie. 
    ◦ **Transfer Acceleration:** Uses **AWS Edge Locations** to speed up long-distance transfers into S3. Nie dla S3->S3
    ◦ **Byte-Range Fetches:** Parallelizes downloads by requesting specific parts of a file.
• **Event Notifications:** S3 can trigger **Lambda, SQS, or SNS** when objects are created or removed.
• **S3 Batch Operations:** Perform bulk actions (like encrypting or copying) on millions of objects with one request.

multi-part upload -> dla dużych plików
s3 transfer acceleration -> globalna szybkość przesyłu 
![[Pasted image 20260217135055.png]]

![[Pasted image 20260217135108.png]]

byte-range fetches
![[Pasted image 20260217135125.png]]

batch operations
![[Pasted image 20260217135139.png]]




--------------------------------------------------------------------------------

# 💡 Solutions Architect Insights

• **VPC Endpoints:** Use **Gateway Endpoints** (free, route table based) to access S3 from a private VPC without an IGW. Use **Interface Endpoints** for on-premises access via Direct Connect/VPN.
• **Static Website Hosting:** S3 can host static websites (HTML/CSS/JS) with a globally accessible URL.
• **Data Lake:** S3 is the primary choice for data lakes due to its scalability and integration with analytics tools like **Athena**.
• **Storage Lens:** Use this for organization-wide visibility into storage usage, cost-optimization, and data protection metrics.
• **Object Lock:** Implements **WORM** (Write Once Read Many) to prevent deletion/overwrite for a specified period for compliance.

requester pays
![[Pasted image 20260217130735.png]]

![[Pasted image 20260217152355.png]]

![[Pasted image 20260217152405.png]]

S3 object lambda
![[Pasted image 20260217235801.png]]


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
