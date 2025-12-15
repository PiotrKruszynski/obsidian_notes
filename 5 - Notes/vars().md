słownik ze wszystkimi property jakie istnieją w obiekcie

zwraca **słownik atrybutów obiektu**.

odwołuje się do `__dict__`

### **Najważniejsze fakty**

- działa tylko dla obiektów, które mają __dict__
    
- nie wywołuje __getattr__ ani __getattribute__
    
- nie pokazuje atrybutów klasy, tylko **instancji**
    
- niczego nie ukrywa — to jest surowy stan obiektu

vars(self) -> daje obj.__dict__

[[class]]
[[oop]]