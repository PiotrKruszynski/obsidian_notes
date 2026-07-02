---
title: "Sequence"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-16
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

> pozwala przetwarzać po indeksie
 >indeks + długość + kolejność, bez modyfikacji

i dużo więcej:
- pobrać długość: len(obj) -> `__len__`
- indeksować: `obj[i]` -> `__getitem__`
- można iterować: for x in obj
- zachowuje **kolejność elementów**, slicing
- elementy są **niemutowalne przez interfejs sekwencji** (brak metod mutujących)
- pozwala na reverse iterator
- `count(items)`
