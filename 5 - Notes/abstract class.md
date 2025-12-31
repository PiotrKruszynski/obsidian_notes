Created: 2025-12-31  17:30
___
Note:

>[! Important]
> Klasa w Pythonie to tylko **namespace**.  
> ABC to **specjalny namespace**, który Python oznacza jako _niekompletny_, dopóki nie zostaną spełnione wszystkie wymagania.

- `ABC` to tylko skrót do `metaclass=ABCMeta`
- `ABCMeta.__call__` **blokuje instancjonowanie**, jeśli `__abstractmethods__` nie jest puste
- `__abstractmethods__` to **frozenset nazw**, wyliczany przy tworzeniu klasy

ABC działa **na etapie tworzenia instancji**, nie w czasie definicji klasy.

 ### 1. Abstractmethod ≠ brak implementacji
```
class Base(ABC):
    @abstractmethod
    def f(self):
        print("default impl")
```

- metoda **może mieć ciało**
- ale dopóki jest oznaczona jako `@abstractmethod`, klasa jest nieinstancjonowalna

➡️ To pozwala pisać **Template Method** z częściową implementacją.

### 2. Dziedziczenie abstrakcji jest transytywne

```
class A(ABC):
    @abstractmethod
    def f(self): ...

class B(A):
    pass
```

- `B` nadal jest **abstrakcyjna**
- nawet jeśli **nic nie deklaruje**

Senior widzi tu: **abstrakcyjność jest dziedziczona**, dopóki nie zostanie zamknięta.


---

## Minimalny przykład

```python
from abc import ABC, abstractmethod

class Repository(ABC):
    @abstractmethod
    def save(self, obj) -> None:
        raise NotImplementedError

    @abstractmethod
    def load(self, id_: int):
        raise NotImplementedError
```

```python
class InMemoryRepository(Repository):
    def save(self, obj) -> None:
        self._obj = obj

    def load(self, id_: int):
        return self._obj
```

```python
repo = InMemoryRepository()  # OK
```

```python
class BrokenRepo(Repository):
    def save(self, obj) -> None:
        pass

BrokenRepo()  # TypeError
```

---

## Co _dokładnie_ sprawdza Python?

Python **nie sprawdza sygnatur typów**, tylko **obecność nazw**:

- metoda istnieje
- property istnieje

To kontrola **strukturalna na poziomie runtime**, ale wymuszona **nominalnym dziedziczeniem**.

---

## ABC + @property

```python
class NotesLoaderABC(ABC):
    @property
    @abstractmethod
    def folder_path(self) -> str:
        raise NotImplementedError

    @property
    @abstractmethod
    def tags(self) -> set[str]:
        raise NotImplementedError
```

Implementacja **musi** użyć `@property`, zwykła metoda nie wystarczy.

---

## ABC a Protocol (kluczowa różnica)

| Cecha                       | ABC |        Protocol        |
| --------------------------- | :-: | :--------------------: |
| Wymaga dziedziczenia        |  ✅  |           ❌            |
| Sprawdzane w runtime        |  ✅  | ❌ (tylko type-checker) |
| Typowanie strukturalne      |  ❌  |           ✅            |
| Błąd przy tworzeniu obiektu |  ✅  |           ❌            |

ABC = **twardy kontrakt runtime**  
Protocol = **miękki kontrakt statyczny**

---

## Kiedy używać ABC?

Używaj ABC gdy:
- projektujesz **framework / bibliotekę**
- chcesz **fail fast**
- tworzysz warstwy (repozytoria, loadery, adaptery)
- implementacja bez metod NIE MA sensu

Nie używaj ABC gdy:
- wystarczy duck typing
- zależy Ci tylko na mypy / pyright

---
## Częste błędy

❌ `raise NotImplementedError` zamiast `@abstractmethod`
❌ traktowanie ABC jak interfejs z Javy
❌ logika biznesowa w ABC

---

## Techniki zapamiętywania

- **Mnemonika**: ABC = _Abstract Before Creation_ (nie utworzysz, dopóki nie spełnisz)
- **Asocjacja**: projekt architektoniczny bez wykonania
- **Wzorzec strukturalny**: _Template for requirements, not behavior_

---

## Dokumentacja

- [https://docs.python.org/3/library/abc.html](https://docs.python.org/3/library/abc.html)
- [https://peps.python.org/pep-3119/](https://peps.python.org/pep-3119/)
- [https://realpython.com/python-abc/](https://realpython.com/python-abc/)

___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Tags: #abc #oop #architecture #contract 