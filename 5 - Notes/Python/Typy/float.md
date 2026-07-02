---
title: "float"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-13
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

double, IEE754 , Bankers Rounting
nie reprezentuje rzeczywistej wartości, tylko aproksymacje ( pracuje na reprezentacji )

	```python
	a = 0.1 + 0.7 # bo binarnie ta liczba nie jest reprezentowana idealnie, chodzi o wydajność
	print(a)
	```
	
	zaokrąglenie - jak potrzebujesz to pewnie decimal 
	```python
	from decimal import Decimal, getcontext, ROUND_HALF_UP
	
	getcontext().rounding = ROUND_HALF_UP # ta linijka ustawia do końca programu
	
	a = round(Decimal(2.5555555555), ndigits=2 )
	print(a)
	```

precyzja double -> 64bity

11 + 1 + 53 ; 53 * log10(2)
