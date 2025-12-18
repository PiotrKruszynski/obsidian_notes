Created: 2025-12-18  13:53
___
Note:

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


___
Metadata:

Status: #pending
Tags: #empty
