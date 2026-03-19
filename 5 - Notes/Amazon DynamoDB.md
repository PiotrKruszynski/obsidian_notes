Created: 2026-02-24  16:38
___
Note:
>[! Important]
>- AWS native technology
>- data type: _key-value_ and _document_, ma możliwość _transakcji_
>- managed _serverless NoSQL_ database, _milisecond_ latency
>- odczyt zużywa RCU, zapis zużywa WCU
>- capacity (througnput) mode: 
>	- **provisioned capacity** with _auto scaling_ option
>	- **on-demand_ capacity**
>- can replace [[Amazon ElastiCache]] as a key-value store (storing session data using _TTL_ feature)
>- _Highly Available_ , _Multi AZ_ by default, Read and Writes are decupled
>- transaction capability
>- **DAX** key-value cluster for read cache, _microsecond_ read latency
>- security, authentication and authorization is done throuht [[IAM]]
>- event processing: _DynamDB Stream_ to integrate with [[AWS Lambda]], or [[Kinesis Data Streams]]
>- _Global Table_ feature: active-active setup
>- auto backups:  _PITR_ window (up to 35 day), on-demand backups 
>- można masowo przenosić dane do S3 bez zużywania jednostek RCU/WCU
>- **greate to rapidly evolve schemas**
>- max _item_ size 400 KB

**Use case:** serverless applications development (small docks 100s KB), distributed serverless cache, **greate for rapidly evolve schemas**


---

## Model danych

DynamoDB to baza klucz-wartość + zagnieżdżenia (jak dokumentowe db). 

[Tabela] to zbiór itemów. Nie ma relacji między tabelami (NoSQL).

### Item
Odpowiednik wiersza w SQL. Max 400 KB. Może zawierać zagnieżdżone atrybuty (JSON-like).

### Atrybut
Odpowiednik kolumny. Typy: String, Number, Binary, Boolean, Null, List, Map, Set.

### Primary Key — 2 opcje:
**Partition Key (Hash Key)** — jeden atrybut, musi być unikalny:

```
UserID (PK)  |  Name   |  Email
user_001     |  Anna   |  anna@x.com
user_002     |  Marek  |  marek@x.com
```

**Partition Key + Sort Key (Composite Key)** — kombinacja musi być unikalna:

```
UserID (PK)  |  OrderDate (SK)  |  Amount
user_001     |  2024-01-15      |  150
user_001     |  2024-02-20      |  300
user_002     |  2024-01-10      |  90
```

Dobry partition key = wysoka kardynalność = równomierny rozkład danych.

---

## Capacity Modes

### On-Demand

- automatyczne skalowanie bez konfiguracji
- płacisz za każdy odczyt/zapis (RRU/WRU)
- droższe per operację, ale zero planowania
- **kiedy:** nieregularny ruch, nowy projekt, nie znasz wzorców, szybkie zmiany

### Provisioned (domyślny)

- ustawiasz RCU (Read Capacity Units) i WCU (Write Capacity Units)
- tańsze przy przewidywalnym ruchu
- można włączyć **Auto Scaling** (automatycznie dostosowuje RCU/WCU)
- **kiedy:** przewidywalny ruch, chcesz optymalizować koszt

|-|On-Demand|Provisioned|
|---|---|---|
|Konfiguracja|zero|RCU + WCU|
|Koszt|wyższy per req|niższy przy stałym ruchu|
|Throttling|brak|możliwy gdy przekroczysz limit|
|Kiedy|spike, nowy projekt|stabilny ruch|

### RCU i WCU — co to?

**1 WCU** = 1 zapis itemu do 1 KB / sekundę

**1 RCU** = 1 strongly consistent read itemu do 4 KB / sekundę = 2 eventually consistent reads itemu do 4 KB / sekundę

---

## Read Consistency

**Eventually Consistent Read (domyślny)**

- może zwrócić lekko nieaktualne dane (replikacja w toku)
- tańszy — zużywa 0.5 RCU
- wystarczy w większości przypadków

**Strongly Consistent Read**

- zawsze aktualne dane
- droższy — zużywa 1 RCU
- ustawiasz `ConsistentRead: true` w zapytaniu

---

## Indexes — dostęp do danych

### Local Secondary Index (LSI)

- alternatywny Sort Key dla tej samej Partition Key
- tworzysz **tylko przy tworzeniu tabeli** — nie można dodać później
- max 5 LSI per tabela
- dane w tym samym partition co tabela główna

### Global Secondary Index (GSI)

- zupełnie nowy Partition Key + opcjonalny Sort Key
- możesz dodać **w dowolnym momencie**
- max 20 GSI per tabela
- osobna pojemność (RCU/WCU) niezależna od tabeli

```
Tabela: Orders
PK: OrderID  |  SK: UserID  |  Status  |  Date

GSI 1: PK = UserID   → wszystkie zamówienia użytkownika
GSI 2: PK = Status   → wszystkie zamówienia o danym statusie
```

**Na egzaminie:** chcesz zapytać po atrybucie który nie jest PK → **GSI**.

---

## DynamoDB Streams

Ordered stream zmian w tabeli (INSERT, UPDATE, DELETE) — w czasie rzeczywistym.

DynamoDB Streams to mechanizm, który rejestruje każdą zmianę w tabeli. Dzięki strumieniom możesz reagować na zmiany (np. wywołać Lambda i uruchomić logikę biznesową)

```
DynamoDB Table  →  Stream  →  Lambda / Kinesis / inne
```

- retencja: 24 godziny
- każda zmiana pojawia się w streamie dokładnie raz
- można wysyłać: tylko klucze, nowy obraz, stary obraz, oba obrazy

**Przypadki użycia:**

- react na zmiany w tabeli (event-driven)
- replikacja między regionami
- audyt zmian
- agregacja / analityka real-time

![[Pasted image 20260224214302.png]]

---

## TTL — Time To Live

Automatyczne usuwanie itemów po określonym czasie — zero kosztów za usunięcie.
- ustawiasz atrybut z Unix timestamp (np. `expires_at`)
- DynamoDB sam usuwa item po upływie czasu
- usunięte itemy pojawiają się w DynamoDB Streams (możesz archiwizować)

**Kiedy:** sesje użytkowników, tymczasowe dane, cache, logi.

---

## Global Tables

Multi-region, multi-active replikacja.

```
Region eu-west-1  ←→  Region us-east-1  ←→  Region ap-southeast-1
```

- zapis w dowolnym regionie replikuje się do pozostałych (< 1 sekunda)
- odczyt i zapis lokalnie — minimalna latencja
- wymaga włączenia DynamoDB Streams
- **active-active** — możesz pisać i czytać z każdego regionu

**Na egzaminie:** "low latency globally" + DynamoDB → **Global Tables**.

---

## DAX — DynamoDB Accelerator

In-memory cache specjalnie dla DynamoDB. Microsecond latency.
DAX cache'uje DynamoDB API, nie zapytania SQL.

DynamoDB streamuje zmiany w danych w tabeli – takie jak wstawienie, aktualizacja czy usunięcie – do specjalnego strumienia. Funkcja Lambda może zostać przypięta do tego strumienia jako wyzwalacz. Kiedy pojawia się nowy wpis w strumieniu, Lambda jest automatycznie wywoływana i może przetworzyć te zmiany – na przykład zaktualizować coś w innej usłudze, wysłać powiadomienie, czy agregować dane.

Cache -> mechanizm przechowywania często odczytywanych danych w szybkiej warstwie pamięci np RAM aby przyspieszyc dostęp i zmniejszy obciążenie źródłowej bazy danych. 

```
App  →  DAX (cache)  →  DynamoDB
```

- drop-in replacement — ta sama API co DynamoDB
- cache read-through: DAX pyta DynamoDB tylko przy cache miss
- idealny dla read-heavy workloads
- **NIE** nadaje się dla strongly consistent reads (cache może być nieaktualny)
- TTL cache domyślnie 5 minut

**DAX vs ElastiCache:**

- DAX — tylko DynamoDB, prostszy setup
- ElastiCache — dowolna baza, bardziej elastyczny

![[Pasted image 20260224214224.png]]

---

## Backup i Recovery

### Point-in-Time Recovery (PITR)

- ciągły backup ostatnich 35 dni
- przywracasz tabelę do dowolnego momentu w tym oknie
- nie wpływa na performance

### On-Demand Backup

- pełny backup w dowolnym momencie
- przechowywany dopóki nie usuniesz
- przywracanie do nowej tabeli

![[Pasted image 20260224223803.png]]

---

## Security

- **Encryption at rest** — AWS KMS domyślnie
- **Encryption in transit** — HTTPS/TLS
- **IAM** — kontrola dostępu per tabela, per operacja, nawet per item (condition expressions)
- **VPC Endpoint** — ruch nie wychodzi do internetu
- **CloudTrail** — audyt wszystkich API calls

---

## DynamoDB vs RDS — kiedy co?

|-|DynamoDB|RDS|
|---|---|---|
|Model|NoSQL (klucz-wartość, dokument)|SQL (relacyjny)|
|Schemat|elastyczny|sztywny|
|Joins|brak|tak|
|Skalowanie|horizontal, automatyczne|vertical (głównie)|
|Latencja|ms|ms–s|
|Transakcje|tak (ACID, max 100 itemów)|tak (pełne)|
|Kiedy|high scale, flexible schema, serverless|złożone queries, relacje, legacy|

**Na egzaminie:** "serverless", "miliony requestów/sekundę", "flexible schema" → **DynamoDB**.

 

---

## Typowe patterny (egzamin)

**Serverless API:**

```
API Gateway  →  Lambda  →  DynamoDB
```

**Session store:**

```
App  →  DynamoDB (TTL na sesje)
```

**Event-driven:**

```
DynamoDB  →  Streams  →  Lambda  →  SNS / SQS
```

**Global low-latency:**

```
Users (EU)  →  DynamoDB Global Table (eu-west-1)
Users (US)  →  DynamoDB Global Table (us-east-1)
```

**Read-heavy z cache:**

```
App  →  DAX  →  DynamoDB
```

---

## Flashcards

**Q: Jaki jest maksymalny rozmiar jednego itemu w DynamoDB?** A: 400 KB.

**Q: Różnica między LSI a GSI?** A: LSI — alternatywny Sort Key, tylko przy tworzeniu tabeli, ten sam PK. GSI — nowy PK + SK, można dodać w każdej chwili, własna pojemność.

**Q: Co to RCU i WCU?** A: Read/Write Capacity Units. 1 WCU = zapis 1 KB/s. 1 RCU = strongly consistent read 4 KB/s (eventually consistent = 0.5 RCU).

**Q: Kiedy On-Demand zamiast Provisioned?** A: Nieregularny ruch, spiki, nowy projekt gdzie nie znasz wzorców użycia.

**Q: Co to DynamoDB Streams i do czego służy?** A: Ordered stream zmian w tabeli (INSERT/UPDATE/DELETE), retencja 24h. Używasz do event-driven processing, replikacji, audytu.

**Q: Co to DAX i kiedy go używać?** A: In-memory cache dla DynamoDB, microsecond latency. Dla read-heavy workloads. Nie dla strongly consistent reads.

**Q: Co to Global Tables?** A: Multi-region active-active replikacja DynamoDB. Piszesz i czytasz z dowolnego regionu z lokalną latencją.

**Q: Jak działa TTL w DynamoDB?** A: Ustawiasz atrybut z Unix timestamp — DynamoDB automatycznie usuwa item po tym czasie. Zero kosztów za usunięcie.

**Q: DynamoDB czy RDS — kiedy DynamoDB?** A: Serverless, miliony req/s, flexible schema, brak złożonych joinów. RDS gdy potrzebujesz SQL, relacji, złożonych transakcji.

**Q: Co wymaga Global Tables?** A: Włączone DynamoDB Streams.

# Max size of an item in a DynamoDB table is 400 KB

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
