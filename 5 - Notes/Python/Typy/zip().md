---
title: "zip()"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
---

`zip(*iterables, strict=False)`

zwraca [[iterator]] tupli zmieniając rzędy w kolumny i kolumny w rzędy
```python
for item in zip([1, 2, 3], ['sugar', 'spice', 'everything nice']):
    print(item)
```
```
(1, 'sugar')
(2, 'spice')
(3, 'everything nice')
```

[`zip()`](https://docs.python.org/3/library/functions.html#zip "zip") is lazy

strict = True -> ValueError przy wyczerpaniu (różne len())
