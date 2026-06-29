# Dzień 12 — Rozdział 7 (2/2): Transakcje: Szeregowalność, 2PL i SSI

**Źródło:** Designing Data-Intensive Applications, Martin Kleppmann (2017)
**Fragment:** Rozdział 7 — Transactions, druga połowa (od sekcji „Write Skew and Phantoms")

---

## O czym jest ten fragment

Druga połowa rozdziału 7 to podróż od subtelnych anomalii współbieżności do trzech strategii, które je wszystkie eliminują.

Kleppmann zaczyna od **write skew** — anomalii trudniejszej do wykrycia niż dirty write czy lost update. Klasyczny przykład: dwoje lekarzy jednocześnie klika „idę na zwolnienie", każde sprawdza, że na dyżurze jest co najmniej jedna osoba, i oboje się wypisują. Wynik: na sali nie ma nikogo. Obie transakcje czytały te same dane, ale aktualizowały różne wiersze — stąd blokada `SELECT FOR UPDATE` nie wystarczy. Write skew to uogólnienie lost update: jeśli dwie transakcje czytają wspólne dane i modyfikują na ich podstawie różne obiekty, klasyczne mechanizmy zawiodą.

Z write skew wywodzi się pojęcie **phantoma**: transakcja sprawdza brak jakichś wierszy, decyduje się działać, a inna transakcja tymczasem te wiersze wstawia. Blokada nie ma do czego się przyczepić, bo obiekt jeszcze nie istniał. Rozwiązaniem awaryjnym jest **materializacja konfliktów** — tworzenie sztucznych wierszy (np. siatki przedziałów czasowych w systemie rezerwacji sal), do których można przykleić blokadę. To jednak nieeleganckie i kruche — lepiej sięgnąć po **izolację szeregowalną**.

Kleppmann prezentuje trzy podejścia do szeregowalności:

**1. Dosłowne szeregowanie (Actual Serial Execution).** Jedna transakcja na raz, jeden wątek, jeden CPU. Brzmi jak krok wstecz, ale działa, gdy: dane mieszczą się w RAM (brak I/O podczas transakcji), transakcje są krótkie i zapisywane jako procedury składowane. VoltDB, Redis, Datomic stosują ten model. Ograniczenie: jeden rdzeń CPU jako wąskie gardło.

**2. Dwufazowe blokowanie (Two-Phase Locking, 2PL).** Przez dekady jedyna metoda szeregowalności w praktycznych bazach. Czytający blokują pisarzy i odwrotnie — stąd drastyczny wpływ na przepustowość i ryzyko zakleszczenia. Kluczowe rozszerzenie: **predicate locks** (blokowanie wszystkich wierszy pasujących do warunku WHERE) i ich praktyczna implementacja jako **index-range locks** (blokowanie całego zakresu indeksu). Index-range locks są mniej precyzyjne, ale tańsze — i wystarczające, by zatrzymać phantomy.

**3. Serializable Snapshot Isolation (SSI).** Nowy (ok. 2008) algorytm stosowany w PostgreSQL i FoundationDB. Bazuje na MVCC (jak snapshot isolation), ale dokłada detekcję konfliktów: baza śledzi, kiedy transakcja czytała dane, które inna transakcja później zapisała. Jeśli taka zależność tworzy cykl (transakcja podjęła decyzję na podstawie nieaktualnych danych), jedna z nich jest przerywana przy commit. To podejście **optymistyczne** — transakcje działają równolegle, konflikty rozwiązuje się dopiero przy zatwierdzeniu. SSI oferuje przewidywalne, niskie latencje dla odczytów i dobrze skaluje się poziomo.

Fragment kończy rozległa lista anomalii omówionych w całym rozdziale: dirty reads, dirty writes, read skew, lost updates, write skew, phantom reads — razem z informacją, który poziom izolacji je blokuje.

---

## Najważniejsze cytaty

> *"Write skew can occur if two transactions read the same objects, and then update some of those objects (different transactions may update different objects). In the special case where different transactions update the same object, you get a dirty write or lost update anomaly."*

— Definicja write skew jako uogólnienia lost update. Ważne: blokada `FOR UPDATE` pomaga tylko gdy transakcje modyfikują ten sam wiersz; przy write skew modyfikują różne wiersze.

> *"This effect, where a write in one transaction changes the result of a search query in another transaction, is called a phantom."*

— Phantom to sytuacja, gdy nowo wstawiony wiersz „podważa" decyzję podjętą przez inną transakcję na podstawie braku takich wierszy. Snapshot isolation nie wystarczy w przypadku read-write transakcji.

> *"Serializable isolation is usually regarded as the strongest isolation level. It guarantees that even though transactions may execute in parallel, the end result is the same as if they had executed one at a time, serially, without any concurrency."*

— Definicja szeregowalności. Baza gwarantuje poprawność bez konieczności rozumowania przez programistę o wszystkich możliwych przeplataniach.

> *"Two-phase locking: for decades this has been the standard way of implementing serializability, but many applications avoid using it because of its performance characteristics."*

— 2PL jest poprawny, ale wolny: czytelnicy blokują pisarzy i odwrotnie, co przy dużej współbieżności zabija przepustowość i generuje zakleszczenia.

> *"Compared to two-phase locking, the big advantage of serializable snapshot isolation is that one transaction doesn't need to block waiting for locks held by another transaction. Like under snapshot isolation, writers don't block readers, and vice versa."*

— SSI łączy gwarancje szeregowalności z wydajnością snapshot isolation: brak blokowania, przewidywalne czasy odpowiedzi.

---

## Myśl dnia

Słabe poziomy izolacji (read committed, snapshot) to kompromis: akceptujesz pewne anomalie w zamian za wydajność. Szeregowalność eliminuje wszystkie anomalie, ale wymaga wyboru: albo jeden wątek (proste, ale ograniczone do jednego CPU), albo 2PL (blokuje wszystko, historycznie dominujące), albo SSI (optymistyczne, nowoczesne, skalowalne). W praktyce SSI w PostgreSQL to dziś najlepszy domyślny wybór dla aplikacji z kompleksowymi wzorcami dostępu.

---

*Jutro (Dzień 13): Rozdział 8, pierwsza połowa — problemy w systemach rozproszonych: zawodność sieci, zegarów i tego, co „naprawdę" wiemy o stanie systemu.*
