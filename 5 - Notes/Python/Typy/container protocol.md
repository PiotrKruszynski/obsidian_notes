---
title: "container protocol"
type: concept
topic: python
tags: ["data-model", "duck-typing", "protocols", "python"]
created: 2026-06-09
status: draft
---

https://docs.python.org/3/library/collections.abc.html#collections-abstract-base-classes 



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

## **Mental model:

- **Iterable** → „mogę po tym chodzić”
- **Container** → „mogę zapytać, czy coś jest w środku”
- **Sized** → „wiem, ile tego jest”

![[Pasted image 20251229171055.png]]
