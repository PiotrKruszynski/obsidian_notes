Created: 2025-12-24  11:41
___
Note:

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

___
Metadata:
[[oop]]  , [[class]] , 
```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #empty
