---
title: "issubclass() vs isinstance()"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-16
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

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
