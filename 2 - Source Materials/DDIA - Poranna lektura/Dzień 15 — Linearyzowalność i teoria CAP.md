# Dzień 15 — Rozdział 9 (1/3): Linearyzowalność i teoria CAP

## O czym jest

Rozdział 9 otwiera temat spójności i konsensusu w systemach rozproszonych — czyli tego, jakie gwarancje da się w ogóle zaoferować aplikacji, gdy dane żyją na wielu maszynach naraz. Kleppmann zaczyna od przypomnienia, że większość baz replikowanych daje tylko *eventual consistency*: jeśli przestaniesz pisać i poczekasz, repliki w końcu się zgodzą, ale do tego czasu odczyty mogą zwracać cokolwiek. To słaba gwarancja, więc autor wprowadza dużo silniejszy model: **linearyzowalność** (linearizability), zwaną też spójnością silną, natychmiastową albo zewnętrzną.

Idea jest prosta do wyobrażenia: system ma sprawiać wrażenie, jakby istniała tylko jedna kopia danych, a każda operacja na niej jest atomowa. W praktyce oznacza to gwarancję *świeżości* — gdy jeden klient skończy zapis, każdy kolejny odczyt (od dowolnego klienta) musi zwrócić tę nową wartość, nigdy starszą. Kleppmann ilustruje to historią Alice i Boba oglądających wynik finału mundialu na telefonach — jeśli Bob odświeża stronę już po tym, jak usłyszał wynik od Alice, a jego telefon nadal pokazuje "mecz trwa", to złamanie linearyzowalności. Rozdział szczegółowo pokazuje też, czym linearyzowalność różni się od serializowalności transakcji (SSI) — to dwie niezależne, często mylone własności.

Dalej autor sprawdza, które metody replikacji potrafią dać linearyzowalność: replikacja z jednym liderem — potencjalnie tak (jeśli czytasz z lidera lub synchronicznych followerów); algorytmy konsensusu (ZooKeeper, etcd) — tak, z założenia; replikacja z wieloma liderami — nie; replikacja bezliderowa (styl Dynamo) — z reguły też nie, nawet przy ścisłym kworum (w + r > n), bo opóźnienia sieciowe wciąż pozwalają na sytuacje niespójne.

Ostatnia część to koszt linearyzowalności — czyli twierdzenie CAP. Kleppmann jest tu krytyczny wobec popularnego sloganu "Consistency, Availability, Partition tolerance: wybierz 2 z 3", bo partycje sieciowe to awaria, a nie opcja wyboru. Realny wybór pojawia się dopiero, gdy partycja faktycznie wystąpi: albo system pozostaje spójny i część replik przestaje odpowiadać, albo pozostaje dostępny wszędzie, ale traci linearyzowalność. Co ciekawe, nawet pamięć RAM we współczesnym wielordzeniowym procesorze nie jest linearyzowalna (przez cache'e rdzeni) — a powodem rezygnacji z tej gwarancji jest tam wydajność, nie odporność na awarie. Dowód Attiyi i Welch mówi wprost: nie da się zbudować szybkiej linearyzowalnej pamięci — czas odpowiedzi rośnie proporcjonalnie do niepewności opóźnień w sieci.

## Najważniejsze cytaty

> "In a linearizable system, as soon as one client successfully completes a write, all clients reading from the database must be able to see the value just written."

Sedno definicji: linearyzowalność to gwarancja świeżości odczytu, nie tylko "w końcu się zgodzimy".

> "Serializability is an isolation property of transactions... Linearizability is a recency guarantee on reads and writes of a register (an individual object)."

Kluczowe rozróżnienie rozdziału — te dwa pojęcia brzmią podobnie, ale dotyczą zupełnie innych rzeczy (transakcje wieloobiektowe vs. pojedynczy rejestr w czasie).

> "CAP is sometimes presented as Consistency, Availability, Partition tolerance: pick 2 out of 3. Unfortunately, putting it this way is misleading because network partitions are a kind of fault, so they aren't something about which you have a choice."

Bezpośrednia krytyka najpopularniejszej (i błędnej) interpretacji CAP, którą powtarza się w niezliczonych rozmowach rekrutacyjnych.

> "A better way of phrasing CAP would be either Consistent or Available when Partitioned."

Poprawna, węższa wersja twierdzenia — wybór dotyczy tylko chwili, gdy partycja faktycznie trwa.

> "Attiya and Welch prove that if you want linearizability, the response time of read and write requests is at least proportional to the uncertainty of delays in the network."

Formalny dowód, że linearyzowalność i niskie opóźnienia są ze sobą w konflikcie fundamentalnym, nie tylko inżynierskim.

## Myśl dnia

Linearyzowalność daje wygodną iluzję "jednej kopii danych", ale ta iluzja ma cenę: przy partycji sieciowej trzeba wybrać między spójnością a dostępnością, a nawet bez awarii silna spójność jest z natury wolniejsza — co pokazuje sam sprzęt, na którym pracujemy.

Jutro: rozdział 9, część 2/3 — gwarancje porządkowania (Ordering Guarantees): przyczynowość, znaczniki czasu Lamporta i total order broadcast.
