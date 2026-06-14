# Dzień 03 — Rozdział 2 (2/2): Języki zapytań i modele grafowe

## O czym jest

Druga połowa rozdziału 2 zmienia temat — z modeli danych na języki, którymi się po nich poruszamy. Kleppmann zaczyna od rozróżnienia imperatywne vs deklaratywne. Kod imperatywny (np. pętla `for` szukająca rekinów na liście) mówi komputerowi *jak* krok po kroku dojść do wyniku. SQL i relacyjna algebra mówią tylko *co* chcemy dostać — `SELECT * FROM animals WHERE family = 'Sharks'` — a optymalizator sam decyduje, jak to wykonać. Deklaratywność ma trzy zalety: jest zwięzła, ukrywa szczegóły silnika (baza może się zmieniać "pod maską" bez psowania zapytań) i lepiej się równoległi, bo nie wymusza konkretnej kolejności operacji.

Ten sam kontrast Kleppmann pokazuje poza bazami danych — na przykładzie CSS/XPath kontra ręczne grzebanie w DOM przez JavaScript. CSS automatycznie usuwa podświetlenie, gdy klasa "selected" zniknie; imperatywny kod JS trzeba by przepisywać przy każdej zmianie API. Wniosek: deklaratywność wygrywa nie tylko w bazach.

Dalej MapReduce — model "pomiędzy": ani w pełni deklaratywny, ani imperatywny. Funkcje `map` i `reduce` muszą być czyste (bez efektów ubocznych, bez dodatkowych zapytań), co pozwala bazie uruchamiać je gdziekolwiek i w dowolnym porządku. Kleppmann pokazuje to samo zapytanie (liczenie zaobserwowanych rekinów per miesiąc) w SQL i w MongoDB MapReduce — SQL jest krótszy i czytelniejszy, co tłumaczy, czemu MongoDB 2.2 dodało własny deklaratywny "aggregation pipeline".

Centralna część fragmentu to modele grafowe — dla danych, gdzie relacje wiele-do-wielu są normą, nie wyjątkiem (sieci społeczne, sieć WWW, sieci drogowe). Property graph to wierzchołki i krawędzie z etykietami i właściwościami (key-value); można to zapisać jako dwie tabele relacyjne (vertices, edges), ale zapytania o "ścieżkę nieznanej długości" (np. znajdź ludzi urodzonych w USA, żyjących w Europie, przez hierarchię WITHIN) są w SQL bardzo niewygodne — przykład z `WITH RECURSIVE` zajmuje 29 linii, podczas gdy Cypher robi to w 4. Triple-store (subject, predicate, object) to model równoważny property graph, tylko innym słownictwem — i prowadzi do dygresji o semantic webie (przereklamowanym, ale wartym docenienia za format Turtle/RDF) i SPARQL (jeszcze bardziej zwięzły niż Cypher, i to on był pierwszy — Cypher pożyczył od niego składnię pattern matching).

Na koniec Datalog — najstarszy, akademicki, oparty na Prologu. Inny sposób myślenia: definiuje się reguły (`within_recursive`, `migrated`), które budują się na sobie jak funkcje, aż zapytanie staje się serią małych kroków. Mniej wygodny do jednorazowych zapytań, ale lepiej radzi sobie ze złożonymi, powtarzalnie używanymi regułami. Rozdział zamyka podsumowanie: trzy modele (dokumentowy, relacyjny, graf) — każdy dobry w swojej domenie, żadny uniwersalny. Dokumentowy = dane samodzielne, rzadkie powiązania. Graf = wszystko potencjalnie powiązane ze wszystkim.

## Najważniejsze cytaty

> "In a declarative query language, like SQL or relational algebra, you just specify the pattern of the data you want [...] but not how to achieve that goal."

Sedno różnicy deklaratywne vs imperatywne — i dlaczego baza ma swobodę optymalizacji.

> "Declarative languages have a better chance of getting faster in parallel execution because they specify only the pattern of the results, not the algorithm that is used to determine the results."

Argument na przyszłość: deklaratywność = łatwiejsza równoległość na wielu rdzeniach/maszynach.

> "If the same query can be written in 4 lines in one query language but requires 29 lines in another, that just shows that different data models are designed to satisfy different use cases."

Najlepsze podsumowanie różnicy między SQL z `WITH RECURSIVE` a Cypher dla zapytań grafowych.

> "Document databases target use cases where data comes in self-contained documents and relationships between one document and another are rare. Graph databases go in the opposite direction, targeting use cases where anything is potentially related to everything."

Klarowny podział ról dwóch "NoSQL" rodzin z podsumowania rozdziału.

> "The Datalog approach requires a different kind of thinking [...] but it's a very powerful approach, because rules can be combined and reused in different queries."

Datalog jako inny paradygmat — mniej intuicyjny, ale kompozycyjny.

## Myśl dnia

Deklaratywność (SQL, CSS, Cypher, SPARQL, Datalog) wygrywa, bo oddziela "co" od "jak" — dając systemowi swobodę optymalizacji, równoległości i zmian bez psowania zapytań; a wybór między modelem dokumentowym, relacyjnym i grafowym sprowadza się do tego, jak gęsto powiązane są Twoje dane — od drzewa (dokument) przez umiarkowane relacje (SQL) do "wszystko ze wszystkim" (graf).

---

**Jutro:** rozdział 3 (pierwsza połowa) — struktury pamięci dla baz danych: B-drzewa, LSM-trees i silniki storage.
