---
tags: ["databases", "ddia", "moc", "sql"]
typ: master-map-of-content
---

# 00 — MASTER MOC: Bazy danych (SQL + DDIA)

> [!summary] Czym jest ta notatka
> Nadrzędny punkt wejścia łączący dwie warstwy wiedzy o bazach: **warstwę zapytań** (SQL pod rozmowę — jak pisać i nie wpaść w pułapki) oraz **warstwę silnika** (notatki z Kleppmann *DDIA* — jak baza działa od środka). To dwa spojrzenia na to samo: jedno mówi „jak używać", drugie „dlaczego tak działa".

## Dwie mapy dziedzinowe (pod-MOC)
- [[00 — MOC SQL (zapytania)]] — praktyka i rozmowa: zapytania, JOIN-y, NULL, okna, pułapki
- [[00 — MOC SQL (DDIA)]] — silnik: storage engines, transakcje, izolacja, SQL vs NoSQL

## Mostki: ten sam temat w dwóch warstwach
Każdy wiersz to jedno pojęcie widziane z dwóch stron — klikaj w zależności od tego, czy chcesz „jak używać", czy „jak działa".

| Temat | Warstwa zapytań (jak używać) | Warstwa silnika (jak działa) |
|---|---|---|
| Transakcje | [[Transakcje i ACID]] | [[ACID — co to naprawdę znaczy]] |
| Izolacja | [[Transakcje i ACID]] | [[Poziomy izolacji transakcji]], [[MVCC — Snapshot Isolation]], [[Dirty Read, Non-Repeatable Read, Phantom Read]] |
| Indeksy | [[Indeks — jak działa i kiedy pomaga]] | [[B-Tree — jak SQL przechowuje dane]], [[Indeks — jak działa i kiedy pomaga|Indeks — koszt i korzyść]], [[LSM-Tree vs B-Tree — porównanie]] |
| Model relacyjny | [[Model relacyjny]] | [[Model Relacyjny — dlaczego wygrał]], [[Impedance Mismatch — SQL a obiekty]] |
| Normalizacja | [[Normalizacja (1NF, 2NF, 3NF)]] | [[Normalizacja vs Denormalizacja]] |
| Wykonanie zapytania | [[Logiczna kolejność wykonania zapytania]] | [[SQL jako język deklaratywny]] |
| Trwałość danych | [[Transakcje i ACID]] | [[WAL — Write-Ahead Log]] |
| Wybór bazy | [[Model relacyjny]] | [[Kiedy SQL, kiedy NoSQL]] |

## Jak tego używać
- Uczysz się pod **rozmowę** → start od [[00 — MOC SQL (zapytania)]] i zestawów pytań; gdy padnie „jak to działa pod spodem", przeskakuj mostkiem do warstwy DDIA.
- Chcesz **zrozumieć silnik** → start od [[00 — MOC SQL (DDIA)]]; gdy chcesz zobaczyć, jak to wygląda w zapytaniu, skacz do warstwy zapytań.

> [!tip] Czemu to połączenie ma sens
> Na rozmowie pytanie „jak działa indeks?" zaczynasz od warstwy zapytań (przyspiesza WHERE/JOIN, koszt przy zapisie), a punktujesz, dodając warstwę silnika ([[B-Tree — jak SQL przechowuje dane|B-Tree]], strony 4KB, ~4 odczyty dysku na 256 TB). Połączone warstwy = odpowiedź, która brzmi jak od kogoś, kto rozumie, a nie wykuł.

> [!warning] Co uzupełniłem, a co zostaje Tobie
> Twój [[00 — MOC SQL (DDIA)]] miał trzy martwe linki. Dwa najczęściej linkowane (a więc centralne) uzupełniłem w Twoim stylu — sprawdź, czy ujęcie Ci pasuje, i przerób pod siebie:
> - [[Poziomy izolacji transakcji]] — była linkowana też z [[ACID — co to naprawdę znaczy|ACID]].
> - [[JOIN — siła relacyjnego modelu]] — była linkowana z 4 miejsc.
>
> Jeden zostaje **Tobie** (świadomie nie pisałem za Ciebie — to Twój temat NoSQL): **Schema-on-write vs Schema-on-read**. Linkowany tylko z MOC.
