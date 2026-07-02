---
title: "__slots__"
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

- **__slots__ = deklaracja pól instancji** , dzięki czemu interpreter nie tworzy standardowego **__dict__** w obiekcie.
- powoduje **ograniczenie**: nie możesz przypisać atrybutu spoza listy w __slots__.
- zamiast dynamicznej tablicy atrybutów (dict) tworzona jest **sztywna tablica wskaźników** do pól → **mniej pamięci, szybszy dostęp**.


>[! Important]
>Przy dziedziczeniu musimy pamiętać aby zawsze dodawać slots do Y(x)
>```python
>class X:
>__slots__ = ('yolo')
>
>class Y(X):
>__slots__ = ('magic') # musimy dodać
