# Dzień 11 — Rozdział 7 (1/2): Transakcje: ACID i izolacja

**Źródło:** Designing Data-Intensive Applications, Martin Kleppmann (2017)
**Fragment:** Rozdział 7 — Transactions, pierwsza połowa (do sekcji „Write Skew and Phantoms")

---

## O czym jest ten fragment

Rozdział 7 to jeden z najbardziej fundamentalnych w całej książce. Kleppmann bierze temat transakcji — coś, co większość programistów traktuje jak oczywistość — i rozkłada go na czynniki pierwsze z chirurgiczną precyzją.

**Po co w ogóle transakcje?** Bazy danych żyją w brutalnej rzeczywistości: sprzęt pada, sieć się urywa, kilku klientów pisze jednocześnie do tych samych danych. Transakcja to mechanizm grupowania wielu odczytów i zapisów w jedną logiczną jednostkę — albo wszystko się udaje (commit), albo nic (rollback). To proste założenie dramatycznie upraszcza obsługę błędów.

**ACID — co to naprawdę znaczy?** Kleppmann dokładnie opisuje każdą literę akronimu i przy okazji obala kilka mitów:

- **Atomicity** (Atomowość) — NIE chodzi o współbieżność. Chodzi o to, że jeśli transakcja się nie powiedzie w połowie, baza cofa wszystkie dotychczasowe zmiany. Kleppmann sugeruje, że lepszym słowem byłoby „abortability" (zdolność do anulowania).
- **Consistency** (Spójność) — jedyna litera, która tak naprawdę nie należy do bazy danych. To aplikacja definiuje, co znaczy „spójny stan". Baza może jedynie egzekwować niektóre ograniczenia (klucze obce, unikalność), ale ogólna odpowiedzialność leży po stronie programisty.
- **Isolation** (Izolacja) — transakcje uruchamiane równolegle nie powinny na siebie wpływać. W teorii oznacza to pełną serializowalność. W praktyce — prawie nikt tego nie stosuje, bo za drogo.
- **Durability** (Trwałość) — po commicie dane nie giną, nawet jeśli baza zaraz się wykraszy. Kleppmann dodaje ważne zastrzeżenie: idealna trwałość nie istnieje. Nośniki padają, SSD traci dane po odłączeniu zasilania, replikacja asynchroniczna może gubić ostatnie zapisy.

**Operacje na pojedynczych i wielu obiektach.** Atomowość i izolacja mają sens na poziomie całych transakcji, nie pojedynczych operacji. Większość nowoczesnych silników storage zapewnia atomowość na poziomie jednego obiektu (jeden rekord, jeden dokument), ale to nie to samo, co transakcja. Transakcja grupuje wiele operacji na wielu obiektach. Autorzy NoSQL często rezygnują z transakcji wieloobiektowych, bo są trudne do zaimplementowania w systemach rozproszonych — ale Kleppmann pokazuje, że wiele rzeczywistych zastosowań (klucze obce, denormalizacja, indeksy wtórne) faktycznie ich potrzebuje.

**Słabe poziomy izolacji.** Tu zaczyna się serce rozdziału. Pełna serializowalność jest droga. Dlatego bazy danych oferują słabsze poziomy izolacji, które chronią przed niektórymi problemami — ale nie wszystkimi.

*Read Committed* (domyślny poziom w PostgreSQL, Oracle, SQL Server) daje dwie gwarancje: nie czytasz niezatwierdzonych danych cudzej transakcji (no dirty reads) i nie nadpisujesz niezatwierdzonych zmian (no dirty writes). Baza implementuje to przez row-level locks dla zapisów i przez trzymanie starej wartości obiektu dla odczytów — dzięki temu odczyty nigdy nie blokują zapisów.

*Snapshot Isolation* (izolacja migawkowa) idzie dalej. Rozwiązuje problem zwany read skew: sytuację, gdy w trakcie jednego zapytania widzisz bazę z różnych punktów czasu (np. Alicja sprawdza saldo i widzi, że $100 „zniknęło", bo jeden przelew jest już w trakcie, a drugi jeszcze nie). Snapshot isolation daje każdej transakcji spójną migawkę bazy z chwili jej startu. Implementacja opiera się na MVCC (Multi-Version Concurrency Control) — baza trzyma wiele wersji każdego obiektu, każdą oznaczoną ID transakcji, która ją stworzyła lub usunęła. Odczyty nigdy nie blokują zapisów i odwrotnie.

Fragment kończy się na problemie *lost updates* (zgubionych aktualizacji): gdy dwa klienty robią read-modify-write na tym samym obiekcie jednocześnie, jeden z zapisów może nadpisać drugi. Rozwiązania to: atomic write operations (np. `UPDATE counter SET val = val + 1`), explicit locking (`SELECT FOR UPDATE`), automatyczne wykrywanie przez bazę, lub compare-and-set. W systemach replikowanych sprawa się komplikuje — np. LWW (Last Write Wins) jest podatne na ten problem.

---

## Najważniejsze cytaty

> **"Transactions are not a law of nature; they were created with a purpose, namely to simplify the programming model for applications accessing a database."**

*Transakcje to nie kosmiczne prawo — to narzędzie inżynieryjne. Można z nich zrezygnować, ale trzeba wiedzieć, co się traci.*

> **"Atomicity, isolation, and durability are properties of the database, whereas consistency (in the ACID sense) is a property of the application. [...] Thus, the letter C doesn't really belong in ACID."**

*Szokująco szczera obserwacja: „C" w ACID to odpowiedzialność programisty, nie bazy. Kleppmann nie owijał w bawełnę.*

> **"Concurrency bugs caused by weak transaction isolation are not just a theoretical problem. They have caused substantial loss of money, led to investigation by financial auditors, and caused customer data to be corrupted."**

*Słabe izolacje to nie akademia — to realne straty finansowe i audyty. „Użyj ACID-owej bazy do finansów" to zbyt proste rozwiązanie, bo większość „ACID-owych" baz i tak używa słabej izolacji.*

> **"The key principle of snapshot isolation is readers never block writers, and writers never block readers."**

*To właśnie sprawia, że MVCC jest tak popularne — odczyty i zapisy nie blokują się wzajemnie.*

> **"Nothing is perfect: [...] In an asynchronously replicated system, recent writes may be lost when the leader becomes unavailable."**

*Trwałość (Durability) to spektrum ryzyka, nie binarna właściwość. Backup, replikacja, zapis na dysk — każde zmniejsza ryzyko, żadne go nie eliminuje.*

---

## Myśl dnia

Transakcje to tarcza przed chaosem współbieżności i awarii — ale ta tarcza ma szczeliny. ACID brzmi jak obietnica absolutnego bezpieczeństwa, a w rzeczywistości każda litera kryje niuanse i kompromisy. Programista, który rozumie te niuanse, pisze kod odporny na błędy; ten, kto ślepo ufa „ACID-owej bazie", pewnego dnia odkryje, że $100 gdzieś znikło.

---

**Jutro (Dzień 12):** Rozdział 7, druga połowa — Write Skew, Phantoms i Serializowalność (2PL, Serializable Snapshot Isolation).
