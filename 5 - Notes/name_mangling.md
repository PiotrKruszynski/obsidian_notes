zapobiega przypadkowemu nadpiasaniu atrybutu klasy bazowej przez klase dziedziczącą
```python
self.__value 
# jest wewnętrznie zmieniany przez Pythona na:
self._NazwaKlasy__value
```

tu nadpisuje wartość z A
```python

class A:
    def __init__(self):
        self.value = 10

class B(A):
    def __init__(self):
        super().__init__()
        self.value = 20   # nadpisuje value z A!

```

## **Kiedy stosować?**

- gdy chcesz uniknąć konfliktów nazw w dziedziczeniu
    
- gdy atrybut ma być „bardziej prywatny” niż zwykłe _nazwa
    
- gdy mechanika klasy nie powinna być łatwo nadpisywana z zewnątrz
    

---

## **Kiedy** nie stosować?

- gdy prywatność nie jest potrzebna
    
- gdy chcesz, by kod był czytelny i łatwo rozszerzalny
    
- gdy nie używasz dziedziczenia — wtedy _nazwa zwykle wystarcza