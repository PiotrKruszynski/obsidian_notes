---
title: "SSL TLS"
type: concept
topic: networking
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-02-05  16:37
___
Note:

## 1️⃣ Czym jest SSL/TLS  
  
SSL (Secure Sockets Layer) oraz jego nowsza wersja TLS (Transport Layer Security) to protokoły kryptograficzne służące do szyfrowania komunikacji w sieci.  
  
Obecnie używa się terminu **TLS**, choć potocznie nadal mówi się "SSL".  
  
Cel:  
- Poufność (confidentiality)  
- Integralność (integrity)  
- Uwierzytelnienie (authentication)  
  
---  
  
## 2️⃣ Co chroni SSL/TLS  
  
Szyfruje dane przesyłane:  
- między przeglądarką a serwerem (HTTPS)  
- między aplikacją a bazą danych  
- między mikroserwisami  
- między klientem a load balancerem  
  
---  
  
## 3️⃣ Jak działa TLS – uproszczony przebieg  
  
### 🔐 TLS Handshake  
  
1. Client Hello  
- wersja TLS  
- lista obsługiwanych algorytmów  
  
2. Server Hello  
- wybór algorytmu  
- przesłanie certyfikatu  
  
3. Weryfikacja certyfikatu  
- czy certyfikat jest ważny  
- czy podpisany przez zaufane CA  
  
4. Wymiana klucza  
- ustanowienie klucza symetrycznego  
  
5. Secure Channel  
- dalsza komunikacja szyfrowana kluczem symetrycznym  
  
Po handshake cała transmisja jest szyfrowana.  
  
---  
  
## 4️⃣ Certyfikat SSL/TLS  
  
Certyfikat zawiera:  
- public key  
- dane właściciela  
- podpis urzędu certyfikacji (CA)  
- okres ważności  
  
Certyfikat umożliwia:  
- szyfrowanie  
- potwierdzenie tożsamości serwera  
  
---  
  
# SSL/TLS w AWS  
  
## 🔹 AWS Certificate Manager (ACM)  
  
Zarządzanie certyfikatami:  
- darmowe certyfikaty publiczne  
- automatyczne odnawianie  
- integracja z:  
- Application Load Balancer  
- CloudFront  
- API Gateway  
  
---  
  
## 🔹 RDS – Encryption in transit  
  
RDS obsługuje TLS dla:  
- MySQL  
- PostgreSQL  
- SQL Server  
- Oracle  
  
Połączenie wymaga:  
- użycia SSL mode w kliencie  
- opcjonalnie certyfikatu CA AWS  
  
---  
  
## 🔹 ELB / ALB  
  
Load Balancer:  
- terminacja TLS (SSL termination)  
- odciążenie backendu z kryptografii  
- możliwość re-encryption do backendu  
  
---  
  
## 🔹 Encryption at rest vs in transit  
  
| Typ | Co oznacza |  
|------|------------|  
| At rest | Dane szyfrowane na dysku (EBS, S3, RDS) |  
| In transit | Dane szyfrowane podczas przesyłania (TLS) |  
  
---  
  
# Kluczowe pojęcia  
  
- Public key cryptography (asymetryczna)  
- Symmetric encryption  
- Certificate Authority (CA)  
- Handshake  
- HTTPS  
- Perfect Forward Secrecy (PFS)  
  
---  
  
# Architektonicznie  
  
Internet → HTTPS (TLS) → Load Balancer → (TLS lub HTTP) → Backend  
  
W środowisku produkcyjnym zaleca się:  
- wymuszanie HTTPS  
- TLS 1.2+  
- automatyczne odnawianie certyfikatów  
- rotację kluczy





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
