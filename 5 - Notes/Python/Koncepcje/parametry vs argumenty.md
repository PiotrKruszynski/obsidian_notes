---
title: "parametry vs argumenty"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-08
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

parametry (to, co jest w definicji funkcji)   pozycyjne i nazwane (defaultowe)

**argumenty**(to, co przekazujemy przy wywołaniu funkcji).  pozycyjne i nazwane

Znak slash mówi, że wszystkie parametry przed mają być pozycyjne

  
```python
def add(a,b, /):

	return a + b

print(add(1,2))

#print(add(1,b=3))

```


  
# po gwiazdce muszą być parametry nazwane  
```python
def add(*,c,d):  
    return c + d

print(add(1,2))
```
[[function python]]
