
Created: 2025-12-17  22:47
___
Note:

	po czym można iterować
	iterator -> obiekt, który iteruje
	Iterable = fabry iteratorów `__iter__`, Iterator = maszyna krokowa `__next__`
	W Python Iterable ≠ Iterator

Iterable to protokół opisujący obiekty, po których można iterować (np. w for). Obiekt jest _iterowalny_, jeśli potrafi zwrócić [[iterator]]

implementuje metodę specjalna `__iter__()` -> zwraca **obiekt iteratora** [[iterator]]
Alternatywna historycznie implementacja: `__getitem__()` (isinstance nie zwraca jako iterable, ale działa z for loop)

```python
from collections.abc import Iterable

isinstance(obj, Iterable)
```

**przykład:**
`list, tuple, set, dict, str, range`


[[iterator]] to obiekt, który implementuje __next__() i __iter__() , pamięta stan iteracji

```python
# RangeLike jest iterable , nie ma stanu iteracji
# ForwardIterator jest iterator

class RangeLike:
    def __init__(self, start, stop):
        self.start = start
        self.stop = stop

    def __iter__(self):
        return ForwardIterator(self.start, self.stop)
```
```python
class ForwardIterator:
    def __init__(self, current, stop):
        self.current = current
        self.stop = stop

    def __next__(self):
        if self.current >= self.stop:
            raise StopIteration
        value = self.current
        self.current += 1
        return value
```


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
