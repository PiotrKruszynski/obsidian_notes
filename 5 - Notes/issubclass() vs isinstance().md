Created: 2025-12-22  15:03
___
Note:

```python

issubclass(class, classinfo, /)

isinstance(object, classinfo, /)

```

`__mro__` - zwraca rzeczywiste dziedziczenie
`type.__mro__` - sprawdzi [[virtual inheritance]]] czy jak `issubclass()` -> `True` oraz `__mro__` puste 


## **Kiedy czego używać — ściąga**

| **Sytuacja**                | **Użyj**        |
| --------------------------- | --------------- |
| Masz obiekt                 | isinstance      |
| Masz klasę                  | issubclass      |
| Walidacja danych            | isinstance      |
| Sprawdzanie API / framework | issubclass      |
| ABC / duck typing           | oba             |
| Typowanie statyczne         | Protocol + mypy |


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
