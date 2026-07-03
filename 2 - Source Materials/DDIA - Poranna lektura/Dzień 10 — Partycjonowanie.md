# Dzień 10 — Partycjonowanie (Rozdział 6, całość)

**Książka:** Designing Data-Intensive Applications — Martin Kleppmann (2017)
**Fragment:** Rozdział 6 „Partitioning" (całość)

> [!note] Uzupełnienie
> Ta porcja wypadła 26.06 — tamten przebieg omyłkowo powtórzył rozdział 5 (2/2). Duplikat został zastąpiony tą notatką, żeby plan 24 porcji się domknął.

---

## O czym jest ten fragment

Replikacja (rozdz. 5) daje kopie tych samych danych na wielu węzłach — ale przy naprawdę dużych zbiorach albo wysokim ruchu to za mało. Trzeba dane pociąć na **partycje** (inaczej sharding): każdy rekord należy do dokładnie jednej partycji, a każda partycja jest w praktyce małą, samodzielną bazą. Główny powód to skalowalność — partycje rozkłada się na węzły klastra shared-nothing, więc rosną i dane, i przepustowość zapytań. Terminologia bywa myląca: partition = shard (MongoDB, Elasticsearch), region (HBase), tablet (Bigtable), vnode (Cassandra, Riak), vBucket (Couchbase). Partycjonowanie zwykle łączy się z replikacją: węzeł bywa liderem jednych partycji i followerem innych, a oba mechanizmy są od siebie w dużej mierze niezależne.

Cel: rozłożyć dane i obciążenie **równomiernie**. Jeśli podział jest niesprawiedliwy, mówimy o **skew**, a partycja z nieproporcjonalnie dużym ruchem to **hot spot** — w skrajnym wypadku 9 z 10 węzłów stoi bezczynnie, a wąskim gardłem jest jeden zapracowany.

### Dwa główne sposoby podziału klucz–wartość

**Podział po zakresach kluczy (key range)** — jak tomy encyklopedii: partycja dostaje ciągły przedział posortowanych kluczy. Zaleta: tanie zapytania zakresowe (range scan), klucz działa jak indeks złożony (np. odczyty z czujników po czasie). Wada: łatwo o hot spot — gdy kluczem jest timestamp, wszystkie dzisiejsze zapisy lecą do jednej partycji. Ratunek: przestawić klucz, np. najpierw nazwa czujnika, potem czas. Tak działają Bigtable/HBase, RethinkDB, stare MongoDB.

**Podział po hashu klucza** — dobra funkcja hashująca zamienia skośne dane w równomiernie rozrzucone. Nie musi być kryptograficzna (Cassandra i MongoDB używają MD5); uwaga na hashCode() Javy, który daje różne wartości w różnych procesach. Cena: tracimy porządek kluczy, więc zapytania zakresowe wymagają odpytania wszystkich partycji. Kleppmann radzi też unikać terminu „consistent hashing" — myli się z consistency i słabo sprawdza w bazach; lepiej mówić „hash partitioning". Kompromis Cassandry: klucz złożony — hash tylko pierwszej kolumny wybiera partycję, reszta kolumn sortuje dane, co elegancko modeluje relacje 1-do-wielu, np. (user_id, update_timestamp).

Hash nie leczy wszystkiego: gdy miliony zapisów idą w **ten sam klucz** (celebryta na portalu społecznościowym), hash identycznych ID jest identyczny. Dziś to aplikacja musi rozbić gorący klucz, np. doklejając dwucyfrową losową liczbę (100 podkluczy) — kosztem odczytów, które muszą potem scalić wszystkie warianty.

### Indeksy wtórne w świecie partycji

Indeks wtórny nie mapuje się gładko na partycje. Dwa podejścia:

**Indeks dokumentowy (lokalny)** — każda partycja indeksuje wyłącznie własne dokumenty. Zapis dotyka jednej partycji, ale odczyt po indeksie („wszystkie czerwone auta") musi iść do wszystkich partycji — to **scatter/gather**, podatny na wzmocnienie ogona latencji. Mimo to powszechny: MongoDB, Riak, Cassandra, Elasticsearch, SolrCloud, VoltDB.

**Indeks termowy (globalny)** — indeks obejmuje dane ze wszystkich partycji, ale sam też jest partycjonowany, po termie (np. color:red) albo jego hashu. Odczyt trafia w jedną partycję indeksu; za to zapis jednego dokumentu może dotknąć wielu partycji indeksu. W praktyce takie indeksy aktualizuje się asynchronicznie (np. globalne indeksy DynamoDB), bo synchroniczność wymagałaby rozproszonej transakcji.

### Rebalancing: jak przesuwać dane, gdy klaster się zmienia

Rośnie ruch, rośnie zbiór, padają maszyny — obciążenie trzeba przenosić między węzłami. Dobry rebalancing: po nim obciążenie jest sprawiedliwe, w trakcie baza działa, a przenosi się tylko tyle danych, ile trzeba.

Jak NIE robić: **hash mod N** — zmiana liczby węzłów przenosi większość kluczy (123456 mod 10 = 6, mod 11 = 3, mod 12 = 0). Strategie właściwe: **stała liczba partycji** — z góry np. 1000 partycji na 10 węzłów; nowy węzeł „podkrada" po kilka partycji od każdego, przenosi się całe partycje (Riak, Elasticsearch, Couchbase, Voldemort); trudność: liczbę trzeba trafić na wyrost, ale nie za dużą. **Partycjonowanie dynamiczne** — partycja po przekroczeniu progu (HBase: 10 GB) dzieli się na pół, a mała scala z sąsiadem, jak w B-drzewie; pusta baza zaczyna od jednej partycji, stąd pre-splitting. **Proporcjonalnie do węzłów** — stała liczba partycji na węzeł (Cassandra: domyślnie 256); nowy węzeł losowo dzieli istniejące partycje i zabiera połówki — to najbliższe oryginalnemu consistent hashing.

Automatyka rebalancingu bywa zdradliwa w połączeniu z automatyczną detekcją awarii: przeciążony (nie martwy!) węzeł zostaje uznany za padły, klaster zaczyna kosztowny rebalancing, który dokłada obciążenia — i robi się kaskada. Dlatego dobrze mieć człowieka w pętli; Couchbase, Riak i Voldemort generują propozycję przydziału, ale czekają na zatwierdzenie przez administratora.

### Routing zapytań

Skoro przydział partycji do węzłów się zmienia, skąd klient wie, gdzie uderzyć z kluczem „foo"? To przypadek ogólnego problemu **service discovery**. Trzy wzorce: klient pyta dowolny węzeł, a ten przekazuje dalej (Cassandra i Riak — protokół gossip); osobna warstwa routingu świadoma partycji (mongos w MongoDB, moxi w Couchbase); albo klient sam zna przydział. Wielu systemom mapę klastra trzyma zewnętrzny koordynator **ZooKeeper** (HBase, SolrCloud, Kafka; Espresso LinkedIna przez Helix). Na koniec rozdział zahacza o MPP — analityczne bazy równoległe, które tną złożone zapytania (joiny, agregacje) na etapy wykonywane równolegle na wielu węzłach.

---

## Najważniejsze cytaty

> "The main reason for wanting to partition data is scalability."

Cała motywacja rozdziału w jednym zdaniu: partycjonujemy po to, by dane i ruch rozłożyć na wiele maszyn.

> "The presence of skew makes partitioning much less effective. In an extreme case, all the load could end up on one partition, so 9 out of 10 nodes are idle and your bottleneck is the single busy node. A partition with disproportionately high load is called a hot spot."

Skew i hot spot to centralni przeciwnicy tego rozdziału — źle dobrany klucz partycjonowania potrafi zamienić klaster w jedną przeciążoną maszynę z dziewięcioma gapiami.

> "Because this is so confusing, it's best to avoid the term consistent hashing and just call it hash partitioning instead."

Rzadki przypadek, gdy Kleppmann wprost każe wyrzucić popularny termin: „consistent" w consistent hashing nie ma nic wspólnego ze spójnością replik ani ACID, a sama technika słabo działa w bazach.

> "The problem with the mod N approach is that if the number of nodes N changes, most of the keys will need to be moved from one node to another."

Dlatego hash mod N to antywzorzec rebalancingu — dobre strategie przenoszą tylko tyle danych, ile naprawdę trzeba.

> "By design, every partition operates mostly independently—that's what allows a partitioned database to scale to multiple machines."

Puenta rozdziału: niezależność partycji jest źródłem skalowalności — a zarazem zapowiedź kłopotów, bo operacje obejmujące wiele partycji (co jeśli jedna się uda, a druga nie?) prowadzą prosto do transakcji rozproszonych.

---

## Myśl dnia

Partycjonowanie to sztuka równego rozsypywania: klucz podziału ma rozrzucić dane i ruch tak, by żaden węzeł nie stał się hot spotem, a rebalancing ma przesuwać możliwie mało i najlepiej pod okiem człowieka. Skalowalność bierze się z niezależności partycji — i dokładnie tam, gdzie ta niezależność się kończy, zaczynają się kolejne rozdziały.

---

*Jutro (Dzień 15): rozdział 9 „Consistency and Consensus", część 1/3 — gwarancje spójności i linearizability.*
