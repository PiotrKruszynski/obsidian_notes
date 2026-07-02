---
title: "Sized"
type: concept
topic: python
tags: ["duck-typing", "protocols", "python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-01
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

zwraca liczbę elementów *len(sized)*

```python
class X:
	def __len__(self) -> int:
		return 42
		
x = X()
len(x) # 42	
```

nie może modyfikować kolekcji, nie może jej dotykać żeby nie zużyć
int >= 0
