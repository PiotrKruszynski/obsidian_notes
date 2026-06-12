# Dzień 01 — Rozdział 1: Reliable, Scalable, and Maintainable Applications

## O czym jest

Kleppmann otwiera książkę obserwacją, że większość dzisiejszych aplikacji jest *data-intensive*, a nie *compute-intensive* — wąskim gardłem nie jest moc CPU, lecz ilość, złożoność i tempo zmian danych. Aplikacje buduje się ze standardowych klocków: baz danych, cache'ów, indeksów wyszukiwania, przetwarzania strumieniowego i wsadowego. Granice między tymi kategoriami się zacierają (Redis bywa kolejką, Kafka ma trwałość bazy), a gdy łączysz kilka narzędzi w jeden serwis, sam stajesz się projektantem systemu danych — z wszystkimi trudnymi pytaniami o spójność, wydajność i skalowanie.

Rozdział definiuje trzy filary, wokół których kręci się cała książka. **Niezawodność** to działanie poprawne mimo przeciwności. Kluczowe rozróżnienie: *fault* (komponent odbiega od specyfikacji) to nie *failure* (system jako całość przestaje świadczyć usługę); sztuką jest projektowanie tak, by usterki nie stawały się awariami. Usterki sprzętowe są w dużej skali codziennością (dysk w klastrze 10 000 dysków pada średnio raz dziennie) i są losowe, więc pomaga redundancja. Błędy programowe są systematyczne i skorelowane między węzłami — gorsze, bo uderzają wszędzie naraz (np. sekunda przestępna 2012). Błędy ludzkie to główna przyczyna awarii (błędy konfiguracji operatorów częstsze niż awarie sprzętu); pomagają dobre abstrakcje, środowiska sandbox, testy, szybki rollback i monitoring. Ciekawostka: warto celowo wstrzykiwać usterki (Netflix Chaos Monkey), żeby stale ćwiczyć mechanizmy odporności.

**Skalowalność** nie jest etykietką („X się skaluje"), tylko pytaniem: co zrobimy, gdy obciążenie wzrośnie? Najpierw trzeba opisać obciążenie *parametrami obciążenia* — przykład Twittera: 4,6k tweetów/s na zapisie vs 300k żądań/s odczytu timeline'u. Twitter przeszedł od zapytania JOIN przy odczycie do fan-outu przy zapisie (tweet trafia do skrzynek obserwujących), bo odczytów jest o dwa rzędy wielkości więcej — a dla celebrytów z 30 mln obserwujących stosuje hybrydę. Wydajność opisuj percentylami, nie średnią: mediana (p50) mówi, co widzi typowy użytkownik, a p99/p999 — co widzą najcenniejsi klienci (Amazon: +100 ms = −1% sprzedaży). Wysokie percentyle psują się przez kolejkowanie (head-of-line blocking) i wzmacniają się, gdy jedno żądanie użytkownika wymaga wielu wywołań backendu (tail latency amplification). Skalowanie to mieszanka *scale up* (mocniejsza maszyna) i *scale out* (więcej maszyn); nie ma „magicznego sosu skalowalności" — architektura zawsze opiera się na założeniach o tym, które operacje będą częste.

**Utrzymywalność** to największy koszt oprogramowania — nie pisanie, lecz utrzymanie. Trzy zasady projektowe: *operability* (ułatwiaj życie zespołowi operacyjnemu: monitoring, automatyzacja, przewidywalność), *simplicity* (usuwaj złożoność *przypadkową* — niewynikającą z problemu, tylko z implementacji; najlepsze narzędzie to dobra abstrakcja, jak SQL ukrywający struktury na dysku) i *evolvability* (łatwość zmian, gdy wymagania się zmienią — a zmienią się na pewno).

## Najważniejsze cytaty

> "We can understand reliability as ‘continuing to work correctly, even when things go wrong.'"

Niezawodność = działać poprawnie dalej, *gdy* coś pójdzie nie tak — nie „jeśli". Usterki są pewne; awarie nie muszą być.

> "A fault is usually defined as one component of the system deviating from its spec, whereas a failure is when the system as a whole stops providing the required service to the user."

Fundamentalne rozróżnienie fault/failure: nie da się wyzerować prawdopodobieństwa usterek, więc projektujemy mechanizmy, które nie pozwalają usterkom eskalować w awarie.

> "It is meaningless to say 'X is scalable' or 'Y doesn't scale.'"

Skalowalność nie jest binarną cechą produktu, tylko rozmową o konkretnych parametrach obciążenia i opcjach radzenia sobie z ich wzrostem.

> "Good operations can often work around the limitations of bad (or incomplete) software, but good software cannot run reliably with bad operations."

Dobry zespół operacyjny uratuje słabe oprogramowanie, ale najlepszy kod nie przeżyje złych operacji — dlatego operability to cecha projektowa, nie dodatek.

> "Making a system simpler does not necessarily mean reducing its functionality; it can also mean removing accidental complexity."

Prostota to nie ubóstwo funkcji, lecz brak złożoności przypadkowej — tej, która wynika z implementacji, a nie z natury problemu.

## Myśl dnia

Niezawodność, skalowalność i utrzymywalność to nie etykietki narzędzi, lecz pytania, które trzeba zadawać o własny system: co się stanie, gdy coś padnie, gdy obciążenie wzrośnie 10×, i gdy za rok ktoś inny będzie musiał to zmienić. Buduje się niezawodne systemy z zawodnych części.

---

**Jutro:** rozdział 2 (pierwsza połowa) — modele danych: relacyjny kontra dokumentowy i skąd wziął się NoSQL.
