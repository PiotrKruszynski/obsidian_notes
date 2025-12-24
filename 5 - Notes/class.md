class = [[namespace]] (schema)

[[class]]  to specjalny [[namespace]], w którym przechowywane są identyfikatory:

to fabryki tworzące obiekty

- ==fields== atrybuty klasowe (variable na poziomie klasy)
	- class fields
	- object fields ( w [[__init__]])
- ==methods== (fn przypisane do klas)
	- class methods (cls) -> @classmethod . w [[__new__]] oraz w [[__call__]] bez dekoratora!
	- [[static method]] (  ) -> @staticmethod ==nie ma świadomości klasowej==
	- classic method (self) -> *nic nie trzeba :D*

class method od zwykłej różni się tym, że manipulujemy klasą, a w zwykłej manipulujemy obiektem
metoda statyczna mogłaby być funkcją bez zmiany implementacji 

```python
class Car:
    wheels = 4  # class field

    def __init__(self, color):
        self.color = color  # object field

    def drive(self):
        return f'Driving {self.color} car'  # classic method

    @classmethod
    def from_string(cls, data):
        return cls(data.split("-")[0])  # class method

    @staticmethod
    def is_valid_color(color):
        return color in ['black', 'white', 'grey']  # static method

Car.is_valid_color("black")  # ✅ True
c = Car.from_string("red-2023")  # cls -> Car("red")
c.drive()  # 'Driving red car'
```

!! pole klasy modyfikujemy tylko z poziomu klasy



==dowód, że metaclass tworzą class==

```python
NameThree = type('NameThree', (), {})
print(NameThree)

# powstaje klasa NameThree bez klas bazowych (poza object) i bez dodatkowych atrybutów
```
[[type()]]  to wbudowana metaklasa , której wywołanie z argumentami

==`type(nazwa_klasy, tuple_klas_bazowych, słownik_atrybutów)`==

zwraca nowy obiekt klasy <class '__main__.NameThree'>

==dowód, że klasa jest tylko namespace==

```python
def init_(self, x):
    self.x = x

attrs = {
    "__init__": init_,
    "value": 42
}

NameFour = type('NameThree', (), attrs)
nf = NameFour(666)
print(nf.x, nf.value)
```
`attrs` przechowuje identyfikatory jako klucze, a fn lub wartości jako obiekty
klasa jest tworzona przez przekazanie słownika
powstaje klasa NameFour


Najważniejsze metody na klasach i obiektach

[[__dir__]]
[[__vars__]]
[[__mro__]]

#study