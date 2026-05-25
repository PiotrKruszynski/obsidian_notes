main:  #database #nosql #distributed #architecture

Status: #pending 

Created: 2026-05-24  18:03
___

Baza danych to nic innego jak zbiór danych 
- model danych żeby dane były ustrukturyzowane
- dostęp (serwer, silnik, konsystencja)

SQL - schema
NoSQL - _schemaless_
# Dlaczego NoSQL istnieje

Relacyjne bazy danych zostały zaprojektowane dla spójności i struktury — nie dla skali i elastyczności. W 2000+ internet 2.0 produkuje dużo danych, dane różne i w sql dużo kolumn w null. Null spowalnia sql. Drugi czynnik to kiedyś używało się HDD, dziś SSD.
SQL jest szybszy jak dane są ustrukturyzowane.

**Główne motywacje:**

- Horyzontalna skalowalność (sharding bez bólu)
- _Schemaless_ — dane heterogeniczne lub ewoluujące szybko
- Specjalizacja pod konkretny access pattern (grafowe, time-series, wyszukiwanie)
- Latencja — brak joinów, dane denormalizowane

---

## CAP Theorem — fundament

Dystrybuowany system może mieć jednocześnie tylko **2 z 3**:

```
C — Consistency      (każdy odczyt widzi ostatni zapis)
A — Availability     (każde zapytanie dostaje odpowiedź)
P — Partition Tol.   (system działa mimo utraty połączeń między węzłami)
```

**P jest obowiązkowe** w systemach rozproszonych — sieć zawsze może się podzielić. Więc wybór to **CP vs AP**.

| Typ | Przykłady                    | Wybór                                     |
| --- | ---------------------------- | ----------------------------------------- |
| CP  | MongoDB, HBase, Zookeeper    | Spójność ważniejsza niż dostępność        |
| AP  | Cassandra, CouchDB, DynamoDB | Dostępność ważniejsza niż ścisła spójność |

CAP jest uproszczeniem — patrz też **PACELC** (trade-off latency vs consistency nawet bez partition).

---

## ten sam problem można rozważyć inaczej

### Yield i Harvest — lepszy model niż CAP

Zamiast binarnego C/A, patrzysz na dwa wymiary:
 
**Yield** AP _plon_= `ile zapytań dostało odpowiedź / wszystkie zapytania`  
→ dostępność z punktu widzenia klienta

**Harvest** CP _żniwo_ = `ile danych zwróciłeś / ile danych istnieje`  
→ kompletność odpowiedzi

Przykład z notatki (wyszukiwarka "cassandra database"):

- Jeden shard z wynikami niedostępny
- Możesz **odmówić odpowiedzi** → niski yield, harvest 100%
- Możesz **odpowiedzieć tym co masz** → yield 100%, harvest 80%

To jest decyzja biznesowa: czy użytkownik woli błąd, czy niepełny wynik? Google wybrało harvest — wolą pokazać niekompletne wyniki niż error 500.


# Rodzaje baz danych
[[types of databases]]

---

## Indeksy w NoSQL — porównanie

|Typ bazy|Indeksowanie|
|---|---|
|Key-Value|Brak (tylko po kluczu)|
|Document|Secondary indexes na polach dokumentu|
|Wide-Column|Primary key only (SAI/SI w Cassandzie jako dodatek)|
|Graph|Automatyczne na węzłach/krawędziach|
|Time-Series|Tag-based index, kompresja temporalna|
|Search|Inverted index (Lucene)|

---

## Eventual Consistency — jak działa w praktyce

Replikacja async → węzeł B może mieć starszą wersję danych niż węzeł A przez chwilę.

**Mechanizmy rozwiązywania konfliktów:**

- **Last Write Wins (LWW)** — wygrywa zapis z wyższym timestamp. Problem: zegary w klastrze nie są idealnie zsynchronizowane (NTP ≠ atomowy). Cassandra domyślnie używa LWW.
- **Vector Clocks** — każdy węzeł trzyma wektor wersji. Umożliwia wykrycie konfliktów (nie rozwiązuje automatycznie). Riak, Dynamo.
- **CRDTs** (Conflict-free Replicated Data Types) — struktury matematycznie zaprojektowane tak, żeby merge był zawsze deterministyczny. Redis, Riak, niektóre Cassandra typy (Counter, Set).
- **Operational Transform / Paxos / Raft** — consensus-based, silna spójność, wyższy latency.

---

## Transakcje w NoSQL

|System|Transakcje|
|---|---|
|MongoDB 4.0+|ACID multi-document (replica set), multi-shard (droższe)|
|Cassandra|LWT (Paxos, tylko CAS) lub BATCH (atomowość, nie izolacja)|
|DynamoDB|TransactWriteItems (do 25 items, cross-table)|
|Redis|MULTI/EXEC (optimistic locking przez WATCH)|
|Neo4j|ACID (single-node), ograniczone w klastrze|
|FaunaDB/Spanner|Pełne ACID dystrybuowane|

**Reguła:** jeśli potrzebujesz ACID często i na wielu encjach — rozważ relacyjną bazę lub NewSQL (CockroachDB, Spanner, YugabyteDB).


