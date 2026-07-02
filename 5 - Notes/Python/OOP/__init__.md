---
title: "__init__"
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

odpowiada za ustawienie początkowego stanu obiektu (np. przypisanie wartości pól).
	
	setuje pola obiektu

Jest wywoływany po utworzeniu instancji przez [[__new__]].

Nie zwraca wartości (tylko modyfikuje istniejący obiekt self).

[[__new__]] to prawdziwy "konstruktor" w Pythonie:

Odpowiada za tworzenie nowej instancji obiektu (alokację pamięci).

Jest metodą klasową (choć nie używa dekoratora @classmethod).

Musi zwrócić nową instancję 

Potoczna nazwa vs techniczna precyzja

- W praktyce wiele osób nazywa __init__ "konstruktorem", bo to miejsce, gdzie zwykle definiuje się inicjalizację obiektu.

```python]class NameFive:  
class Name:
    def __new__(cls, *args: Any, **kwargs: Any) -> "Name":  
        self = super().__new__(cls)  
        return self  # nasz __new__ nic nie robi , to defaultowa metoda tworzenia obiektu
  
    def __init__(self, value):  # self już istnieje fizycznie i wskakuje tu
        self.value = value # teraz tworze pola obiektu
```
