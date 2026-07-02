---
title: "factory fn"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-06
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

[[design pattern]] -> optymalne rozwiązanie do często występujących problemów

Wzorzec projektowy fabryki

- funkcja, która tworzy obiekty innej funkcji

```python

def power_n(exponent):  
    def inner(base):  
        return base ** exponent  
  
    return inner  
  
power_2 = power_n(2)  
  
print(power_2(2))

```
