# Dzień 19 — Rozdział 10 (2/2): Beyond MapReduce — silniki dataflow, grafy i podsumowanie batch processingu

## O czym jest

MapReduce był przełomem, ale to tylko jeden z możliwych modeli programowania rozproszonego — i ma wbudowane problemy wydajnościowe, których nie naprawi żadna warstwa abstrakcji (Pig, Hive, Cascading) położona na wierzchu. Główny winowajca to **pełna materializacja stanu pośredniego**: każdy job zapisuje wynik na HDFS, a następny czyta go od zera. Kolejny job może ruszyć dopiero, gdy poprzedni skończy w całości (wolne maruderskie taski blokują wszystko), mappery często tylko przepakowują dane zapisane przed chwilą przez reducery, a tymczasowe pliki są niepotrzebnie replikowane na kilka węzłów. Dla porównania: potok Unixa nie materializuje nic — strumieniuje dane przez mały bufor w pamięci.

Odpowiedzią są **silniki dataflow**: Spark, Tez i Flink. Traktują cały workflow jako jeden job i modelują jawnie przepływ danych przez kolejne etapy. Zamiast sztywnej przeplatanki map/reduce mamy uogólnione **operatory**, łączone elastycznie: repartycjonowanie z sortowaniem (jak shuffle w MapReduce), partycjonowanie bez sortowania (wystarcza do hash joinów) albo broadcast. Efekty: sortowanie tylko tam, gdzie naprawdę potrzebne, brak zbędnych mapperów, optymalizacje lokalności (dane przekazywane przez pamięć zamiast sieci), stan pośredni w pamięci lub na lokalnym dysku zamiast HDFS, start operatora gdy tylko pojawi się wejście, reużywanie JVM. Ten sam kod Pig/Hive można przełączyć z MapReduce na Teza czy Sparka zmianą konfiguracji.

Skoro nie ma trwałych plików pośrednich, **odporność na awarie** działa inaczej: utracone dane się **przelicza ponownie** z wciąż dostępnych danych wcześniejszych etapów. Spark śledzi pochodzenie danych abstrakcją RDD, Flink robi checkpointy stanu operatorów. Kluczowy staje się **determinizm**: jeśli ponownie policzony wynik różni się od utraconego (losowość, iteracja po hash-mapie, zegar systemowy), trzeba ubić także operatory w dół strumienia. A gdy dane pośrednie są dużo mniejsze od źródłowych albo obliczenie jest bardzo kosztowne CPU — materializacja i tak bywa tańsza niż rekomputacja.

Druga część fragmentu to **przetwarzanie grafów** (PageRank, systemy rekomendacji): algorytmy typu „powtarzaj aż do zbieżności" nie pasują do jednoprzebiegowego MapReduce, który w każdej iteracji czyta i pisze cały dataset. Model **Pregel** (BSP — bulk synchronous parallel; Giraph, GraphX, Gelly) rozwiązuje to tak: wierzchołek wysyła komunikaty do innych wierzchołków wzdłuż krawędzi, a między iteracjami **pamięta swój stan** — przetwarza tylko nowe komunikaty. Jak model aktorów, ale z gwarancjami: komunikaty z iteracji N docierają dokładnie raz w iteracji N+1, a odporność zapewniają checkpointy stanu wierzchołków. Haczyk: partycjonowanie grafu jest w praktyce arbitralne, więc komunikacja sieciowa potrafi zdominować koszt — jeśli graf mieści się na jednej maszynie (nawet na dysku — GraphChi), podejście jednomaszynowe często wygrywa z klastrem.

Na koniec **konwergencja z bazami danych**: wysokopoziomowe API (Spark DataFrames, Hive) wprowadzają deklaratywność — optymalizator kosztowy sam wybiera algorytm złączenia, proste filtry wykonuje wektorowo na danych kolumnowych, generuje kod maszynowy. Frameworki batchowe upodabniają się do baz MPP wydajnością, zachowując przewagę: swobodę uruchamiania dowolnego kodu (ML, NLP, analiza genomu) i czytania dowolnych formatów. Podsumowanie rozdziału domyka klamrę: dwa fundamentalne problemy to **partycjonowanie** (sprowadź powiązane dane w jedno miejsce) i **odporność na awarie**; trzy algorytmy join (sort-merge, broadcast hash, partitioned hash); a ograniczony model programowania (funkcje bez stanu i efektów ubocznych) pozwala frameworkowi ukryć całą brzydotę systemów rozproszonych — retry jest bezpieczny, wynik jak gdyby awarii nie było. Cechą definiującą batch jest **ograniczone (bounded) wejście** o znanym rozmiarze: job wie, kiedy skończył. Strumienie tę granicę zniosą.

## Najważniejsze cytaty

> "There are various differences in the way they are designed, but they have one thing in common: they handle an entire workflow as one job, rather than breaking it up into independent subjobs."

Istota silników dataflow (Spark, Tez, Flink): cały workflow jako jeden job z jawnym przepływem danych — to otwiera drogę do wszystkich optymalizacji, których MapReduce nie widzi.

> "If a machine fails and the intermediate state on that machine is lost, it is recomputed from other data that is still available."

Odwrócenie filozofii fault tolerance: zamiast płacić z góry za trwałość (replikacja na HDFS), płacisz przy awarii rekomputacją — Spark przez rodowód RDD, Flink przez checkpointy.

> "In order to avoid such cascading faults, it is better to make operators deterministic."

Rekomputacja działa tylko, gdy operator z tego samego wejścia zawsze da to samo wyjście. Losowość, kolejność iteracji po hash-mapie czy zegar systemowy — wszystko to psuje odzyskiwanie po awarii.

> "If your graph can fit in memory on a single computer, it's quite likely that a single-machine (maybe even single-threaded) algorithm will outperform a distributed batch process."

Lekcja pokory dla big data: narzut komunikacji sieciowej w rozproszonych algorytmach grafowych bywa tak duży, że laptop bije klaster. Rozproszenie to ostateczność, nie domyślna odpowiedź.

> "Crucially, the input data is bounded: it has a known, fixed size […] Because it is bounded, a job knows when it has finished reading the entire input, and so a job eventually completes when it is done."

Definicja batch processingu w jednym zdaniu — i most do następnego rozdziału: strumienie to dane bez końca, więc job nigdy nie jest „skończony".

## Myśl dnia

Silniki dataflow to MapReduce odchudzony z niepotrzebnej materializacji — potok Unixa rozpisany na klaster, z rekomputacją zamiast replikacji jako polisą na awarie. A gdy dołożyć deklaratywne API i optymalizatory, batch framework i baza MPP zbiegają się w jedno: systemy do przechowywania i przetwarzania danych.

---

*Jutro: pierwsza połowa rozdziału 11 — „Stream Processing": przesyłanie strumieni zdarzeń, brokery komunikatów i logi partycjonowane w stylu Kafki.*
