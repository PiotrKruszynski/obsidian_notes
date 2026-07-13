# Dzień 18 — Rozdział 10 (1/2): Batch Processing — Unix i MapReduce

## O czym jest

Kleppmann otwiera trzecią część książki, odchodząc od systemów online (żądanie → odpowiedź) w stronę przetwarzania wsadowego. Wyróżnia trzy typy systemów: usługi online (liczy się czas odpowiedzi), systemy wsadowe (liczy się przepustowość — job miele duży, skończony zbiór danych i produkuje wynik) oraz przetwarzanie strumieniowe pomiędzy nimi. Batch to bardzo stara idea — maszyny Holleritha ze spisu ludności USA z 1890 r. robiły to samo mechanicznie, a MapReduce łudząco przypomina sortery kart IBM z lat 50.

Zanim dojdzie do klastrów, autor pokazuje analizę loga serwera www jednym potokiem: `cat | awk | sort | uniq -c | sort -rn | head`. Taki łańcuch przetwarza gigabajty w sekundy, a `sort` sam rozlewa dane na dysk i używa wielu rdzeni — skaluje się poza RAM, gdzie skrypt z hash-tablicą w pamięci by poległ. Siłą Unixa jest jego filozofia: każdy program robi jedną rzecz dobrze, jednolity interfejs (plik = ciąg bajtów, zwykle tekst dzielony `\n`), oddzielenie logiki od „okablowania" (stdin/stdout) oraz przejrzystość — niezmienne wejście pozwala eksperymentować bez ryzyka. Ograniczenie: jedna maszyna.

MapReduce to „Unix rozproszony na tysiące maszyn". Job czyta pliki z rozproszonego systemu plików (HDFS — tania, shared-nothing reimplementacja GFS na zwykłym sprzęcie, z replikacją bloków), niczego nie nadpisuje i produkuje niezmienne wyjście. Schemat: podziel wejście na rekordy → mapper wyciąga pary klucz-wartość → framework sortuje (shuffle: partycjonowanie po hashu klucza, sortowanie na dysku mappera, scalanie u reducera) → reducer przetwarza wartości tego samego klucza. Sort jest wbudowany; piszesz tylko mapper i reducer. Pojedynczy job niewiele umie, więc łańcuchy 50–100 jobów spinane katalogami w HDFS są normą (stąd schedulery: Airflow, Oozie, Luigi).

Sercem fragmentu są złączenia. Reduce-side sort-merge join: mappery obu zbiorów emitują wspólny klucz (np. user ID), sortowanie zbiera wszystko o danym kluczu w jednym wywołaniu reducera — klucz działa jak adres, na który mapper „wysyła wiadomość". Gorące klucze (celebryci) psują równoległość, więc są triki: skewed join (losowy rozrzut + replikacja drugiej strony), dwustopniowa agregacja. Map-side joins są tańsze (bez sortowania i shuffle), ale wymagają założeń o danych: broadcast hash join (mały zbiór mieści się w RAM każdego mappera), partitioned hash join (oba wejścia tak samo spartycjonowane), map-side merge join (spartycjonowane i posortowane).

Wyjście batcha to zwykle nie raport, lecz struktura: indeks wyszukiwarki (pierwotne zastosowanie MapReduce w Google) albo pliki bazy klucz-wartość budowane w jobie i ładowane hurtem do serwerów read-only (Voldemort) — nigdy zapis rekord-po-rekordzie do zewnętrznej bazy z wnętrza joba. Niezmienne wejścia i brak efektów ubocznych dają „human fault tolerance": zły kod → wracasz do starego wyjścia. Na koniec porównanie z bazami MPP: Hadoop pozwala zrzucać surowe dane (schema-on-read, „zasada sushi", data lake) i uruchamiać dowolne modele przetwarzania na jednym klastrze. A częste zapisy na dysk i odtwarzanie na poziomie zadania biorą się nie z zawodnego sprzętu, lecz z wywłaszczania tanich, niskopriorytetowych zadań w mieszanych centrach danych Google (~5% ryzyka przerwania na godzinę pracy).

## Najważniejsze cytaty

> "Make each program do one thing well. To do a new job, build afresh rather than complicate old programs by adding new 'features'."

Rdzeń filozofii Unixa (1978): małe, komponowalne narzędzia zamiast rozbudowywanych molochów. Kleppmann zauważa, że brzmi to jak dzisiejsze Agile i DevOps — przez cztery dekady niewiele się zmieniło.

> "MapReduce is a bit like Unix tools, but distributed across potentially thousands of machines."

Cała rama rozdziału w jednym zdaniu: job = proces, HDFS = system plików, niezmienne wejście, jednorazowo zapisane wyjście. Toporny, siłowy, ale zaskakująco skuteczny.

> "When a mapper emits a key-value pair, the key acts like the destination address to which the value should be delivered."

Najlepsza intuicja MapReduce: klucz to adres. Framework oddziela komunikację sieciową od logiki aplikacji — dlatego złączenia i grupowania to to samo „sprowadzanie powiązanych danych w jedno miejsce".

> "Hadoop opened up the possibility of indiscriminately dumping data into HDFS, and only later figuring out how to process it further."

Odwrócenie podejścia baz MPP: najpierw zbierz surowe dane (data lake), schemat martw się później (schema-on-read). Szybkie udostępnienie danych bywa cenniejsze niż idealny model z góry.

> "…it's not because the hardware is particularly unreliable, it's because the freedom to arbitrarily terminate processes enables better resource utilization in a computing cluster."

Zaskakujący powód odporności MapReduce na awarie: to cena za dojadanie resztek zasobów po procesach o wyższym priorytecie, nie strach przed padającymi dyskami.

## Myśl dnia

Filozofia Unixa — niezmienne wejścia, brak efektów ubocznych, małe narzędzia spinane jednolitym interfejsem — skaluje się z jednej maszyny na tysiące: MapReduce to potok unixowy rozpisany na klaster, a jego sercem jest sortowanie, które sprowadza powiązane dane w jedno miejsce.

---

*Jutro: druga połowa rozdziału 10 — „Beyond MapReduce": materializacja stanu pośredniego, silniki dataflow (Spark, Flink), przetwarzanie grafów i API wysokiego poziomu.*
