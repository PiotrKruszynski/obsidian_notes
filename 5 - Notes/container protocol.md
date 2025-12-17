Created: 2025-12-17  10:27
___
Note:

jeden z kluczowych protokołów, oparty na [[duck typing]] oraz ABC [[abstraction]]
minimalny zestaw metod, by obiekt zachowywał się jak kontener.
- czy coś w nim jest **in**
- poznać rozmiar **len()**
- iterować po elementach

**obiekt spełnia jeśli**
```python
__contains__(self, item) -> bool
```

```python
# i wtedy działa 
item in obj
item not in obj
```

Jeśli `__contains__` **nie istnieje**, Python próbuje fallback:

1. Iteruje po obiekcie `__iter__`
2. Porównuje elementy `==`
3. Gdy znajdzie → `True`, gdy nie → `False`

```python
class Bag:
    def __init__(self, items):
        self.items = items

    def __contains__(self, item):
        return item in self.items
```

```python
bag = Bag([1, 2, 3])
2 in bag      # True
5 in bag      # False
```

| **Protokół** | **Metoda**     | **Co umożliwia** |
| ------------ | -------------- | ---------------- |
| Container    | `__contains__` | x in obj         |
| Iterable     | `__iter__`     | for x in obj     |
| Sized        | `__len__`      | len(obj)         |
## **ABC:**  **collections.abc.Container**

Python udostępnia formalną definicję:

```python
from collections.abc import Container

isinstance([1, 2, 3], Container)  # True
```

definicja logiczna
```python
class Container(ABC):
    @abstractmethod
    def __contains__(self, item):
        ...
```

## **Ważne niuanse (częste pułapki)**

- __contains__ **nie musi** iterować – może używać indeksów, hashy, struktur drzewiastych.
- Jeśli masz **Iterable**, ale nie __contains__, in nadal działa, ale wolniej (iteracja).
- str jest **Container**, ale często wykluczany celowo (np. flatten).



___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
level: beginner  # beginner | intermediate | advanced
status: understood    # draft | understood
---
```

Status: #pending
Tags: #empty
