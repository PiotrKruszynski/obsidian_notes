
Created: 2025-12-17  22:47
___
Note:

metoda specjalna `__iter__()` -> zwraca **obiekt iteratora**
Alternatywna historycznie implementacja: `__getitem__()` (isinstance nie zwraca jako iterable, ale działa z for loop)


Ta metoda **musi zwracać iterator object** (czyli obiekt, który implementuje __next__() i __iter__())

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
