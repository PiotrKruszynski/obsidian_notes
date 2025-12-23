słownik ze wszystkimi property jakie istnieją w obiekcie

zwraca **słownik atrybutów obiektu**.

odwołuje się do `__dict__`

### **Najważniejsze fakty**

- działa tylko dla obiektów, które mają __dict__
    
- nie wywołuje __getattr__ ani __getattribute__
    
- nie pokazuje atrybutów klasy, tylko **instancji**
    
- niczego nie ukrywa — to jest surowy stan obiektu

vars(self) -> daje obj.__dict__


```python
class A:
    def __init__(self):
        self.x = 10
        self.y = 20

a = A()
vars(a)
# {'x': 10, 'y': 20}
```


porównanie `dir()`  vs  `vars()`:

| **Funkcja** | **Co pokazuje**         | **Typ**   | **Zastosowanie**    |
| ----------- | ----------------------- | --------- | ------------------- |
| dir(obj)    | nazwy atrybutów + metod | list[str] | eksploracja API     |
| vars(obj)   | **stan obiektu**        | dict      | debug, serializacja |
[[dir()]]

[[class]]
[[oop]]