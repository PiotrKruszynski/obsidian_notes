
- __repr__ → służy aby pokazać programiście w jaki sposób została zrobiona instancja obiektu.
		w każdej chwili można zwalidować na jakiej podstawie powstał obiekt
    
- __str__ → **wizytówka obiektu** dla GUI (użytkownika).

czy to powinien być repr czy str??
```python

def info(self):  
    return (f"{self.name} is {self.age} years old"            f" and work as {self.position}"  
            f" and salary: {self.salary}")

```

jezeli repr to powinno byc

```python
def __repr__(self):
    return (f"Employee(name={self.name!r}, "
            f"age={self.age}, "
            f"position={self.position!r}, "
            f"salary={self.salary})")
```

dla daty w [[repl]]

```python
>>> x = datetime.date(2025,1,11)
>>> str(x)
'2025-01-11'
>>> repr(x)
'datetime.date(2025, 1, 11)'

```

##Jak rozpoznać które to które?

jak repl to można zevaluować to co jest wyprintowane

```python
>>> x = 'datetime.date(2025, 1, 11)'
>>> eval(x)
datetime.date(2025, 1, 11)

>>> x1 = datetime.date(2025, 1, 11)
>>> eval(x) == x1
True

```

kiedy repr nie jest możliwy?

brak `__str` i `__repr` -> python uzywa z obj
wlasny `__repr` -> nie ma str wiec str używa fallback do `__repr__`

ma swoj str a repr do obj.

```python
# w każdym z przypadków to samo  
class Magic:  
    pass  
m = Magic()  
print(m)        # <__main__.Magic object at 0xa110c0>
print(str(m))   # <__main__.Magic object at 0xa110c0>
print(repr(m))  # <__main__.Magic object at 0xa110c0>
  
# teraz dodaje __repr__  i uwaga! nie ma str a i tak dostajemy yolo bo w obj __str__ = __repr__
class Magic2:  
    def __repr__(self):  
        return "yolo"  
  
m = Magic2()  
print(str(m))   # yolo
print(repr(m))  # yolo


# teraz zmieniam na str  
class Magic3:  
    def __str__(self):  
        return "yolo"  
  
m = Magic3()  
print(str(m))  # yolo
print(repr(m))  # <__main__.Magic object at 0xa110c0>
```