Created: 2025-12-17  16:48
___
Note:

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


___
Metadata:

```yaml
---
type: concept    # concept | tool | pattern
language: python # python | js | sql | etc.
level: beginner  # beginner | intermediate | advanced
status: understood    # draft | understood
---
```

Status: #pending
Tags:  #python #protocol #abc #sized #len #collections-abc #duck-typing