---
sr_due: 2026-07-14
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---
# Normalizacja vs Denormalizacja

> [!summary]
> Normalizacja eliminuje duplikację danych kosztem JOIN-ów. Denormalizacja przyspiesza odczyty kosztem duplikacji i ryzyka niespójności.

## Normalizacja — idea

Jeśli ta sama informacja jest w wielu miejscach, wydziel ją do oddzielnej tabeli i linkuj przez ID.

```
-- Zduplikowane (denormalizacja):
users: {name: "Jan", city: "Warszawa", city_country: "PL"}

-- Znormalizowane:
users: {name: "Jan", city_id: 42}
cities: {id: 42, name: "Warszawa", country_id: 1}
countries: {id: 1, name: "PL"}
```

> [!tip]
> Kleppmann: "ID ma tę zaletę, że nie ma znaczenia dla ludzi — nigdy nie trzeba go zmieniać. Wszystko co ma znaczenie dla ludzi (nazwy, adresy) może się zmienić. Jeśli jest zduplikowane — musisz zaktualizować wszystkie kopie."

## Kiedy normalizacja boli

- Każde zapytanie o użytkownika z miastem i krajem → 3-table JOIN
- Na dużym zbiorze danych JOIN jest kosztowny
- Dokument DB (np. MongoDB) nie ma wydajnych JOINów → normalizacja utrudnia

> [!warning]
> MySQL robi `ALTER TABLE` przez kopiowanie całej tabeli. Na tabeli 100M wierszy = godziny downtime'u. Inne bazy (PostgreSQL) robią to w milisekundach.

## Denormalizacja — kiedy sensowna

- Read-heavy workload (np. dashboard, raporty)
- Dane rzadko się zmieniają
- Akceptowalne jest ręczne utrzymywanie spójności w aplikacji

> [!example]
> Twitter: każdy tweet zawiera `author_name` zamiast tylko `author_id`. Odczyt home timeline = bez JOIN. Ale zmiana nazwy użytkownika → update milionów tweetów.

## Związek z NoSQL

Dokumentowe bazy (MongoDB) naturalnie faworyzują denormalizację — cały "dokument" w jednym miejscu. Działa dla 1:many (user → tweets). Nie działa dla many:many.

## Połączenia
- [[Normalizacja (1NF, 2NF, 3NF)]] — postaci normalne w praktyce

- [[JOIN — siła relacyjnego modelu]] — normalizacja zakłada sprawne JOINy
- [[Indeks — jak działa i kiedy pomaga|Indeks — koszt i korzyść]] — znormalizowane tabele potrzebują indeksów na kluczach obcych
- [[Kiedy SQL, kiedy NoSQL]] — wybór między normalizacją a denormalizacją wpływa na wybór bazy
- [[Impedance Mismatch — SQL a obiekty]] — normalizacja pogłębia impedance mismatch
