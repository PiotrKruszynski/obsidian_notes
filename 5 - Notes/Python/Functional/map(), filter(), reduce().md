---
title: "map(), filter(), reduce()"
type: concept
topic: python
tags: []
created: 2026-06-09
status: draft
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
