---
title: "Transakcje w Pythonie"
type: concept
topic: databases
tags: ["databases", "python", "context-managers"]
created: 2026-06-09
status: draft
sr_due: 2026-07-14
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Transakcje w Pythonie — context manager

> [!summary] Zakres tej notatki
> Implementacja transakcji przez context manager w Pythonie + SQLAlchemy. Teoria ACID → [[Transakcje i ACID]].

Transakcja idealnie pasuje do wzorca `with`:

```python
with Transaction() as tx:
    tx.op()
```

Mechanika:
- `__enter__` → BEGIN transakcji
- kod bloku wykonuje się
- `__exit__(exc_type, exc_val, exc_tb)`:
  - brak błędu → COMMIT
  - błąd → ROLLBACK + decyzja o propagacji

---

## Działanie `__exit__` i propagacja błędów

Python wywołuje:
- `__exit__(None, None, None)` → brak błędu
- `__exit__(ExcType, ExcVal, ExcTB)` → błąd w bloku

| return | efekt |
|--------|-------|
| `True` | tłumi wyjątek — brak propagacji |
| `False` | pozwala wyjątek propagować wyżej |

`False` ma znaczenie tylko gdy wystąpił wyjątek.

---

## Minimalna implementacja

```python
class Transaction:
    def __enter__(self):
        print("BEGIN")
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if exc_type is None:
            print("COMMIT")
        else:
            print("ROLLBACK:", exc_type.__name__)
        return False  # zawsze propaguj wyjątek
```

---

## SQLAlchemy

```python
with engine.begin() as conn:
    conn.execute(insert(users).values(name="Jan"))
    conn.execute(insert(orders).values(user_id=1, amount=100))
# commit automatyczny; wyjątek → rollback automatyczny
```

SQLAlchemy działa identycznie — `__enter__` otwiera transakcję, `__exit__` commituje lub rollbackuje.

---

## Powiązane notatki
- [[Transakcje i ACID]] — teoria: co to jest transakcja, cztery gwarancje ACID
- [[ACID — co to naprawdę znaczy]] — głębsze ujęcie (Kleppmann, DDIA)
