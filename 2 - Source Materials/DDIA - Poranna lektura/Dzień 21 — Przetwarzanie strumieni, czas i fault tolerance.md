# Dzień 21 — Rozdział 11 (2/2): Przetwarzanie strumieni — zastosowania, czas, joiny, odporność na awarie

## O czym jest

Wczoraj było o tym, skąd strumienie się biorą i jak je transportować. Dziś Kleppmann odpowiada na pytanie: co z nimi robić. Trzy opcje: zapisywać zdarzenia do bazy/indeksu/cache'a, pchać je do ludzi (alerty, dashboardy) albo — najciekawsze — przetwarzać strumienie w inne strumienie. Taki procesor (operator, job) przypomina procesy Uniksa i MapReduce, z jedną kluczową różnicą: strumień nigdy się nie kończy. Nie da się posortować nieskończonych danych (odpadają sort-merge joiny), a restart "od zera" po awarii nie wchodzi w grę, gdy job działa od lat.

Zastosowania: CEP (complex event processing) szuka wzorców zdarzeń w strumieniu — odwraca relację bazy i zapytania, bo to zapytania są trwałe, a dane przepływają obok nich. Analityka strumieniowa liczy agregacje i statystyki w oknach czasowych (często algorytmami probabilistycznymi jak Bloom filter czy HyperLogLog — to optymalizacja, nie wada strumieni). Do tego utrzymywanie zmaterializowanych widoków (okno "od początku czasu") i wyszukiwanie na strumieniach (zapisane zapytania, dokumenty przepływają — np. percolator w Elasticsearch).

Rozumowanie o czasie to pole minowe. Trzeba odróżniać event time (kiedy coś się stało) od processing time (kiedy procesor to zobaczył). Mylenie ich daje artefakty: po restarcie procesora backlog wygląda jak nagły skok ruchu. Problem maruderów (stragglers): nigdy nie wiadomo, czy okno jest już kompletne — można ich ignorować albo publikować korekty. Zegar urządzenia użytkownika bywa przekłamany, więc loguje się trzy timestampy (zdarzenie i wysyłka wg zegara urządzenia, odbiór wg zegara serwera), by oszacować offset. Typy okien: tumbling (stałe, rozłączne), hopping (nakładające się), sliding (przesuwne) i session (bez stałej długości, kończy się bezczynnością użytkownika).

Joiny na strumieniach są trzy. Stream-stream (window join): np. łączenie wyszukiwań z kliknięciami po session ID, by policzyć CTR — procesor trzyma stan z ostatniej godziny po obu stronach. Stream-table (wzbogacanie): zdarzenia aktywności łączone z lokalną kopią bazy profili, aktualizowaną przez CDC — czyli w praktyce też join dwóch strumieni. Table-table: dwa changelogi utrzymują zmaterializowany widok, jak timeline'y Twittera. Wspólny problem: zależność od czasu — jeśli stan się zmienia (np. stawka VAT), z którą wersją joinować? Hurtownie danych znają to jako slowly changing dimension i rozwiązują wersjonowanymi identyfikatorami, kosztem log compaction.

Na koniec fault tolerance. Batch daje "exactly-once semantics" (trafniej: effectively-once) — wynik wygląda, jakby nic nie zawiodło. W strumieniu nie można czekać z pokazaniem wyniku do końca, bo końca nie ma. Rozwiązania: microbatching (Spark Streaming, ~1 s), checkpointy z barierami (Flink), atomowy commit wewnątrz frameworku (Dataflow, VoltDB, plany w Kafce) oraz idempotencja — dopisanie offsetu Kafki do zapisu w zewnętrznej bazie pozwala wykryć powtórkę. Stan odbudowuje się z replik, snapshotów albo wprost z logu wejściowego.

## Najważniejsze cytaty

> "CEP engines reverse these roles: queries are stored long-term, and events from the input streams continuously flow past them in search of a query that matches an event pattern."

Silniki CEP odwracają role bazy danych: zapytanie jest trwałe, a dane przepływają obok niego — przeciwieństwo klasycznej bazy, gdzie dane leżą, a zapytania są ulotne.

> "If you measure the rate based on the processing time, it will look as if there was a sudden anomalous spike of requests while processing the backlog, when in fact the real rate of requests was steady."

Mierzenie po czasie przetwarzania kłamie: po restarcie procesora nadrabianie zaległości wygląda jak skok ruchu, którego nigdy nie było. Dlatego okna trzeba liczyć po event time.

> "This principle is known as exactly-once semantics, although effectively-once would be a more descriptive term."

"Dokładnie raz" nie znaczy, że rekord fizycznie przetworzono raz — znaczy, że w widocznym wyniku wygląda to tak, jakby przetworzono go raz, mimo powtórek po awariach.

> "if state changes over time, and you join with some state, what point in time do you use for the join?"

Sedno problemu joinów: gdy stan (profil, stawka podatku) zmienia się w czasie, join z "aktualnym" stanem jest niedeterministyczny — powtórne uruchomienie może dać inny wynik.

> "An idempotent operation is one that you can perform multiple times, and it has the same effect as if you performed it only once."

Idempotencja to tani sposób na exactly-once: skoro powtórzenie operacji nic nie zmienia, można bezpiecznie ponawiać po awarii — pod warunkiem deterministycznego przetwarzania i tej samej kolejności komunikatów.

## Myśl dnia

Strumień to batch, który nigdy się nie kończy — więc wszystko, co w batchu było darmowe (sortowanie, restart od zera, "gotowy wynik"), w strumieniu trzeba odzyskać sprytem: oknami po event time, stanem w procesorze i idempotencją zamiast czekania na koniec danych.

---

*Jutro: początek rozdziału 12 — „The Future of Data Systems": integracja danych, łączenie narzędzi przez pochodne dane i granice architektury lambda.*
