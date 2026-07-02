---
title: "annotations"
type: concept
topic: python
tags: ["dataclasses", "introspection", "mypy", "pydantic", "typing"]
created: 2026-06-09
status: draft
sr_due: 2026-07-13
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

`__annotations__` -> specjalny atrybut (słownik) Pythona przechowujący _adnotacje typów_ (type hints) dla zmiennych, argumentów funkcji i wartości zwracanych. Jest podstawą typowania statycznego, introspekcji oraz narzędzi takich jak mypy, pydantic, dataclasses.

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

```python
def num_vowels(text: str) -> int:
    return sum(1 if c.lower() in 'aeiou' else 0 for c in text)
```
```python
sig = inspect.signature(num_vowels)
sig.parameters['text']
sig.parameters['text'].annotation   # str
sig.return_annotation               # int
```
```python
num_vowels.__annotations__
# {'text': <class 'str'>, 'return': <class 'int'>}
```
