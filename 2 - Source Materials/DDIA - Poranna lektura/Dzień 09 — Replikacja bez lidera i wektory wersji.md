# Dzień 09 — Replikacja bez lidera: kwora, konflikty i wektory wersji (Rozdział 5, część 2/2)

**Książka:** Designing Data-Intensive Applications — Martin Kleppmann (2017)
**Fragment:** Rozdział 5 „Replication", druga połowa (Leaderless Replication → Summary)

---

## O czym jest ten fragment

Druga połowa rozdziału 5 to głęboka wycieczka w świat replikacji bez lidera — tzw. architektury Dynamo-style, używanej przez Riak, Cassandrę i Voldemort. W modelu tym każda replika może przyjmować zapisy bezpośrednio od klienta, bez żadnego centralnego koordynatora. To radykalnie inne podejście niż single-leader, i przynosi inne kompromisy.

### Leaderless Replication: pisanie do wielu replik jednocześnie

Gdy jeden z węzłów jest niedostępny (np. restart po aktualizacji), w modelu z liderem trzeba robić failover. W modelu bez lidera — nie. Klient po prostu wysyła zapis do wszystkich replik równolegle. Jeśli dwie z trzech odpowiedź potwierdzą — zapis jest uznawany za udany. Niedostępna replika po prostu go przegapia.

Problem pojawia się przy odczycie: węzeł, który przegapił zapisy, może zwrócić stare dane. Dlatego odczyty też idą równolegle do wielu replik — klient porównuje wersje i bierze najnowszą.

Mechanizmy naprawcze to **read repair** (klient zapisuje nowszą wartość z powrotem do opóźnionej repliki przy okazji odczytu) oraz **anti-entropy** (proces w tle, który wykrywa różnice między replikami i je wyrównuje). Nie wszystkie systemy implementują oba — Voldemort nie ma anti-entropy, co oznacza, że rzadko czytane dane mogą być „wiecznie stare".

### Kwora: matematyka dostępności

Formuła kworum: jeśli mamy **n** replik, zapis musi potwierdzić **w** węzłów, odczyt musi zapytać **r** węzłów, i musi zachodzić **w + r > n**. Tylko wtedy gwarantujemy, że przynajmniej jeden odczytany węzeł będzie miał najnowsze dane.

Typowy wybór: n=3, w=2, r=2. Toleruje to awarię jednego węzła. Można konfigurować: r=1 i w=n daje szybkie odczyty kosztem zapisów; r=n i w=1 odwrotnie. Elastyczność to siła tego modelu.

Kleppmann jednak ostrzega: **kworum to nie gwarancja silnej spójności**. Istnieje wiele scenariuszy brzegowych — sloppy quorum, równoczesne zapisy, błędy częściowe — gdzie stale wartości mogą przeciec. Dynamo-style db są zaprojektowane dla eventual consistency, nie dla linearizability.

Osobna trudność: **monitoring opóźnienia** jest tu dużo trudniejszy niż w single-leader, bo nie ma jednolitego replication log. Nikt nie wie, jak stara jest replika, dopóki ktoś jej nie zapyta.

### Sloppy Quorum i Hinted Handoff

Gdy sieć partycjonuje się i klient nie może dotrzeć do wystarczającej liczby „domowych" węzłów, ma wybór: zwrócić błąd albo zapisać dane na zastępczych węzłach (sloppy quorum). Dane trafiają tymczasowo „do sąsiada", a po naprawie sieci są odsyłane do właściwego węzła (hinted handoff). To zwiększa dostępność zapisu, ale osłabia gwarancje spójności — bo dane mogą siedzieć „u sąsiada" przez pewien czas.

### Wykrywanie równoległych zapisów

Największy problem w leaderless: **dwa klienty mogą jednocześnie zapisywać do tego samego klucza na różnych węzłach** — i oba dostaną potwierdzenie sukcesu. Jak zdecydować, która wersja „wygrywa"?

Najprostsze podejście: **Last Write Wins (LWW)** — każdy zapis dostaje timestamp, wygrywa najnowszy. Cassandra używa tego domyślnie. Problem: zegary w systemach rozproszonych są zawodne. LWW po cichu usuwa dane — zapisy raportowane jako sukcesy mogą zaginąć.

Poprawne rozwiązanie wymaga zdefiniowania „zdarzenie A zaszło przed zdarzeniem B". Kleppmann precyzuje: **A happened before B, jeśli B wie o A, zależy od A albo na nim buduje**. Dwa zdarzenia są równoległe, jeśli żadne nie wie o drugim — niezależnie od czasu zegarowego.

### Algorytm numerów wersji (przykład koszyka)

Kleppmann pokazuje elegancki algorytm: serwer trzyma numer wersji dla każdego klucza. Każdy zapis: klient najpierw odczytuje (dostaje aktualną wersję + wszystkie wartości), potem wysyła nową wartość z numerem wersji, który dostał przy odczycie. Serwer wie, co może nadpisać (starsze lub równe wersje), a co zachować jako równoległe (wyższe wersje).

Efekt: żadne dane nie giną po cichu. Klient może dostać kilka równoległych wartości (Riak nazywa je **siblings**) i musi je scalić. Usuwanie danych wymaga specjalnego markera — **tombstone** — bo inaczej usunięty element może „zmartwychwstać" przy scalaniu.

### Wektory wersji

Gdy mamy wiele replik bez lidera, jeden numer wersji nie wystarczy. Każda replika potrzebuje własnego licznika. Zbiór numerów wersji ze wszystkich replik to **wektor wersji** (version vector). Riak 2.0 używa wariantu zwanego dotted version vector. Wektory wersji pozwalają odróżnić „ten zapis nadpisuje tamten" od „te dwa zapisy są równoległe".

---

## Najważniejsze cytaty

> "Dynamo-style databases are generally optimized for use cases that can tolerate eventual consistency. The parameters w and r allow you to adjust the probability of stale values being read, but it's wise to not take them as absolute guarantees."

*Kworum daje prawdopodobieństwo, nie pewność. Kleppmann jest bezwzględnie szczery: „wise to not take them as absolute guarantees" to ostrzeżenie dla wszystkich, którzy ślepo ufają matematyce kworum.*

> "Eventual consistency is a deliberately vague guarantee, but for operability it's important to be able to quantify 'eventual.'"

*„Eventual" może oznaczać milisekundy albo godziny. Z punktu widzenia operacyjnego różnica jest kolosalna — i właśnie dlatego monitoring lag w systemach leaderless jest tak trudny i tak ważny.*

> "LWW achieves the goal of eventual convergence, but at the cost of durability: if there are several concurrent writes to the same key, even if they were all reported as successful to the client, only one of the writes will survive and the others will be silently discarded."

*Last Write Wins brzmi niewinnie. W praktyce oznacza: „dane przepadają bez ostrzeżenia". Każdy, kto używa Cassandry, powinien to zdanie znać na pamięć.*

> "An operation A happens before another operation B if B knows about A, or depends on A, or builds upon A in some way. We can simply say that two operations are concurrent if neither happens before the other."

*Precyzyjna definicja współbieżności — niezależna od zegarów. To fundament, na którym stoi cały algorytm wektorów wersji i teoria przyczynowości w systemach rozproszonych.*

> "The only safe way of using a database with LWW is to ensure that a key is only written once and thereafter treated as immutable, thus avoiding any concurrent updates to the same key."

*Praktyczna rada: jeśli musisz używać LWW (np. Cassandra), projektuj klucze tak, by nigdy nie były nadpisywane — każdy zapis to nowy UUID.*

---

## Myśl dnia

Leaderless replication to architektura dla tych, którzy wybierają dostępność i tolerancję partycji ponad silną spójność — świadomie. Kleppmann pokazuje, że „eventual consistency" to nie magia: za kworum kryje się matematyka, za wykrywaniem konfliktów — precyzyjna definicja przyczynowości, a za scalaniem danych — prawdziwa praca aplikacji. Nie ma tu srebrnych kul. Cassandra, Riak i Dynamo dają potężne narzędzia, ale przerzucają ciężar rozwiązywania konfliktów na programistę.

---

*Jutro (Dzień 10): Rozdział 6 (całość) — Partycjonowanie. Jak dzielić duże zbiory danych na wiele węzłów, strategie partycjonowania (range vs hash), problemy z gorącymi kluczami i przepisywanie zapytań.*
