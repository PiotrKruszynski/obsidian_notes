		mechanizm, w którym klasa jest uznawana za podklasę interfejsu/klasy 
		bazowej, mimo że nie dziedziczy po niej nominalnie

		Zgodność jest wirtualna, bo zależy od:
		- struktury (czy klasa ma wymagane metody),
		- zachowania (czy spełnia kontrakt)
		- ewentualnej rejestracji (register())

>[!TIP] 3 mechanizmy wirtualnego dziedziczenia w Python
	1. Duck typing
	2. ABC.register()
	3. Protocol (PEP 544)

spełnia protokół Sized

Typy w python rozpoznawane są przez [[duck typing]].
Python sprawdza, czy protokół jest spełniony, czy istnieją specjalne warunki by
potwierdzić, że to jest tym czymś.
czyli duck typing 

# **4. Gdzie Python wykorzystuje wirtualne dziedziczenie?**

Wbudowane protokoły:

- **iterowalność**: `__iter__, __next__
- **kontekst manager**: `__enter__, __exit__
- **kolekcje**: `__len__, __getitem__
- **deskryptory**:` __get__, __set__, __delete__
    
Żaden obiekt nie musi dziedziczyć po formalnej klasie, aby być:

- iterowalny,  
- sekwencją,
- deskryptorem,
- kontekst managerem.

Jeśli _MA_ odpowiednie metody → Python _traktuje go jako takiego_.
To czysta implementacja wirtualnego dziedziczenia.



```python
from collections.abc import Sized

class Auto:  
    color = 'red' # share stage param  
  
    def __init__(self, model: str, max_speed: int, year: int):  
        self.model = model  
        self.max_speed = max_speed  
        self.year = year  

    def __len__(self):  
        return 42 # jak to wywołać aby pokazać drzewo drzedziczenia?  


print(Auto.__mro__)
print(issubclass(Auto, object)) #  True
print(issubclass(Auto, Sized)) # True bo jest __len__ i to wystarcza
``` 

```python
    A
   / \
  B   C
   \ /
    D
```
- D dziedziczy po B i C, a one oba po A.
    
- Bez dziedziczenia wirtualnego, D ma **dwie kopie A** (bałagan).
    
- Dziedziczenie wirtualne (virtual) zapewnia, że D ma **jedną wspólną kopię A**.
    

---

## **A jak w  W Pythonie?**


Python nie ma słowa kluczowego virtual jak w C++, ale rozwiązuje problem **własnym mechanizmem**:

**C3 linearization (MRO – Method Resolution Order).**

- Python **gwarantuje jedną kopię** bazowej klasy w drzewie dziedziczenia.
    
- Kolejność wyszukiwania metod/atrybutów jest deterministyczna i jednoznaczna.

[[oop]]
