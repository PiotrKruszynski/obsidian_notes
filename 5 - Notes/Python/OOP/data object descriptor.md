---
title: "data object descriptor"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

==“Descriptors are the magic behind properties, methods, and super() in Python.”==

==**Data descriptor** = obiekt zdefiniowany w klasie, który implementuje przynajmniej **__set__** lub **__delete__**.

Różnica wobec non-data descriptor (tylko __get__): **ma pierwszeństwo** przed wpisami w __dict__ instancji.

**Deskryptor** = obiekt w Pythonie, który implementuje co najmniej jedną z metod protokołu deskryptorów:

- __get__(self, instance, owner)
    
- __set__(self, instance, value)
    
- __delete__(self, instance)



## **🔑 Reguły rozwiązywania atrybutów**

Kolejność wyszukiwania przy obj.attr:

1. **Data descriptor** w klasie → jeśli obecny, wygrywa.
2. slots
    
3. **__dict__ instancji** → zwykły atrybut, nadpisuje non-data descriptors.
    
4. **Non-data descriptor** (__get__ bez __set__/__delete__).
    
5. Atrybut w klasie. 
    
6. `__getattr__`

```python
class DataDescriptor:
    def __get__(self, instance, owner):
        print("GET")
        return instance.__dict__.get("value")

    def __set__(self, instance, value):
        print("SET")
        instance.__dict__["value"] = value

    def __delete__(self, instance):
        print("DELETE")
        del instance.__dict__["value"]


class A:
    x = DataDescriptor()

a = A()
a.x = 42       # SET
print(a.x)     # GET → 42
del a.x        # DELETE

```
## **⚖️ Praktyczne użycia**

- **property** jest data-descriptorem (generowane przez @property).
    
- **classmethod**, **staticmethod** → descriptors.
    
- Kontrola dostępu do pól (np. walidacja, logowanie, lazy eval).
    
- Mechanizmy ORM (SQLAlchemy) i Django Fields.
    

---

## **🧠 Zapamiętaj różnice**

- **Data descriptor**: ma __set__ lub __delete__, zawsze wygrywa z __dict__.
    
- **Non-data descriptor**: tylko __get__, może zostać przesłonięty wpisem w __dict__.
