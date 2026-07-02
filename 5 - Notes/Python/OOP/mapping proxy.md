---
title: "mapping proxy"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-11
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

to **specjalny wrapper typu read-only na słownik** w Pythonie

```python
from types import MappingProxyType

d = {"a": 1, "b": 2}
proxy = MappingProxyType(d)

print(proxy["a"])     # 1
d["c"] = 3            # zmiana w oryginale
print(proxy["c"])     # 3 (proxy widzi aktualizację)

proxy["c"] = 4        # TypeError – nie można zmieniać

```
