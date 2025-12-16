	nie da się stworzyć obiektu. Służą do logiki

[klasa bazowa] której nie można **instancjonować bezpośrednio**, i która **określa interfejs (API)** dla klas potomnych.


W Pythonie tworzy się ją 
- dziedzicząc po abc.ABC 
- oznaczając metody za pomocą dekoratora @abstractmethod.
```python
from abc import ABC, abstractmethod

class Shape(ABC):  # dziedziczenie po ABC
    @abstractmethod
    def area(self):
        pass
```

**@abstractmethod**: oznacza metodę, którą **MUSI** zaimplementować każda podklasa
    

  
Próba stworzenia instancji klasy Shape **zwróci wyjątek** TypeError.

```python
from abc import ABC, abstractmethod

class Animal(ABC):  # 👈 klasa abstrakcyjna
    @abstractmethod
    def sound(self) -> str:  # 👈 metoda abstrakcyjna
        pass

class Dog(Animal):
    def sound(self) -> str:
        return "woof"

dog = Dog()  # 👈 działa
# animal = Animal()  # ❌ TypeError: Can't instantiate abstract class

```

#### **🧵 Interpreter:**

- interpreter widząc @abstractmethod, **rejestruje metodę jako niepełną**
    
- przy próbie utworzenia instancji Animal() → sprawdzana jest **pełność klasy**
    
- ponieważ sound() nie ma implementacji → TypeError
    

---

### **🧪 Case Study (PL):**


Załóżmy system z wieloma czujnikami (Sensor), które mają różne typy: TemperatureSensor, HumiditySensor, itd. Każdy musi mieć metodę read() – ale każdy inaczej.

```python
from abc import ABC, abstractmethod

class Sensor(ABC):
    @abstractmethod
    def read(self) -> float:
        pass

class TemperatureSensor(Sensor):
    def read(self) -> float:
        return 21.5  # np. odczyt z API

class HumiditySensor(Sensor):
    def read(self) -> float:
        return 58.2  # np. z hardware
```

> Dzięki abstrakcji wymuszamy **spójny interfejs read()** niezależnie od źródła danych.

---

### **🧠 Techniczne ciekawostki:**

- @abstractmethod może współistnieć z @classmethod, @staticmethod, @property (np. @abstractmethod @classmethod)
    
- abstrakcyjna klasa **może** zawierać normalne metody z implementacją
    
- abc.ABCMeta to **metaklasa**, którą ABC używa
    
- isinstance(obj, ABC) zadziała tylko na klasach abstrakcyjnych
    
- `__subclasshook__` można przeciążyć by dać duck-typing bez dziedziczenia
    

Lista abstrakcyjnych interfejsów w collections.abc

https://docs.python.org/pl/3.14/library/collections.abc.html#collections-abstract-base-classes 