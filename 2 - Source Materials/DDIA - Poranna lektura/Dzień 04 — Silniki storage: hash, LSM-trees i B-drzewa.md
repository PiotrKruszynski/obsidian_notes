# Dzień 04 — Rozdział 3 (1/2): Silniki storage — indeksy haszujące, LSM-trees i B-drzewa

## O czym jest

Rozdział 3 zmienia perspektywę z rozdziału 2: tam była mowa o tym, jak aplikacja podaje dane bazie (modele, języki zapytań), teraz Kleppmann patrzy z drugiej strony — jak baza te dane fizycznie przechowuje i odnajduje. Zaczyna od prowokująco prostego przykładu: bazy danych jako dwie funkcje bashowe — `db_set` (append do pliku) i `db_get` (`grep` + `tail -n 1`). Zapis jest błyskawiczny, bo dopisywanie do pliku jest najtańszą możliwą operacją I/O. Odczyt jest katastrofalny — O(n), bo trzeba przeskanować cały plik. Stąd potrzeba indeksu: dodatkowej struktury, która jest "drogowskazem" do danych, ale kosztuje przy każdym zapisie. To jest fundamentalny trade-off całego rozdziału — każdy indeks przyspiesza odczyty i utrudnia zapisy.

Pierwsza konkretna konstrukcja to indeks haszujący — w pamięci trzymamy hashmapę klucz → offset w pliku na dysku. To dokładnie robi Bitcask (domyślny silnik Riaka): świetne dla obciążeń, gdzie jest mało unikalnych kluczy, ale każdy aktualizowany bardzo często (np. licznik odtworzeń filmiku). Żeby plik nie rósł w nieskończoność, dzieli się go na segmenty i robi compaction — zostaje tylko najnowsza wartość dla każdego klucza, a stare segmenty można scalać w tle. Ograniczenia: hashmapa musi się zmieścić w RAM, a range queries (np. "wszystkie klucze między kitty00000 i kitty99999") są nieefektywne — trzeba sprawdzać każdy klucz osobno.

Rozwiązaniem range queries jest SSTable (Sorted String Table) — segment, w którym par klucz-wartość są sortowane po kluczu, a każdy klucz występuje tylko raz. Dzięki sortowaniu scalanie segmentów jest jak mergesort, a indeks w pamięci może być rzadki (sparse) — wystarczy jeden wpis na kilka KB, bo skanowanie krótkiego zakresu jest szybkie. Jak utrzymać sortowanie przy zapisach w losowej kolejności? Memtable — zbalansowane drzewo w pamięci (np. red-black tree); gdy przekroczy rozmiar, zrzucane jest na dysk jako SSTable. Do odzyskania po crashu służy dodatkowy append-only log. Cała ta konstrukcja to LSM-tree (Log-Structured Merge-Tree) — to silnik LevelDB, RocksDB, a podobne podejście stoi za Cassandrą, HBase (inspirowane Bigtable) i indeksem termów w Lucene. Optymalizacje: Bloom filtery (szybkie "na pewno nie ma tego klucza"), oraz strategie compaction — size-tiered (HBase) vs leveled (LevelDB, RocksDB).

Drugi wielki rodzaj indeksu to B-drzewo — wynalezione w 1970, wciąż standard w relacyjnych bazach. Filozofia odwrotna do LSM: dane dzielone na strony o stałym rozmiarze (typowo 4 KB), strony tworzą drzewo, każda strona ma zakres kluczy i wskaźniki do dzieci. Przy aktualizacji nadpisuje się stronę w miejscu (in-place); przy przepełnieniu strona dzieli się na dwie, a rodzic się aktualizuje. Drzewo z n kluczami ma głębokość O(log n) — 3-4 poziomy wystarczą na petabajty. Bezpieczeństwo zapewnia write-ahead log (WAL) — każda modyfikacja najpierw trafia do append-only loga, dzięki czemu po crashu można odbudować B-drzewo do konsystentnego stanu.

Porównanie B-trees vs LSM-trees: LSM-trees zwykle szybsze przy zapisach (mniejsza write amplification, sekwencyjne zapisy), B-trees zwykle szybsze przy odczytach (LSM musi sprawdzić wiele struktur na różnych etapach compaction). LSM-trees lepiej się kompresują i mają mniejszą fragmentację. Z drugiej strony compaction w LSM może zakłócać działające odczyty/zapisy (wyższe percentyle czasu odpowiedzi są mniej przewidywalne niż w B-tree), a przy bardzo wysokim throughput compaction może nie nadążać, co prowadzi do narastania liczby segmentów. B-drzewa mają tę zaletę, że każdy klucz istnieje w jednym miejscu — co ułatwia blokady na zakresach kluczy przy transakcjach (temat rozdziału 7).

Reszta fragmentu to przegląd innych struktur indeksowych: indeksy wtórne (secondary indexes), heap file vs clustered index (InnoDB trzyma dane w samym indeksie primary key) i covering index jako kompromis; indeksy wielokolumnowe (concatenated index jak książka telefoniczna nazwisko+imię) oraz wielowymiarowe (R-trees do danych geoprzestrzennych, ale też np. indeks 2D na (data, temperatura)); indeksy pełnotekstowe i fuzzy (Lucene, automaty Levenshteina do wyszukiwania z literówkami). Na końcu — bazy w pamięci (Memcached, Redis, VoltDB, RAMCloud): ich przewaga nie wynika z unikania dysku (system operacyjny i tak cache'uje strony), a z uniknięcia narzutu kodowania struktur do formatu zapisywalnego na dysk. Anti-caching pozwala obsłużyć dane większe niż RAM, wyrzucając najrzadziej używane na dysk.

## Najważniejsze cytaty

> "This is an important trade-off in storage systems: well-chosen indexes speed up read queries, but every index slows down writes."

Centralny trade-off rozdziału — każda dalsza struktura (hash index, SSTable, B-tree) jest tylko innym kompromisem między szybkością zapisu i odczytu.

> "An append-only log seems wasteful at first glance [...] but an append-only design turns out to be good for several reasons: [sequential writes,] concurrency and crash recovery are much simpler [...] merging old segments avoids the problem of data files getting fragmented over time."

Dlaczego "głupie" dopisywanie na koniec pliku jest fundamentem nowoczesnych silników storage (LSM-trees, logi w bazach).

> "As a rule of thumb, LSM-trees are typically faster for writes, whereas B-trees are thought to be faster for reads."

Najprostsze podsumowanie różnicy — chociaż autor zaraz dodaje, że benchmarki bywają niejednoznaczne i trzeba testować na własnym obciążeniu.

> "Counterintuitively, the performance advantage of in-memory databases is not due to the fact that they don't need to read from disk [...] Rather, they can be faster because they can avoid the overheads of encoding in-memory data structures in a form that can be written to disk."

Zaskakujące spostrzeżenie — dysk i tak jest cache'owany przez OS; realna przewaga baz in-memory to brak narzutu serializacji.

> "There is no quick and easy rule for determining which type of storage engine is better for your use case, so it is worth testing empirically."

Powtarzający się refren Kleppmanna: zamiast wierzyć w ogólne reguły, testuj na swoim workloadzie.

## Myśl dnia

Każdy indeks to inny sposób radzenia sobie z tym samym napięciem: zapis lubi sekwencyjność i append (stąd logi, SSTables, LSM-trees), a odczyt lubi przewidywalną strukturę i lokalizację (stąd strony, B-drzewa, sortowanie); wybór silnika storage to w gruncie rzeczy wybór, które z tych dwóch potrzeb jest dla Twojego obciążenia ważniejsze.

---

**Jutro:** rozdział 3 (druga połowa) — przetwarzanie transakcyjne vs analityczne (OLTP vs OLAP) i magazyny kolumnowe.
