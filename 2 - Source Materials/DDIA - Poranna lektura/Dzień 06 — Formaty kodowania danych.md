# Dzień 06 — Formaty kodowania danych

**Książka:** Designing Data-Intensive Applications, Martin Kleppmann (2017)
**Fragment:** Rozdział 4, część 1/2 — od początku do sekcji „Modes of Dataflow"
**Data:** 2026-06-19

---

## O czym jest ten fragment

Rozdział 4 zaczyna od prostego faktu: aplikacje się zmieniają, a dane trwają dłużej niż kod. Gdy wdrażasz nową wersję serwisu przez rolling upgrade, przez chwilę stara i nowa wersja działają obok siebie. Stare dane muszą być czytelne dla nowego kodu (*backward compatibility*), a nowe dane muszą być jakoś strawione przez stary kod (*forward compatibility*). To nie teoria — to codzienna rzeczywistość każdego systemu produkcyjnego.

Kleppmann przechodzi przez całe spektrum formatów kodowania danych.

**Serializacja wbudowana w język** (Java Serializable, Python pickle, Ruby Marshal) jest najwygodniejsza, ale niesie poważne problemy: wiąże cię z jednym językiem, stanowi zagrożenie bezpieczeństwa (deserializacja pozwala instancjować dowolne klasy), i zazwyczaj ignoruje kwestię wersjonowania.

**JSON, XML, CSV** to powszechnie akceptowane formaty wymiany danych, ale mają ukryte pułapki: JSON nie rozróżnia liczb całkowitych od zmiennoprzecinkowych (Twitter dlatego przesyła ID tweeta dwa razy — jako liczbę i jako string), nie obsługuje binarnych danych natywnie (stąd Base64 puchnie dane o 33%), a CSV nie ma żadnego schematu i przez to jest podatny na błędną interpretację.

**Binarne warianty JSON** (MessagePack, BSON itd.) są nieco mniejsze, ale wciąż zawierają nazwy pól w każdym rekordzie — bo nie mają schematu. Zysk jest niewielki.

Prawdziwa zmiana jakościowa to **Thrift i Protocol Buffers** — formatów binarnych opartych na schemacie. Zamiast nazw pól używają *field tags* (numerów). Tag to liczbowe ID pola, trwałe jak umowa: możesz zmienić nazwę pola w schemacie, ale tagu — nigdy. Dodając nowe pole z nowym tagiem, stary kod po prostu go ignoruje (forward compatibility). Usuwając pole, nigdy nie możesz użyć jego tagu ponownie.

**Apache Avro** idzie inaczej: brak tagów w ogóle, pola identyfikowane są po nazwie. Kluczowa idea: *writer's schema* (schemat, którym zapisano dane) i *reader's schema* (schemat, którego oczekuje czytelnik) nie muszą być identyczne — muszą być kompatybilne. Avro porównuje je przy odczycie i tłumaczy między nimi. To sprawia, że Avro świetnie sprawdza się przy dynamicznie generowanych schematach (np. z tabel relacyjnych).

Fragment kończy zestawienie zalet schematów binarnych: kompaktowość, schematy jako żywa dokumentacja, możliwość weryfikacji kompatybilności przed wdrożeniem, generowanie kodu ze schematu dla języków statycznie typowanych.

---

## Najważniejsze cytaty

> "Applications inevitably change over time. Features are added or modified as new products are launched, user requirements become better understood, or business circumstances change."

*Punkt wyjścia całego rozdziału: ewolucja jest nieunikniona, więc systemy muszą być na nią gotowe z góry.*

---

> "The encoding is often tied to a particular programming language, and reading the data in another language is very difficult. If you store or transmit data in such an encoding, you are committing yourself to your current programming language for potentially a very long time."

*Dlaczego pickle czy Serializable to pułapka: uzależniasz trwałe dane od przejściowej decyzji technologicznej.*

---

> "Field tags are like aliases for fields—they are a compact way of saying what field we're talking about, without having to spell out the field name."

*Serce Protocol Buffers i Thrift: tag to kontrakt, który pozwala na ewolucję schematu bez łamania istniejących danych.*

---

> "The key idea with Avro is that the writer's schema and the reader's schema don't have to be the same—they only need to be compatible."

*Avro oddziela moment zapisu od momentu odczytu — zamiast wymagać identyczności schematów, wymaga ich wzajemnej kompatybilności. To daje dużą elastyczność w środowiskach takich jak Hadoop.*

---

> "Schema evolution allows the same kind of flexibility as schemaless/schema-on-read JSON databases provide, while also providing better guarantees about your data and better tooling."

*Podsumowanie rozdziału: schemat to nie ograniczenie, ale narzędzie do kontrolowanej ewolucji.*

---

## Myśl dnia

Kodowanie danych to nie detal techniczny — to umowa między przeszłością a przyszłością twojego systemu. Format, który wybierzesz dziś, określa jak trudno będzie ci zmienić cokolwiek jutro. Tagi w Protobuf, nazwy w Avro, brak schematu w JSON — każde z tych podejść to inny kompromis między sztywnością a elastycznością. Kleppmann pokazuje, że da się mieć obie: schematy binarne dają rygor i wydajność, a mechanizmy ewolucji schematu — elastyczność porównywalną z „bezschematowymi" bazami danych, tylko z lepszymi gwarancjami.

---

**Jutro (Dzień 07):** Rozdział 4, część 2/2 — Modes of Dataflow: dataflow przez bazy danych, przez serwisy (REST i RPC), oraz przez kolejki wiadomości.
