# Dzień 20 — Rozdział 11 (1/2): Stream Processing — strumienie zdarzeń, brokery, logi i bazy danych

## O czym jest

Batch processing miał jedno wielkie założenie: wejście jest **ograniczone** i job wie, kiedy skończył. W rzeczywistości dane są **nieograniczone** — przychodzą stale, a dataset nigdy nie jest „kompletny". Zamiast sztucznie ciąć dane na dzienne porcje, można przetwarzać każde zdarzenie, gdy tylko się pojawi — to jest stream processing. Podstawową jednostką jest **zdarzenie (event)**: mały, samodzielny, niemutowalny zapis czegoś, co się wydarzyło, zwykle z timestampem. Producent zapisuje zdarzenie raz, wielu konsumentów je przetwarza; powiązane zdarzenia grupuje się w **topiki**. Odpytywanie bazy w pętli (polling) robi się tym droższe, im częstsze — dlatego potrzebne są systemy, które **powiadamiają** konsumentów o nowych zdarzeniach.

Systemy komunikatów najlepiej różnicować dwoma pytaniami: **co się dzieje, gdy producenci są szybsi niż konsumenci** (odrzucanie, buforowanie albo backpressure — tak działają potoki Unixa i TCP), oraz **czy komunikaty przetrwają awarię węzła**. Komunikacja bezpośrednia (UDP multicast na giełdach, ZeroMQ, StatsD, webhooki) jest szybka, ale zakłada, że wszyscy są cały czas online. **Broker komunikatów** to w istocie baza danych wyspecjalizowana w strumieniach: buforuje komunikaty, przez co znosi znikających klientów, a dostarczanie jest asynchroniczne. Klasyczne brokery (JMS/AMQP: RabbitMQ, ActiveMQ, IBM MQ…) używają **potwierdzeń (ack)** i ponownego dostarczania. Dwa wzorce konsumpcji: **load balancing** (każdy komunikat do jednego z konsumentów — równoleglenie pracy) i **fan-out** (każdy do wszystkich). Haczyk: load balancing plus redelivery nieuchronnie **przestawia kolejność** komunikatów — a po dostarczeniu broker komunikat kasuje, więc odbiór jest destrukcyjny i nie da się „przeczytać jeszcze raz".

**Logi partycjonowane** (Kafka, Kinesis, DistributedLog) to hybryda: trwałość bazy danych plus niskie opóźnienia komunikacji. Producent dopisuje komunikaty na koniec append-only loga, konsument czyta go sekwencyjnie (jak `tail -f`). Log dzieli się na **partycje** na różnych maszynach; w obrębie partycji każdy komunikat dostaje monotoniczny **offset**, więc kolejność jest totalna (między partycjami — żadnych gwarancji). Broker nie śledzi acków per komunikat, tylko okresowo zapisuje offset konsumenta — dokładnie jak **log sequence number w replikacji**: broker zachowuje się jak baza-lider, konsument jak follower. Czytanie jest niedestrukcyjne, więc wolny konsument szkodzi tylko sobie, można bez ryzyka podpiąć konsumenta eksperymentalnego do produkcji, a cofnięcie offsetu daje **replay** — przetwarzanie strumienia robi się powtarzalne jak batch. Dysk buforuje typowo dni lub tygodnie historii. Wybór praktyczny: JMS/AMQP, gdy komunikaty są drogie w przetwarzaniu, a kolejność nieistotna; log, gdy przepustowość wysoka, każdy komunikat szybki, a kolejność ważna.

Druga część fragmentu odwraca perspektywę: **zapis do bazy też jest zdarzeniem**. Log replikacji to strumień zdarzeń zapisu. Realne aplikacje łączą wiele systemów (OLTP, cache, indeks pełnotekstowy, hurtownia) i te kopie trzeba synchronizować. **Dual writes** — aplikacja pisze sama do każdego systemu — to pułapka: wyścig dwóch klientów zostawia bazę i indeks **trwale niespójne** bez żadnego błędu, a częściowa awaria (jeden zapis się udał, drugi nie) wymaga kosztownego atomic commit. Rozwiązanie: niech baza będzie jedynym liderem, a reszta jej followerami. **Change Data Capture (CDC)** wyciąga z bazy strumień wszystkich zmian — zwykle parsując log replikacji (Debezium/Maxwell dla MySQL, Bottled Water dla PostgreSQL, Databus w LinkedIn) — i przez log-based broker (zachowujący kolejność!) karmi systemy pochodne. Do odbudowy pełnego stanu służy **snapshot początkowy** albo elegantsza **kompakcja loga**: trzymaj tylko najnowszą wartość każdego klucza, a skompaktowany topik Kafki zawiera pełną kopię bazy — nowy konsument startuje od offsetu 0 bez żadnego snapshotu.

**Event sourcing** (z domain-driven design) stosuje tę samą ideę na wyższym poziomie abstrakcji: aplikacja od początku zapisuje niemutowalne zdarzenia wyrażające **intencję użytkownika** („student anulował zapis na kurs"), nie mechaniczne zmiany wierszy. Kluczowe rozróżnienie: **command vs event** — żądanie jest najpierw komendą, którą trzeba zwalidować (czy miejsce wolne?), a dopiero po akceptacji staje się zdarzeniem: trwałym, niemutowalnym faktem, którego konsumenci nie mogą odrzucić. Stan bieżący wyprowadza się z loga deterministyczną transformacją; kompakcja jak w CDC nie działa (późniejsze zdarzenia nie nadpisują wcześniejszych), więc potrzebna jest pełna historia, a snapshoty stanu to tylko optymalizacja.

Finał to filozoficzne domknięcie: **stan zmienny i niemutowalny log to dwie strony tej samej monety** — stan to „całka" ze strumienia zdarzeń po czasie. Księgowi wiedzą to od stuleci: błędów w księdze się nie maże, dopisuje się transakcję korygującą. Niemutowalny log daje audytowalność, łatwiejsze odzyskiwanie po zdeployowaniu buggy kodu i więcej informacji niż sam stan (koszyk porzucony mówi analityce więcej niż koszyk pusty). Z jednego loga można wyprowadzić **wiele widoków zoptymalizowanych pod odczyt** (CQRS) — spór normalizacja vs denormalizacja przestaje mieć znaczenie, bo widoki i tak są spójne z logiem. Ograniczenia: konsumenci są asynchroniczni (problem read-your-own-writes), duży churn danych rozdyma historię, a prawo do bycia zapomnianym wymaga **naprawdę usuwać** dane (Datomic: excision) — co jest zaskakująco trudne, bo kopie żyją wszędzie.

## Najważniejsze cytaty

> "Why can we not have a hybrid, combining the durable storage approach of databases with the low-latency notification facilities of messaging? This is the idea behind log-based message brokers."

Cała idea Kafki w dwóch zdaniach: trwałe przechowywanie z bazy danych plus natychmiastowe powiadamianie z komunikacji.

> "This is not the case with AMQP/JMS-style messaging: receiving a message is destructive if the acknowledgment causes it to be deleted from the broker, so you cannot run the same consumer again and expect to get the same result."

Kluczowa wada klasycznych brokerów: odbiór niszczy dane. Log-based broker czyta jak z pliku — stąd replay, eksperymenty i powtarzalność znana z batcha.

> "Exactly the same principle is used here: the message broker behaves like a leader database, and the consumer like a follower."

Offset konsumenta to log sequence number z replikacji baz danych. Komunikacja i replikacja okazują się tym samym mechanizmem.

> "The key idea is that mutable state and an append-only log of immutable events do not contradict each other: they are two sides of the same coin."

Stan to wynik scałkowania zdarzeń po czasie, changelog to pochodna stanu. Nie musisz wybierać — możesz mieć jedno wyprowadzone z drugiego.

> "The truth is the log. The database is a cache of a subset of the log. That cached subset happens to be the latest value of each record and index value from the log."

Pat Helland odwraca hierarchię: to nie log jest dodatkiem do bazy, tylko baza jest cache'em loga. Najwyżej cytowane zdanie tego rozdziału.

## Myśl dnia

Append-only log to wspólny mianownik komunikacji i baz danych: broker to baza-lider, konsument to follower, a tabela w bazie to tylko cache najnowszych wartości z loga. Kto trzyma niemutowalne zdarzenia jako źródło prawdy, dostaje replay, audyt i dowolnie wiele widoków odczytu — w cenie asynchroniczności.

---

*Jutro: druga połowa rozdziału 11 — „Processing Streams": zastosowania przetwarzania strumieni, rozumowanie o czasie (event time vs processing time, okna), joiny strumieni i odporność na awarie.*
