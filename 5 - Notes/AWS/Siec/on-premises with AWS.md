---
title: "on-premises with AWS"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-13
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!tip]
>Strategia **On-Premises + AWS** polega na integracji infrastruktury lokalnej z chmurą AWS.  
Najczęściej stosuje się ją przy **migracji do chmury**, **architekturze hybrydowej** lub **disaster recovery**.

# Szybka tabela 
  
| Service                                 | Do czego służy         | Co migruje         | Typowy use case     |              |
| --------------------------------------- | ---------------------- | ------------------ | ------------------- | ------------ |
| **Application Discovery Service**       | analiza infrastruktury | metadane serwerów  | planowanie migracji |              |
| **VM Import / Export**                  | przenoszenie VM        | pojedyncze maszyny | lift-and-shift      |              |
| **Application Migration Service (MGN)** | migracja aplikacji     | całe serwery       | rehosting           | zastąpił SMS |
| **Database Migration Service (DMS)**    | migracja baz danych    | bazy danych        | minimal downtime    |              |
  
---
# 1. Amazon Linux 2 jako VM on-premises  
  
Można pobrać **Amazon Linux 2 w formacie ISO** i uruchomić lokalnie jako maszynę wirtualną.  
  
Obsługiwane hypervisory:  
- VMware  
- KVM  
- VirtualBox (Oracle VM)  
- Microsoft Hyper-V  
### Dlaczego to się robi  
Pozwala utrzymać **spójne środowisko systemowe** między:  
- on-premises  
- AWS EC2  
Dzięki temu:  
- te same skrypty  
- te same biblioteki  
- ten sam kernel Linux  
działają w obu środowiskach.  
### Ograniczenia  
Nie działają integracje specyficzne dla AWS:  
- EC2 metadata service  
- IAM roles  
- AWS managed networking  
  
---  
  
# 2. VM Import / Export  
  
Usługa umożliwia **przenoszenie maszyn wirtualnych między on-premises a AWS**.  
  
### Funkcje  
- migracja istniejących VM do **EC2**  
- tworzenie strategii **Disaster Recovery**  
- eksport VM z **EC2 z powrotem do on-premises**  
### Typowy workflow 
On-prem VM  
↓  
Upload image (VMDK/VHD)  
↓  
Import do AWS  
↓  
EC2 instance

  
### Kiedy używać  
- lift-and-shift migracja  
- DR backup środowiska  
  
---  
  
# 3. AWS Application Discovery Service  
  
Usługa służy do **analizy infrastruktury on-premises przed migracją**.  
### Co zbiera  
- informacje o serwerach  
- wykorzystanie CPU / RAM  
- ruch sieciowy  
- zależności między aplikacjami  
### Dlaczego to ważne  
Migracja bez analizy często prowadzi do problemów:  
- nieznane zależności aplikacji  
- błędny sizing instancji  
- błędna architektura w AWS  
### Integracja  
Dane trafiają do:  
**AWS Migration Hub**  
który centralizuje status migracji.  
  
---  
  
# 4. AWS Database Migration Service (DMS)  
Usługa do **migracji i replikacji baz danych**.  
### Obsługiwane scenariusze  
On-prem DB → AWS  
AWS → AWS  
AWS → On-prem
### Cechy  
- minimalny downtime  
- continuous replication  
- migracja heterogeniczna  
  
### Obsługiwane bazy    
- Oracle  
- MySQL  
- PostgreSQL  
- SQL Server  
- MariaDB  
- DynamoDB  
- Aurora    
# 5. AWS Server Migration Service (SMS)  
  
Usługa migracji **całych serwerów** do AWS.  
### Mechanizm  
- incremental replication  
- synchronizacja zmian  
- tworzenie obrazów EC2  
### Kluczowa cecha  
  
Replikacja działa **inkrementalnie**, więc:  
  
- minimalizuje downtime  
- umożliwia testy migracji  
  
---  
  
# Jak to wszystko się łączy  
  
Typowy pipeline migracji wygląda tak:  

1️⃣ Discovery  
AWS Application Discovery Service

2️⃣ Migracja aplikacji  
AWS Server Migration Service / VM Import

3️⃣ Migracja baz danych  
AWS DMS

4️⃣ Zarządzanie migracją  
AWS Migration Hub
  
---  
  
# Kiedy używa się strategii hybrid  
  
Najczęstsze powody:  
- compliance / regulacje  
- legacy systems  
- niskie opóźnienia lokalne  
- stopniowa migracja do chmury  
  
---  
  
# Najważniejszy insight architektoniczny  
  
AWS nie zakłada natychmiastowego przeniesienia wszystkiego do chmury.  
  
Dlatego istnieją narzędzia do:  
  
- **analizy infrastruktury**  
- **migracji VM**  
- **replikacji baz danych**  
- **utrzymania środowiska hybrydowego**  
  
To pozwala migrować systemy **stopniowo**, a nie w jednym ryzykownym kroku.
