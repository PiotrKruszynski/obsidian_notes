Created: 2025-12-23  09:43
___
Note:

`__annotations__` specjalny atrybut Pythona przechowujący _adnotacje typów_ (type hints) dla zmiennych, argumentów funkcji i wartości zwracanych. Jest podstawą typowania statycznego, introspekcji oraz narzędzi takich jak mypy, pydantic, dataclasses.

- __annotations__ → **opis kontraktu**, nie logika
- jak **docstring**, ale dla typów
- paliwo dla:
    - inspect  
    - typing.get_type_hints 
    - mypy    
    - pydantic

```python

from __future__ import annotations

def foo(x: MyClass) -> list[int]:
    ...

```
```python
foo.__annotations__
# {'x': 'MyClass', 'return': 'list[int]'}
```




___
Metadata:

```yaml
---
type: concept    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #empty

 #__annotations__  #type-hints  #static-typing  #inspect  #mypy #dataclasses #pydantic
 
[[type annotations]]
