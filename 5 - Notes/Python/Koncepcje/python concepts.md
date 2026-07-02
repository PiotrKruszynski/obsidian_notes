---
title: "python concepts"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-03
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Python — kluczowe cechy języka

## 1. Interpreted + JIT

Python jest językiem interpretowanym — kod wykonuje interpreter CPython. Istnieje też kompilacja JIT (PyPy). Jak nie wiadomo o co chodzi z wydajnością, to chodzi o CPython vs PyPy.

## 2. Dynamic typing

[[duck typing]] — działa na podstawie protokołów. Nie wymaga podania typu zmiennej.

```python
x: int = 42
x = "tekst"  # ✅ działa — x to referencja, nie „slot int"
```

Typingi to `Gentleman Agreement` — nie są egzekwowane w runtime.

## 3. Strong typing

Python nie wykonuje **coercji** (niejawnej konwersji) między niekompatybilnymi typami. `"1" + 1` → `TypeError`.

[[variable python]] = nazwana referencja do obiektu w pamięci, nie pojemnik na wartość.

## 4. Wszystko jest obiektem

Funkcje, klasy, moduły — wszystko to obiekty z atrybutami i metodami. `Plik.py` = moduł (obiekt klasy `module`).

## 5. Concurrency model

| Model | Kiedy używać |
|-------|-------------|
| Synchroniczny | domyślnie — proste skrypty |
| Async (event loop) | I/O-bound — HTTP, pliki, DB |
| Multithreading | I/O-bound — GIL zwalniany przy I/O |
| Multiprocessing | CPU-bound — każdy proces = osobny rdzeń, własny GIL |

[[GIL]] (Global Interpreter Lock) — od Python 3.13 można wyłączyć (PEP 703). Przez GIL multithreading i async dają podobny efekt dla I/O.

## 6. Moduły i paczki

```
Aplikacja Python = package + module + namespace
```

- [[package]] → katalog z `__init__.py`
- [[module]] → plik `.py`; przy imporcie jest singletonem
- [[namespace]] → słownik mapujący nazwy → obiekty

**Venv** (`python -m venv`): własny python + pip + site-packages. Nie zapisuje jakie paczki zainstalowałeś → do tego `requirements.txt` lub [[UV]].

## 7. Brak TCO (Tail Call Optimization)

Python nie implementuje [[tail call optimization]]. Rekurencja głęboka → `RecursionError`.

Obejście — iteracja lub trampolina:

```python
def tramp(gen, *args, **kwargs):
    g = gen(*args, **kwargs)
    while isinstance(g, types.GeneratorType):
        g = next(g)
    return g
```

## 8. Domyślnie eager

Python domyślnie jest eager — [[materialized object]]. Lazy evaluation przez generatory i `yield`.
