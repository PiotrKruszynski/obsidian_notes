---
title: "map(), filter(), reduce()"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-21
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

[[functional programming]]

map(function, iterable1, iterable2, iterable3)

filter(function, iterable)

```python
nums = [1, 2, 3, 4, 5, 6]

even = filter(lambda x: x % 2 == 0, nums)

print(list(even))
```

reduce(function, iterable, initializer=option)
