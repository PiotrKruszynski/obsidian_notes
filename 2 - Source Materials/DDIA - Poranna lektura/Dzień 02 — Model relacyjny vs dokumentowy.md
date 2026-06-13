# Dzień 02 — Rozdział 2 (1/2): Relational Model Versus Document Model

## O czym jest

Druga porcja otwiera rozdział o modelach danych i językach zapytań. Kleppmann zaczyna od przypomnienia, że oprogramowanie buduje się z warstw modeli danych — od struktur w kodzie aplikacji, przez ogólny model (JSON, relacyjny, graf), aż po bajty na dysku — i każda warstwa ukrywa złożoność tej poniżej. Wybór modelu ma głęboki wpływ na to, co aplikacja może zrobić łatwo, a co z trudem.

Następnie krótka historia: model relacyjny Codda z 1970 roku zdominował rynek na 25-30 lat, mimo że konkurenci (model sieciowy, hierarchiczny, bazy obiektowe, XML) regularnie próbowali go zrzucić z piedestału. NoSQL — nazwa powstała jako hasztag na Twitterze w 2009 roku, później przemianowana na "Not Only SQL" — to najnowsza odsłona tej walki, napędzana potrzebą większej skalowalności, otwartym oprogramowaniem, specjalizowanymi zapytaniami i frustracją sztywnością schematów relacyjnych.

Centralny temat fragmentu to "object-relational mismatch" — niezgodność między obiektami w kodzie a tabelami w bazie. Na przykładzie CV/profilu LinkedIn (Bill Gates) Kleppmann pokazuje, że dokument JSON ma lepszą lokalność (jedno zapytanie, cała struktura) niż znormalizowany schemat relacyjny rozbity na wiele tabel z kluczami obcymi. Ale to działa dobrze tylko dla relacji jeden-do-wielu tworzących drzewo. Gdy pojawiają się relacje wiele-do-wielu (np. odnośniki do firm, szkół, rekomendacje od innych userów), model dokumentowy zaczyna trzeszczeć — referencje wymagają joinów, a bazy dokumentowe słabo je wspierają.

Historyczna pętla: Kleppmann przypomina debatę z lat 70. między modelem hierarchicznym IMS (bardzo podobnym do JSON — drzewo zagnieżdżonych rekordów), modelem sieciowym CODASYL (rekordy z wieloma rodzicami, dostęp przez "access paths" — ręczne nawigowanie wskaźnikami, koszmar przy zmianach) i modelem relacyjnym, który wygrał, bo oddzielił *co* chcesz odczytać od *jak* to znaleźć — optymalizator zapytań wybiera ścieżkę dostępu automatycznie. Bazy dokumentowe powtarzają część błędów modelu hierarchicznego, ale przy referencjach wiele-do-wielu zachowują się jak relacyjne (identyfikator rozwiązywany przy odczycie).

Ostatnia część porównuje modele "tu i teraz": dokumentowy wygrywa przy danych o strukturze drzewa i schema-on-read (elastyczność, np. zmiana formatu pól bez migracji ALTER TABLE), relacyjny — przy silnie powiązanych danych i joinach. Schema-on-read przypomina typowanie dynamiczne, schema-on-write — statyczne; żadne nie jest "lepsze" w ogóle, tylko w kontekście. Fragment kończy się obrazem konwergencji: relacyjne bazy dogoniły JSON/XML, a dokumentowe (RethinkDB, MongoDB) dorabiają sobie joiny — granice się zacierają.

## Najważniejsze cytaty

> "The relational model thus made it much easier to add new features to applications."

Kluczowa przewaga modelu relacyjnego: query optimizer budujesz raz, a korzystają z niego wszystkie aplikacje — nie trzeba ręcznie przepisywać "access paths" przy każdej zmianie.

> "Document databases are sometimes called schemaless, but that's misleading, as the code that reads the data usually assumes some kind of structure — i.e., there is an implicit schema, but it is not enforced by the database."

"Brak schematu" to mit — schemat zawsze istnieje, tylko przenosi się z bazy do kodu aplikacji (schema-on-read).

> "For highly interconnected data, the document model is awkward, the relational model is acceptable, and graph models [...] are the most natural."

Skala odpowiedzi na "który model wybrać": zależy od tego, jak bardzo Twoje dane są ze sobą powiązane.

> "It seems that relational and document databases are becoming more similar over time, and that is a good thing: the data models complement each other."

Konwergencja: nie trzeba wybierać raz na zawsze — najlepsze bazy łączą cechy obu światów.

> "Most relational database systems execute the ALTER TABLE statement in a few milliseconds. MySQL is a notable exception."

Drobna, ale praktyczna uwaga: zła reputacja migracji schematu nie jest uniwersalna — zależy od silnika bazy.

## Myśl dnia

Wybór między modelem relacyjnym a dokumentowym to nie wybór "lepszej technologii", lecz odpowiedź na pytanie o kształt Twoich danych: drzewo (dokument wygrywa lokalnością) czy gęsta sieć powiązań (relacje i joiny wygrywają elastycznością). Historia się powtarza — debata IMS vs CODASYL vs relacyjny z lat 70. to ten sam spór, tylko w nowych kostiumach.

---

**Jutro:** rozdział 2 (druga połowa) — języki zapytań (deklaratywne, MapReduce) i modele grafowe.
