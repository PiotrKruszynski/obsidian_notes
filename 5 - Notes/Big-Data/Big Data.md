---
title: "Big Data"
type: service
topic: big-data
tags: ["big-data"]
created: 2026-06-09
status: draft
---

>[! Definition ]
> **Big data** is _high-volume_, _high-velocity_ and _high-variety_ information assets that demand cost-effective, innovative forms of information processing for enhanced insight and decision making.

### 1. **Volume (ilość danych)**
- TB → PB → EB  
    👉 jeden serwer nie wystarcza → potrzebujesz **distributed storage**

### 2. **Velocity (prędkość napływu danych)**
- dane przychodzą ciągle (streaming, logi, IoT)  
    👉 nie możesz robić tylko batch → potrzebujesz **real-time processing**

### 3. **Variety (różnorodność)**
- structured (SQL), semi (JSON), unstructured (logi, obraz)  
    👉 schemat nie jest stały → potrzebujesz **schema-on-read (np. data lake)**

# Architektura systemów Big Data

### 🔹 Batch processing
- dane zbierane i przetwarzane **okresowo / na żądanie**
- brak real-time
👉 mental:
> „najpierw zbierz wszystko → potem policz”

**Przykład:** nocne ETL na Apache Spark / Hive

### 🔹 Kappa architecture
- wszystko traktujesz jako **stream**
- brak oddzielnego batch layer
👉 mental:
> „masz jeden pipeline → działa ciągle”

**Technologie:**
- Apache Kafka
- Spark Streaming / Flink
### 🔹 Lambda architecture
- 2 ścieżki:
    - batch (dokładność)
    - speed layer (real-time)
👉 mental:
> „robisz to samo 2 razy (batch + streaming)”

## 🚀 typowa architektura Kappa

![[Pasted image 20260328233109.png]]

**sources → streaming engine → sink**
- input:
    - Kafka / Kinesis / logs
- processing:
    - Spark Streaming
- output:
    - HDFS / DB / dashboards

**Kafka** — kolejka wiadomości. Producenci piszą, konsumenci czytają. Bardzo szybki, rozproszony. Standard w big data.

**Spark Streaming** — odbiera dane w małych porcjach czasowych (micro-batch), przetwarza jak zwykłe RDD/DataFrame.
```python
# co 2 sekundy przetwarzaj nową porcję danych
ssc = StreamingContext(sc, batchDuration=2)
```

**Databases** — np. Cassandra, PostgreSQL, Redis — zapis do bazy.
**Dashboards** — np. Grafana, Kibana — wizualizacja na żywo.
