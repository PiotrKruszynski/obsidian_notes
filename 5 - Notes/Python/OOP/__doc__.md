---
title: "__doc__"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

przechowuje dokumentację

```python

def dump(obj):  
    print("Type")  
    print("===")  
    print(type(obj))  
    print()  
  
    print("Documentation")  
    print("=============")  
    print(obj.__doc__)  
  
    print("a")  
    print("=============")  
    print()  
  
  
if __name__ == "__main__":  
    dump(int(42))

```
```bash
/Users/piotr/.local/bin/uv run /Users/piotr/projects/meta_/.venv/bin/python /Users/piotr/projects/meta_/introspection/dump.py 
Type
===
<class 'int'>

Documentation
=============
int([x]) -> integer
int(x, base=10) -> integer

Convert a number or string to an integer, or return 0 if no arguments
are given.  If x is a number, return x.__int__().  For floating-point
numbers, this truncates towards zero.

If x is not a number or if base is given, then x must be a string,
bytes, or bytearray instance representing an integer literal in the
given base.  The literal can be preceded by '+' or '-' and be surrounded
by whitespace.  The base defaults to 10.  Valid bases are 0 and 2-36.
Base 0 means to interpret the base from the string as an integer literal.
>>> int('0b100', base=0)
4
a
=============


Process finished with exit code 0

```
