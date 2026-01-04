Created: 2026-01-04  14:47
___
Note:
# inspect — introspekcja runtime w Pythonie

## Idea (Second Brain → **Concept**)

`inspect` to **standardowy moduł Pythona**, który pozwala **badać obiekty w czasie działania programu** (runtime): funkcje, klasy, metody, moduły, ramki stosu, sygnatury, adnotacje, kod źródłowy.

Kluczowa idea: **Python nie ukrywa metadanych**. Obiekty niosą ze sobą strukturę, a `inspect` jest oficjalnym API do jej czytania.

---
## Mentalny model (senior‑level)

> **Obiekt ≠ tylko zachowanie**. Obiekt = _wartość + metadane + relacje w runtime_.

- Funkcja → ma **sygnaturę**, **kod**, **globals**, **closure**
- Klasa → ma **MRO**, **namespace**, **metody**, **adnotacje**
- Wywołanie → tworzy **frame** na stosie

`inspect` pozwala **czytać te warstwy bez łamania enkapsulacji**.

---
## Najważniejsze narzędzia

### 1. `inspect.signature(obj)`

```python
import inspect

def f(a: int, b: str = "x") -> bool:
    return True

sig = inspect.signature(f)
```

Co się naprawdę dzieje:
- tworzony jest **obiekt Signature**
- parametry są **obiektami Parameter**
- adnotacje NIE są sprawdzane — są tylko metadanymi
    
```python
sig.parameters
# OrderedDict([('a', <Parameter "a: int">), ('b', <Parameter "b: str = 'x'">)])
```

**Zastosowanie:
- walidacja dekoratorów
- generowanie API
- automatyczny `__repr__`

---
### 2. `inspect.getsource(obj)`

```python
inspect.getsource(f)
```

- czyta **plik źródłowy**
- działa tylko gdy source jest dostępny
- NIE działa dla C‑extensions

**Wzorzec**: debug / dokumentacja / narzędzia dev

---

### 3. `inspect.is*` — predykaty typu

```python
inspect.isfunction(f)
inspect.isclass(f)
inspect.ismethod(f)
inspect.isgenerator(f)
```

**Dlaczego nie `isinstance`?**  
Bo funkcje, metody, klasy to **różne byty runtime**, mimo że są callable.

---
### 4. Ramki stosu (`frame`)

```python
frame = inspect.currentframe()
frame.f_code.co_name
frame.f_locals
```

Mentalny model:
- każda funkcja → **frame**
- frame = lokalne zmienne + kod + referencje

**Uwaga**:
- ramki tworzą **cykle referencji**
- zawsze `del frame`

---

### 5. `inspect.getmembers(obj)`

```python
inspect.getmembers(MyClass)
```

- iteruje po **namespace + MRO**
- filtruj z `predicate`

```python
inspect.getmembers(MyClass, inspect.isfunction)
```

---
## Przykład: dekorator walidujący API (real‑world)

```python
import inspect

def require_kw_only(fn):
    sig = inspect.signature(fn)
    for p in sig.parameters.values():
        if p.kind is not inspect.Parameter.KEYWORD_ONLY:
            raise TypeError("Only keyword-only params allowed")
    return fn
```

**Co tu się dzieje naprawdę**:
- dekorator NIE zmienia funkcji
- tylko **analizuje jej kontrakt**
- kontrakt = sygnatura

---
## Typowe pułapki

- `inspect.getsource` ≠ zawsze dostępne
- `signature` ≠ walidacja typów
- `frame` = potencjalny memory leak

---
## Techniki zapamiętywania

- **Mnemonika**: _inspect = microscope for runtime_
- **Asocjacja**: debugger, REPL, decorators, metaprogramming
- **Wzorzec strukturalny**:
    - object → metadata → inspect → tooling

---

## Dokumentacja

- Oficjalna docs: [https://docs.python.org/3/library/inspect.html](https://docs.python.org/3/library/inspect.html)
- Artykuł: [https://realpython.com/python-inspect-module/](https://realpython.com/python-inspect-module/)
- PEP 362 — Function Signature Object

---
## type: concept  
language: python  
tags: introspection inspect reflection metaprogramming decorators runtime

___
Metadata:

```yaml
---
type: concept    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #introspection #inspect #reflection #metaprogramming #decorators #runtime
