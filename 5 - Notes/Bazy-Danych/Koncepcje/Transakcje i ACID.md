---
tags: ["sql"]
powiązane: ["[[Model relacyjny]]"]
---

# Transakcje i ACID

> [!summary] W jednym zdaniu
> Transakcja grupuje kilka operacji w jedną "wszystko albo nic"; ACID to cztery gwarancje, które baza relacyjna daje takim grupom.

Transakcja:
```sql
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;   -- albo ROLLBACK, by cofnąć całość
```
Przelew to dwie operacje, które muszą się wykonać **razem albo wcale** — inaczej znikłyby pieniądze. `COMMIT` zatwierdza, `ROLLBACK` cofa.

**ACID** — cztery litery, które warto umieć rozwinąć:
- **Atomicity (atomowość)** — wszystko albo nic; częściowe wykonanie jest cofane.
- **Consistency (spójność)** — transakcja przeprowadza bazę z jednego poprawnego stanu w drugi (reguły, klucze, ograniczenia pozostają spełnione).
- **Isolation (izolacja)** — równoległe transakcje nie widzą swoich niezakończonych zmian (poziomy izolacji regulują, jak bardzo).
- **Durability (trwałość)** — po `COMMIT` dane przetrwają nawet awarię zasilania.

> [!tip] Pytanie rozmowowe
> "Rozwiń ACID" pada często. Atomowość zilustruj przelewem (dwa UPDATE-y jako całość). Izolację możesz podlinkować do zjawisk jak dirty read / phantom read, jeśli rozmowa idzie głębiej.

## Połączenia
- [[ACID — co to naprawdę znaczy]] — głębsze ujęcie (DDIA): czemu „C” to marketing
- [[Poziomy izolacji transakcji]] — co realnie daje READ COMMITTED vs SERIALIZABLE
- [[MVCC — Snapshot Isolation]] — jak baza realizuje izolację bez locków
- [[WAL — Write-Ahead Log]] — jak działa Durability pod spodem
- [[Model relacyjny]] — transakcje to gwarancje nad operacjami na tabelach
