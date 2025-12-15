

# 🟦 Transakcje i Context Managery — Notatka

## 1. Definicja transakcji  
**Transakcja = operacja atomowa: wykonuje się w całości albo wcale.**  
Gwarantuje spójność i bezpieczeństwo przy operacjach wieloetapowych.

### ACID:
- **Atomicity** – brak stanów pośrednich; przerwanie = pełny rollback.
- **Consistency** – transakcja nie może złamać zasad systemu.
- **Isolation** – transakcje równoległe są od siebie odizolowane.
- **Durability** – commit jest trwały i odporny na awarie.

---

## 2. Transakcje a context manager  
Transakcja idealnie pasuje do konstrukcji:

```python
with Transaction() as tx:
    tx.op()
```

Mechanika:

- `__enter__` → start transakcji
- kod bloku
- `__exit__(exc_type, exc_val, exc_tb)`:
  - brak błędu → commit  
  - błąd → rollback + decyzja o propagacji

---

## 3. Działanie __exit__ i propagacja błędów

Python wywołuje:

- `__exit__(None, None, None)` → brak błędu
- `__exit__(ExcType, ExcVal, ExcTB)` → błąd w bloku

### Reguła:

| return | efekt |
|--------|--------|
| **True** | tłumi wyjątek — brak propagacji |
| **False** | pozwala wyjątek propagować wyżej (traceback) |

`False` ma znaczenie tylko, gdy wystąpił wyjątek.

---

## 4. Minimalna implementacja transakcji

```python
class Transaction:
    def __enter__(self):
        print("BEGIN")
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if exc_type is None:
            print("COMMIT")
            return False
        else:
            print("ROLLBACK:", exc_type.__name__)
            return False
```

Zachowanie:
- brak błędu → COMMIT  
- błąd → ROLLBACK + propagacja

---

## 5. Transakcje w SQLAlchemy

```python
with engine.begin() as conn:
    conn.execute(...)
```

SQLAlchemy:
- `__enter__` → otwarcie transakcji  
- `__exit__` → commit lub rollback  

---

## 6. Esencja

**Transakcja = blok operacji z automatycznym commit/rollback.  
Context manager steruje, czy wyjątek jest tłumiony (`True`), czy propagowany (`False`).**