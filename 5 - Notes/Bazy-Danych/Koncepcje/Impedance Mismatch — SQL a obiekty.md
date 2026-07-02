---
sr_due: 2026-07-16
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---
# Impedance Mismatch — SQL a obiekty

> [!summary]
> Impedance mismatch = niezgodność między obiektowym modelem kodu a relacyjnym modelem bazy. Musisz tłumaczyć między nimi — to źródło bugów i złożoności.

## Na czym polega problem

W aplikacji masz obiekt (Sakila: film z obsadą):
```python
film = {
  "title": "ALIEN CENTER",
  "actors": ["PENELOPE GUINESS", "NICK WAHLBERG"]
}
```

W relacyjnej bazie nie możesz wstawić listy w jedno pole. Musisz rozbić na tabele i tabelę łączącą:
```sql
INSERT INTO film (title, language_id) VALUES ('ALIEN CENTER', 1);
INSERT INTO film_actor (actor_id, film_id) VALUES (1, 1001);
INSERT INTO film_actor (actor_id, film_id) VALUES (2, 1001);
```

To impedance mismatch — dwie reprezentacje tego samego (a w kodzie `film.actors` to po stronie SQL aż trzy tabele: `film`, `film_actor`, `actor`).

## Konsekwencje

- ORMy (SQLAlchemy, Hibernate) ukrywają problem, ale nie eliminują
- N+1 queries — klasyczny bug ORM: pobierasz 100 userów, każdy user odpala osobne query po adresy = 101 queries
- Migracje schematu są skomplikowane, bo dwie warstwy (kod + baza)

> [!warning]
> ORM nie jest rozwiązaniem impedance mismatch — jest jego opakowaniem. Musisz rozumieć co ORM generuje za SQL. `user.addresses` może być 1 query lub 1000 queries zależnie od konfiguracji.

## Częściowe rozwiązania

- **JSON kolumny w SQL** (PostgreSQL): możesz wstawić listę adresów jako JSON. Ale stracisz JOIN, indeksowanie po polach JSON jest ograniczone.
- **Document DB** (MongoDB): natywna obsługa zagnieżdżonych dokumentów. Impedance mismatch mniejszy dla danych drzewiastych. Ale wraca przy many-to-many.

> [!tip]
> Kleppmann: PostgreSQL od wersji 9.3 obsługuje JSON z zapytaniami wewnątrz JSON. Możesz mieć relacyjny model + elastyczne zagnieżdżone pola tam gdzie to sensowne.

## Połączenia

- [[Normalizacja vs Denormalizacja]] — normalizacja pogłębia impedance mismatch (więcej tabel = więcej JOIN)
- [[JOIN — siła relacyjnego modelu]] — JOINy to cena, którą płacisz za normalizację
- [[Kiedy SQL, kiedy NoSQL]] — document DB jako odpowiedź na impedance mismatch
