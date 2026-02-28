Created: 2026-02-23  16:27
___
Note:

>[!tip]
>Collect and store **streaming** data in **real-time**
>pozwala zbierać i przetwarzać ogromne ilości danych np logi, zdarzenia niemal natychniast. Dane są dzielone na _shard'y_ które pozwalają na równoległy zapis i odczyt.

streaming - dane napływają ciągle, na bieżąco, w małych porcjach.
batch
transaction interaction


• Retention between up to 365 days 
• Ability to reprocess (replay) data by consumers 
• Data can’t be deleted from Kinesis (until it expires) 
• Data up to 1MB (typical use case is lot of “small” real-time data) 
• Data ordering guarantee for data with the same** **Partition ID**
• At-rest KMS encryption, in-flight HTTPS encryption 
• Kinesis Producer Library (KPL) to write an optimized producer application 
• Kinesis Client Library (KCL) to write an optimized consumer application


![[Pasted image 20260223185925.png]]

Służy do streamowania danych w czasie rzeczywistym.

---

**Różnica vs SQS:**

```
SQS  →  kolejka, wiadomość znika po przetworzeniu
KDS  →  stream, dane zostają (domyślnie 24h, max 365 dni)
        wielu konsumentów czyta niezależnie, każdy od swojego miejsca
```

---

**Jak działa:**

```
Producer → KDS (shardy) → Consumer #1 (czyta od początku)
                        → Consumer #2 (czyta od swojego miejsca)
```

**Shard** = jednostka przepustowości

- 1 shard = 1MB/s zapis, 2MB/s odczyt
- więcej shardów = większy throughput
- pay for shard per hour

# Capacity modes
- provisioned mode
	- choose number of shards
	- each shard gets 1 shard
	- scale manually to increase or decrease number of shards
- on-demend mode
	- no neeed to provision or manage capasity
	- scales automatically

---

**Kiedy KDS a kiedy SQS:**

```
SQS  →  task queue, każda wiadomość przetwarza jeden konsument
KDS  →  analityka real-time, logi, wiele konsumentów czyta to samo
```

---

**Przykład:**

```
kliknięcia użytkowników → KDS → Lambda (real-time analityka)
                               → KDF (zapis do S3)
                               → ElasticSearch (wyszukiwanie)
```

Wszyscy trzej czytają te same dane niezależnie.

![[Pasted image 20260223214010.png]]


jest jeszcze _Kinesis Data Analytic_ when you want to perform real-time analytics on streams of data
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
