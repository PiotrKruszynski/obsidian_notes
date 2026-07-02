---
sr_due: 2026-07-04
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---
# Kiedy SQL, kiedy NoSQL

> [!summary]
> Nie ma odpowiedzi "SQL zawsze" ani "NoSQL jest nowocześniejszy". Każdy model danych ma swoje przypadki użycia. Kleppmann: relacyjny model jest "niezbędny, ale nie ostatnim słowem".

## Model danych jako główne kryterium

### Silnie powiązane dane (many-to-many) → SQL

Jeśli dane mają dużo relacji krzyżowych: użytkownik należy do wielu organizacji, organizacja ma wielu użytkowników, użytkownik komentuje wiele postów...

SQL + JOINy to naturalne środowisko. Dokumentowe bazy mają słabe lub emulowane JOINy.

### Drzewiaste dane (1:many, brak join'ów) → Document DB

Profil użytkownika z listą adresów, listą telefonów, listą certyfikatów. Wszystko w jednym "dokumencie".

> [!tip]
> Kleppmann: "Jeśli twoje dane wyglądają jak drzewa, które rzadko się krzyżują — dokumentowe bazy dają locality za darmo."

### Graf (wszystko łączy się ze wszystkim) → Graph DB

Sieci społecznościowe, rekomendacje, zależności. Neo4j, ArangoDB.

## Praktyczna heurystyka Kleppmann'a

Pytania przy wyborze:

1. **Czy potrzebujesz JOINów?** Tak → SQL. Nie → Document może być prostszy.
2. **Czy dane mają sztywny schemat?** Tak → SQL (schema-on-write). Nie → Document (schema-on-read).
3. **Write-heavy, proste odczyty?** → LSM-based NoSQL (Cassandra).
4. **Analytics na dużych zbiorach?** → Column-oriented (BigQuery, Redshift).
5. **ACID transakcje wymagane?** → SQL (lub NewSQL).

> [!warning]
> NoSQL ≠ "bez SQL". Wiele NoSQL baz ma swój język zapytań. NoSQL = "Not Only SQL" — różnorodność modeli danych, nie "bez transakcji".

## Schema-on-write vs Schema-on-read

- **Schema-on-write (SQL)**: schemat zdefiniowany z góry. Baza odrzuca dane niezgodne. Bezpieczniej, sztywniej.
- **Schema-on-read (Document)**: baza przyjmuje wszystko, aplikacja interpretuje. Elastyczniej, ryzykowniej.

> [!example]
> SQL: `ALTER TABLE users ADD COLUMN phone VARCHAR(20)` — na dużej tabeli może być problem.
> MongoDB: po prostu zacznij wstawiać dokumenty z polem `phone`. Stare dokumenty go nie mają — aplikacja musi obsłużyć `null`.

## Połączenia

- [[Normalizacja vs Denormalizacja]] — normalizacja jest łatwiejsza w SQL
- [[JOIN — siła relacyjnego modelu]] — przewaga SQL dla powiązanych danych
- [[LSM-Tree vs B-Tree — porównanie]] — storage engine jest powiązany z modelem danych
- [[Impedance Mismatch — SQL a obiekty]] — document DB częściowo rozwiązuje impedance mismatch
