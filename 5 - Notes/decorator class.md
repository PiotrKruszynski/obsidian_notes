Created: 2026-01-04  02:41
___
Note:

>[! Definicja]
>Dekorator klas to funkcja, która przyjmuje obiekt klasy i zwraca obiekt klasy (ten sam lub zmodyfikowany)
# minimalna implementacja:
```python

def auto_repr(cls):

    return cls

```

Kluczowe jest to, że **nazwa klasy (identifier)** zostaje _zbindowana_ do **obiektu zwróconego przez dekorator**, a **nie** do obiektu wygenerowanego bezpośrednio przez `class`.

Formalnie:
```
@decorator
class C:
    ...
```
jest równoważne:
```
class C:
    ...

C = decorator(C)
```

➡️ `C` to tylko **referencja** (name → object), a dekorator **podmienia obiekt**, do którego ta referencja wskazuje.

---
## Co _naprawdę_ robi dekorator klasy

1. `class` tworzy **obiekt klasy** (`type.__call__` → `__prepare__`, `__new__`, `__init__`)
2. Obiekt klasy trafia jako argument do dekoratora
3. Dekorator:
    - **mutuje klasę** (np. dodaje metody)
    - **lub** zwraca _inny obiekt_ (proxy, subclass, wrapper)
4. Nazwa klasy zostaje zbindowana do **wyniku dekoratora**

---

## Przykład 1 — dekorator _mutujący_ klasę

```
def add_repr(cls):
    def __repr__(self):
        return f"{type(self).__name__}({self.__dict__})"

    cls.__repr__ = __repr__
    return cls


@add_repr
class User:
    def __init__(self, name: str, age: int):
        self.name = name
        self.age = age
```

### Co się dzieje semantycznie

- `class User` tworzy obiekt klasy `User`
    
- `add_repr(User)` **modyfikuje namespace klasy**
    
- `User` wskazuje na **ten sam obiekt klasy**, tylko rozszerzony
    

➡️ brak nowej klasy, brak dziedziczenia

---

## Przykład 2 — dekorator _zastępujący_ klasę (wrapper)

```
def singleton(cls):
    instance = None

    def get_instance(*args, **kwargs):
        nonlocal instance
        if instance is None:
            instance = cls(*args, **kwargs)
        return instance

    return get_instance


@singleton
class Config:
    def __init__(self, path: str):
        self.path = path
```

### Krytyczna obserwacja (senior‑level)

- `Config` **nie jest już klasą** ❌
    
- `Config` → funkcja `get_instance`
    
- `isinstance(Config("a"), Config)` → ❌
    

➡️ dekorator **zmienił typ obiektu**, do którego zbindowana jest nazwa

---

## Przykład 3 — dekorator klasy jako alternatywa dla metaklasy

```
def auto_repr(cls):
    if "__init__" not in cls.__dict__:
        raise TypeError("__init__ required")

    init = cls.__init__
    params = init.__code__.co_varnames[1:init.__code__.co_argcount]

    def __repr__(self):
        args = ", ".join(f"{p}={getattr(self, p)!r}" for p in params)
        return f"{type(self).__name__}({args})"

    cls.__repr__ = __repr__
    return cls
```

➡️ ten sam problem rozwiązany:

- **bez** `metaclass`
    
- **bez** ingerencji w MRO
    
- **czytelniej** i lokalnie
    

---

## Kiedy dekorator klasy jest lepszy od metaklasy

|Problem|Dekorator|Metaklasa|
|---|---|---|
|Dodanie metod|✅|✅|
|Walidacja klasy|✅|✅|
|Globalne reguły dziedziczenia|❌|✅|
|Prostota|✅|❌|
|Debuggowanie|łatwe|trudne|

---

## Mentalny model (ważne!)

> **Dekorator nie „owija” klasy magicznie**  
> **Dekorator podmienia obiekt, do którego wskazuje nazwa**

Tak samo jak:

```
x = 42        # x → obiekt int(42)
x = f(x)     # x → inny obiekt
```

---

## Techniki zapamiętywania

- **Mnemonika**: `@class_decorator` = `Class = decorator(Class)`
    
- **Asocjacja**: jak dekorator funkcji, ale _po etapie_ `_class_`
    
- **Wzorzec strukturalny**: lokalna metaprogramistyka
    
- **Antywzorzec**: dekorator zwracający funkcję zamiast klasy
    

---

## Dokumentacja

- https://docs.python.org/3/glossary.html#term-decorator
    
- https://docs.python.org/3/reference/compound_stmts.html#class-definitions
    
- https://www.python.org/dev/peps/pep-0318/

___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #empty
