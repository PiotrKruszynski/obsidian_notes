# Dirty Read, Non-Repeatable Read, Phantom Read

> [!summary]
> Trzy klasy anomalii transakcyjnych. Im słabszy poziom izolacji, tym więcej anomalii. Musisz wiedzieć które cię dotyczą — i wybrać odpowiedni poziom izolacji.

## Dirty Read

Transakcja T1 czyta dane **niezatwierdzone** przez T2 (które mogą być potem wycofane).

> [!example]
> T2: `UPDATE orders SET status = 'paid' WHERE id = 5` (jeszcze nie COMMIT)
> T1: `SELECT status FROM orders WHERE id = 5` → widzi `'paid'`
> T2: ROLLBACK
> T1 podjęła decyzję na podstawie danych, które nigdy "oficjalnie" nie istniały.

**Rozwiązanie**: poziom izolacji `READ COMMITTED` lub wyższy.

## Non-Repeatable Read

T1 czyta te same dane dwa razy i dostaje różne wyniki, bo T2 je zmodyfikowała między odczytami.

> [!example]
> T1: `SELECT saldo FROM konto WHERE id = 1` → 1000 zł
> T2: `UPDATE konto SET saldo = 500 WHERE id = 1` + COMMIT
> T1: `SELECT saldo FROM konto WHERE id = 1` → 500 zł
> 
> T1 miała spójny widok na początku — potem się zmienił. Dla transakcji raportującej to problem (suma może się nie zgadzać).

**Rozwiązanie**: `REPEATABLE READ` lub Snapshot Isolation.

## Phantom Read

T1 wykonuje ten sam zakres zapytania dwa razy i widzi różne wiersze (T2 wstawiła lub usunęła wiersze pasujące do warunków T1).

> [!example]
> T1: `SELECT COUNT(*) FROM orders WHERE amount > 100` → 50
> T2: `INSERT INTO orders (amount) VALUES (200)` + COMMIT
> T1: `SELECT COUNT(*) FROM orders WHERE amount > 100` → 51
> 
> Żaden z widzianych wcześniej wierszy nie zmienił się — pojawił się nowy ("fantom").

**Rozwiązanie**: `SERIALIZABLE` lub Predicate Locks.

## Podsumowanie

| Anomalia | READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE |
|---|---|---|---|---|
| Dirty Read | ✗ możliwy | ✓ wyeliminowany | ✓ | ✓ |
| Non-Repeatable Read | ✗ | ✗ możliwy | ✓ wyeliminowany | ✓ |
| Phantom Read | ✗ | ✗ | ✗ możliwy | ✓ wyeliminowany |

PostgreSQL domyślnie: `READ COMMITTED`.

## Połączenia
- [[Poziomy izolacji transakcji]] — który poziom blokuje którą anomalię

- [[ACID — co to naprawdę znaczy]] — anomalie to konsekwencja słabego Isolation
- [[Poziomy izolacji transakcji]] — formalna definicja poziomów
- [[MVCC — Snapshot Isolation]] — jak baza eliminuje te anomalie bez locków
