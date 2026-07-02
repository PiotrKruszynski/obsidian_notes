---
title: "closure"
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

dostęp do zmiennych z poza aktualnie obsługiwanego zasięgu

  
Tworzenie closure:  
- minimum 2 funkcje, jedna w drugiej  
- funkcja zewnętrzna (outer) musi zwracać deklaracje funkcji wewnętrznej (inner)  
- funkcja wewnętrzna (inner) musi używać czegoś (identyfikatora) z funkcji zewnętrznej (outer)  
  
Zalety:  
- persystencję (trwałość) - dodaje persystencje do efemerycznego świata wywołań funkcji  
  
Wady:  
- potencjalnie memory-leak  
  
Definicja:  
- dostęp do zmiennych spoza aktualnie wykonywanego zasięgu

wynika z [[composition]]

```python
def first_fn():  
    x = 42  
  
    def second_fn():  
        return f'Odpowiedź na wszystkie pytania: {x}'  
  
    return second_fn
```

```pyt
```

używane do:
- [[factory fn]]
