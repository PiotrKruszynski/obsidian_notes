---
title: "hasattr()"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-18
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

hasattr(_object_, _name_, _/_)[](https://docs.python.org/3/library/functions.html#hasattr "Link to this definition")

The arguments are an object and a string. 
The result is `True` if the string is the name of one of the object’s attributes, `False` if not. 
(This is implemented by calling `getattr(object, name)` and seeing whether it raises an [`AttributeError`](https://docs.python.org/3/library/exceptions.html#AttributeError "AttributeError") or not.)
