Created: 2025-12-24  11:28
___
Note:

konstruktor, który tworzy obiekt. 
ma go tylko **object**
wywołuje się zawsze jako pierwszy
musi zwrócić obiekt (zwykle instancje cls)

```python
  
class NameFive(object, metaclass=type):  
    def __new__(cls, *args: Any, **kwargs: Any) -> "NameFive":  
        self = super().__new__(cls) # object.__new__(cls) tworzy i przypisuje pustą instancję klasy NameFive do self. 
        # return self przekazuje ją dalej
		# nasz __new__ nic nie robi , to defaultowa metoda tworzenia obiektu  
  
    def __init__(self, value): # za każdym razem jak wywołuje init obiekt już istnieje  
        self.value = value  
        self.temp = 42

```
```python
cls is NameFive        # True
isinstance(cls, NameFive)  # False
isinstance(cls, type) # True
```

[[__init__]] 
- działa na już istniejącym obiekcie
- ustawia stan obiektu (setuje pola obiektu)
- nic nie zwraca

```python
n_five = NameFive(666) #  666 trafia do __new__ (najpier) i automatycznie to co zwróci __new__ trafia pod self do __init__

# wywoływany jest poniższy kod
tmp = NameFive.__new__(NameFive, 666) # to trafia pod self

if isinstance(tmp, NameFive):
    NameFive.__init__(tmp, 666)

n_five = tmp

```

 **✅**  **__init__** — 95% przypadków

- ustawianie pól
- walidacja
- konfiguracja 

 **✅** **__new__** — tylko gdy:

- implementujesz **singleton**
- tworzysz **immutable** obiekty (int, str, tuple)
- chcesz **zwrócić inny obiekt**
- kontrolujesz **czy obiekt w ogóle powstanie**


`__new__` występuje tylko w object. Jak nadpisujemy, konieczne jest `super().__new__(cls)`
```python
class OnlyPositive:
    def __new__(cls, value):
        if value < 0:
            return None
        return super().__new__(cls)

    def __init__(self, value):
        self.value = value
```





___
Metadata:
[[class]]

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #class 
