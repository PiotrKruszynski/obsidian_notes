konstruktor, który tworzy obiekt. 
ma go tylko **object**
wywołuje się zawsze jako pierwszy
musi zwrócić obiekt (zwykle instancje cls)

```python
  
class NameFive:  
    def __new__(cls, *args: Any, **kwargs: Any) -> "NameFive":  
        self = super().__new__(cls) # object.__new__(cls) przypisuje pustą instancję klasy NameFive do self. 
        # return self przekazuje ją dalej
		# nasz __new__ nic nie robi , to defaultowa metoda tworzenia obiektu  
  
    def __init__(self, value): # za każdym razem jak wywołuje init obiekt już istnieje  
        self.value = value  
        self.temp = 42

```

[[__init__]] 
- działa na już istniejącym obiekcie
- ustawia stan obiektu (atrybuty)
- nic nie zwraca
