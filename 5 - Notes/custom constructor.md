niestandardowy konstruktor klasy

```python
class Auto:  
    color = 'red' # share stage param  
  
    def __init__(self, model: str, max_speed: int, year: int):  
        self.model = model  
        self.max_speed = max_speed  
        self.year = year  
        self.engine = True  
        self._color = type(self).color #type(self) zwraca klasę obiektu  
        self.speed = 0  
  
  
    def speed_up(self, amount): # metoda na rzecz obiektu  
        if self.engine:  
            self.speed = min(self.speed + amount, self.max_speed)  
  
    @classmethod # oto custom constructor  
    def auto_nitro(cls, model:str, max_speed: int, year: int, nitro: bool) -> 'Auto':  
        self = super().__new__(cls)  
        self.__init__(model, max_speed, year)  
        self.nitro = nitro  
        return self

toyota = Auto.auto_nitro('auris', 270, 1990, True)
print(toyota.nitro)

```
