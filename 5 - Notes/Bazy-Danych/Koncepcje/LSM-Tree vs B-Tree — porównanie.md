---
sr_due: 2026-07-19
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---
# LSM-Tree vs B-Tree — porównanie

> [!summary]
> LSM-Tree pisze szybko (zawsze append), B-Tree czyta szybko (stała liczba seek'ów). Wybór zależy od stosunku odczytów do zapisów w aplikacji.

## LSM-Tree w skrócie

Log-Structured Merge-Tree — dane najpierw trafiają do memtable (RAM), potem periodycznie spłukiwane do SSTable (posortowane pliki na dysku). Stare SSTables są mergowane w tle.

```
Zapis → memtable (RAM)
       ↓ (gdy pełna)
   SSTable_1 (dysk, posortowana)
   SSTable_2 (dysk, posortowana)
       ↓ (compaction w tle)
   SSTable_merged (dysk)
```

> [!example]
> **Cassandra** używa LSM-Tree. Dlatego insert/update jest błyskawiczny — to zawsze append. Ale `SELECT` na starych danych wymaga przeszukania wielu SSTables.

## Dlaczego B-Tree wygrywa w SQL

Relacyjne bazy (PostgreSQL, MySQL, Oracle) używają B-Tree, bo:
- OLTP = dużo małych odczytów i zapisów mieszanych
- B-Tree daje przewidywalny czas odczytu (O(log n), mała stała)
- Łatwo robić range queries (B-Tree posortowany)

> [!warning]
> LSM-Tree ma "write amplification" i "read amplification" w różnych konfiguracjach compaction. Nie ma magicznego rozwiązania — zawsze trade-off.

## Praktyczna zasada

- **Dużo odczytów, mało zapisów** → B-Tree (PostgreSQL, MySQL)
- **Dużo zapisów (logi, IoT, timeseries)** → LSM-Tree (Cassandra, RocksDB, LevelDB)
- **Analytics (kolumnowe)** → osobna historia → [[Kiedy SQL, kiedy NoSQL]]

## Bloom Filter — bonus LSM

LSM wie, że "ten klucz NA PEWNO nie istnieje" dzięki Bloom filterowi (probabilistyczna struktura w pamięci). Eliminuje niepotrzebne odczyty dysku dla nieistniejących kluczy.

## Połączenia

- [[B-Tree — jak SQL przechowuje dane]] — szczegóły B-Tree
- [[Indeks — jak działa i kiedy pomaga|Indeks — koszt i korzyść]] — oba są strukturami indeksów
- [[Kiedy SQL, kiedy NoSQL]] — wybór silnika zależy od workloadu
