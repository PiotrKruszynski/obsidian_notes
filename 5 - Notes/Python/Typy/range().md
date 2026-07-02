---
title: "range()"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-03
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

generator danych

```python
print(*range(0,10)) # range jest iterable, print przyjmuje nieskończoną wartość parametrów. * rozpakowuje wartości
print(*range(10))
print(*range(2,11,3))
print(*range(10,1, -1)) # jak ujemny step, trzeba odwrócić
print([x / 10 for x in range(0,11)])
```
