# Dzień 08 — Replikacja: lider i zwolennicy (Rozdział 5, część 1/2)

**Książka:** Designing Data-Intensive Applications — Martin Kleppmann (2017)
**Fragment:** Rozdział 5 „Replication", pierwsza połowa (od początku do Multi-Leader Replication Topologies)

---

## O czym jest ten fragment

Rozdział 5 to głębokie nurkowanie w temat replikacji — przechowywania kopii tych samych danych na wielu maszynach połączonych siecią. Kleppmann zaczyna od trzech powodów, dla których w ogóle to robimy: zmniejszenie latencji (dane bliżej użytkownika), odporność na awarie (system działa mimo upadku węzła) i skalowalność odczytu (więcej maszyn = więcej obsłużonych zapytań). Ale zaraz potem uderza w sedno: **jedyną trudnością jest obsługa zmian**. Statyczne dane kopiuje się raz i koniec; problem zaczyna się, gdy dane mutują.

### Single-leader: lider i jego zwolennicy

Najpopularniejszy model to replikacja z jednym liderem (master-slave). Każda replika (węzeł z kopią danych) to follower. Zapis idzie zawsze do lidera, który propaguje go do followerów przez tzw. replication log. Odczyty mogą iść do każdego followera — to podstawa skalowalności odczytu.

Kluczowe pytanie: czy replikacja jest **synchroniczna** czy **asynchroniczna**? Synchroniczna gwarantuje, że follower potwierdzi zapis zanim lider odblokuje klienta. W praktyce zwykle jeden follower jest synchroniczny (semi-synchronous), a reszta asynchroniczna — bo gdyby wszystkie były synchroniczne, jeden wolny węzeł blokowałby cały system.

Asynchronia ma cenę: jeśli lider padnie zanim zdąży zreplikować, **dane mogą zaginąć** na zawsze.

### Failover: trudniejsze niż się wydaje

Gdy lider pada, jeden z followerów musi zostać nowym liderem. Brzmi prosto; w praktyce pełne jest pułapek:

- **Utrata danych** — nowy lider może nie mieć wszystkich zapisów starego lidera.
- **Konflikty** — stary lider wraca i myśli, że nadal jest liderem (split brain).
- **Nieprawidłowy threshold** — zbyt krótki timeout powoduje niepotrzebne failovery; zbyt długi — długą niedostępność.

Kleppmann pointuje: niektóre zespoły wolą **ręczny failover** właśnie dlatego, że automatyczny jest zbyt ryzykowny.

### Cztery metody implementacji replication log

1. **Statement-based** — lider wysyła do followerów surowe SQL (`INSERT`, `UPDATE`). Problem: funkcje niedeterministyczne (`NOW()`, `RAND()`), wyzwalacze i sekwencje auto-increment zachowają się różnie. MySQL tak to początkowo robił, ale porzucił.
2. **WAL shipping** — lider wysyła bajty z write-ahead log (tego samego, co służy do recovery). PostgreSQL i Oracle tak działają. Wada: log jest ściśle powiązany z formatem storage engine — nawet zmiana wersji bazy może uniemożliwić replikację między różnymi wersjami.
3. **Logical (row-based) log** — oddzielny strumień opisujący zmiany na poziomie wierszy, niezależny od storage engine. MySQL binlog w trybie row-based. Łatwiejszy do parsowania przez zewnętrzne narzędzia (CDC — change data capture).
4. **Trigger-based** — aplikacja lub baza same rejestrują zmiany w osobnej tabeli. Bardzo elastyczne, ale wolniejsze i bardziej podatne na błędy.

### Eventual consistency i replication lag

Przy asynchronicznych followerach nieuchronnie pojawia się **replication lag** — chwilowe opóźnienie między zapisem u lidera a pojawieniem się go u followera. W normalnych warunkach to milisekundy; przy przeciążeniu sieci — minuty. To prowadzi do **eventual consistency**: system jest spójny „w końcu", ale nie w każdej chwili.

Kleppmann omawia trzy konkretne anomalie i jak im zaradzić:

**1. Reading Your Own Writes (read-your-writes consistency)**
Piszesz komentarz, odświeżasz stronę — komentarza nie ma, bo trafił do lagującego followera. Rozwiązanie: jeśli użytkownik czyta własne dane (np. swój profil), zawsze czytaj z lidera. Albo śledź timestamp ostatniego zapisu i przez minutę po nim czytaj tylko z lidera.

**2. Monotonic Reads**
Użytkownik wysyła dwa zapytania do dwóch różnych followerów. Pierwsze zwraca nowy komentarz, drugie (do bardziej lagującego) — już go nie widzi. Wygląda jak cofanie się w czasie. Rozwiązanie: każdy użytkownik zawsze trafia do tego samego followera (np. hash user_id).

**3. Consistent Prefix Reads**
W systemie shardowanym odpowiedź może dojść przed pytaniem — Pani pyta, Pan odpowiada, a czytelnik widzi najpierw odpowiedź. Rozwiązanie: powiązane zapisy idą do tego samego sharda, lub używamy zależności przyczynowych (causal consistency).

### Multi-Leader Replication: kiedy jeden lider to za mało

Multi-leader (master-master, active/active) pozwala wielu węzłom przyjmować zapisy. Najczęstsze przypadki użycia:

- **Multi-datacenter** — każde centrum danych ma swojego lidera. Zapis jest lokalny (niska latencja), a replikacja między datacenter — asynchroniczna. Odporność na awarię całego DC.
- **Offline operation** — aplikacja mobilna (np. kalendarz) zapisuje lokalnie, syncuje gdy wróci do sieci. Każde urządzenie to de facto lider.
- **Collaborative editing** — Google Docs: wiele osób edytuje jednocześnie. Zmiany propagowane asynchronicznie.

Wielki problem multi-leader: **konflikty zapisu**. Dwóch użytkowników modyfikuje ten sam rekord jednocześnie w różnych liderach — obaj dostają potwierdzenie sukcesu, a konflikt wychodzi przy replikacji.

Strategie rozwiązania konfliktów:
- **Last Write Wins (LWW)** — timestamp decyduje; proste, ale traci dane.
- **Conflict avoidance** — wszystkie zapisy danego rekordu kieruj do jednego lidera. Eliminuje konflikt, ale traci elastyczność.
- **Converging to consistent state** — repliki muszą dojść do tego samego stanu. Różne podejścia: merge wartości, trzymaj wszystkie wersje i oddaj decyzję użytkownikowi.
- **Custom conflict resolution** — aplikacja sama rozstrzyga (np. w kodzie on-write lub on-read).

---

## Najważniejsze cytaty

> "All of the difficulty in replication lies in handling changes to replicated data, and that's what this chapter is about."

*Kleppmann od razu stawia sprawę jasno: kopiowanie statycznych danych jest trywialne. Cała sztuka to propagowanie zmian w sposób spójny.*

> "If you stop writing to the database and wait a while, the followers will eventually catch up and become consistent with the leader. For that reason, this effect is known as eventual consistency."

*Eventual consistency to nie magia — to po prostu lag, który znika gdy przestajemy pisać. Problem: „eventually" jest celowo nieokreślone.*

> "The term 'eventually' is deliberately vague: in general, there is no limit to how far a replica can fall behind."

*To ważne ostrzeżenie: w teorii follower może lagować nieskończenie długo. W praktyce systemy nie dają żadnej gwarancji co do tego opóźnienia.*

> "Unfortunately, if an application reads from an asynchronous follower, it may see outdated information if the follower has fallen behind. This leads to apparent inconsistencies in the database."

*Sedno problemu: z punktu widzenia użytkownika wygląda to jak błąd lub utrata danych. System działa poprawnie — ale użytkownik nie wie, co to jest replication lag.*

> "Some teams prefer to perform failovers manually, even in systems that otherwise support automatic failover, precisely because the automatic process is too risky."

*Ironiczny wniosek: niekiedy „mądrzy" inżynierowie wolą ręczny failover, bo automatyczny może narobić więcej szkody niż pożytku.*

---

## Myśl dnia

Replikacja to nie kopia zapasowa — to żywy, ciągły proces propagowania zmian między węzłami, obarczony nieusuwalnym opóźnieniem. Każdy system replikowany asynchronicznie żyje w stanie tymczasowej niespójności, i trzeba to zaakceptować. Kleppmann uczy, że zamiast walczyć z lagiem, lepiej precyzyjnie zdefiniować, jakie gwarancje spójności aplikacja naprawdę potrzebuje — i budować pod te gwarancje.

---

*Jutro (Dzień 09): druga połowa Rozdziału 5 — Leaderless Replication (Dynamo-style), kwora, wykrywanie równoległych zapisów i wektory wersji.*
