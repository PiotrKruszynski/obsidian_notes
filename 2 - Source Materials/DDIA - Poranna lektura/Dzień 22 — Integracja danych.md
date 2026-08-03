# Dzień 22 — Rozdział 12 (1/3): Integracja danych

*Designing Data-Intensive Applications, Martin Kleppmann — poranna lektura, część 22 z 24*

## O czym jest

Ostatni rozdział książki zmienia perspektywę: zamiast opisywać, jak jest, Kleppmann mówi, jak jego zdaniem **być powinno**. Otwiera go cytat z Tomasza z Akwinu o kapitanie, który trzymałby statek w porcie, gdyby jego najwyższym celem było zachowanie statku — systemy danych też nie istnieją dla samych siebie, tylko po to, żeby czemuś służyć.

Pierwsza część rozdziału dotyczy integracji danych. Punkt wyjścia: nie ma jednego narzędzia dobrego do wszystkiego. Każdy soft, nawet „uniwersalna" baza danych, jest projektowany pod konkretny wzorzec użycia. W złożonej aplikacji te same dane są używane na kilka sposobów (baza OLTP, indeks pełnotekstowy, cache, hurtownia, systemy rekomendacji), więc nieuchronnie składasz system z kilku narzędzi. Problemem staje się utrzymanie spójności kopii danych między nimi.

Rada Kleppmanna: przepuść wszystkie zapisy przez **jeden system, który ustala kolejność** (system of record), a pozostałe reprezentacje wyprowadzaj z niego przez change data capture lub event sourcing — przetwarzając zmiany w tej samej kolejności. Pisanie przez aplikację bezpośrednio do bazy *i* do indeksu prowadzi do trwałej niespójności, bo dwa systemy mogą przetworzyć konkurencyjne zapisy w różnej kolejności. Dane pochodne aktualizowane z logu są deterministyczne i idempotentne, więc łatwo wracają do zdrowia po awarii.

Porównanie z transakcjami rozproszonymi: XA/2PC daje linearyzowalność (np. czytasz własne zapisy), ale ma słabą odporność na awarie i wydajność. Systemy pochodne aktualizują się asynchronicznie — słabsze gwarancje, ale awaria jednej części nie rozlewa się na całość. Wobec braku dobrego, powszechnie przyjętego protokołu transakcji rozproszonych Kleppmann uznaje log-based derived data za najbardziej obiecujące podejście.

Totalny porządek zdarzeń ma jednak granice: wymaga zwykle jednego lidera, więc przy partycjonowaniu, wielu datacenter, mikroserwisach i klientach offline porządek między niezależnymi źródłami jest niezdefiniowany. Skalowalny, geograficznie rozproszony konsensus to wciąż otwarty problem badawczy. Czasem gubi się przez to przyczynowość — przykład: usuwasz ex-partnera ze znajomych, potem piszesz o nim złośliwą wiadomość; jeśli system powiadomień przetworzy zdarzenia w złej kolejności, ex dostanie powiadomienie. Częściowe rozwiązania: logiczne znaczniki czasu, zapisywanie zdarzenia „co użytkownik widział przed decyzją", algorytmy rozwiązywania konfliktów.

Druga sekcja: batch i stream processing to narzędzia integracji — „dostarczyć dane we właściwej formie we właściwe miejsca". Oba mają funkcyjny charakter: deterministyczne funkcje, niemutowalne wejścia, wyjścia append-only. Reprocessing historii pozwala na stopniową ewolucję schematu — jak XIX-wieczne koleje przechodziły na wspólny rozstaw szyn przez trzecią szynę (dual gauge), tak można utrzymywać stary i nowy widok równolegle i stopniowo przenosić użytkowników, z możliwością odwrotu na każdym etapie. **Architektura lambda** (równolegle batch = dokładnie i strumień = szybko, w przybliżeniu) spopularyzowała derived views z niemutowalnych zdarzeń, ale utrzymywanie tej samej logiki w dwóch systemach i scalanie ich wyników jest kosztowne. Nowszy kierunek: jeden system łączący oba tryby — wymaga replay historycznych zdarzeń, semantyki exactly-once i okien po event time (np. Apache Beam na Flink/Dataflow).

## Najważniejsze cytaty

> "It's hard enough to get one code path robust and performing well—trying to do everything in one piece of software almost guarantees that the implementation will be poor."

Jedno narzędzie do wszystkiego = kiepskie we wszystkim. Dlatego składamy systemy ze specjalizowanych klocków.

> "Whether you use change data capture or an event sourcing log is less important than simply the principle of deciding on a total order."

Mechanizm (CDC czy event sourcing) jest wtórny; istotą jest zasada: jedno miejsce ustala kolejność wszystkich zapisów.

> "In the absence of widespread support for a good distributed transaction protocol, I believe that log-based derived data is the most promising approach for integrating different data systems."

Teza całej sekcji: skoro transakcje rozproszone (XA) są kruche i wolne, integruj systemy przez log zdarzeń i dane pochodne.

> "Asynchrony is what makes systems based on event logs robust: it allows a fault in one part of the system to be contained locally, whereas distributed transactions abort if any one participant fails, so they tend to amplify failures."

Asynchroniczność to nie wada, tylko źródło odporności: awaria zostaje lokalna zamiast rozlewać się na cały system.

> "By reducing the risk of irreversible damage, you can be more confident about going ahead, and thus move faster to improve your system."

Stopniowa, odwracalna migracja (stary i nowy widok obok siebie) zmniejsza ryzyko — a mniejsze ryzyko pozwala szybciej ulepszać system.

## Myśl dnia

Nie ma jednej bazy dobrej do wszystkiego — zamiast tego wybierz jeden system ustalający kolejność zapisów i wyprowadzaj z jego logu wszystkie pozostałe reprezentacje danych. Asynchroniczne dane pochodne z logu to solidniejszy fundament integracji niż transakcje rozproszone.

---

*Jutro: rozdział 12 (2/3) — Unbundling Databases: baza danych rozłożona na części i aplikacje projektowane wokół przepływu danych.*
