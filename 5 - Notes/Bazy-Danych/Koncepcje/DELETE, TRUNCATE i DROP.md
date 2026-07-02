---
tags: ["sql"]
powiązane: ["[[Transakcje i ACID]]", "[[Model relacyjny]]"]
sr_due: 2026-07-06
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# DELETE, TRUNCATE i DROP

> [!summary] W jednym zdaniu
> Wszystkie trzy "usuwają", ale na różnym poziomie: `DELETE` kasuje wybrane wiersze (i da się cofnąć w transakcji), `TRUNCATE` błyskawicznie czyści całą tabelę, `DROP` usuwa samą tabelę ze schematem.

| Polecenie | Co usuwa | Warunek WHERE | Cofnięcie (ROLLBACK) | Szybkość na dużej tabeli |
|-----------|----------|----------------|----------------------|--------------------------|
| `DELETE`  | wybrane wiersze | tak | tak (w transakcji) | wolne (wiersz po wierszu, loguje) |
| `TRUNCATE`| wszystkie wiersze | nie | zwykle nie / ograniczone | bardzo szybkie |
| `DROP`    | całą tabelę (struktura + dane) | nie | nie | n/d |

```sql
DELETE FROM payment WHERE amount = 0;  -- tylko płatności zerowe
TRUNCATE TABLE payment;                -- opróżnij całą tabelę
DROP TABLE tmp_raport;                 -- tabela (np. robocza z analizy) przestaje istnieć
```

> [!warning] Klucze obce blokują usuwanie
> W Sakili `DELETE FROM customer` padnie, bo na klienta wskazują `rental` i `payment` (FK). To nie złośliwość — to [[Klucz główny i obcy|klucze obce]] chronią spójność. `TRUNCATE` wymaga, by NA tabelę nic nie wskazywało (`payment` przejdzie, `customer` nie). Po eksperymentach: `docker compose down && up -d` przywraca bazę.

> [!tip] Pytanie-klasyk: DELETE vs TRUNCATE
> "DELETE to DML — usuwa wybrane wiersze, działa w [[Transakcje i ACID|transakcji]], można cofnąć, ale jest wolniejszy bo loguje każdy wiersz. TRUNCATE to DDL — zrzuca całą tabelę naraz, bardzo szybko, zwykle bez możliwości ROLLBACK i resetuje liczniki auto-increment." Ta różnica pada bardzo często.

> [!warning] DROP to nie to samo
> `DROP TABLE` usuwa **strukturę** tabeli, nie tylko dane — po nim tabela nie istnieje. Łatwo pomylić z TRUNCATE (które zostawia pustą tabelę gotową do użycia).

## Połączenia
- [[Transakcje i ACID]] — czemu DELETE da się cofnąć, a TRUNCATE zwykle nie
- [[Model relacyjny]] — DROP rusza sam schemat tabeli
