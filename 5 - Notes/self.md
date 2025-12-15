	obiekt

to referencja do bieżącej instancji klasy / do obiektu , który powstał z `__new__`

```python
class Dog:
    def __init__(self, name):  # name to argument, self.name to pole obiektu
        self.name = name

    def speak(self):
        return f"{self.name} says woof"
```


Każdy obiekt ma własny count, ale Counter.total rośnie globalnie – self i Counter wskazują na różne przestrzenie.
```python
class Counter:
    total = 0  # zmienna klasowa

    def __init__(self):
        self.count = 0  # zmienna instancyjna

    def increment(self):
        self.count += 1
        Counter.total += 1
```

[[oop]]