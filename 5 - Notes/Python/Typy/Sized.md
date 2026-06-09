---
title: "Sized"
type: concept
topic: python
tags: ["duck-typing", "protocols", "python"]
created: 2026-06-09
status: draft
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
