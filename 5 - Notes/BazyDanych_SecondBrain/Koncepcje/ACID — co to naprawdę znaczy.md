# ACID — co to naprawdę znaczy

> [!summary]
> ACID to cztery gwarancje transakcji. Brzmią prosto, ale każda ma subtelne implikacje. Kleppmann: "C w ACID to marketing — consistency to właściwość aplikacji, nie bazy."

## Cztery litery

### A — Atomicity (Atomiczność)
Transakcja albo w całości się udaje, albo w całości jest wycofana. Nie ma "połowicznego" stanu.

> [!example]
> Przelew bankowy: `UPDATE konto_A SET saldo = saldo - 100` i `UPDATE konto_B SET saldo = saldo + 100`. Jeśli baza crashuje po pierwszym UPDATE — drugi się nie wykona. Bez atomicity: pieniądze znikają z A, nie docierają do B. Z ACID: całość jest rollback'owana.

### C — Consistency (Spójność)
Baza przechodzi ze spójnego stanu do spójnego stanu. Ale **spójność definiujesz Ty** — przez constrainty, foreign keys, CHECK. Baza tylko egzekwuje reguły, które napisałeś.

> [!warning]
> Kleppmann wprost pisze: "C w ACID zostało dodane żeby akronim brzmiał ładnie." To nie jest gwarancja bazy — to odpowiedzialność aplikacji. Baza pilnuje constaintów, ale jeśli ich nie zdefiniowałeś, nic nie pilnuje.

### I — Isolation (Izolacja)
Równoległe transakcje nie widzą się nawzajem — jakby były wykonywane sekwencyjnie. Pełna izolacja = serializable.

Ale pełna izolacja jest droga (locki). Dlatego istnieją słabsze poziomy izolacji z określonymi anomaliami. → [[Poziomy izolacji transakcji]]

### D — Durability (Trwałość)
Po `COMMIT` dane są zapisane. Nawet crash nie cofnie zatwierdzonej transakcji.

Implementacja: WAL (Write-Ahead Log) → [[WAL — Write-Ahead Log]]

## ACID w praktyce

PostgreSQL domyślnie: poziom izolacji `READ COMMITTED` (nie pełna izolacja, ale bez dirty reads).
MySQL InnoDB: podobnie.

Pełna izolacja (`SERIALIZABLE`) dostępna, ale rzadko używana w produkcji — za wolna.

## Połączenia
- [[Transakcje i ACID]] — praktyczne ujęcie i typowe pytania rozmowowe
- [[Poziomy izolacji transakcji]] — jak Isolation jest implementowane w praktyce
- [[Dirty Read, Non-Repeatable Read, Phantom Read]] — anomalie bez pełnej izolacji
- [[MVCC — Snapshot Isolation]] — wydajna implementacja izolacji
- [[WAL — Write-Ahead Log]] — implementacja Durability
