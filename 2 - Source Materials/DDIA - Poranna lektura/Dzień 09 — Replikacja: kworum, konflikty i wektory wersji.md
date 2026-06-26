# Dzień 09 — Replikacja: kworum, konflikty i wektory wersji (Rozdział 5, część 2/2)

**Książka:** Designing Data-Intensive Applications — Martin Kleppmann (2017)
**Fragment:** Rozdział 5 „Replication", druga połowa (Multi-Leader Replication Topologies → koniec rozdziału)

---

## O czym jest ten fragment

Druga połowa rozdziału 5 to trzy duże tematy: topologie replikacji multi-leader, replikacja bez lidera (leaderless / Dynamo-style) oraz problem wykrywania i rozwiązywania konfliktów między równoległymi zapisami.

### Topologie replikacji multi-leader

W układzie z wieloma liderami ważne jest, jak propagują się zapisy między węzłami. Trzy popularne topologie to: okrągła (circular), gwiaździsta (star) i all-to-all. Circular i star mają jeden punkt awarii — jeśli jeden węzeł padnie, przepływ replikacji zostaje przerwany. Topologia all-to-all jest odporniejsza, ale wprowadza problem kolejności: zapis B zależny od zapisu A może dotrzeć do repliki przed zapisem A, bo sieć między liderami nie jest jednakowo szybka. Kleppmann wskazuje, że wiele systemów multi-leader (np. PostgreSQL BDR, Tungsten Replicator for MySQL) słabo radzi sobie z tym problemem.

### Replikacja bez lidera — Dynamo-style

Amazon Dynamo (2007) spopularyzował inną filozofię: żaden węzeł nie jest liderem, klient wysyła zapis równolegle do kilku replik. Jeśli jedna replika jest niedostępna — nie ma failoveru, po prostu ignorujemy jej brak i czekamy na potwierdzenie od wymaganej liczby pozostałych.

**Kworum (quorum):** mamy n replik, zapis musi potwierdzić w węzłów, odczyt musi zapytać r węzłów. Warunek `w + r > n` gwarantuje, że zbiory węzłów zapisu i odczytu muszą się nachodzić — czyli co najmniej jeden węzeł odczytywany będzie miał aktualną wartość. Typowo: n=3, w=2, r=2.

Gdy węzeł wraca po przestoju, dwie techniki pomagają mu dogonić resztę:
- **Read repair** — klient przy odczycie równoległym wykrywa przestarzałą odpowiedź i zapisuje nowszą wartość z powrotem do opóźnionej repliki.
- **Anti-entropy** — proces tła szuka różnic między replikami i kopiuje brakujące dane.

**Sloppy quorum i hinted handoff:** gdy węzły "domowe" danej wartości są niedostępne, a klient może dosięgnąć inne węzły klastra, system może zaakceptować zapis na zastępczych węzłach (sloppy quorum). Po powrocie "domowych" węzłów dane są do nich transferowane (hinted handoff). To zwiększa dostępność zapisu, ale osłabia gwarancje spójności.

### Ograniczenia kworum

Mimo że `w + r > n` wygląda solidnie, Kleppmann wskazuje wiele scenariuszy, w których stale (nieaktualne) wartości mogą mimo to trafić do klienta: dwa równoległe zapisy z niejasną kolejnością, zapis który udał się na mniej niż w węzłach i nie został wycofany z tych, gdzie się udał, przywrócenie węzła ze starą kopią danych, czy właśnie sloppy quorum. **Dynamo-style bazy to systemy eventual consistency** — nie gwarantują read-after-write, monotonic reads ani consistent prefix reads bez dodatkowych mechanizmów.

### Wykrywanie równoległych zapisów

Gdy kilka klientów jednocześnie pisze ten sam klucz, replikii mogą widzieć te zapisy w różnej kolejności — powstaje konflikt. Kluczowe pojęcie: operacja A *happens-before* operację B wtedy, gdy B zna A lub od niej zależy. Dwie operacje, które wzajemnie o sobie nie wiedzą, są **concurrent** (równoległe) — i wtedy potrzeba rozwiązania konfliktu.

Najprostsze podejście to **Last Write Wins (LWW)** — wygrywa zapis z największym timestampem. LWW jest domyślną metodą w Cassandrze. Problem: może cicho wyrzucać dane, bo zegary w rozproszonych systemach nie są w pełni zsynchronizowane.

**Algorytm z numerami wersji:** serwer trzyma numer wersji dla każdego klucza. Klient przed zapisem musi odczytać klucz (dostaje aktualny numer wersji i wszystkie wartości). Przy zapisie podaje numer wersji z odczytu i merguje wszystkie wartości, które dostał. Serwer wie wtedy: wartości z tym numerem wersji lub niższe zostały zmergowane — można je zastąpić; wartości z wyższym numerem wersji są równoległe — trzeba je zachować jako rodzeństwo (siblings). Klient jest odpowiedzialny za merge wartości sibling.

Przy usuwaniu elementów nie można ich po prostu kasować — zamiast tego stosuje się **tombstone** (znacznik usunięcia), bo inaczej merge z inną repliką "wskrzesi" usunięty element.

**Wektory wersji (version vectors):** gdy replik jest wiele, jeden globalny numer wersji nie wystarczy. Każda replika trzyma swój własny licznik dla każdego klucza. Zbiór tych liczników ze wszystkich replik to właśnie wektor wersji (Riak 2.0 używa *dotted version vectors*). Pozwala to odróżnić nadpisanie od równoległego zapisu nawet w systemie bez lidera.

---

## Najważniejsze cytaty

> "If you have n replicas, every write must be confirmed by w nodes to be considered successful, and we must query at least r nodes for each read. As long as w + r > n, we expect to get an up-to-date value when reading."

Fundamentalna formuła kworum: suma węzłów zapisu i odczytu musi przekroczyć liczbę replik, by gwarantować nachodzenie się zbiorów i aktualność odczytu.

> "LWW achieves the goal of eventual convergence, but at the cost of durability: if there are several concurrent writes to the same key, even if they were all reported as successful to the client, only one of the writes will survive and the others will be silently discarded."

Last Write Wins wygląda prosto, ale **cicho wyrzuca dane** — każdy, kto polega na LWW w systemie z równoległymi zapisami, powinien to dobrze rozumieć.

> "Two operations are concurrent if neither happens before the other (i.e., neither knows about the other)."

Definicja współbieżności w systemach rozproszonych — nie chodzi o czas zegarowy, lecz o wzajemną wiedzę (kauzalność).

> "A sloppy quorum actually isn't a quorum at all in the traditional sense. It's only an assurance of durability, namely that the data is stored on w nodes somewhere. There is no guarantee that a read of r nodes will see it until the hinted handoff has completed."

Sloppy quorum to nie prawdziwe kworum — to tylko gwarancja, że dane gdzieś przetrwają, nie że będą natychmiast widoczne.

> "Dynamo-style databases are generally optimized for use cases that can tolerate eventual consistency. The parameters w and r allow you to adjust the probability of stale values being read, but it's wise to not take them as absolute guarantees."

Kworum to narzędzie do strojenia prawdopodobieństwa, nie gwarancja spójności — tu Kleppmann ostrzega przed zbyt dużym zaufaniem do parametrów w i r.

---

## Myśl dnia

Replikacja bez lidera (Dynamo-style) kupuje dostępność i odporność na partycje kosztem spójności — kworum daje probabilistyczne gwarancje, nie absolutne. Każdy system, który mówi "eventual consistency", de facto przenosi ciężar rozwiązywania konfliktów na aplikację lub deweloperów; algorytmy takie jak wektory wersji i tombstones to narzędzia, które pomagają nie tracić danych przy tej kompromisowej architekturze.

---

**Jutro (Dzień 10):** Rozdział 6 (całość) — Partycjonowanie (Partitioning): jak podzielić duży zbiór danych na partycje, routing zapytań, hot spots i strategie partycjonowania.
