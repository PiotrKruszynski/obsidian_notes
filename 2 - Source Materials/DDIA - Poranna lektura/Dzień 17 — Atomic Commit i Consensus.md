# Dzień 17: Atomic Commit, Consensus i Koordynacja (Rozdział 9, część 3/3)

## O czym jest

Ostatnia część rozdziału 9 zanurza się w sercu systemów rozproszonych: problemie, jak sprawić, by rozproszone węzły osiągnęły porozumienie (consensus) mimo awarii i sieci. Kleppmann zaczyna od atomic commit problem — gdy transakcja musi powieść się na wszystkich węzłach albo nie powieść się na żadnym. Wprowadza słynne twierdzenie FLP (Fischer, Lynch, Paterson), które udowadnia niemożliwość osiągnięcia consensusu w asynchronicznych systemach z potencjalnymi awariami węzłów.

Następnie omawia praktyczne rozwiązania: dwufazowy commit (2PC) — klasyczny algorytm, który działa, ale ma poważne wady (blokowanie, single point of failure). Pokazuje, że dodanie timeoutów (wbrew FLP) czy losowości rozwiązuje problem teoretycznie. Dalej wprowadza Paxos i inne algorytmy consensus, które rzeczywiście działają w praktyce. Na koniec przechodzi do service discovery, membership management i koordynacji węzłów — jak wiedzieć, które węzły są żywe, jak przydzielić im pracę.

## Najważniejsze cytaty

**1. "The atomic commit problem"**  
> *"In a database that supports transactions spanning several nodes or partitions, we have the problem that a transaction may fail on some nodes but succeed on others. If we want to maintain transaction atomicity (in the sense of ACID), we have to get all nodes to agree on the outcome of the transaction: either they all abort/roll back (if anything goes wrong) or they all commit (if nothing goes wrong)."*

**Wyjaśnienie:** To sedno problemu — transakcje rozproszone wymagają całkowitego porozumienia. Brak zgody = niespójność bazy.

---

**2. "FLP impossibility result"**  
> *"The FLP result proves that there is no algorithm that is always able to reach consensus if there is a risk that a node may crash. In a distributed system, we must assume that nodes may crash, so reliable consensus is impossible."*

**Wyjaśnienie:** Twierdzenie matematyczne pokazujące, że consensus jest teoretycznie niemożliwy, gdy wziąć dosłownie założenia asynchronicznego modelu.

---

**3. "Timeouts break the impossibility"**  
> *"If the algorithm is allowed to use timeouts, or some other way of identifying suspected crashed nodes (even if the suspicion is sometimes wrong), then consensus becomes solvable. Even just allowing the algorithm to use random numbers is sufficient to get around the impossibility result."*

**Wyjaśnienie:** W praktyce — timeouty i zegary załatwiają problem. To, że czasem się mylimy, nie psuje algorytmu.

---

**4. "Two-phase commit: a system of promises"**  
> *"Two-phase commit is an algorithm for achieving atomic transaction commit across multiple databases or services. The key deciding moment for whether the transaction commits or aborts is the moment at which the coordinator makes a decision."*

**Wyjaśnienie:** 2PC to „system obietnic" — koordynator pyta wszystkich (faza 1), czy mogą commitować, potem każe wszystkim (faza 2). Problem: koordynator może się zawisnąć.

---

**5. "Limitations of distributed transactions"**  
> *"Holding locks while in doubt [during coordinator failure] is dangerous because it can lead to deadlocks and availability problems. Recovering from coordinator failure is tricky and often requires manual intervention."*

**Wyjaśnienie:** 2PC ma brutalne wady — jeśli koordynator pada, wszystkie pozostałe węzły czekają z zablokowanymi zasobami. To jest jeden z powodów, dla których NoSQL systemy 2PC unikają.

## Myśl dnia

Consensus to jeden z najtrudniejszych problemów systemów rozproszonych. Matematyka (FLP) mówi: niemożliwe. Praktyka mówi: możliwe, ale drażliwe. Timeouty i algorytmy takie jak Paxos czy Raft są pragmatycznym kompromisem — żyją w świecie, gdzie węzły mogą się zawieszać, sieci mogą się zerwać, a zegary nie są idealne. 2PC jest ostrzeżeniem: consensus bez dobrych algorytmów to blokada i cierpienie.

---

**Jutro (Dzień 18):** Ostatni rozdział (12) — Epilog: części 1/3 — podsumowanie i przyszłość systemów danych.
