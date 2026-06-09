---
tags: ["sql"]
powiązane: ["[[Transakcje i ACID]]", "[[Model relacyjny]]"]
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
DELETE FROM users WHERE active = FALSE;  -- tylko nieaktywni
TRUNCATE TABLE logs;                     -- opróżnij całą tabelę
DROP TABLE temp_data;                    -- tabela przestaje istnieć
```

> [!tip] Pytanie-klasyk: DELETE vs TRUNCATE
> "DELETE to DML — usuwa wybrane wiersze, działa w [[Transakcje i ACID|transakcji]], można cofnąć, ale jest wolniejszy bo loguje każdy wiersz. TRUNCATE to DDL — zrzuca całą tabelę naraz, bardzo szybko, zwykle bez możliwości ROLLBACK i resetuje liczniki auto-increment." Ta różnica pada bardzo często.

> [!warning] DROP to nie to samo
> `DROP TABLE` usuwa **strukturę** tabeli, nie tylko dane — po nim tabela nie istnieje. Łatwo pomylić z TRUNCATE (które zostawia pustą tabelę gotową do użycia).

## Połączenia
- [[Transakcje i ACID]] — czemu DELETE da się cofnąć, a TRUNCATE zwykle nie
- [[Model relacyjny]] — DROP rusza sam schemat tabeli
