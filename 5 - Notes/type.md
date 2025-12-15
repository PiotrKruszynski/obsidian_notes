wbudowana [[metaclass]] , której wywołanie z argumentami

==`type(nazwa_klasy, tuple_klas_bazowych, słownik_atrybutów)`==

zwraca nowy obiekt klasy  <class '__main__.NameThree'>

```python

NameThree = type("NameThree", (object,), {"x": 42, "foo": lambda self: self.x})

print(NameThree)
obj = NameThree()
print(obj.foo())

```

[[oop]]