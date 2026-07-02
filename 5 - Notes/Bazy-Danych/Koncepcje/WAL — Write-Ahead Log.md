---
sr_due: 2026-07-15
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---
# WAL — Write-Ahead Log

> [!summary]
> WAL to append-only dziennik zmian na dysku. Każda modyfikacja trafia najpierw do WAL, potem do rzeczywistych struktur. Gwarantuje Durability w ACID — nawet po crashu transakcje nie giną.

## Po co WAL

B-Tree modyfikuje strony in-place. Jeśli crash w połowie operacji (np. split strony):
- połowa zmian jest na dysku
- połowa nie
- indeks uszkodzony

WAL rozwiązuje to przez: **zapisz intencję zanim wykonasz**.

```
1. COMMIT transakcji →
2. Zapisz opis zmiany do WAL (append, szybkie) →
3. Potwierdź COMMIT klientowi →
4. Asynchronicznie aplikuj zmiany do B-Tree
```

Jeśli crash między 3 a 4: po restarcie baza odtwarza zmiany z WAL.

> [!example]
> PostgreSQL WAL = pliki w `pg_wal/`. InnoDB (MySQL) = `ib_logfile0`, `ib_logfile1`. Oba działają na tej zasadzie.

## WAL a replikacja

W PostgreSQL WAL służy też do replikacji: slave pobiera WAL od mastera i aplikuje te same zmiany. To standardowy mechanizm primary-replica setup.

> [!tip]
> Dlatego `pg_wal` może być duży — jeśli replica nie nadąża z replikacją, master musi trzymać więcej plików WAL. `wal_keep_size` to parametr konfiguracyjny.

## WAL a performance

WAL to **sequential write** (append). Sequential I/O jest wielokrotnie szybszy niż random I/O, szczególnie na HDD. Na SSD mniej, ale też ma znaczenie.

To dlatego commit jest szybki — trzeba tylko dopisać do WAL. Aktualizacja B-Tree może poczekać.

## Połączenia

- [[B-Tree — jak SQL przechowuje dane]] — WAL chroni B-Tree przed uszkodzeniem
- [[ACID — co to naprawdę znaczy]] — WAL implementuje D (Durability)
- [[LSM-Tree vs B-Tree — porównanie]] — LSM-Tree też ma swój WAL (dla memtable)
