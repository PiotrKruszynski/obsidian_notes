---
tags: ["sql"]
powiązane: ["[[Model relacyjny]]"]
sr_due: 2026-07-18
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Transakcje i ACID

> [!summary] W jednym zdaniu
> Transakcja grupuje kilka operacji w jedną "wszystko albo nic"; ACID to cztery gwarancje, które baza relacyjna daje takim grupom.

Transakcja (Sakila — zwrot filmu i pobranie opłaty):
```sql
BEGIN;
UPDATE rental SET return_date = NOW() WHERE rental_id = 1;
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (130, 1, 1, 2.99, NOW());
COMMIT;   -- albo ROLLBACK, by cofnąć całość
```
Zwrot to dwie operacje, które muszą się wykonać **razem albo wcale** — inaczej film wróciłby "za darmo" (albo klient zapłaciłby bez odnotowania zwrotu). `COMMIT` zatwierdza, `ROLLBACK` cofa.

**ACID** — cztery litery, które warto umieć rozwinąć:
- **Atomicity (atomowość)** — wszystko albo nic; częściowe wykonanie jest cofane.
- **Consistency (spójność)** — transakcja przeprowadza bazę z jednego poprawnego stanu w drugi (reguły, klucze, ograniczenia pozostają spełnione).
- **Isolation (izolacja)** — równoległe transakcje nie widzą swoich niezakończonych zmian (poziomy izolacji regulują, jak bardzo).
- **Durability (trwałość)** — po `COMMIT` dane przetrwają nawet awarię zasilania.

> [!tip] Pytanie rozmowowe
> "Rozwiń ACID" pada często. Atomowość zilustruj przelewem bankowym (dwa UPDATE-y sald jako całość — kanon rozmów) albo zwrotem+płatnością jak wyżej. Izolację możesz podlinkować do zjawisk jak dirty read / phantom read, jeśli rozmowa idzie głębiej.

## Połączenia
- [[ACID — co to naprawdę znaczy]] — głębsze ujęcie (DDIA): czemu „C” to marketing
- [[Poziomy izolacji transakcji]] — co realnie daje READ COMMITTED vs SERIALIZABLE
- [[MVCC — Snapshot Isolation]] — jak baza realizuje izolację bez locków
- [[WAL — Write-Ahead Log]] — jak działa Durability pod spodem
- [[Model relacyjny]] — transakcje to gwarancje nad operacjami na tabelach
