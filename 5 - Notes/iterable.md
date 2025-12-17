
Created: 2025-12-17  22:47
___
Note:

	po czym można iterować
	iterator -> obiekt, który iteruje
	Iterable = fabryka iteratorów, Iterator = maszyna krokowa

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
