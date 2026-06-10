---
title: "00 — MOC SQL (DDIA)"
type: concept
topic: databases
tags: ["databases"]
created: 2026-06-09
status: draft
---

# 00 — MOC SQL (Kleppmann DDIA)

Punkt wejścia do notatek z *Designing Data-Intensive Applications* (Kleppmann, 2017), rozdział SQL i relacyjne bazy danych.

---

## Fundament: model relacyjny

- [[Model Relacyjny — dlaczego wygrał]]
- [[SQL jako język deklaratywny]]
- [[Normalizacja vs Denormalizacja]]
- [[Impedance Mismatch — SQL a obiekty]]

## Storage Engines — co dzieje się pod spodem

- [[B-Tree — jak SQL przechowuje dane]]
- [[LSM-Tree vs B-Tree — porównanie]]
- [[WAL — Write-Ahead Log]]
- [[Indeks — jak działa i kiedy pomaga|Indeks — koszt i korzyść]]

## Transakcje i ACID

- [[ACID — co to naprawdę znaczy]]
- [[Poziomy izolacji transakcji]]
- [[Dirty Read, Non-Repeatable Read, Phantom Read]]
- [[MVCC — Snapshot Isolation]]

## SQL vs NoSQL — kiedy co

- [[Kiedy SQL, kiedy NoSQL]]
- [[JOIN — siła relacyjnego modelu]]
- [[Schema-on-write vs Schema-on-read]]

---

## Pytania kontrolne

1. Dlaczego relacyjny model wygrał z hierarchicznym i sieciowym? → [[Model Relacyjny — dlaczego wygrał]]
2. Co daje deklaratywność SQL i dlaczego to ważne dla optymalizatora? → [[SQL jako język deklaratywny]]
3. Jaka jest różnica między B-Tree a LSM-Tree pod względem odczytów i zapisów? → [[LSM-Tree vs B-Tree — porównanie]]
4. Co to jest dirty read i jak snapshot isolation go eliminuje? → [[Dirty Read, Non-Repeatable Read, Phantom Read]]
5. Kiedy normalizacja szkodzi wydajności? → [[Normalizacja vs Denormalizacja]]

---

*Źródło: Kleppmann M., Designing Data-Intensive Applications, O'Reilly 2017, rozdziały 2, 3, 7*
