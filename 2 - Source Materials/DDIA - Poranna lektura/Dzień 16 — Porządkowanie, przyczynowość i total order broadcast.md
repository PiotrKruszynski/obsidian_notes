# Dzień 16 — Rozdział 9 (2/3): Porządkowanie, przyczynowość i total order broadcast

## O czym jest

Druga część rozdziału 9 zbiera wątek, który przewija się przez całą książkę — porządkowanie zdarzeń — i pokazuje, że kryje się za nim głęboki związek między przyczynowością, linearyzowalnością i konsensusem. Kleppmann zaczyna od przyczynowości: jeśli operacja B "wie o" operacji A (bo ją odczytała, albo jest jej logiczną konsekwencją), to A musi poprzedzać B we wszystkich replikach. To właśnie łamią zjawiska typu odczyt niespójnego prefiksu (odpowiedź widoczna przed pytaniem) czy write skew w transakcjach. Kluczowe rozróżnienie: przyczynowość daje tylko porządek częściowy (niektóre operacje są nieporównywalne, bo są współbieżne — jak commity na różnych gałęziach w Gicie), podczas gdy linearyzowalność wymusza porządek całkowity — jedną, prostą oś czasu bez rozgałęzień. Z tego wynika ważny fakt: linearyzowalność implikuje przyczynowość, ale jest od niej silniejsza (droższa) — a niedawne badania nad "spójnością przyczynową" (causal consistency) próbują dać namiastkę porządku bez płacenia pełnej ceny wydajnościowej CAP.

Dalej autor pokazuje, jak w praktyce nadawać operacjom numery porządkowe. Naiwne generatory (liczby parzyste/nieparzyste na różnych węzłach, zegary fizyczne, przedziały zarezerwowane blokami) są szybkie, ale niespójne z przyczynowością. Rozwiązaniem jest znacznik czasu Lamporta (Lamport timestamp) z 1978 roku: para (licznik, ID węzła), gdzie każdy węzeł i klient propaguje najwyższą widzianą wartość licznika i natychmiast się do niej podciąga. To daje porządek całkowity zgodny z przyczynowością — ale, co zaskakujące, nie wystarcza do rozwiązania praktycznych problemów typu "unikalna nazwa użytkownika", bo w danej chwili węzeł nie wie, czy gdzie indziej nie trwa równoległe żądanie z niższym znacznikiem. Porządek całkowity "krystalizuje się" dopiero po zebraniu wszystkich operacji — a to za późno na podjęcie natychmiastowej decyzji.

Odpowiedzią jest total order broadcast (rozgłaszanie w porządku całkowitym): protokół gwarantujący, że (1) żadna wiadomość nie ginie i dociera do wszystkich węzłów, oraz (2) wszystkie węzły widzą wiadomości w tej samej kolejności, ustalonej raz na zawsze w momencie doręczenia. To dokładnie to, czego potrzeba do replikacji bazy danych (state machine replication) i do serializowalnych transakcji jako deterministycznych procedur składowanych. Kleppmann pokazuje też, że total order broadcast i linearyzowalny rejestr z operacją compare-and-set / increment-and-get są sobie matematycznie równoważne — każdy da się zbudować z drugiego. A ponieważ zbudowanie niezawodnego, linearyzowalnego licznika w obliczu awarii sieci nieuchronnie prowadzi do algorytmu konsensusu, rozdział kończy się zapowiedzią: to właśnie konsensus jest tematem kolejnej części.

## Najważniejsze cytaty

> "Causality imposes an ordering on events: cause comes before effect; a message is sent before that message is received; the question comes before the answer."

Esencja przyczynowości — porządek wynikający z logiki "co zależy od czego", nie z zegara.

> "Linearizability implies causality: any system that is linearizable will preserve causality correctly... In fact, causal consistency is the strongest possible consistency model that does not slow down due to network delays."

Kluczowa relacja rozdziału: linearyzowalność to "za dużo" — daje przyczynowość za darmo, ale płaci cenę CAP; spójność przyczynowa to najsilniejsza gwarancja, która tej ceny unika.

> "The problem here is that the total order of operations only emerges after you have collected all of the operations... it's not sufficient to have a total ordering of operations—you also need to know when that order is finalized."

Dlaczego same znaczniki Lamporta nie wystarczą do np. unikalności nazw użytkowników — brakuje wiedzy "kiedy mogę być pewien, że nikt mnie nie wyprzedzi".

> "Total order broadcast is exactly what you need for database replication: if every message represents a write to the database, and every replica processes the same writes in the same order, then the replicas will remain consistent with each other."

Praktyczne zastosowanie — to fundament replikacji z jednym logiem zapisów (state machine replication).

> "It can be proved that a linearizable compare-and-set (or increment-and-get) register and total order broadcast are both equivalent to consensus. That is, if you can solve one of these problems, you can transform it into a solution for the others."

Zaskakujący wynik teoretyczny spinający cały rozdział: trzy z pozoru różne problemy to w gruncie rzeczy jeden i ten sam problem — konsensus.

## Myśl dnia

Przyczynowość daje tylko porządek częściowy i jest tania; linearyzowalność daje porządek całkowity, ale jest droga — a total order broadcast to praktyczny sposób na "tanie" uzyskanie porządku całkowitego, który jednak w obliczu awarii nieuchronnie okazuje się być tym samym problemem co konsensus.

Jutro: rozdział 9, część 3/3 — transakcje rozproszone i konsensus: two-phase commit, algorytmy konsensusu (Paxos/Raft w skrócie) i usługi koordynacji jak ZooKeeper.
