---
title: "type()"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-21
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

wbudowana [[metaclass]] , której wywołanie z argumentami

==`type(nazwa_klasy, tuple_klas_bazowych, słownik_atrybutów)`==

zwraca nowy obiekt klasy  <class '__main__.NameThree'>

```python

NameThree = type("NameThree", (object,), {"x": 42, "foo": lambda self: self.x})

print(NameThree)
obj = NameThree()
print(obj.foo())

```

##  Co się dzieje przy  class X: ...  (w skrócie)

1. Wywoływane jest `metaclass.__prepare__()` → tworzy **namespace** klasy
2. Wykonywane jest ciało klasy (definicje metod, atrybuty)
3. Wywoływane jest `metaclass.__new__()` → **powstaje klasa**
4. `metaclass.__init__()` → finalizacja klasy
    
Jeśli nie podasz metaclass=..., używany jest **type**.

![[Pasted image 20251224124722.png]]
