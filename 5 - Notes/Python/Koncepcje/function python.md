---
title: "function python"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-10
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

- zbiór instrukcji zamknięte pod indetyfikatorem  
- cel: re-używalność kodu  
- automatycznie nie dziedziczy stanu automatycznych wywołań
  
### Nazwa funkcji:  
- sneake case  
- deskryptywna / opisowa  
- litery, cyfry, underscore (podłoga), nie może zaczynać się od cyfry  
- po angielsku

Params:
1- positional
3- named
4- optional / default -> first!
2- * args
5- ** kwargs
* * wymusza pozycyjne przed nią
* / wymusza nazwane po


tworzenie fn z klasy z protokołem call

```python
class Magic:
	def __call__(self, x, y):
		return x + y
		
add = Magic()
print(add(1, 2))

```
