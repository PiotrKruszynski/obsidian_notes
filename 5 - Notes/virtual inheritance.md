Created: 2025-12-16  16:00
___
Note:

mechanizm, w którym klasa **jest uznawana** za podklasę interfejsu/klasy bazowej, mimo że nie dziedziczy po niej nominalnie

**jednostronne** nie dostajemy funkcjonalności, ale możemy sprawdzić czy spełniamy, jesteśmy zgodni z wymaganiami
**nie jest explicite** nie ma virtual jak w C++

Zgodność jest wirtualna, bo zależy od:
	- struktury (czy klasa ma wymagane metody),
	- zachowania (czy spełnia kontrakt)
	- ewentualnej rejestracji (register())

>[!TIP]  Mechanizmy wirtualnego dziedziczenia w Python
	1.	MRO + super() – wykonawcze
	2.	ABC + __subclasshook__ – semantyczne (automatyczne)
	3.	ABC.register() – semantyczne (jawne)
	4.	Protocol (PEP 544) – strukturalne (deklaratywne)
	5.	Duck typing – strukturalne (niejawne)

>[!TIP] Virtual inheritance oparte o ABC:
`issubclass()` i `isinstance()` uruchamiają metody metaklasy `__subclasscheck__` i `__instancecheck__`.
Te metody sprawdzają, **czy dana klasa spełnia zasady interfejsu**, nawet jeśli po nim nie dziedziczy.
Logika sprawdzania może być zapisana w `__subclasshook__`, który w prosty sposób weryfikuje, czy klasa spełnia wymagany „protokół” rodzica.
Dzięki temu wiemy, że obiekt **jest traktowany jak podtyp**, mimo braku jawnego dziedziczenia.


spełnia protokół Sized

Typy w python rozpoznawane są przez [[duck typing]].
Python sprawdza, czy protokół jest spełniony, czy istnieją specjalne warunki by
potwierdzić, że to jest tym czymś.
czyli duck typing 

# **gdzie Python wykorzystuje wirtualne dziedziczenie?**

Wbudowane protokoły:
obiekt nie musi dziedziczyć, aby być:

- **iterowalny: `__iter__, __next__
- **kontekst managerem**: `__enter__, __exit__
- **kolekcją**: `__len__, __getitem__
- **deskryptorem**:` __get__, __set__, __delete__
    

Jeśli _MA_ odpowiednie metody → Python _traktuje go jako takiego_.

To czysta implementacja wirtualnego dziedziczenia:

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


## **jak jest realizowane w  Pythonie?**


Python nie ma słowa kluczowego virtual jak w C++, ale rozwiązuje problem **własnym mechanizmem**:

**C3 linearization (MRO – Method Resolution Order).**

- Python **gwarantuje jedną kopię** bazowej klasy w drzewie dziedziczenia.
    
- Kolejność wyszukiwania metod/atrybutów jest deterministyczna i jednoznaczna.




___
Metadata:

Status: #pending
Tags: #python #oop 

