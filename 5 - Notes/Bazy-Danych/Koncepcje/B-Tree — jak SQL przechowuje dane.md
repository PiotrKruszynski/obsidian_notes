---
sr_due: 2026-07-14
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---
# B-Tree — jak SQL przechowuje dane

> [!summary]
> B-Tree to drzewo zbalansowane na stałych blokach dyskowych. Niemal wszystkie relacyjne bazy używają go jako domyślnej struktury indeksów. Optymalizuje **odczyty** kosztem wolniejszych zapisów.

## Jak to działa (fizycznie)

Dane na dysku podzielone są na **strony** (pages), typowo 4KB. Każda strona to węzeł drzewa. Jeden węzeł ("root") jest wejściem.

```
          [50 | 100]
         /     |     \
    [20|30] [60|80] [110|120]
```

- Każdy węzeł zawiera klucze i wskaźniki do dzieci
- Liście zawierają rzeczywiste dane (lub wskaźniki do wierszy)
- Szukasz klucza → startujesz od roota → schodzisz do odpowiedniej gałęzi

> [!example]
> Szukasz `user_id = 75`. Root mówi: "jeśli 50 < x < 100, idź środkiem". Trafiasz do `[60|80]`. Tam: "75 jest między 60 a 80". Jedna strona niżej — gotowe.
> 
> Dla 256 TB danych wystarczą **4 poziomy** (branching factor ~500, strony 4KB). Czyli max 4 odczyty dysku na dowolne wyszukanie.

## Write-Ahead Log (WAL) — odporność na crash

B-Tree modyfikuje strony **in-place** (nadpisuje). To ryzykowne: jeśli crash w środku operacji (np. split strony), indeks będzie uszkodzony.

Rozwiązanie: **WAL** (Write-Ahead Log) — każda zmiana najpierw trafia do dziennika append-only na dysku, dopiero potem do B-Tree. Po crashu baza odtwarza stan z WAL.

> [!warning]
> MySQL z InnoDB i PostgreSQL mają WAL. Jeśli kiedyś baza "się psuła" po nagłym wyłączeniu — brak lub błąd w WAL.

## B-Tree vs LSM-Tree — kiedy co

| | B-Tree | LSM-Tree |
|---|---|---|
| Odczyty | Szybkie (kilka seek'ów) | Wolniejsze (wiele plików) |
| Zapisy | Wolniejsze (random write) | Szybkie (sequential append) |
| Zastosowanie | OLTP, dużo odczytów | Dużo zapisów (Cassandra, LevelDB) |

→ Patrz [[LSM-Tree vs B-Tree — porównanie]]

## Połączenia
- [[Indeks — jak działa i kiedy pomaga]] — kiedy i jak używać indeksu w zapytaniach

- [[Indeks — jak działa i kiedy pomaga|Indeks — koszt i korzyść]] — B-Tree jest strukturą indeksu
- [[WAL — Write-Ahead Log]] — szczegóły mechanizmu crash recovery
- [[LSM-Tree vs B-Tree — porównanie]] — alternatywa dla write-heavy workloads
- [[SQL jako język deklaratywny]] — query optimizer decyduje kiedy użyć B-Tree
