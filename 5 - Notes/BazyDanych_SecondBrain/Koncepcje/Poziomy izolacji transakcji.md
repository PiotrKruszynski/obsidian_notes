# Poziomy izolacji transakcji

> [!summary]
> Pełna izolacja (serializable) jest droga, więc bazy oferują słabsze poziomy, z których każdy dopuszcza określone anomalie. Im wyższy poziom, tym mniej anomalii i wolniejsza praca. Kleppmann: większość baz domyślnie używa słabszych poziomów, niż programiści zakładają.

## Cztery standardowe poziomy

Od najsłabszego do najsilniejszego, wraz z anomaliami, które **dopuszczają**:

| Poziom           | Dirty Read | Non-Repeatable Read | Phantom Read |
| ---------------- | ---------- | ------------------- | ------------ |
| READ UNCOMMITTED | możliwy    | możliwy             | możliwy      |
| READ COMMITTED   | nie        | możliwy             | możliwy      |
| REPEATABLE READ  | nie        | nie                 | możliwy*     |
| SERIALIZABLE     | nie        | nie                 | nie          |

\* W PostgreSQL REPEATABLE READ (oparty na snapshotach) eliminuje też phantomy; w standardzie SQL — niekoniecznie. Szczegóły anomalii: [[Dirty Read, Non-Repeatable Read, Phantom Read]].

## Co który eliminuje

- **READ UNCOMMITTED** — widzisz niezatwierdzone zmiany innych. W praktyce prawie nieużywany.
- **READ COMMITTED** — widzisz tylko zatwierdzone dane; brak dirty reads. **Domyślny w PostgreSQL i większości baz.**
- **REPEATABLE READ** — w obrębie transakcji ten sam odczyt daje ten sam wynik (snapshot). Realizowany przez [[MVCC — Snapshot Isolation]].
- **SERIALIZABLE** — efekt jak gdyby transakcje wykonywały się jedna po drugiej. Najbezpieczniejszy, najwolniejszy.

> [!warning]
> Domyślny poziom to zwykle READ COMMITTED, **nie** pełna izolacja. Programiści często piszą kod zakładając serializable, którego baza nie daje — stąd subtelne bugi przy współbieżności. Jeśli logika zależy od niezmiennego odczytu, ustaw poziom świadomie.

> [!example]
> Raport sumujący salda wszystkich kont: pod READ COMMITTED w trakcie liczenia ktoś robi przelew między kontami — możesz policzyć jedno konto przed, drugie po. Suma się nie zgadza. SERIALIZABLE albo snapshot isolation (REPEATABLE READ) temu zapobiega.

## Połączenia

- [[ACID — co to naprawdę znaczy]] — izolacja to "I" w ACID
- [[Dirty Read, Non-Repeatable Read, Phantom Read]] — anomalie, które poziomy dopuszczają lub blokują
- [[MVCC — Snapshot Isolation]] — jak bazy realizują izolację bez kosztownych locków
- [[Transakcje i ACID]] — praktyczne ujęcie transakcji (warstwa zapytań)
