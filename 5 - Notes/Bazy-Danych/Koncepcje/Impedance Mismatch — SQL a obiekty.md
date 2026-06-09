# Impedance Mismatch — SQL a obiekty

> [!summary]
> Impedance mismatch = niezgodność między obiektowym modelem kodu a relacyjnym modelem bazy. Musisz tłumaczyć między nimi — to źródło bugów i złożoności.

## Na czym polega problem

W aplikacji masz obiekt:
```python
user = {
  name: "Jan",
  addresses: [
    {type: "home", city: "Warszawa"},
    {type: "work", city: "Kraków"}
  ]
}
```

W relacyjnej bazie nie możesz wstawić listy w jedno pole. Musisz rozbić:
```sql
INSERT INTO users (name) VALUES ('Jan');
INSERT INTO addresses (user_id, type, city) VALUES (1, 'home', 'Warszawa');
INSERT INTO addresses (user_id, type, city) VALUES (1, 'work', 'Kraków');
```

To impedance mismatch — dwie reprezentacje tego samego.

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
