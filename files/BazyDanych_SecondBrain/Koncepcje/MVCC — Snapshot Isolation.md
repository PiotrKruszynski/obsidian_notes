# MVCC — Snapshot Isolation

> [!summary]
> MVCC (Multi-Version Concurrency Control) daje każdej transakcji "zdjęcie" bazy z momentu startu. Czytasz swoją kopię — bez locków na odczyt, bez blokowania zapisów.

## Problem z lockami

Klasyczny sposób na izolację: locki. Chcesz czytać wiersz — zakładasz lock read. Chcesz pisać — lock write.

Problem: każdy odczyt blokuje zapisy i vice versa. Na ruchliwej bazie = deadlocki, kolejki, słaba wydajność.

## Rozwiązanie: wiele wersji

Zamiast jednej kopii danych, baza trzyma **wiele wersji** każdego wiersza, oznaczonych timestampem/transaction ID.

```
wiersz user_id=42:
  wersja txn_100: {email: "stary@test.pl"}   ← stara wersja
  wersja txn_150: {email: "nowy@test.pl"}    ← nowa wersja
```

Transakcja T1 zaczyna się przy txn_140 → widzi wersję txn_100.
Transakcja T2 zaczyna się przy txn_160 → widzi wersję txn_150.

> [!tip]
> Analogia: MVCC to jak Git dla każdego wiersza. Każda transakcja dostaje checkout z konkretnego commita. Nowe commity (inne transakcje) nie wpływają na twój checkout.

## Readers don't block writers, writers don't block readers

To kluczowa właściwość MVCC. Odczyty i zapisy mogą się dziać równolegle bez wzajemnego blokowania.

> [!example]
> PostgreSQL, MySQL InnoDB — oba używają MVCC. Dlatego długi SELECT na tabeli nie blokuje INSERT innych użytkowników.

## Co MVCC nie rozwiązuje

Write-Write konflikty: dwie transakcje chcą zmienić ten sam wiersz. Tu potrzebne są locki lub mechanizm wykrywania konfliktów.

> [!warning]
> Snapshot Isolation nie zapobiega **write skew**: T1 i T2 obie czytają ten sam wiersz, obie decydują na podstawie tej wartości, obie piszą do różnych wierszy. Wynik może łamać niezmiennik. Przykład: obaj lekarze widzą że ktoś jest on-call, obaj biorą urlop → nikt nie jest on-call. Potrzeba SERIALIZABLE.

## Stare wersje a VACUUM

Stare wersje wierszy zajmują miejsce. PostgreSQL ma `VACUUM` — proces sprzątający stare wersje, których żadna aktywna transakcja już nie potrzebuje.

## Połączenia
- [[Transakcje i ACID]] — transakcje od strony zapytań
- [[Poziomy izolacji transakcji]] — gdzie MVCC pasuje w hierarchii poziomów

- [[ACID — co to naprawdę znaczy]] — MVCC implementuje Isolation
- [[Dirty Read, Non-Repeatable Read, Phantom Read]] — MVCC eliminuje dirty i non-repeatable reads
- [[Poziomy izolacji transakcji]] — Snapshot Isolation to jeden z poziomów
