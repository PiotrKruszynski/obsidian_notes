---
title: "Database"
type: concept
topic: databases
tags: ["databases", "sql"]
created: 2026-06-09
status: draft
sr_due: 2026-07-17
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Baza danych

> [!summary] W jednym zdaniu
> Baza danych to zbiór danych  + mechanizmy zapisu, odczytu, aktualizacji i wyszukiwania, wysoka dostępność dla wielu aktorów , potrzebny jest cały system -> DBMS.

**DBMS** (Database Management System) — oprogramowanie zarządzające bazą:
- PostgreSQL, MySQL, Oracle, SQL Server
- MongoDB, Redis (NoSQL)

---

## SQL — języki poleceń

Polecenia SQL dzielą się na cztery grupy:

**DML** — Data Manipulation Language (CRUD na danych)
```sql
SELECT, INSERT INTO, UPDATE, DELETE
```

**DDL** — Data Definition Language (manipulacja schematem)
```sql
CREATE, DROP, ALTER, TRUNCATE
```

**DCL** — Data Control Language (uprawnienia)
```sql
GRANT, REVOKE
```

**TCL** — Transaction Control Language
```sql
COMMIT, ROLLBACK
```

---

## Powiązane notatki
- [[types of databases|Typy baz danych]] — przegląd wszystkich typów (SQL, NoSQL, Graph, Vector…)
- [[Model relacyjny]] — tabele, wiersze, klucze
- [[ACID — co to naprawdę znaczy]] — gwarancje transakcyjne
- [[Transakcje i ACID]] — praktyczne ujęcie z przykładami SQL
- [[Kiedy SQL, kiedy NoSQL]] — jak wybrać
