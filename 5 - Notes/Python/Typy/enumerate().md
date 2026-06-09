---
title: "enumerate()"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
---

[Build-in](https://docs.python.org/3/library/functions.html)

enumerate(_iterable_, _start=0_) 
zwraca [[iterator]], który przy każdym kroku daje [[tuple()]]

equivalent to:
```python
def enumerate(iterable, start=0):
    n = start
    for elem in iterable:
        yield n, elem
        n += 1
```
