Created: 2026-02-23  19:09
___
Note:

>[!tip]
>Managed delivery pipeline — zarządzany potok dostarczania danych strumieniowych do miejsc docelowych.
>- automatic scaling, serverless, pay for use
>- **near real-time** with buffering capability based on size / time ( zapisuje co jakiś czas paczkami)


Nie trzeba zarządzać infrastrukturą — AWS ogarnia skalowanie, replikację i dostępność.

Firehose **NIE jest kolejką** — wiadomości nie czekają na konsumenta. To potok z buforem.

ma wbudowane **buffering + retries + batching + compression**

---

## Jak działa?

```
Producer  ->  Firehose  ->  [bufor]  ->  transformacja (opcja)  ->  S3 / Redshift / OpenSearch
```

Firehose zbiera dane, buforuje je, opcjonalnie przetwarza i zapisuje w batchach.

![[Pasted image 20260223210523.png]]

## Miejsca docelowe (Destinations)

- **S3** — najczęstszy, pliki w batchach
- **Amazon Redshift** — przez S3 jako staging
- **Amazon OpenSearch** — logi, analityka
- **Splunk** — zewnętrzny SIEM
- **HTTP endpoint** — dowolny webhook

---

## Buforowanie

Firehose nie wysyła każdej wiadomości osobno — czeka aż zbierze porcję.

|Parametr|Wartość|Opis|
|---|---|---|
|Buffer size|1 MB – 128 MB|wyślij gdy rozmiar osiągnięty|
|Buffer interval|60s – 900s|wyślij po czasie nawet jeśli mały|

Który warunek spełniony pierwszy — taki wyzwala zapis.

---

## Transformacja przez Lambda

Opcjonalnie można podłączyć funkcję Lambda która przetworzy każdy rekord przed zapisem.

```
Producer  ->  Firehose  ->  Lambda (transform)  ->  S3
```

Przykłady użycia:

- konwersja formatu (JSON -> Parquet, CSV -> JSON)
- filtrowanie rekordów
- wzbogacanie danych (enrich)
- maskowanie wrażliwych pól

---

## Format i kompresja

- **Kompresja:** GZIP, Snappy, ZIP, Hadoop-compatible GZIP
- **Konwersja:** JSON -> Apache Parquet lub ORC (lepsze do analityki w Athena/Redshift)
- **Partycjonowanie S3:** automatyczne foldery `rok/miesiąc/dzień/godzina`

---

# [[Amazon SQS]] vs [[Kinesis Data Streams]] vs [[Amazon Data Firehose]]

|Cecha|SQS|Kinesis Data Streams|Firehose|
|---|---|---|---|
|Typ|Kolejka|Stream|Delivery pipeline|
|Konsument|Pull (sam bierze)|Pull (wiele niezależnych)|Push (automatyczny)|
|Retencja|do 14 dni|do 365 dni|brak — dostarcza od razu|
|Real-time|tak|tak|mini-batch (bufor)|
|Cel|task queue|analityka, wiele konsumentów|zapis do S3/Redshift|
|Zarządzanie|managed|shardy (ręczne skalowanie)|w pełni managed|

![[Pasted image 20260223210549.png]]
---
---

## Typowe patterny

**Fan-out z SNS:**

```
Aplikacja  ->  SNS  ->  Firehose  ->  S3  ->  Athena / Redshift
```

**Logi z EC2:**

```
EC2 (CloudWatch Logs)  ->  Firehose  ->  S3 (partycjonowane)
```

---

## Bezpieczeństwo

- Szyfrowanie w tranzycie: HTTPS zawsze
- Szyfrowanie w spoczynku: SSE przez AWS KMS
- IAM: kontrola kto może wysyłać dane do delivery stream
- VPC Endpoint: ruch nie wychodzi do internetu

---

## Kiedy używać?

✅ Chcesz zapisywać dane strumieniowe do S3/Redshift bez pisania kodu konsumenta  
✅ Potrzebujesz automatycznej kompresji i partycjonowania  
✅ Dane do analityki (Athena, Redshift Spectrum)  
✅ Logi aplikacji, clickstream, IoT

❌ NIE używaj gdy potrzebujesz real-time processing z wieloma niezależnymi konsumentami — wtedy **Kinesis Data Streams**


![[Pasted image 20260223214019.png]]

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
