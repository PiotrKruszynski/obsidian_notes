---
title: "Database"
type: concept
topic: databases
tags: []
created: 2026-06-09
status: draft
---

dane zebrane w jakieś miejsce

DBMS - data base management system
- PostgresSQL
- Oracle
- MySQL
- SQL Server pierwsza z ‘79
- Mongo DB
- Redis

RDBMS używają Structured Query Language

SQL 
 - **DML** (_data manipulation language_) CRUD 
	 -  INSERT INTO
	 - SELECT
	 - UPDATE
	 - DELETE
- DCL (_data control language)
	- GRANT _nadanie uprawnienia_
	- REVOKE _odebranie_
- DDL _data definition language_ komendy, które pozwalają manipulować schema
	- CREATE
	- DROP
	- ALTER
	- TRUNCATE
- TCL _transaction definition language_
	- COMMIT
	- ROLLBACK

ACID
atomic
consistency - mamy spójność na wejściu i na wyjściu
isolation
durability - trwałość
[[5 - Notes/BazyDanych_SecondBrain/Koncepcje/ACID — co to naprawdę znaczy|ACID — co to naprawdę znaczy]]]
![[Pasted image 20260608174518.png]]

![[Pasted image 20260609115239.png]]