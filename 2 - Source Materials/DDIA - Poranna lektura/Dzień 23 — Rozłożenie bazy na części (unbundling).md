# Dzień 23 — Rozdział 12 (2/3): Unbundling Databases — baza rozłożona na części i aplikacje wokół przepływu danych

## O czym jest

Kleppmann zaczyna od obserwacji, że baza danych, Hadoop i system operacyjny robią w gruncie rzeczy to samo: przechowują dane i pozwalają je przetwarzać oraz odpytywać. Różni je filozofia. Unix dał programiście cienką warstwę nad sprzętem — pliki i potoki, czyli ciągi bajtów. Relacyjna baza poszła w drugą stronę: wysoka abstrakcja, deklaratywne SQL i transakcje, a pod spodem ukryta cała maszyneria optymalizatora, indeksów, kontroli współbieżności i replikacji. To napięcie trwa od lat 70. i nadal nie jest rozstrzygnięte; ruch NoSQL autor czyta jako próbę przeniesienia unixowego, niskopoziomowego podejścia do świata rozproszonego OLTP. Ta sekcja jest próbą pogodzenia obu tradycji.

Punktem zaczepienia jest zwykłe `CREATE INDEX`. Co robi baza, gdy je wykonasz? Skanuje spójny snapshot tabeli, wyciąga indeksowane wartości, sortuje je, zapisuje indeks, dogania zaległe zapisy powstałe od momentu snapshotu, a potem utrzymuje indeks aktualny przy każdej transakcji. To jest dokładnie ta sama procedura, co uruchamianie nowej repliki-follower albo bootstrapowanie change data capture w systemie strumieniowym. Indeks to po prostu widok pochodny wyprowadzony z danych bazowych — i nagle widać, że rzeczy, które baza robi wewnętrznie, to te same rzeczy, które my budujemy na zewnątrz z batchy i strumieni.

Stąd bierze się „meta-baza wszystkiego": przepływ danych w całej organizacji zaczyna wyglądać jak jedna wielka baza. Procesy batch, stream i ETL to rozbudowane odpowiedniki triggerów, procedur składowanych i rutyn odświeżających widoki zmaterializowane. Systemy danych pochodnych to różne typy indeksów — tyle że zamiast być funkcjami jednego produktu, są osobnym oprogramowaniem, na osobnych maszynach, pod opieką osobnych zespołów. Autor widzi dwie drogi łączenia takich narzędzi w spójną całość. **Bazy federacyjne** ujednolicają odczyty: jeden interfejs zapytań nad wieloma silnikami (np. foreign data wrappers w PostgreSQL) — tradycja relacyjna, elegancka semantyka, skomplikowana implementacja. **Bazy rozłożone (unbundled)** ujednolicają zapisy: change data capture i logi zdarzeń pozwalają synchronizować zapisy między heterogenicznymi technologiami — tradycja unixowa, małe narzędzia z jednym zadaniem, wspólne niskopoziomowe API.

Trudniejszym problemem inżynierskim jest synchronizacja zapisów, i tu Kleppmann jest kategoryczny: transakcje rozproszone między różnymi technologiami to zła odpowiedź. Wewnątrz jednego systemu — owszem, działają (np. exactly-once w procesorach strumieni). Ale gdy dane przekraczają granicę między systemami pisanymi przez różne zespoły, brak standardowego protokołu transakcyjnego zabija integrację. Uporządkowany log zdarzeń z idempotentnymi konsumentami to abstrakcja prostsza i realnie wykonalna. Jej przewagą jest luźne sprzężenie na dwóch poziomach: systemowym (log buforuje zdarzenia, awaria konsumenta zostaje lokalna zamiast eskalować, jak przy transakcjach rozproszonych) i ludzkim (zespoły rozwijają swoje komponenty niezależnie, za dobrze zdefiniowanym interfejsem).

Autor od razu studzi zapał. Unbundling nie zastąpi baz danych — nadal są potrzebne do trzymania stanu procesorów strumieni i obsługiwania zapytań. Każdy dodatkowy kawałek infrastruktury to krzywa uczenia, konfiguracja i operacyjne dziwactwa; jeden zintegrowany produkt bywa szybszy i bardziej przewidywalny. Celem rozłożenia nie jest konkurowanie wydajnością na konkretnym obciążeniu, tylko **szerokość**, nie głębokość: obsłużyć więcej rodzajów zapytań, niż potrafi jeden produkt. Jeśli istnieje jedna technologia, która robi wszystko, czego potrzebujesz — użyj jej. Brakuje przy tym jednej rzeczy: odpowiednika unixowego shella, deklaratywnego języka do składania systemów. Autor marzy o tym, by móc napisać po prostu `mysql | elasticsearch` i dostać ciągle aktualizowany indeks bez pisania kodu klejącego.

Druga połowa fragmentu przenosi te idee na poziom projektowania aplikacji — podejście nazwane „database inside-out". Wzorcem jest arkusz kalkulacyjny: wpisujesz formułę, a gdy zmienia się wejście, wynik przelicza się sam. Tego właśnie chcemy od systemów danych, a VisiCalc miał to w 1979. Dziś dochodzą tylko wymagania odporności na awarie, skalowalności i trwałości. Kod aplikacji jest tu **funkcją wyprowadzającą**: indeks wtórny, indeks pełnotekstowy, model ML wyprowadzony z danych treningowych, cache z agregacją pod konkretny UI — wszystko to transformacje danych bazowych. Standardowe transformacje baza ma wbudowane; te specyficzne dla domeny wymagają własnego kodu, z którym bazy radzą sobie kiepsko (triggery i procedury składowane zawsze były w nich doczepione po macoszemu). Dlatego Kleppmann proponuje rozdział: jedne części systemu specjalizują się w trwałym przechowywaniu, inne w uruchamianiu kodu (Mesos, YARN, Docker, Kubernetes robią to lepiej niż baza z UDF-ami). Problem w tym, że w klasycznym modelu baza jest **pasywną zmienną współdzieloną** — nie da się zasubskrybować jej zmian, można tylko odpytywać.

Przepływ danych odwraca tę relację: zamiast traktować bazę jak zmienną, którą aplikacja manipuluje, myślimy o współpracy między stanem, jego zmianami i kodem, który na nie reaguje. Utrzymywanie danych pochodnych to jednak nie to samo, co asynchroniczne zadania w kolejce — tu kolejność zdarzeń jest istotna (inaczej widoki się rozjadą), a utrata jednej wiadomości trwale desynchronizuje dane pochodne. Stabilne uporządkowanie i niezawodne przetwarzanie to wymagania ostre, ale wciąż tańsze i operacyjnie solidniejsze niż transakcje rozproszone. Przykład różnicy wobec mikroserwisów: przy przeliczaniu waluty mikroserwis odpytuje synchronicznie serwis kursów, a system dataflow subskrybuje strumień kursów z wyprzedzeniem i trzyma aktualny kurs lokalnie — czyli zamienia RPC na stream-table join. Szybciej i odporniej: najszybsze zapytanie sieciowe to brak zapytania.

Ostatnia część sekcji wprowadza podział na **ścieżkę zapisu** i **ścieżkę odczytu**. Ścieżka zapisu to wszystko, co robimy zawczasu, gdy dane wpływają (ewaluacja zachłanna); ścieżka odczytu to praca wykonywana dopiero, gdy ktoś pyta (ewaluacja leniwa). Zbiór pochodny jest miejscem ich spotkania, a indeksy, cache i widoki zmaterializowane po prostu **przesuwają granicę** między nimi. Brak indeksu = mało pracy przy zapisie, dużo przy odczycie; wstępne policzenie wszystkich możliwych zapytań = odwrotnie (i niewykonalne). To ten sam kompromis, co w przykładzie z Twitterem z rozdziału 1 — po pięciuset stronach koło się domyka. Granicę można też przesunąć aż do urządzenia użytkownika: aplikacje offline-first trzymają stan lokalnie, a stan na urządzeniu to cache stanu serwera; piksele na ekranie to widok zmaterializowany modelu, a model to lokalna replika stanu w datacenter. Server-sent events i WebSockety pozwalają rozciągnąć ścieżkę zapisu aż do przeglądarki, a problem urządzeń offline rozwiązujemy tak samo jak offsety konsumenta w logu. Na koniec autor idzie jeszcze dalej: **odczyty też są zdarzeniami**. Jeśli przepuścić zapytania przez ten sam procesor strumieni co zapisy, wykonujemy stream-table join między strumieniem zapytań a bazą; jednorazowy odczyt to join, o którym natychmiast zapominamy, a subskrypcja to join trwały. Logowanie odczytów kosztuje miejsce i I/O, ale pozwala śledzić zależności przyczynowe — np. odtworzyć, jaką datę dostawy widział klient, zanim kupił.

## Najważniejsze cytaty

> "Whenever you run CREATE INDEX, the database essentially reprocesses the existing dataset and derives the index as a new view onto the existing data."

Kluczowe przestawienie perspektywy: indeks nie jest magią bazy, tylko danymi pochodnymi. Ta sama operacja co uruchomienie repliki czy bootstrap CDC.

> "The dataflow across an entire organization starts looking like one huge database."

Batch, stream i ETL to triggery i widoki zmaterializowane w skali firmy. Cała organizacja jest jedną rozproszoną bazą — tylko administrowaną przez różne zespoły.

> "When data crosses the boundary between different technologies, I believe that an asynchronous event log with idempotent writes is a much more robust and practical approach."

Teza sekcji: wewnątrz jednego systemu transakcje są w porządku, ale między systemami — log zdarzeń z idempotencją zamiast transakcji rozproszonych.

> "It's about breadth, not depth. […] If there is a single technology that does everything you need, you're most likely best off simply using that product."

Ważny hamulec przed hype'em: unbundling opłaca się dopiero wtedy, gdy żaden pojedynczy produkt nie spełnia wymagań. Inaczej to przedwczesna optymalizacja.

> "The fastest and most reliable network request is no network request at all!"

Uzasadnienie dataflow wobec mikroserwisów: subskrybuj kursy walut z wyprzedzeniem i trzymaj je lokalnie, zamiast pytać cudzy serwis w krytycznej ścieżce.

> "The role of caches, indexes, and materialized views is simple: they shift the boundary between the read path and the write path."

Jedno zdanie porządkujące pół książki. Każdy indeks, cache i widok to decyzja, ile pracy wykonać zawczasu, a ile odłożyć na moment zapytania.

## Myśl dnia

Baza danych to zbiór funkcji — indeksy, widoki, replikacja — które można rozmontować i złożyć na nowo z osobnych narzędzi, spinając je uporządkowanym logiem zdarzeń zamiast transakcji rozproszonych. Aplikacja przestaje wtedy być kodem manipulującym pasywną zmienną, a staje się siecią funkcji reagujących na zmiany stanu — jak arkusz kalkulacyjny, tylko odporny na awarie.

---

*Jutro: rozdział 12 (3/3) — Aiming for Correctness i Doing the Right Thing: argument end-to-end, wymuszanie ograniczeń bez koordynacji, audytowalność oraz etyka danych, prywatność i inwigilacja.*
